
# encoding: utf-8
module Entity
  class Base < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt.to_i }
    format_with(:to_string) { |dt| dt.to_s }
    format_with(:to_date_string) { |dt| dt.strftime("%F %T") }
  end
end
