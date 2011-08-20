# CSSTree

Ultra-simple CSS parser.

## Install

    gem install csstree

## Usage
### Parsing CSS

```ruby
tree = CSSTree.parse("body { background-color: #FFFFFF; color: #000000; }")
# => #<CSSTree:0x123456>
```

### Finding Rules For A Selector

```ruby
tree.find("body")
# => #<OpenStruct background_color="#FFFFFF" color="#000000">
```

### Access Properties

```ruby
tree.find("body").color
# => "#000000"
```

### Access Dashed Property Names Using Underscores

```ruby
tree.find("body").background_color
# => "#FFFFFF"
```

### Manipulating the Tree

```ruby
tree.find("body").color = "#A3A3A3"
# => "#A3A3A3"
```

### Rendering Normal CSS

```ruby
tree.render
# => "body { background-color: #FFFFFF; color: #A3A3A3; }
```

