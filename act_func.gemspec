Gem::Specification.new do |s|
  s.name        = 'acts-func'
  s.version     = '1.1.0'
  s.date        = '2015-06-20'
  s.summary     = "acts-func!"
  s.description = "vcode,fileupload,pager,func,pay_gateway,tmagick;"
  s.authors     = ["lean"]
  s.email       = '54850915@qq.com' 
  s.files       = `git ls-files`.split("\n")
  s.extra_rdoc_files = ['README.rdoc']
  s.require_paths = ['lib']
  s.add_dependency 'iconv', ['>= 0']
  s.add_dependency 'rmagick', ['>= 0']
  s.homepage    = 'http://rubygems.org/gems/acts-func'
  s.license     = 'acts-func'
end
