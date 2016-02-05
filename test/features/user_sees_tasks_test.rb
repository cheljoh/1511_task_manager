require_relative '../test_helper'

class UserSeesAllTasksTest < FeatureTest
  include TestHelpers

  def create_tasks(num)
    num.times do |i|
      task_manager.create(
        title:       "title#{i+1}",
        description: "description#{i+1}"
      )
    end
  end

  def test_a_user_can_see_a_single_task
    create_tasks(1)
    task = task_manager.all.last

    visit "/tasks"

    click_link("title1")

    assert_equal "/tasks/#{task.id}", current_path
    assert page.has_content?("description1")
  end

  def test_filter_task_index_by_param
    create_tasks(1)

    task_manager.create({
      :title       => "dogsitting",
      :description => "Friday"
    })

    task_manager.create({
      :title       => "dogsitting",
      :description => "Saturday"
    })

    visit "/tasks?title=dogsitting"

    selected_tasks = task_manager.all.select { |task| task.title == "dogsitting"}

    selected_tasks.each do |task|
      id = task.id
      within("#task") do
        save_and_open_page
        assert page.has_content?("dogsitting")
      end
    end

    refute page.has_content?("title1")
  end

end
