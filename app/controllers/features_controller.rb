class FeaturesController < ApplicationController
  def index
    page, per_page = params[:page].to_i, params[:per_page].to_i

    unless page >= 1
      return render json: { error: "page must be greater or equal than 1" }, status: :bad_request
    end

    unless per_page.between?(1, 1000)
      return render json: { error: "per_page must be between 1 and 1000." }, status: :bad_request
    end

    filters = params[:mag_type]
    offset = per_page.to_i * (page.to_i - 1)

    features = if filters
      Feature.where(mag_type: filters)
    else
      Feature.all
    end

    features_with_pagination = features.limit(per_page).offset(offset)
    render json: {
      pagination: {
        current_page: page,
        per_page: per_page,
        total: features.count 
      },
      data: features_with_pagination.map { |f| format f }
    }
  end

  def show  
    begin
      feature = Feature.find(params[:id])
      render json: format(feature)
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Feature not found' }, status: :not_found
    end
  end

  private 
  
  def format feature
    return {
      id: feature["id"],
      type: "feature",
      attributes: {
        external_id: feature["external_id"],
        magnitude: feature["magnitude"],
        place: feature["place"],
        time: feature["time"],
        tsunami: feature["tsunami"],
        mag_type: feature["mag_type"],
        title: feature["title"],
        coordinates: {
          longitude: feature["longitude"],
          latitude: feature["latitude"]
        }
      },
      links: {
        external_url: feature["external_url"]
      },
      comments: feature.comments.map { |c| { id: c.id, text: c.body, created_at: c.created_at}}
    }
  end
end
