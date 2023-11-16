
// Are singletons and global instances damaging your system design and testability?
// how singletons and global state can damage app architecture and make app harder to test. Especially in the networking layer

// there are better ways and better solutions.

// 1. How can I test the network layer?
// 2. Should I be using Singletons?

// what are singletons pattern? - is a way to make sure that a class has only one instance and it provides a single point of access to it. The pattern specifies that the class should be responsible itself for keeping track of its sole instance

import UIKit

struct LoggedInUser {}

final class ApiClient {
    static let instance  = ApiClient()
    
    static func getInstance() -> ApiClient {
        return instance
    }
    private init() {}
    
    func login(completion: (LoggedInUser) -> Void) { }
}

let client = ApiClient.instance


class LoginViewController: UIViewController {
    func didTapLoginButton() {
        ApiClient.instance.login() { user in
            // show next screen
        }
    }
}
