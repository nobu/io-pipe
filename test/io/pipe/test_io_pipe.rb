require 'test/unit'
require 'io/pipe'

class TestIOPipe < Test::Unit::TestCase
  def test_overridden_backquote
    cmd = extended_object.instance_eval do
      `./this-is-not a command`
    end
    assert_instance_of IO::Pipe::Command, cmd
    assert_equal './this-is-not a command', cmd.command

    ensure_not_affected
  end

  def test_using_backquote
    cmd = ExtendedModule.backquote('./this-is-not a command')
    assert_instance_of IO::Pipe::Command, cmd
    assert_equal './this-is-not a command', cmd.command

    ensure_not_affected
  end

  private

  module ExtendedModule
    using IO::Pipe

    def self.backquote(cmd)
      `#{cmd}`
    end
  end

  def ensure_not_affected
    assert_equal "Not affected", `echo Not affected`.chomp
  end

  def extended_object = Object.new.extend(IO::Pipe)
end
