
Pod::Spec.new do |s|
  s.name         = "AssetFixture"
  s.version      = "0.0.3"
  s.summary      = "ALAssetsLibrary-based Asset Fixtures, in Swift"
  s.description  = <<-DESC
                   A longer description of AssetFixture in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  s.homepage     = "https://github.com/julien-c/AssetFixture"
  s.license      = "MIT"
  s.author             = { "Julien Chaumond" => "chaumond@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/julien-c/AssetFixture.git", :tag => s.version.to_s }
  s.source_files  = "AssetFixture/AssetFixture.swift"
  s.requires_arc = true
end
