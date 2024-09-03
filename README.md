28181视频服务器，直播推拉流服务器

### 1、CWQ-PUBLIC-VEDIO是一个流媒体服务的管理端
 github地址：https://github.com/chenweiquan-red/cwq-public-vedio.git
 
 fork from : https://gitee.com/pan648540858/wvp-GB28181-pro.git

完整的application.yaml：

```editorconfig
spring:
  # 设置接口超时时间
  mvc:
    async:
      request-timeout: 20000
  # [可选]上传文件大小限制
  servlet:
    multipart:
      max-file-size: 10MB
      max-request-size: 100MB
  # REDIS数据库配置
  redis:
    # [必须修改] Redis服务器IP, REDIS安装在本机的,使用192.168.10.250
    host: 192.168.10.252
    # [必须修改] 端口号
    port: 6379
    # [可选] 数据库 DB
    database: 4
    # [可选] 访问密码,若你的redis服务器没有设置密码，就不需要用密码去连接
    password: hhd@redis23.com
    # [可选] 超时时间
    timeout: 10000
    # [可选] 一个pool最多可分配多少个jedis实例
    poolMaxTotal: 1000
    # [可选] 一个pool最多有多少个状态为idle(空闲)的jedis实例
    poolMaxIdle: 500
    # [可选] 最大的等待时间(秒)
    poolMaxWait: 5
  # [必选] jdbc数据库配置
  datasource:
    type: com.zaxxer.hikari.HikariDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://192.168.10.252:3306/wvp?useUnicode=true&characterEncoding=UTF8&rewriteBatchedStatements=true&serverTimezone=PRC&useSSL=false&allowMultiQueries=true
    username: root
    password: hhd@2023
    hikari:
      connection-timeout: 20000             # 是客户端等待连接池连接的最大毫秒数
      initialSize: 10                       # 连接池初始化连接数
      maximum-pool-size: 200                # 连接池最大连接数
      minimum-idle: 5                       # 连接池最小空闲连接数
      idle-timeout: 300000                  # 允许连接在连接池中空闲的最长时间（以毫秒为单位）
      max-lifetime: 1200000                 # 是池中连接关闭后的最长生命周期（以毫秒为单位)


# 修改分页插件为 postgresql， 数据库类型为mysql不需要
#pagehelper:
#    helper-dialect: postgresql

# [可选] WVP监听的HTTP端口, 网页和接口调用都是这个端口
server:
  port: 18080
  # [可选] HTTPS配置， 默认不开启
  ssl:
    # [可选] 是否开启HTTPS访问
    enabled: false
    # [可选] 证书文件路径，放置在resource/目录下即可，修改xxx为文件名
    key-store: classpath:xxx.jks
    # [可选] 证书密码
    key-store-password: password
    # [可选] 证书类型， 默认为jks，根据实际修改
    key-store-type: JKS
    # 配置证书可以使用如下两项，如上面二选一即可
    # PEM 编码证书
    certificate: xx.pem
    #   私钥文件
    certificate-private-key: xx.key

# 作为28181服务器的配置
sip:
  # [必须修改] 本机的IP，对应你的网卡，监听什么ip就是使用什么网卡，
  # 如果要监听多张网卡，可以使用逗号分隔多个IP， 例如： 192.168.1.4,10.0.0.4
  # 如果不明白，就使用0.0.0.0，大部分情况都是可以的
  # 请不要使用192.168.10.43，任何包括localhost在内的域名都是不可以的。
  ip: 192.168.10.250
  # [可选] 没有任何业务需求，仅仅是在前端展示的时候用
  show-ip: 0.0.0.0
  # [可选] 28181服务监听的端口
  port: 5060
  # 根据国标6.1.2中规定，domain宜采用ID统一编码的前十位编码。国标附录D中定义前8位为中心编码（由省级、市级、区级、基层编号组成，参照GB/T 2260-2007）
  # 后两位为行业编码，定义参照附录D.3
  # 3701020049标识山东济南历下区 信息行业接入
  # [可选]
  domain: 4401020049
  # [可选]
  id: 44010200492000000001
  # [可选] 默认设备认证密码，后续扩展使用设备单独密码, 移除密码将不进行校验
  password: admin123
  # [可选] 国标级联注册失败，再次发起注册的时间间隔。 默认60秒
  register-time-interval: 60
  # [可选] 云台控制速度
  ptz-speed: 50
  # TODO [可选] 收到心跳后自动上线， 重启服务后会将所有设备置为离线，默认false，等待注册后上线。设置为true则收到心跳设置为上线。
  # keepalliveToOnline: false
  # 是否存储alarm信息
  alarm: false

# 做为JT1078服务器的配置
jt1078:
  #[必须修改] 是否开启1078的服务
  enable: true
  #[必修修改] 1708设备接入的端口
  port: 21078
  #[可选] 设备鉴权的密码
  password: admin123

#zlm 默认服务器配置
media:
  # [必须修改] zlm服务器唯一id，用于触发hook时区别是哪台服务器,general.mediaServerId
  id: 035c73f7bb6b
  # [必须修改] zlm服务器的内网IP
  ip: 192.168.10.250
  # [可选] 返回流地址时的ip，置空使用 media.ip
  stream-ip:
  # [可选] wvp在国标信令中使用的ip，此ip为摄像机可以访问到的ip， 置空使用 media.ip
  sdp-ip: 192.168.10.250
  # [可选] zlm服务器的hook所使用的IP, 默认使用sip.ip
  hook-ip: 192.168.10.250
  # [必须修改] zlm服务器的http.port
  http-port: 8001
  # [可选] zlm服务器的http.sslport, 置空使用zlm配置文件配置
  http-ssl-port:
  # [可选] zlm服务器的rtmp.port, 置空使用zlm配置文件配置
  rtmp-port:
  # [可选] zlm服务器的rtmp.sslport, 置空使用zlm配置文件配置
  rtmp-ssl-port:
  # [可选] zlm服务器的 rtp_proxy.port, 置空使用zlm配置文件配置
  rtp-proxy-port:
  # [可选] zlm服务器的 rtsp.port, 置空使用zlm配置文件配置
  rtsp-port:
  # [可选] zlm服务器的 rtsp.sslport, 置空使用zlm配置文件配置
  rtsp-ssl-port:
  # [可选] 是否自动配置ZLM, 如果希望手动配置ZLM, 可以设为false, 不建议新接触的用户修改
  auto-config: false
  # [可选] zlm服务器的hook.admin_params=secret
  secret: l5DPpqy3YbPE5oaJCL2AxOBOuAVwEvlG
  # 启用多端口模式, 多端口模式使用端口区分每路流，兼容性更好。 单端口使用流的ssrc区分， 点播超时建议使用多端口测试
  rtp:
    # [可选] 是否启用多端口模式, 开启后会在portRange范围内选择端口用于媒体流传输
    enable: true
    # [可选] 在此范围内选择端口用于媒体流传输, 必须提前在zlm上配置该属性，不然自动配置此属性可能不成功
    port-range: 50000,50050 # 端口范围
    # [可选] 国标级联在此范围内选择端口发送媒体流，请不要与收流端口范围重合
    send-port-range: 50502,50506 # 端口范围
  # 录像辅助服务， 部署此服务可以实现zlm录像的管理与下载， 0 表示不使用
  record-assist-port: 18081

# [可选] 日志配置, 一般不需要改
logging:
  config: classpath:logback-spring-local.xml

# [根据业务需求配置]
user-settings:
  # [可选] 服务ID，不写则为000000
  server-id: 000000
  # [可选] 自动点播， 使用固定流地址进行播放时，如果未点播则自动进行点播, 需要rtp.enable=true
  auto-apply-play: true
  # [可选] 部分设备需要扩展SDP，需要打开此设置
  senior-sdp: false
  # 保存移动位置历史轨迹：true:保留历史数据，false:仅保留最后的位置(默认)
  save-position-history: false
  # 点播/录像回放 等待超时时间,单位：毫秒
  play-timeout: 24000
  # 上级点播等待超时时间,单位：毫秒
  platform-play-timeout: 120000
  # 是否开启接口鉴权
  interface-authentication: false
  # 接口鉴权例外的接口, 即不进行接口鉴权的接口,尽量详细书写，尽量不用/**，至少两级目录
  interface-authentication-excludes:
    - /api/v1/**
  # 推流直播是否录制
  record-push-live: false
  # 等待音视频编码信息再返回， true： 可以根据编码选择合适的播放器，false： 可以更快点播
  wait-track: false
  # 国标是否录制
  record-sip: false
  # 是否将日志存储进数据库
  logInDatabase: false
  # 使用推流状态作为推流通道状态
  use-pushing-as-status: true
  # 使用来源请求ip作为streamIp,当且仅当你只有zlm节点它与wvp在一起的情况下开启
  use-source-ip-as-stream-ip: false
  # 国标点播 按需拉流, true：有人观看拉流，无人观看释放， false：拉起后不自动释放
  stream-on-demand: false
  # 推流鉴权， 默认开启
  push-authority: false
  # 设备上线时是否自动同步通道
  sync-channel-on-device-online: false
  # 是否使用设备来源Ip作为回复IP， 不设置则为 false
  sip-use-source-ip-as-remote-address: false
  # 是否开启sip日志
  sip-log: true
  # 是否开启sql日志
  sql-log: false
  # 消息通道功能-缺少国标ID是否给所有上级发送消息
  send-to-platforms-when-id-lost: true
  # 保持通道状态，不接受notify通道状态变化， 兼容海康平台发送错误消息
  refuse-channel-status-channel-form-notify: false
  # 设置notify缓存队列最大长度，超过此长度的数据将返回486 BUSY_HERE，消息丢弃, 默认10000
  max-notify-count-queue: 10000
  # 设备/通道状态变化时发送消息
  device-status-notify: false
  # 上级平台点播时不使用上级平台指定的ssrc，使用自定义的ssrc，参考国标文档-点播外域设备媒体流SSRC处理方式
  use-custom-ssrc-for-parent-invite: true
  # 国标级联离线后多久重试一次注册
  register-again-after-time: 60
  # 国标续订方式，true为续订，每次注册在同一个会话里，false为重新注册，每次使用新的会话
  register-keep-int-dialog: false
  # 跨域配置，配置你访问前端页面的地址即可， 可以配置多个
  allowed-origins:
    - http://localhost:8008
    - http://127.0.0.1:8001
    - http://192.168.10.43:8080
    - http://192.168.10.250:8080
    - http://192.168.10.250:8008
    - http://192.168.10.43:8008
    - http://192.168.10.250:8001
    - http://192.168.10.250:18080
    - http://192.168.10.43:18080

# 关闭在线文档（生产环境建议关闭）
springdoc:
  api-docs:
    enabled: true
  swagger-ui:
    enabled: true
```

注意的信息点：
```editorconfig
1、这个配置相当于zlm流媒体服务器的账号密码，是要和流媒体服务器配置的信息一致
而且流媒体服务器的配置信息中还有IP白名单，也需要加上当前IP
media:
    id: 035c73f7bb6b
    secret: l5DPpqy3YbPE5oaJCL2AxOBOuAVwEvlG


2、SIP是填服务端地址，注意区分服务端和流媒体服务器端的区别，如果两者不在同一台服务器中就要区分好

```



### 2、CWQ-VEDIO-WEB是流媒体服务管理端的前端界面
1、注意点是配置文件：\web_src\config下面有
dev.env.js  dev 本地运行时使用的配置
index.js    本地运行时使用，换为服务端：18080端口
prod.env.js BASE_API: '"/28181api"' 配置的是代理地址，走nginx时的配置

index.js 配置如下：
```editorconfig
'use strict'
// see http://vuejs-templates.github.io/webpack for documentation.

const path = require('path')

module.exports = {
  dev: {

    // Paths
    assetsSubDirectory: 'static',
    assetsPublicPath: '/',
    proxyTable: {
      '/debug': {
        target: 'http://192.168.10.43:18080',
        changeOrigin: true,
        pathRewrite: {
          '^/debug': '/'
        }
      },
      '/static/snap': {
        target: 'http://192.168.10.43:18080',
        changeOrigin: true,
        // pathRewrite: {
        //   '^/static/snap': '/static/snap'
        // }
      },

    },

    // Various Dev Server settings
    host:"192.168.10.43",
    useLocalIp: false, // can be overwritten by process.env.HOST
    port: 8080, // can be overwritten by process.env.PORT, if port is in use, a free one will be determined
    autoOpenBrowser: false,
    errorOverlay: true,
    notifyOnErrors: true,
    hot: true,//自动保存
    poll: false, // https://webpack.js.org/configuration/dev-server/#devserver-watchoptions-
    
    // https://webpack.js.org/configuration/devtool/#development
    devtool: 'cheap-module-eval-source-map',

    // https://vue-loader.vuejs.org/en/options.html#cachebusting
    cacheBusting: true,
    cssSourceMap: true
  },

  build: {
    // Template for index.html
    index: path.resolve(__dirname, '../../src/main/resources/static/index.html'),

    // Paths
    assetsRoot: path.resolve(__dirname, '../../src/main/resources/static/'),
    assetsSubDirectory: './static',
    assetsPublicPath: '/',
    
    productionSourceMap: true,
    // https://webpack.js.org/configuration/devtool/#production
    devtool: '#source-map',
    
    productionGzip: false,
    productionGzipExtensions: ['js', 'css'],
    
    bundleAnalyzerReport: process.env.npm_config_report
  }
}

```

### 3、流媒体服务器搭建（docker）
为了避免不同版本带来的影响，镜像重新打包放到个人仓库上。

```shell
docker pull registry.cn-shenzhen.aliyuncs.com/sz_public/public:zlmediakit-master
docker run -id -p 1935:1935 -p 1935:1935/udp -p 554:554 -p 8000:8000 -p 8001:8001 -p 18081:18081 -p 10000:10000 -p 10000:10000/udp -p 50000-50050:50000-50050  -p 50000-50050:50000-50050/udp -v /usr/local/28181/config.ini:/opt/media/conf/config.ini registry.cn-shenzhen.aliyuncs.com/sz_public/public:zlmediakit-master
```

config.ini 如下(注意secret/ip白名单/开放端口等)：
```editorconfig
; auto-generated by mINI class {

[api]
apiDebug=0
defaultSnap=./www/logo.png
downloadRoot=./www
secret=l5DPpqy3YbPE5oaJCL2AxOBOuAVwEvlG
snapRoot=./www/snap/

[cluster]
origin_url=
retry_count=3
timeout_sec=15

[ffmpeg]
bin=/usr/bin/ffmpeg
cmd=%s -fflags nobuffer -i %s -c:a aac -strict -2 -ar 44100 -ab 48k -c:v libx264  -f flv %s
log=./ffmpeg/ffmpeg.log
restart_sec=0
snap=%s -i %s -y -f mjpeg -t 0.001 %s

[general]
addMuteAudio=1
check_nvidia_dev=1
continue_push_ms=3000
enableVhost=0
enable_audio=1
enable_ffmpeg_log=0
flowThreshold=1024
fmp4_demand=0
hls_demand=0
maxStreamWaitMS=15000
mediaServerId=035c73f7bb6b
mergeWriteMS=0
modifyStamp=0
publishToHls=1
publishToMP4=0
resetWhenRePlay=1
rtmp_demand=0
rtsp_demand=0
streamNoneReaderDelayMS=10000
ts_demand=0
unready_frame_cache=100
wait_add_track_ms=3000
wait_track_ready_ms=3000

[hls]
broadcastRecordTs=0
deleteDelaySec=0
fastRegister=0
fileBufSize=65536
filePath=./www
segDur=2
segKeep=0
segNum=3
segRetain=5

[hook]
admin_params=secret=035c73f7-bb6b-4889-a715-d9eb2d1925cc
alive_interval=10.0
enable=1
on_flow_report=
on_http_access=
on_play=http://192.168.10.250:18080/index/hook/on_play
on_publish=http://192.168.10.250:18080/index/hook/on_publish
on_record_mp4=http://192.168.10.250:18080/api/record/on_record_mp4
on_record_ts=
on_rtp_server_timeout=
on_rtsp_auth=
on_rtsp_realm=
on_send_rtp_stopped=
on_server_exited=
on_server_keepalive=http://192.168.10.250:18080/index/hook/on_server_keepalive
on_server_started=http://192.168.10.250:18080/index/hook/on_server_started
on_shell_login=http://192.168.10.250:18080/index/hook/on_shell_login
on_stream_changed=http://192.168.10.250:18080/index/hook/on_stream_changed
on_stream_none_reader=http://192.168.10.250:18080/index/hook/on_stream_none_reader
on_stream_not_found=http://192.168.10.250:18080/index/hook/on_stream_not_found
retry=1
retry_delay=3.000000
stream_changed_schemas=rtsp/rtmp/fmp4/ts/hls/hls.fmp4
timeoutSec=20

[http]
allow_cross_domains=1
allow_ip_range=::1,127.0.0.1,172.16.0.0-172.31.255.255,192.168.0.0-192.168.255.255,10.0.0.0-10.255.255.255
charSet=utf-8
dirMenu=1
forbidCacheSuffix=
forwarded_ip_header=
keepAliveSecond=30
maxReqSize=40960
notFound=<html><head><title>404 Not Found</title></head><body bgcolor="white"><center><h1>您访问的资源不存在！</h1></center><hr><center>ZLMediaKit(git hash:a3d696d,branch:master,build time:Feb 23 2022 12:29:13)</center></body></html>
port=8001
rootPath=./www
sendBufSize=65536
sslport=443
virtualPath=

[multicast]
addrMax=239.255.255.255
addrMin=239.0.0.0
udpTTL=64

[protocol]
add_mute_audio=1
auto_close=0
continue_push_ms=15000
enable_audio=1
enable_fmp4=1
enable_hls=1
enable_hls_fmp4=0
enable_mp4=0
enable_rtmp=1
enable_rtsp=1
enable_ts=1
fmp4_demand=0
hls_demand=0
hls_save_path=./www
modify_stamp=2
mp4_as_player=0
mp4_max_second=3600
mp4_save_path=./www
paced_sender_ms=0
rtmp_demand=0
rtsp_demand=0
ts_demand=0

[record]
appName=record
fastStart=0
fileBufSize=65536
filePath=./www
fileRepeat=0
fileSecond=3600
sampleMS=500

[rtc]
externIP=
max_bitrate=0
min_bitrate=0
port=8000
preferredCodecA=PCMU,PCMA,opus,mpeg4-generic
preferredCodecV=H264,H265,AV1X,VP9,VP8
rembBitRate=0
start_bitrate=0
tcpPort=0
timeoutSec=15

[rtmp]
directProxy=1
enhanced=0
handshakeSecond=15
keepAliveSecond=15
modifyStamp=0
port=1935
sslport=0

[rtp]
audioMtuSize=600
h264_stap_a=1
lowLatency=0
rtpMaxSize=10
videoMtuSize=1400

[rtp_proxy]
dumpDir=
gop_cache=1
h264_pt=98
h265_pt=99
opus_pt=100
port=10000
port_range=50000-50050
ps_pt=96
timeoutSec=15

[rtsp]
authBasic=0
directProxy=1
handshakeSecond=15
keepAliveSecond=15
lowLatency=0
port=554
rtpTransportType=-1
sslport=0

[shell]
maxReqSize=1024
port=0

[srt]
latencyMul=4
pktBufSize=8192
port=9000
timeoutSec=5

; } ---
```

最后贴上流程图：
![](https://wqknowledge.oss-cn-shenzhen.aliyuncs.com/blog/vedio.png)

具体使用配置：
![](https://wqknowledge.oss-cn-shenzhen.aliyuncs.com/blog/vedio2.png)
