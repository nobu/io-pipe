# frozen_string_literal: true

class IO; end

# Module to refine <tt>Kernel#`</tt> method.
module IO::Pipe
  # The version number
  VERSION = "0.0.1"

  #:stopdoc:
  Command = Data.define(:command, :each_args, :each_kwds, :open_args)
  #:startdoc:

  ##
  # Wrapper of command and options.
  class Command
    include Enumerable

    ##
    # :attr_reader: command
    #
    # \Command string or array to start a process.

    ##
    # :attr_reader: each_args
    #
    # Positional arguments to be passed to +#each+ method.

    ##
    # :attr_reader: each_kwds
    #
    # Keyword arguments to be passed to +#each+ method.

    ##
    # :attr_reader: open_args
    #
    # Arguments to be passed to +#open+ method.

    # Creates instance.
    def initialize(command:, each_args: nil, each_kwds: nil, open_args: {})
      super
    end

    # Starts the command with +open_args+.
    def open(&block)
      IO.popen(command, **open_args, &block)
    end

    code = []

    %i[
      read read_nonblock readline readlines readpartial
      readchar readbyte ungetbyte ungetc getbyte getc gets
    ].map do |m|
      code << "def #{m}(...) = open {|f| f.#{m}(...)}\n"
    end

    # Iterates command outputs.
    def each(*args, **kwds, &block)
      if block_given?
        open {|f| f.each(*each_args, *args, **each_kwds, **kwds, &block)}
      else
        with(each_args: args, each_kwds: kwds)
      end
    end

    %i[
      each_line each_byte each_char each_codepoint
    ].map do |m|
      code << "def #{m}(*args, **kwds, &block) = open {|f| f.#{m}(*each_args, *args, **each_kwds, **kwds, &block)}\n"
    end

    eval code.join("")

    # Redirects outputs.
    def redirect(**to)
      open_args.update(to)
      self
    end

    alias to_str read
    alias to_s read
  end

  ##
  # Creates IO::Pipe::Command with +str+.
  def `(str) = Command.new(str)

  refine(::Kernel) {
    ##
    # Extended <tt>Kernel#`</tt> that creates IO::Pipe::Command with +str+.
    def `(str) = Command.new(str)
  }
end
