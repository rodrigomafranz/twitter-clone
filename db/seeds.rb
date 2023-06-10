if Rails.env.development? && User.count.zero? && Message.count.zero?
	users = 5.times.map do |i|
		User.create(name: "User #{i + 1}", email: "user#{i + 1}@example.com", password: '12345678')
	end

	100.times do |i|
		image_url = ["https://picsum.photos/id/#{rand(0..1084)}/300", nil].sample
		users.sample.messages.create(text: Faker::ChuckNorris.fact, image_url)
	end
end