# List
Trying to figure out how to implement a simpler version of Clean Architecture that allows to run non-UIKit Unit tests without a simulator

#Unit Tests
In order to run unit tests without the simulator execute:

`xcodebuild -workspace List.xcworkspace -scheme "UnitTests" test CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO`
