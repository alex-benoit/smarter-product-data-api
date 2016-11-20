namespace :items do
  desc 'Updating all the items (sync)'
  task update_all: :environment do
    items = Item.all
    items.each do |item|
      UpdateItemsJob.perform_now(item.id)
      sleep 3
    end
  end

  desc 'Updating a single item (sync)'
  task :update, [:item_id] => :environment do |_t, args|
    item = Item.find(args[:item_id])
    UpdateItemsJob.perform_now(item.id)
  end

  desc 'Updating a range of items (sync)'
  task :update_range, [:start_id] => :environment do |_t, args|
    items = Item.all[(args[:start_id].to_i..(args[:start_id].to_i + 120))]
    items.each do |item|
      UpdateItemsJob.perform_now(item.id)
      sleep 3
    end
  end

  desc 'Updating at restart (sync)'
  task :update_restart, [:start_id] => :environment do |_t, args|
    items = Item.all[(args[:start_id].to_i..999_999_999_999)]
    items.each do |item|
      UpdateItemsJob.perform_now(item.id)
      sleep 3
    end
  end
end
