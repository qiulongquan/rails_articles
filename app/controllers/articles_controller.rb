
class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  
  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # @article = Article.new(params[:article])
    @article = Article.new(article_params)
    # @article = Article.new(params.require(:article).permit(:title, :text))
    # 通过判断访问Athenz得到的response的值来判断是不是可以授权访问
    # 如果可以访问就render 
    # 如果不可以就  redirect_to
    if @article.save
      redirect_to @article
    else
      render 'new'
  	# render plain: params[:article].inspect
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
 
    redirect_to articles_path
  end

  private
  	def article_params
    	params.require(:article).permit(:title, :text)
  	end
end