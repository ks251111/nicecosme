class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to article_path(@comment.article)
    else
      @article = @comment.article
      @comments = @article.comments
      render "articles/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
