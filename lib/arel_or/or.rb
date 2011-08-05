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
          w = []
          s.where_clauses.each do |where_clause|
            w << where_clause
          end
          where << w.join(" AND ")

          joins << s.joins_values if s.joins_values.any?
          includes << s.includes_values if s.includes_values.any?
        end
        scoped = self
        # p self
        scoped = scoped.includes(includes.uniq.flatten) if includes.any?
        scoped = scoped.joins(joins.uniq.flatten) if joins.any?
        # p where.join(" OR ")
        scoped.where(where.join(" OR "))
      end
      scope :or, __or_fn
    end
  end
end