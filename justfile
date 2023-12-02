# Build and serve the site with unreleased posts
serve:
  cargo run -p serve
  
# Build and serve the site with unreleased posts
preview:
  PREVIEW=1 cargo run -p serve

# Build the site statically
build:
  cargo r
