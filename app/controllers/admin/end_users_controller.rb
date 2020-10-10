class Admin::EndUsersController < ApplicationController
	def index
		@end_users = EndUser.with_deleted #論理削除されたデータも「含める」  削除されたデータのみを表示したい場合はModel.only_deleted
	end
end
