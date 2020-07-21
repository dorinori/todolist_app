class TodoListTagsController < ApplicationController
  def index
    @todo_list_tags = TodoListTag.all
  end

  def new
    @todo_list_tag = TodoListTag.new
  end

  def create
  	inserts = []
  	inserts.push "(#{params[:todo_list_id]}, #{params[:tag]})"
  	sql = "INSERT INTO todo_list_tags (todo_list_id, tags_id) VALUES #{inserts.join(", ")}"
  	ActiveRecord::Base.connection.execute(sql) 
    redirect_to :controller => 'todo_lists', action: "show", id: params[:todo_list_id]
  end

  def destroy
  	@todo_list_tag = TodoListTag.where(tags_id: params[:tag_id], todo_list_id: params[:todo_list_id])
  	if @todo_list_tag.delete_all
  		flash[:success] = "Todo List item was deleted."
  	else
  		flash[:error] = "Todo List item could not be deleted."
  	end 
    redirect_to :controller => 'todo_lists', :action => "show"
  end

  # private
  # def todo_list_tag_params
  #   byebug
  # 	params.permit(:todo_list_id, :tag)
  # end
end

