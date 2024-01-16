class CommentsController < ApplicationController

  #el código aprovecha algunos de los métodos disponibles para una asociación. Usamos el método de creación en @article.
  # comments para crear y guardar el comentario. Esto vinculará automáticamente el comentario para que pertenezca a ese artículo
  # en particular.
  #
  # Una vez que hayamos realizado el nuevo comentario, enviamos al usuario de regreso al artículo original utilizando el asistente
  # Article_path(@article). Como ya hemos visto, esto llama a la acción show del ArticlesController que a su vez representa
  # la plantilla show.html.erb. Aquí es donde queremos que se muestre el comentario, así que agreguémoslo
  # a app/views/articles/show.html.erb.
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to articles_path(@article)
  end

  def destroy
    #@article = Article.find(params[:article_id]): Aquí, estás buscando un artículo en la base de datos utilizando el modelo Article
    # (supongo que tienes un modelo llamado Article) y el valor proporcionado en params[:article_id]. params es un hash que contiene los
    # parámetros pasados en la solicitud HTTP. En este contexto, params[:article_id] se usa para identificar el artículo al que pertenece el
    # comentario que se va a eliminar. El artículo se asigna a la variable de instancia @article.
    @article = Article.find(params[:article_id])

    #@comment = @article.comments.find(params[:id]): Aquí, estás buscando un comentario asociado a ese artículo. Supongo que tienes una
    # elación entre Article y Comment en tu modelo de datos. @article.comments asume que has definido una asociación en tu modelo Article
    # que te permite acceder a los comentarios asociados a ese artículo. Luego, estás buscando un comentario específico utilizando el valor
    @comment = @article.comments.find(params[:id])
    @comment.destroy

    #redirect_to article_path(@article), status: :see_other: Después de eliminar el comentario, estás redirigiendo al usuario a la vista del
    # artículo al que pertenecía el comentario. article_path(@article) genera la URL para ver el artículo, y status: :see_other establece el
    # código de estado HTTP en 303 ("See Other"), lo que indica que la solicitud se completó y el navegador debe seguir el enlace proporcionado
    # para continuar. En este caso, el navegador se redirige a la página del artículo una vez que se ha eliminado el comentario.
    # En resumen, este código se utiliza para eliminar un comentario asociado a un artículo y luego redirigir al usuario a la página de dicho
    # artículo después de la eliminación.
    redirect_to article_path(@article), status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
