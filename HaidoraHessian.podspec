Pod::Spec.new do |s|
  s.name             = "HaidoraHessian"
  s.version          = "0.1.1"
  s.summary          = "A short description of HaidoraHessian."
  s.description      = <<-DESC
                       An optional longer description of HaidoraHessian
                       DESC
  s.homepage         = "https://github.com/Haidora/HaidoraHessian"
  s.license          = 'MIT'
  s.author           = { "mrdaios" => "mrdaios@gmail.com" }
  s.source           = { :git => "https://github.com/Haidora/HaidoraHessian.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'HaidoraHessian' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'libObjCAttr', '~> 1.3.4'
end
