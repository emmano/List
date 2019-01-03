# Uncomment the next line to define a global platform for your project

target 'List' do
    platform :ios, '12.1'
    
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxOptional'
    # Pods for List
    
    target 'ListTests' do
        inherit! :search_paths
        pod 'RxTest'
        pod 'RxBlocking'
        # Pods for testing
    end
    
    target 'ListUITests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end

target 'UnitTests' do
    platform :macos, '10.13'
    
    use_frameworks!
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxOptional'
    pod 'RxTest'
    pod 'RxBlocking'
    # Pods for testing
end
