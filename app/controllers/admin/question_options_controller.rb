class Admin::QuestionOptionsController < AdminController
  before_action :set_question, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_question_option, only: [:show, :edit, :update, :destroy]

  def index
    @question_options = QuestionOption.all
  end

  def show
  end

  def new
    @question_option = QuestionOption.new
    render layout: false
  end

  def edit
    render layout: false
  end

  def sort
    params[:question_option].each_with_index do |id, index|
      QuestionOption.find(id).update(position: index + 1)
    end

    head :ok
  end

  def update_title
    question_option = QuestionOption.where(id: params[:question_option_id]).first
    question_option.update!(text: params[:text])
    render json: question_option
  end

  def create
    text_array = question_option_params[:text].split("\n")
    position = @question.question_options.size + 1
    @question_options = []
    @errors = []
    result = false

    if text_array.length > 0
      text_array.each do | txt |
        question_option = QuestionOption.where(question_id: params[:question_id], text: txt).first
        if question_option
          @errors << "Question option already exists for text #{txt}"
          next
        end
        question_option = QuestionOption.new(question_id: params[:question_id], text: txt, value: txt, position: position)
        if question_option.save
          @question_options << question_option
          position += 1
        else
          @errors << question_option.errors.full_messages
        end
      end
    else
      question_option = QuestionOption.where(question_id: params[:question_id], text: params[:text]).first
      if question_option
        @errors << "Question option already exists for text #{params[:text]}"
      else
        question_option = QuestionOption.new(question_option_params)
        question_option.position = position
        if question_option.save
          @question_options << question_option
        else
          @errors << question_option.errors.full_messages
        end
      end
    end

    respond_to do |format|
      if @errors.empty?
        format.html { redirect_to questions_admin_form_path(@question.form), notice: 'Question option was successfully created.' }
        format.js { }
      else
        format.html { redirect_to questions_admin_form_path(@question.form), alert: "Question option could not be created! #{@errors.join(', ')}" }
        format.js { render json: @errors, status: :unprocessable_entity }        
      end
    end
  end

  def update
    @question_option.update(question_option_params)
    render :update, format: :js
  end

  def destroy
    @question_option.destroy
    head :ok
  end

  private
    def set_question_option
      @question_option = QuestionOption.find(params[:id])
    end

    def set_question
      @question = Question.find(params[:question_id])
    end

    def question_option_params
      params.require(:question_option).permit(
        :question_id,
        :text,
        :position,
        :value
      )
    end
end
