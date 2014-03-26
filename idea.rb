class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id

  def initialize(attributes={})
    @title = attributes["title"]
    @description = attributes["description"]
    @rank = attributes["rank"] || 0
    @id = attributes["id"]
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank
    }
  end

  def save
    IdeaStore.create(to_h)
  end

  def database
    IdeaStore.database
  end

  def like!
    @rank += 1
  end

  def hate!
    @rank -= 1
  end

  def <=>(other)
    other.rank <=> rank
  end
end
