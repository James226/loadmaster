Puppet::Type.type(:loadmaster).provide(:ruby) do
  def exists?
    puts "Call to exists"
    false
  end

  def create
    puts "Call to create"
  end

  def destroy
    puts "Call to destroy"
  end

  def test
    puts "Get test"
    'as'
  end

  def test=(value)
    puts "Set test"
  end
end
