module Or
  def self.included(base)
    base.class_eval do
      __or_fn = lambda do |*scopes|
        where = []
        joins = []
        includes = []

        # for some reason, flatten is actually executing the scope
        scopes = scopes[0] if scopes.size == 1
        scopes.each do |s|
          s = s.proxy_options
          begin
            where << merge_conditions(s[:conditions])
          rescue NoMethodError
            # I am ActiveRecord::Base. Only my subclasses define merge_conditions:
            where << subclasses.first.merge_conditions(s[:conditions])
          end
          #where << merge_conditions(s[:conditions])
          joins << s[:joins] unless s[:joins].nil?
          includes << s[:include] unless s[:include].nil?
        end
        scoped = self
        scoped = scoped.includes(includes.uniq.flatten) unless includes.blank?
        scoped = scoped.joins(joins.uniq.flatten) unless joins.blank?
        scoped.where(where.join(" OR "))
      end
      named_scope :or, __or_fn
    end
  end
end