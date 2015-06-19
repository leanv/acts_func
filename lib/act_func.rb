module ActFunc
end
begin
  require 'rails'
rescue LoadError
  #do nothing
end
require 'act_func/fileupload'
require 'act_func/func'
require 'act_func/pager'
require 'act_func/pay_gateway'
require 'act_func/sms'
require 'act_func/tmagick'
require 'act_func/vcode'
