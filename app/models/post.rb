class Post < ActiveRecord::Base
  validates :slug, presence: true, uniqueness: true
  acts_as_url :title, :url_attribute => :slug

  def to_param
    slug
  end

  def external?
    !url.blank?
  end

  def has_more_tag
    content =~ /<!--\s*more\s*-->/i ? true : false
  end

  def excerpt
    if content.index(/<!--\s*more\s*-->/i)
      content.split(/<!--\s*more\s*-->/i)[0]
    else
      content
    end
  end
end
