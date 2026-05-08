# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://auto-glossary.com"

SitemapGenerator::Sitemap.create do
  # Keep sitemap focused on canonical, content-rich pages.
  add "/docs", priority: 0.9, changefreq: "weekly"
  add "/glossary", priority: 0.7, changefreq: "weekly"
end
