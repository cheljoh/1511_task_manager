require 'sequel'

Sequel.sqlite("db/task_manager_test.sqlite3").create_table(:tasks) do
  primary_key :id
  String :title
  String :description
end