class Pagenator
  def initialize(collection)
    @collection = collection
  end

  def fetch(opts = {})
    page = opts[:page] || 0
    per = opts[:per] || 30
    sort_by = opts[:sort_by]
    order = opts[:order] || 'asc'

    sorted = sort_by ? sort_by_attr(sort_by,order) : @collection

    offset = page * per
    sorted.slice(offset,per)
  end

  private

  def sort_by_attr(sort_by, order)
    attr_is_hash = @collection.select{|obj| obj[sort_by] }.first[sort_by].is_a?(Hash)

    non_nils = @collection.select{|obj| obj[sort_by] }
    nils = @collection.select{|obj| !obj[sort_by] }

    sorted = if !attr_is_hash
      non_nils.sort{|a,b| a[sort_by].downcase <=> b[sort_by].downcase} + nils
    else
      non_nils.sort{ |a,b| a[sort_by].keys.sort <=> b[sort_by].keys.sort } + nils
    end

    order == 'asc' ? sorted : sorted.reverse
   end
end
