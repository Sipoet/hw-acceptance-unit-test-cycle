require 'rails_helper'

RSpec.describe Movie, type: :model do
    describe 'with_director active recrod scope method' do
        before :each do
            [
                {title: 'Star Wars', director: 'George Lucas'},
                {title: 'Blade Runner', director: 'Ridley Scott'},
                {title: 'Alien'},
                {title: 'THX-1138', director: 'George Lucas'}
            ].each{|attribute|Movie.create!(attribute)}

        end
        it 'it should return the correct matches for movies by the same director' do
            result = Movie.with_director('George Lucas')
            expect(result.count).to eql(2)
            expect(result.map(&:title)).to include('Star Wars', 'THX-1138')
            result = Movie.with_director('Ridley Scott')
            expect(result.count).to eql(1)
            expect(result.map(&:title)).to include('Blade Runner')
        end
        it ' it should not return matches of movies by different directors' do
            result = Movie.with_director('George Lucas')
            expect(result.map(&:title)).not_to include('Blade Runner', 'Alien')
        end
    end
end
