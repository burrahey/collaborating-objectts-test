describe Category do
  let(:category){Category.new.tap {|c| c.name = "Fiction"}}
  let(:story){Story.new.tap{|s| s.name = "The Old Man and the Sea"}}

  it 'has a name' do

    #Expectation
    expect(category.name).to eq ("Fiction")
  end

  context 'has many stories' do
      describe  '#stories' do
        it 'has an empty array of stories when initialized' do
          expect(category.stories).to match_array([])
        end

        it 'returns a frozen copy of the stories array' do
          expect(category.stories).to be_frozen
        end

      end

      describe '#add_story' do
        it 'can add a story instances onto it' do
          category.add_story(story)
          expect(category.stories).to include(story)
        end
        it 'reciprocates assigning this category as the story\'s category' do
          category.add_story(story)
          expect(story.category).to eq(category)
        end
        it 'only allows stories to be pushed onto it' do
          story = "Old Man and the Sea"
          expect{category.add_story(story)}.to raise_error(AssociationTypeMismatchError)
        end
      end
    end
  context 'has many categories through stories' do
    it 'returns the collection of unique category instances based on the stories' do
      author = Author.new
      fiction = Category.new{|c| c.name = "Fiction"}
      non_fiction = Category.new{|c| c.name = "Non-Fiction"}

      story_1 = Story.new.tap{|s| s.name = "Old Man and the Sea"; s.category = fiction}
      story_2 = Story.new.tap{|s| s.name = "The Sun Also Rises"; s.category = fiction}
      story_3 = Story.new.tap{|s| s.name = "A Moveable Feast"; s.category = non_fiction}

      author.add_story(story_1)
      author.add_story(story_2)
      author.add_story(story_3)

      expect(author.categories).to match_array([fiction, non_fiction])
    end
  end

end
