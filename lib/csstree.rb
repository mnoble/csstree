require "ostruct"
require "forwardable"

class CSSTree
  VERSION       = "0.0.1"
  RULESET_REGEX = /([^{]*){([^}]*)}/

  include Enumerable
  extend  Forwardable

  def_delegators :"@tree", :each, :keys, :values, :[], :[]=, :includes?
  alias :selectors :keys
  alias :declarations :values

  def self.parse s
    new.parse s
  end

  def initialize
    @tree = {}
  end

  def parse s
    @tree = Hash[*trim(s).scan(RULESET_REGEX).collect { |a| parse_block *a }.flatten]
    self
  end

  def find s
    @tree[s]
  end

  def render
    @tree.map { |s,d| "#{s.strip} { #{render_declarations d} }" }.join("\n")
  end

  def to_s
    "#<CSSTree:0x#{self.object_id}>"
  end

private

  def render_declarations d
    d.marshal_dump.map { |k,v| [deunderscore(k), v].join(": ") }.join("; ") + ";"
  end

  def parse_declarations d
    r = d.strip.split(";").map { |d| d.split(":") }.map { |p,v| [underscore(p), v.strip] }
    OpenStruct.new Hash[r]
  end

  def parse_block s, d
    s.split(",").collect { |s| [s.strip, parse_declarations(d)] }.flatten
  end

  def trim s
    s.gsub("\n", " ").gsub(/\s{2,}/, " ")
  end

  def underscore s
    s.to_s.gsub("-", "_").strip
  end

  def deunderscore s
    s.to_s.gsub("_", "-").strip
  end
end

