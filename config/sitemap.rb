# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://auto-glossary.com"

SitemapGenerator::Sitemap.create do
  # Add main pages
  add glossary_path, priority: 0.9, changefreq: 'daily'
  add demo_path, priority: 0.7, changefreq: 'weekly'

  # Add individual glossary terms
  # Fetching all terms from the Wikipedia glossary service
  terms = WikipediaGlossaryService.fetch_glossary_terms
  terms.each do |term, _definition|
    # Each term can be accessed via the glossary page with the term as a URL fragment
    # We won't add individual definition API endpoints, but we could add term-specific pages if they exist
    add "#{glossary_path}##{CGI.escape(term.downcase.gsub(' ', '-'))}",
        priority: 0.6,
        changefreq: 'monthly'
  end
end
