class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :get_subjects, only: [:new, :edit]

  def index
    @questions = Question.includes(:subject)
                         .order(:id)
                         .page(params[:page])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params_question)
    if @question.save
      gerencia_chave_redis(@question)
      redirect_to admins_backoffice_questions_path, notice: "Questão cadastrada com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update    
    if @question.update(params_question)
      gerencia_chave_redis(@question)
      redirect_to admins_backoffice_questions_path, notice: "Questão atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      gerencia_chave_redis(@question)
      redirect_to admins_backoffice_questions_path, notice: "Questão excluída com sucesso!"
    else
      render :index
    end
  end

  private
  
  def params_question
    params.require(:question).permit(:description, :subject_id,
       answers_attributes: [:id, :description, :correct, :_destroy])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def get_subjects
    @subjects = Subject.all
  end

  def gerencia_chave_redis(question)
    question.answers.find_each do |answer|
      if Rails.cache.exist?(answer.id) # so entra aqui no update e destroy
        Rails.cache.delete(answer.id) 
      end  
      if params[:action] != 'destroy' 
        Rails.cache.write(answer.id, "#{question.id}@@#{answer.correct}") 
      end  
    end
  end  

end
