SimpleFixture.migrate do
  create_table :orders do |t|
    t.text :order_no
  end
end
