Gem::Specification.new do |s|
  s.name        = 'act-func'
  s.version     = '1.1.1'
  s.date        = '2015-06-20'
  s.summary     = "act-func!"
  s.description = "vcode,fileupload,pager,func,pay_gateway,tmagick;"
  s.authors     = ["lean"]
  s.email       = '54850915@qq.com' 
  s.files       = `git ls-files`.split("\n")
  s.extra_rdoc_files = ['README.md']
  s.require_paths = ['lib']
  s.add_development_dependency 'iconv', ['>= 0']
  s.add_development_dependency 'rmagick', ['>= 0']
  s.homepage    = 'http://rubygems.org/gems/act-func'
  s.license     = 'act-func'
end
