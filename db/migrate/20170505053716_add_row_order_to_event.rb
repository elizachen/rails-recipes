class AddRowOrderToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :row_order, :integer
    # 因为得会会改用这个 row_order 来排序，而数据库已经有的 events 会是 nil
    # 因此这里要设定 row_order 的值，其中 `:last` 是 ranked-model 提供的方式，会将资料放到列表最后。
    Event.find_each do |e|
      e.update( :row_order => :last )
    end

    add_index :events, :row_order
  end
end
