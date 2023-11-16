
// Are singletons and global instances damaging your system design and testability?
// how singletons and global state can damage app architecture and make app harder to test. Especially in the networking layer

// there are better ways and better solutions.

// 1. How can I test the network layer?
// 2. Should I be using Singletons?

// what are singletons pattern? - is a way to make sure that a class has only one instance and it provides a single point of access to it. The pattern specifies that the class should be responsible itself for keeping track of its sole instance

import UIKit

struct LoggedInUser {}
struct FeedItems {}

class ApiClient {
    static let shared = ApiClient()

    func login(completion: (LoggedInUser) -> Void) { }
    func loadFeed(completion: ([FeedItems]) -> Void) { }
}

// this allow you to test
class MockApiClient: ApiClient {
    
}

class LoginViewController: UIViewController {
    
    // introducing property injection
    var api = ApiClient.shared
    
    func didTapLoginButton() {
        api.login() { user in
            // show feed screen
        }
    }
}


class FeedViewController: UIViewController {
    
    var api = ApiClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.loadFeed { loadedItems in
            // update UI
        }
    }
}
