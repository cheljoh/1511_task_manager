

class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    #insert into tasks table
    dataset.insert(task)
  end

  def all
    dataset.to_a.map { |data| Task.new(data) }
  end

  def find(id)
    find = dataset.where(:id => id).to_a.first
    Task.new(find)
  end

  def dataset
    database.from(:tasks)
  end

  def update(task, id)
    dataset.where(:id => id).update(task) #:title => task[:title], :description => task[:description]) 
  end

  def delete(id)
    dataset.where(:id => id).delete
  end

  def delete_all
    database.transaction do
      database['tasks'] = []
      database['total'] = 0
    end
  end
end
