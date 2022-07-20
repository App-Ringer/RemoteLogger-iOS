Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.1'
s.name = "RemoteLoggeriOS"
s.summary = "RemoteLoggeriOS create pod."
s.requires_arc = true

# 2
s.version = "0.1.19"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author             = { "Ajay" => "ajay@appringer.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/App-Ringer/RemoteLogger-iOS"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/App-Ringer/RemoteLogger-iOS.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'RealmSwift'

# 8
#s.source_files = "RemoteLoggeriOS/**/*.{h,m,swift}"
s.source_files = "RemoteLoggeriOSPodFile", "RemoteLoggeriOS/**/*.{swift}"

# 9
#s.resources = "RemoteLoggeriOSPodFile", "RemoteLoggeriOS/*.{storyboard,xib}"

# 10
s.swift_version = "5.0"

end
