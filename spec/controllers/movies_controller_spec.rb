require 'spec_helper'

describe MoviesController do
  
  describe 'find movies with same director' do
    before :each do
      @fake_movie = [mock('movie')]
      @fake_movie.stub(:director).and_return('Pete')
      # @no_director = [mock('movie')]
      # @no_director.stub(:director).and_return('')
      @fake_results = [mock('movie1'), mock('movie2')]
    end

    it 'should call the model method that finds the movies details' do
      Movie.should_receive(:find).with('123')
        .and_return(@fake_movie)
      get  :similar, :id => "123"
    end

    describe 'if director present' do

      it 'should call the model method that finds other movies by director ' do
        Movie.stub(:find).and_return(@fake_movie)
        Movie.should_receive(:find_all_by_director).with('Pete')
          .and_return(@fake_results)
        get  :similar, :id => "123"
      end
    end

    describe 'if no director present' do

      before :each do
        @no_director = [mock('movie')]
        @no_director.stub(:title).and_return('title')
        @no_director.stub(:director).and_return('')
      end

      it 'should return to the home page ' do
        # debugger
        Movie.stub(:find).and_return(@no_director)
        get  :similar, :id => "321"
        response.should redirect_to movies_path
      end
    end

    describe 'after valid search' do

      before :each do
        Movie.stub(:find).and_return(@fake_movie)
        Movie.stub(:find_all_by_director).and_return(@fake_results)
        get  :similar, :id => "123"
      end

      it 'should select the Search Results template for rendering' do 
        response.should render_template('similar')
      end

      it 'should make the search results available to that template' do
        assigns(:movies).should == @fake_results
      end

    end

  end

end