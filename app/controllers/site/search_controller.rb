class Site::SearchController < SiteController
  def questions
    # MODO DE PESQUISA COM ELASTICSEARCH
    
    # subir o servico sudo systemctl start elasticsearch.service
    # No model question.rb descomentar searchkick
    # Executar o comando <Question.reindex> uma vez. Coloquei aqui pois nao consegui acessar o rails console
    # Question.reindex 
    # @questions = Question.search(params[:term], page: params[:page], per_page: 5)

    
    
    # MODO DE PESQUISA NORMAL
    
    # Caso NAO queira funcionar utilizando o elasticsearch, dar stop no servico 
    # com o comando sudo systemctl stop elasticsearch.service e utilizar o modo abaixo. 
    # No model question.rb descomentar searchkick
    # Caso contrario startar o serviço e usar o modo acima
    @questions = Question._search_(params[:page], params[:term], params[:subject_id])
    @subjects = Subject.all #where(id: params[:subject_id] )
    # subject = Subject.find(params[:subject_id])
    # @subjects.new(subject)
  end

  def subject
    @questions = Question._search_subject_(params[:page], params[:subject_id])
    @subjects = Subject.all #where(id: params[:subject_id] )
  end
end
