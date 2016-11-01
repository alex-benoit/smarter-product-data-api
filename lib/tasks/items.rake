namespace :items do
  desc 'Updating all the items (sync)'
  task update_all: :environment do
    items = Item.all
    items.each do |item|
      UpdateItemsJob.perform_now(item.id)
      sleep 15
    end
  end

  desc 'Updating a single item (sync)'
  task :update, [:item_id] => :environment do |_t, args|
    item = Item.find(args[:item_id])
    UpdateItemsJob.perform_now(item.id)
  end

  desc 'Reindex the items on Aloglia'
  task reindex: :environment do
    Item.reindex!
  end
end
