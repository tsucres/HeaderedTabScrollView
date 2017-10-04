#
# `pod lib lint HeaderedTabScrollView.podspec'

Pod::Spec.new do |s|
  s.name             = 'HeaderedTabScrollView'
  s.version          = '0.1.0'
  s.summary          = 'A swift View-Controller managing a scrollable tab-based menu above a header.'

  s.description      = <<-DESC
A swift View-Controller managing a scrollable tab-based menu above a header. It can be used as a starting template for any view composed of a main header and several subpages.
                       DESC

  s.homepage         = 'https://github.com/tsucres/HeaderedTabScrollView'
  s.screenshots      = 'https://github.com/tsucres/HeaderedTabScrollView/raw/master/Screenshots/presentationImg.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stéphane Sercu' => 'stefsercu@gmail.com' }
  s.source           = { :git => 'https://github.com/tsucres/HeaderedTabScrollView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'


  s.default_subspec = 'Both'

  s.subspec 'Base' do |base|
    base.source_files = 'HeaderedTabScrollView/Classes/AbstractHeaderedTabScrollViewController.swift'

  end

  s.subspec 'Both' do |both|
    both.dependency 'HeaderedTabScrollView/Base'
    both.dependency 'HeaderedTabScrollView/PageMenu'
    both.dependency 'HeaderedTabScrollView/ACTabScrollView'
  end


  s.subspec 'PageMenu' do |pagemenu|
    pagemenu.dependency 'PageMenu', '~> 2.0.0'
    pagemenu.source_files = 'HeaderedTabScrollView/Classes/HeaderedCAPSPageMenuViewController.swift'
  end

  s.subspec 'ACTabScrollView' do |actabscrollview|
    actabscrollview.dependency 'ACTabScrollView', '~> 0.3.0'
    actabscrollview.source_files = 'HeaderedTabScrollView/Classes/HeaderedACTabScrollViewController.swift'
  end

  s.frameworks = 'UIKit'


end
