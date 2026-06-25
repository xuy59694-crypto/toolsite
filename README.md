# 免费在线工具箱 - 部署指南

## 📁 项目结构

```
toolsite/
├── index.html                 # 首页（工具导航）
├── sitemap.xml               # 搜索引擎网站地图
├── robots.txt                # 搜索引擎爬虫规则
├── vercel.json               # Vercel 部署配置
├── css/
│   └── style.css             # 全局样式
├── js/
│   └── common.js             # 共享函数库
└── tools/
    ├── image-compress.html   # 图片压缩
    ├── image-convert.html    # 图片格式转换
    ├── qrcode.html           # 二维码生成器
    ├── color-picker.html     # 颜色选择器
    ├── json-formatter.html   # JSON格式化
    ├── base64.html           # Base64编解码
    ├── text-diff.html        # 文本差异对比
    ├── url-encode.html       # URL编解码
    ├── word-count.html       # 字数统计
    ├── md5.html              # MD5/SHA加密
    ├── regex-tester.html     # 正则表达式测试
    └── uuid-generator.html   # UUID生成器
```

## 🚀 部署步骤

### 方法一：Vercel 部署（推荐，免费）

1. 访问 https://vercel.com 注册账号（用 GitHub 账号即可）
2. 把整个 `toolsite` 文件夹上传到你的 GitHub 仓库
3. 在 Vercel 导入该仓库，自动部署
4. 你会得到一个免费域名：`xxx.vercel.app`

### 方法二：Cloudflare Pages（免费）

1. 访问 https://pages.cloudflare.com
2. 连接 GitHub 仓库，自动部署
3. 获得 `xxx.pages.dev` 域名

### 方法三：Netlify（免费）

1. 访问 https://netlify.com
2. 拖拽 `toolsite` 文件夹到网页即可部署

## 💰 变现配置

### 1. Google AdSense（广告）

部署后，去 https://adsense.google.com 申请账号：

1. 用你的网站域名注册
2. 获取广告代码中的 `data-ad-client` ID
3. 替换所有 HTML 文件中 `ca-pub-XXXXXXXXXXXXXXXX` 为你的 ID
4. 等待 Google 审核通过（通常 1-2 周）

### 2. 淘宝联盟 / 京东联盟（返利）

1. 注册淘宝联盟：https://pub.alimama.com
2. 注册京东联盟：https://union.jd.com
3. 在工具页面底部添加相关的商品推广链接
4. 用户点击购买后你获得佣金

### 3. 百度联盟（国内流量）

如果你的流量主要来自百度搜索，可以考虑百度联盟：
- https://union.baidu.com

## 📈 如何获取流量

1. **提交给搜索引擎**：
   - 百度站长平台：https://ziyuan.baidu.com
   - Google Search Console：https://search.google.com/search-console
   - 提交你的 sitemap.xml

2. **SEO 优化已内置**：
   - 每个页面已写好 title/description/keywords
   - sitemap.xml 已包含所有页面

3. **社交分享**：
   - 在知乎、小红书分享你的工具链接
   - 工具好用自然有人转发

## 🔄 自动化内容更新（可选）

部署后可以配置 GitHub Actions 定时更新内容：

1. 定期生成新的工具页面
2. 更新博客内容
3. 自动提交搜索引擎 ping

## ⚠️ 重要提醒

- 部署前记得替换所有 HTML 中的 `ca-pub-XXXXXXXXXXXXXXXX` 为你自己的 AdSense ID
- sitemap.xml 中的 `your-site.com` 需要替换为你的实际域名
- 建议绑定自定义域名（可选），看起来更专业
- 广告审核通过前不要放太多广告位，先以内容为主

## 📞 技术说明

- 纯静态网站，无需服务器，部署即运行
- 所有工具在浏览器本地处理，数据不上传
- 响应式设计，手机和电脑都能用
- 零依赖（除二维码工具使用 CDN 加载的 qrcodejs）
