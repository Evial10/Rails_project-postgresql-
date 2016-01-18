require 'translator_api'
class TranslationsController < ApplicationController
  
  before_filter :authentication  
    
  def new 
    @langs, = create_translator("en").get_list
    @translation = Translation.new
  end
  
  def index   
    @translations = current_user.translation    
    @langs, = create_translator("en").get_list
  end
  
  def destroy
    Translation.find(params[:id]).destroy
    redirect_to translations_path
  end
  
  def edit
    @langs, = create_translator("en").get_list
    @translation = Translation.find(params[:id])
  end
  
  def update    
    @translation = Translation.find(params[:id])
    translate_params
    if @translation.update_attributes(translation_params)     
      redirect_to translations_path
    else
      render 'edit' 
    end 
  end
  
  def create
    translate_params
    current_user.translation.create(translation_params)
    #@translation = Translation.new(translation_params)    
    #if @translation.save
      redirect_to translations_path
  #  else
  #    render 'new' 
   # end  
  end
  
  private
  
  def authentication
    unless current_user
      redirect_to sign_in_path
    end
  end
  
  def translation_params
    params.require(:translation).permit(:language, :text, :translated_text)
  end
    
  def translate_params
    params[:translation][:translated_text] = create_translator(params[:translation][:language]).translate(params[:translation][:text])
  end
  
  def create_translator(lang)
    TranslatorAPI::Translator.new('trnsl.1.1.20151124T095711Z.d41f13a82e427408.736db2b43c90575b5934e1b988554b94947240e1', lang)
  end

end
