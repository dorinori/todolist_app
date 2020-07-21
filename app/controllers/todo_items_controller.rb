class TodoItemsController < ApplicationController
	 before_action :set_todo_list
	 before_action :set_todo_item, except: [:create]

	def create
		@last_item = @todo_list.todo_items.order(:priority).last
		if @last_item == nil
			params[:todo_item][:priority] = 1
		else
			params[:todo_item][:priority] = @last_item.priority + 1
		end
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to @todo_list
	end

	def increment
		@todo_item = @todo_list.todo_items.find(params[:id])
		before_item = @todo_list.todo_items.where("priority < ?", @todo_item.priority).order(:priority).last
		before_item.update_attribute(:priority, @todo_item.priority)
		@todo_item.update_attribute(:priority, @todo_item.priority - 1)
		redirect_to @todo_list
	end

	def decrement
		@todo_item = @todo_list.todo_items.find(params[:id])
		after_item = @todo_list.todo_items.where("priority > ?", @todo_item.priority).order(:priority).first
		after_item.update_attribute(:priority, @todo_item.priority)
		@todo_item.update_attribute(:priority, @todo_item.priority + 1)
		redirect_to @todo_list
	end

	def destroy
		@todo_item = @todo_list.todo_items.find(params[:id])
	 	if @todo_item.destroy
	 		# change every priority below to - 1
	 		@next_items = @todo_list.todo_items.where("priority > ?", @todo_item.priority)
	 		@next_items.each do |item|
	 			item.priority = item.priority - 1
	 		end
	  		flash[:success] = "Todo List item was deleted."
	 	else
	  		flash[:error] = "Todo List item could not be deleted."
	 	end
	 	redirect_to @todo_list 
	end

	def completed?
   		!completed_at.blank?
  	end

	def complete
		if @todo_item.completed?
	 		@todo_item.update_attribute(:completed_at, blank?)
	 		notice = "Todo item incomplete"
	 	else
	 		@todo_item.update_attribute(:completed_at, Time.now)
	 		notice = "Todo item completed"
	 	end
	 	redirect_to @todo_list, notice: notice
	end

	private
		def set_todo_list
		 @todo_list = TodoList.find(params[:todo_list_id])
		end
		def set_todo_item
		 @todo_item = @todo_list.todo_items.find(params[:id])
		end
		def todo_item_params
		 params[:todo_item].permit(:content, :priority)
		end
	end
