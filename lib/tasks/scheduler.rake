desc "This task is called by the Heroku scheduler add-on"
task :connect_to_hn => :environment do
  Slot.update
  puts "Finished running."
end