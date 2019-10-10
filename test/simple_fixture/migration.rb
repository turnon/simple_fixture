SimpleFixture.migrate do
  create_table :orders do |t|
    t.text :order_no
  end

  create_table :items do |t|
    t.integer :order_id
    t.integer :good_id
    t.integer :amount
  end

  create_table :goods do |t|
    t.text :name
    t.float :price
  end
end
