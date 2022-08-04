require_relative 'lib/omniauth-adobe-analytics/version'

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-adobe-analytics'
  gem.version       = OmniAuthAdobeAnalytics::VERSION
  gem.license       = 'MIT'
  gem.summary       = %(An Adobe Analytics OAuth2 strategy for OmniAuth)
  gem.description   = %(An Adobe Analytics OAuth2 strategy for OmniAuth. This allows you to login with Adobe Analytics in your ruby app.)
  gem.authors       = ['Alexander Carvalho']
  gem.homepage      = 'https://github.com/burtcorp/omniauth-adobe_analytics'

  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.6'
  gem.add_runtime_dependency 'oauth2', '~> 1.1'
end