class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
    @article = Article.new
  end

  def show; end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = 'Article was successfully created!'
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article updated successfully!'
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = 'Article was successfully deleted!'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    unless current_user == @article.user and current_user.admin?
      flash[:alert] = 'You can only edit or delete your own article!'
      redirect_to root_path
    end
  end
end
