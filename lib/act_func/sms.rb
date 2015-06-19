class Sms
  URL = "http://api.cnsms.cn/"
  require 'net/https'
  require 'uri'
  def Sms.send(uid,pwd,mobile,content)
    response = Func.post(URL,{'ac'=>"send",'uid'=>uid,'pwd'=>pwd,'mobile'=>mobile,'content'=>content})
    return response.body=="100"
  end
end