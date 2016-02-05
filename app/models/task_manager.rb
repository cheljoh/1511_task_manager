class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    dataset.insert(task)
  end

  def all
    dataset.to_a.map { |data| Task.new(data) }
  end

  def dataset
    database.from(:tasks)
  end

  def find(id)
    data = dataset.where(:id => id).to_a.first
    Task.new(data)
  end

  def update(task, id)
    dataset.where(:id => id).update(task)
  end

  def delete(id)
    dataset.where(:id => id).delete
  end

  def self.find_by(input)
    database.where(input.keys.first => input.keys.last)
  end
end