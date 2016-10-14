json.extract! trainer, :id, :name, :level, :description, :gender, :training_ground, :created_at, :updated_at
json.url trainer_url(trainer, format: :json)