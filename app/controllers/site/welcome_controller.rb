class Site::WelcomeController < SiteController
  def index
    @questions = Question.last_questions(params[:page])
    @subjects = Subject.all
  end
end
