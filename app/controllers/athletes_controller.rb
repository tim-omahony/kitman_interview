class AthletesController < ApplicationController
  def index
    requests = Requests.new
    requests.key_request
    response_body = requests.api_request
      @athletes = response_body.map do |athlete|
        athlete_summary = athlete["summary"].map { |summary| Summary.new(summary["date"], summary["value"]) }
        Athlete.new(athlete['athlete'], athlete['test'], athlete_summary)
      end
  end
end
