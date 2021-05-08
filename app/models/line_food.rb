class LineFood <ApplicationRecord
  belongs_to :food
  belongs_to :restaurant
  # 「optional: true」で、関連付け先が存在しなくてもいい
  belongs_to :order, optional: true

  # 「numericality: { greater_than: 0 }」で、countが０以上であることのバリデーション
  validates :count, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) }
  # 引数以外の、「他の店舗のLineFood」があるかどうか？をチェックする
  scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id) }

  def total_amount
    food.price * count
  end
end