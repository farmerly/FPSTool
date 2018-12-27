Pod::Spec.new do |s|
  s.name         = 'FPSTool'
  s.summary      = 'FPS实时检测工具'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'farmerly' => '318465271@qq.com' }
  s.homepage     = 'https://github.com/farmerly/FPSTool'
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => 'https://github.com/farmerly/FPSTool.git', : commit => "86276018ef48781fb35e5c735fc493676ec26638"}
  #tag => s.version
  s.requires_arc = true
  s.source_files = 'FPSTool/**/*.{h,m}'
  s.frameworks = 'UIKit'

end
