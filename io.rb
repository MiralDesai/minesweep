class IO
  def self.output(message)
      puts message
  end

  def self.input
    stdin.gets.chomp
  end
end
