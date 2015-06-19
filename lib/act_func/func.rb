module ActFunc
  class Func
    # 判断是否含有中文
    def self.ischinese(temp)
      (temp=~/[\u4e00-\u9fa5]/).nil? ? false : true
    end

    # 判断是否只含有中英文，数字和下划线
    def self.iscn_zn_num(temp)
      (temp=~/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/).nil? ? false : true
    end

    # 格式化时间
    def self.formattime(time)
      time.strftime("%Y-%m-%d %H:%M:%S")
    end

    # 限制文字长度
    def self.truncate_u(text, length = 30, truncate_string = "...")
      l=0
      char_array=text.unpack("U*")
      char_array.each_with_index do |c, i|
        l = l+ (c<127 ? 0.5 : 1)
        if l>=length
          return char_array[0..i].pack("U*")+(i<char_array.length-1 ? truncate_string : "")
        end
      end
      return text
    end

    # 金额大写小转换
    def self.uppercase(nums)
      cstr = ["零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"]
      cn_nums1 = ["元", "拾", "佰", "仟", "萬", "拾", "佰", "仟", "億", "拾", "佰", "仟"]
      cn_nums2 = ['分', '角']
      s = ""
      # 整数部分
      array = nums.to_s.split(".")
      p h = array[0].to_s.split(//)
      ai = h.count
      h.each_with_index do |a, j|
        s+=cstr[a.to_i]+cn_nums1[ai-1]
        ai=ai-1
      end
      # 小数部分
      p h1 = array[1].to_s.split(//)
      aj = h1.count
      h1.each_with_index do |o, p|
        s+=cstr[o.to_i]+cn_nums2[aj-1]
        aj=aj-1
      end
      rstr = ""
      rstr=s.gsub("拾零", "拾")
      rstr=rstr.gsub("零拾", "零");
      rstr=rstr.gsub("零佰", "零");
      rstr=rstr.gsub("零仟", "零");
      rstr=rstr.gsub("零萬", "萬");
      for i in 1..6 do
        rstr=rstr.gsub("零零", "零");
        rstr=rstr.gsub("零萬", "零");
        rstr=rstr.gsub("零億", "億");
        rstr=rstr.gsub("零零", "零");
      end
      rstr=rstr.gsub("零角", "零");
      rstr=rstr.gsub("零分", "");
      rstr=rstr.gsub("零元", "");
    end

    require 'net/http'
    require 'net/https'
    require 'uri'

    # get请求
    # 参数url：网址，header：请求头json类型如：{'Accept' => 'application/json', 'X-Requested-With' => 'XMLHttpRequest'}
    # 返回response对象，response.code 状态200/304/404;response.body 内容
    def self.get(url, params=nil, header=nil)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      request = Net::HTTP::Get.new(uri.request_uri)
      if !params.blank?
        request.form_data = params
      end
      if !header.nil?
        request.initialize_http_header(header)
      end
      http.request(request)
    end

    def self.post(url, params=nil, header=nil)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      request = Net::HTTP::Post.new(uri.request_uri)
      if !params.blank?
        request.set_form_data(params)
      end
      if !header.nil?
        request.initialize_http_header(header)
      end
      http.request(request)
    end
  end
end
