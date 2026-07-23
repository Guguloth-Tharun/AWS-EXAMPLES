# Import the AWS SDK for Amazon S3.
require 'aws-sdk-s3'

# Import the Pry debugging library.
require 'pry'

# Import SecureRandom to generate random UUIDs.
require 'securerandom'

# Read the bucket name from the environment variable.
bucket_name = ENV['BUCKET_NAME']

# Stop the program if BUCKET_NAME is not set.
abort("Error: BUCKET_NAME environment variable is not set.") if bucket_name.nil? || bucket_name.empty?

# AWS Region
region = 'ap-south-2'

# Print values for verification.
puts "Bucket Name: #{bucket_name}"
puts "Region: #{region}"

# Create an S3 client.
client = Aws::S3::Client.new(region: region)

# Create the S3 bucket.
begin
  resp = client.create_bucket(
    bucket: bucket_name,
    create_bucket_configuration: {
      location_constraint: region
    }
  )

  puts "Bucket '#{bucket_name}' created successfully."

rescue Aws::S3::Errors::BucketAlreadyOwnedByYou
  puts "Bucket '#{bucket_name}' already exists in your AWS account."

rescue Aws::S3::Errors::BucketAlreadyExists
  puts "Bucket name '#{bucket_name}' is already taken. Please choose another unique bucket name."
  exit
end

# Pause execution for debugging.
binding.pry

# Generate a random number between 1 and 6.
number_of_files = 1 + rand(6)

puts "Number of files to upload: #{number_of_files}"

# Create and upload the files.
number_of_files.times do |i|

  # Create a unique filename.
  filename = "sample-file-#{i + 1}.txt"

  # Local file path.
  output_path = "/tmp/#{filename}"

  # Write a random UUID into the file.
  File.open(output_path, "w") do |f|
    f.write(SecureRandom.uuid)
  end

  # Upload the file to S3.
  File.open(output_path, "rb") do |f|
    client.put_object(
      bucket: bucket_name,
      key: filename,
      body: f
    )
  end

  puts "#{filename} uploaded successfully."
end

puts "All files uploaded successfully."