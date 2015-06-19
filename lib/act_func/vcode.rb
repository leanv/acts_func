#first gem 'rmagick'
class Vcode
  #controller
  #def getcode
  #  vcode = Vcode.getvcode
  #  session[:code]=vcode[:code]
  #  send_data vcode[:img], content_type: 'image/jpeg', disposition: 'inline'
  #end
  #view
  # <img src="/getcode">
  #Vcode.getvcode(90,40,24)
  #w宽，h高，fontsize字体大小
  #返回json类型
  def self.getvcode(w=90,h=40,fontsize=24)
    #创建画布
    img = Magick::Image.new(w, h) {
      self.background_color = 'white'
      self.format="JPG"
    }
    text= Magick::Draw.new
    text.pointsize = fontsize
    text.kerning = -1
    text.fill('blue')
    #随机文字
    code=""
    4.times{code << (97 + rand(26)).chr}
    #设置文字
    text.text(rand(w/2-5),h/2-5+ rand(h/2), code)
    #随机直线
    for i in 1..rand(4)
      text.line(rand(w), rand(h), rand(w), rand(h)) #直线
    end
    text.fill('blue')
    #燥点
    for i in 1..280
      text.point(rand(w), rand(h))
    end
    text.draw(img)
    #模糊
    img = img.sketch(0, 10, 50)
    #扭曲
    img = img.wave(5.5, 50)
    #返回图片数据流
    {img: img.to_blob,code: code}
  end
end
