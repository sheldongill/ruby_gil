require 'thread'

class Sheep
  def initialize
    @shorn = false
  end

  def shorn?
    @shorn
  end

  def shear!
    puts "shearing..."
    @shorn = true
  end
end

sheep = Sheep.new
sheep_queue = Queue.new
sheep_queue << sheep

5.times.map do
  Thread.new do
    begin
        sheep = sheep_queue.pop(true)
        sheep.shear!
    rescue ThreadError
        puts "No sheep"
    end
  end
end.each(&:join)

