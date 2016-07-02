Pod::Spec.new do |s|
  s.name             = 'ZLazyList'
  s.version          = '0.1.0'
  s.summary          = 'ZLazyList is just a functional programming test.'


  s.description      = <<-DESC
ZLazyList is just a functional programming test.
To show what is lazily calculate。
                       DESC

  s.homepage         = 'https://github.com/WilliamZang/ZLazyList'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WilliamZang' => 'chengwei.zang.1985@gmail.com' }
  s.source           = { :git => 'https://github.com/WilliamZang/ZLazyList.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZLazyList/Classes/**/*'
end
