class Sheep
  def initialize
    @shorn = false
    
    # A mutex to protect each sheep
    @mutex = Mutex.new
  end

  def shorn?
    @shorn
  end
  private :shorn?

  def shear!
    @mutex.synchronize do
      return if shorn?

      puts "shearing..."
      @shorn = true
    end
  end
end

sheep = Sheep.new

# You could create the mutex here and let
# the threads fight over it before shearing
# the sheep. 
5.times.map do
  Thread.new do
    sheep.shear!
  end
end.each(&:join)

