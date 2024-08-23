class LinksController < ApplicationController

  def top_links
    @links = Link.order(access_count: :desc).limit(get_top_limit)
    render json: @links
  end

  def show
    short_code params.permit(:short_code)
    @link = Link.find_by(short_code: short_code)
    if !@link
      render json: { status: 'not found' }, status: :not_found
      return
    end
    render json: @link
  end

  def create
    data = link_params
    @link = Link.find_by(url: data[:url])
    if !@link
      data[:short_code] = get_short_code
      data[:access_count] = 0
      @link = Link.new(data)
      TitleFetchJob.perform_later(@link.id, @link.url)
    end

    if @link.save
      render json: @link, status: :created
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def link_params
      # TODO: proper validation
      params.require(:link).require(:url)
      params.require(:link).permit(:url)
    end

    def get_short_code
      Time.now.to_i.to_s(8)
    end

    def get_top_limit
      top_params = params.permit(:limit)
      # set const
      max_links = 100
      if !top_params[:limit]
        return max_links
      end
      top_params[:limit] > max_links ? max_links : top_params[:limit]
    end
end
