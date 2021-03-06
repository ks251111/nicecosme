require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  describe 'いいね機能' do
    context 'いいねできるとき' do
      it 'userとarticleがあればいいねできる' do
        expect(@like).to be_valid
      end
    end
    context 'いいねできないとき' do
      it 'userが紐付いていないといいねできない' do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Userを入力してください")
      end
      it 'articleが紐付いていないといいねできない' do
        @like.article = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Articleを入力してください")
      end
    end
  end
end
