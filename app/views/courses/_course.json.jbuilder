json.extract! course, :id, :name, :term, :description, :created_at, :updated_at
json.url course_url(course, format: :json)