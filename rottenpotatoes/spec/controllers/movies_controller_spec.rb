require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    describe "Similar Movie" do

        it 'should return the correct matches for movies by the same director ' do
            movie_with_director1 = instance_double("Movie", id: 1, title: 'title1', director: 'director')
            movie_with_director2 = instance_double("Movie", id: 2, title: 'title2', director: 'director')
            expect(Movie).to receive(:find).with('1').and_return(movie_with_director1)
            expect(Movie).to receive(:with_director).with('director').and_return([movie_with_director1,movie_with_director2])
            get :similar_movies, {id: '1'}
            expect(response).to render_template('index')
        end

        it 'should redirect to home path if director is empty' do
            movie_without_director = instance_double("Movie", id: 4, title: 'title2', director: nil)
            expect(Movie).to receive(:find).with('4').and_return(movie_without_director)
            expect(Movie).not_to receive :with_director
            get :similar_movies, {id: '4'}
            expect(response).to redirect_to(movies_path)
        end
    end
end
