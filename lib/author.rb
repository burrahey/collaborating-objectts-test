class Author
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
    story.author = self unless story.author == self
  end

  def bibliography
    self.stories.collect{|s| s.name}
    # @stories.collect(&:name)
  end

  def categories
    self.stories.collect{|s| s.category}.uniq
  end

end
