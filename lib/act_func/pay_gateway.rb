#gemfile中加入 gem 'iconv'
module ActFunc
  class PayGateway
    require 'net/https'
    require 'uri'
    # 支付接口地址
    URL_UTF8 = "https://pay3.chinabank.com.cn/PayGate?encoding=UTF-8"
    # 图片和css文件地址
    URL = "https://pay3.chinabank.com.cn"
    # 功能：网银在线，网管支付;
    # 参数：
    #   v_mid：商户编号
    #   key：商户md5密钥
    #   v_url：支付成功后跳转的页面
    #   remark2：异步订单状态地址
    #   v_oid：订单编号
    #   v_amount：订单金额
    #   v_moneytype：支付货币类型
    def self.pay(v_mid, key, v_url, remark2, v_oid, v_amount, v_moneytype = "CNY")
      v_md5info = Digest::MD5.hexdigest(v_amount.to_s + v_moneytype + v_oid + v_mid + v_url + key).upcase
      response = Func.post(URL_UTF8, {'v_mid' => v_mid, 'v_oid' => v_oid, 'v_amount' => v_amount, 'v_moneytype' => v_moneytype, 'v_url' => v_url, 'v_md5info' => v_md5info, 'remark2' => remark2})
      html = Iconv.iconv('utf-8', 'gbk', response.body).first
      html.scan(/[href|src]=("[^"]*.[css|js|gif|jpg]")/).each do |h|
        html = html.gsub(h[0], URL+eval(h[0]).gsub('..', ''))
      end
      html
    end

    # 功能：自动验证结果
    # 参数：
    # params参数
    # key商户的md5密钥
    # 返回：如果支付成功返回订单号，否则返回nil
    def self.receive(params, key)
      v_oid = params["v_oid"]
      v_pstatus = params["v_pstatus"]
      v_md5str = params["v_md5str"] #该参数的MD5字符串的顺序为：v_oid，v_pstatus，v_amount，v_moneytype，key
      v_amount = params["v_amount"]
      v_moneytype = params["v_moneytype"]
      # 20（表示支付成功）
      # 30（表示支付失败）
      if v_pstatus=="20" && v_md5str==Digest::MD5.hexdigest(v_oid+v_pstatus+v_amount+v_moneytype+key)
        return params["v_oid"]
      else
        return nil
      end
    end
  end
end