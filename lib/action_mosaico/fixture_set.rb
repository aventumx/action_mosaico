# frozen_string_literal: true

module ActionMosaico
  # Fixtures are a way of organizing data that you want to test against; in
  # short, sample data.
  #
  # To learn more about fixtures, read the
  # {ActiveRecord::FixtureSet}[rdoc-ref:ActiveRecord::FixtureSet] documentation.
  #
  # === YAML
  #
  # Like other Active Record-backed models, ActionMosaico::RichText records inherit
  # from ActiveRecord::Base instances and therefore can be populated by
  # fixtures.
  #
  # Consider a hypothetical <tt>Article</tt> model class, its related fixture
  # data, as well as fixture data for related ActionMosaico::RichText records:
  #
  #   # app/models/article.rb
  #   class Article < ApplicationRecord
  #     has_rich_text :content
  #   end
  #
  #   # tests/fixtures/articles.yml
  #   first:
  #     title: An Article
  #
  #   # tests/fixtures/action_mosaico/rich_texts.yml
  #   first_content:
  #     record: first (Article)
  #     name: content
  #     body: <div>Hello, world.</div>
  #
  # When processed, Active Record will insert database records for each fixture
  # entry and will ensure the Action Mosaico relationship is intact.
  class FixtureSet
    # Fixtures support Action Mosaico attachments as part of their <tt>body</tt>
    # HTML.
    #
    # === Examples
    #
    # For example, consider a second <tt>Article</tt> record that mentions the
    # first as part of its <tt>content</tt> HTML:
    #
    #   # tests/fixtures/articles.yml
    #   second:
    #     title: Another Article
    #
    #   # tests/fixtures/action_mosaico/rich_texts.yml
    #   second_content:
    #     record: second (Article)
    #     name: content
    #     body: <div>Hello, <%= ActionMosaico::FixtureSet.attachment("articles", :first) %></div>
    def self.attachment(fixture_set_name, label, column_type: :integer)
      signed_global_id = ActiveRecord::FixtureSet.signed_global_id fixture_set_name, label,
                                                                   column_type: column_type, for: ActionMosaico::Attachable::LOCATOR_NAME

      %(<action-text-attachment sgid="#{signed_global_id}"></action-text-attachment>)
    end
  end
end
