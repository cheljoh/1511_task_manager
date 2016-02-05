require 'sequel'

environments = ["test", "development"]

environments.each do |env|
  Sequel.sqlite("db/task_manager_#{env}.sqlite3").create_table(:tasks) do
    primary_key :id
    String :title
    String :description
  end
end

# Sequel.sqlite("db/task_manager_test.sqlite3").create_table(:tasks) do
#   primary_key :id
#   String :title
#   String :description
# end
#
# Sequel.sqlite("db/task_manager_development.sqlite3").create_table(:tasks) do
#   primary_key :id
#   String :title
#   String :description
# end

#have to run twice by itself in order to actually create table
