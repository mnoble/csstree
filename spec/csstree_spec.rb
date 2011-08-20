require "spec_helper"

describe CSSTree do
  let(:tree) { CSSTree.new }

  it "parses single-line css" do
    tree.parse "body { color: #000000; }"
    tree.find("body").color.should == "#000000"
  end

  it "converts dashed properties to underscores" do
    tree.parse "body { background-color: #FFFFFF; }"
    tree.find("body").background_color.should == "#FFFFFF"
  end

  it "parses multiple lines of css" do
    tree.parse <<-CSS
      body { color: #000000; }
      p    { color: #111111; }
      ul   { list-style: none; }
    CSS
    tree.selectors.should == %w(body p ul)
  end

  it "parses rules with multiple selectors" do
    tree.parse "body, img { margin: 0 }"
    tree.selectors.should == %w(body img)
  end

  it "parses multiline rules" do
    tree.parse <<-CSS
    body {
        color: #000000;
        padding: 10px;
    }
    CSS
    tree.find("body").padding.should == "10px"
  end

  it "renders css back to text" do
    tree.parse "body { background: #A2A2A2; }"
    tree.find("body").background = "#999999"
    tree.render.should == "body { background: #999999; }"
  end
end
