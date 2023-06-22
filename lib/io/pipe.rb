module IO::Pipe
  Command = Data.define(:command, :each_args, :each_kwds, :open_args) {
    include Enumerable

    def initialize(command:, each_args: nil, each_kwds: nil, open_args: {})
      super
    end

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

    def redirect(**to)
      open_args.update(to)
      self
    end

    %i[to_str to_s].each {|m| alias_method(m, :read)}
  }

  refine(Kernel) {
    def `(str) = Command.new(str)
  }
end
