class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    database.from(:tasks).insert(task)
  end

  def raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def all
    database.from(:tasks).to_a.map { |data| Task.new(data) }
  end

  def raw_task(id)
    raw_tasks.find { |task| task["id"] == id }
  end

  def dataset
    database.from(:tasks)
  end

  def find(id)
    data = dataset.where(:id => id).to_a.first
    Task.new(data)
  end

  def update(task, id)
    database.from(:tasks).where(:id => id).update(task)
  end

  def delete(id)
    database.from(:tasks).delete(:id => id)
  end

  def delete_all
    database.transaction do
      database['tasks'] = []
      database['total'] = 0
    end
  end
end
