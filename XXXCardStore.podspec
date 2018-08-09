Pod::Spec.new do |s|
  s.name         = 'XXXCardStore'
  s.version      = '1.0.2'
  s.summary      = '可拖拽的叠加卡片'
  s.homepage     = 'https://github.com/xxxIxxxx/XXXCardStore'
  s.license      = 'MIT'
  s.authors      = {'i2yf' => 'i2yf@foxmail.com'}
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = {:git => 'https://github.com/xxxIxxxx/XXXCardStore.git', :tag => s.version}
  s.source_files = 'XXXCardStoreDemo/XXXCardStore/*.{h,m}'
  s.requires_arc = true
  s.dependency "SDWebImage"
end