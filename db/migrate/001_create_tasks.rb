require 'sequel'

environments = ["test", "development"]

environments.each do |env| 
  Sequel.sqlite("db/task_manager_#{env}.sqlite3").create_table(:tasks) do
    primary_key :id
    String :title
    String :description
  end
end