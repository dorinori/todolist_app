class TodoListTagsController < ApplicationController
  def index
    @todo_list_tags = TodoListTag.all
  end

  def new
    @todo_list_tag = TodoListTag.new
  end

  def create
  	inserts = []
  	inserts.push "(#{todo_list_tag_params[:todo_list_id]}, #{todo_list_tag_params[:tags_id]})"
  	sql = "INSERT INTO todo_list_tags (todo_list_id, tags_id) VALUES #{inserts.join(", ")}"
    	ActiveRecord::Base.connection.execute(sql) 
      redirect_to :action => "index"
  end

  def destroy
  	@todo_list_tag = TodoListTag.where(tags_id: params[:tags_id], todo_list_id: params[:todo_list_id])
  	if @todo_list_tag.delete_all
  		flash[:success] = "Todo List item was deleted."
  	else
  		flash[:error] = "Todo List item could not be deleted."
  	end
  	redirect_to :action => "index"
  end

  private
  def todo_list_tag_params
  	params.require(:todo_list_tag).permit(:todo_list_id, :tags_id)
  end
end

