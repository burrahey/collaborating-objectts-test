class Category
  attr_accessor :name

  def initialize
    @stories = []
  end

  def stories
    #make a duplicate, freeze it, and return that, so that no one can add stories by using a.stories << "some string", there's also no attr_accessor for this reason
    @stories.dup.freeze
  end

  def add_story(story)
    raise AssociationTypeMismatchError, "#{story.class} received, Story expected." if !story.is_a?(Story)
    @stories << story
    story.category = self unless story.category == self
  end

  def authors
    self.stories.collect{|s| s.author}.uniq
  end
end
