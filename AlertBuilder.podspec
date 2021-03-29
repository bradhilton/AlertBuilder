Pod::Spec.new do |s|
  s.name         = "AlertBuilder"
  s.version      = "5.0.0"
  s.summary      = "Create Alerts and Action Sheets Easily"
  s.description  = <<-DESC
                    AlertBuilder makes it easy to construct and present alerts with the builder pattern.
                   DESC
  s.homepage     = "https://github.com/bradhilton/AlertBuilder"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brad Hilton" => "brad.hilton.nw@gmail.com" }
  s.source       = { :git => "https://github.com/bradhilton/AlertBuilder.git", :tag => s.version }
  s.swift_version = '5.0'

  s.ios.deployment_target = "9.0"

  s.source_files  = "AlertBuilder", "AlertBuilder/**/*.{swift,h,m}"
  s.requires_arc = true
  s.dependency 'SwiftCallbacks', '5.0.0'
  s.dependency 'Swiftstraints', '5.0.0'
end
