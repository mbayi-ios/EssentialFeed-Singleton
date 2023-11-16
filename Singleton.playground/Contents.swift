
// Are singletons and global instances damaging your system design and testability?
// how singletons and global state can damage app architecture and make app harder to test. Especially in the networking layer

// there are better ways and better solutions.

// 1. How can I test the network layer?
// 2. Should I be using Singletons?

// what are singletons pattern? - is a way to make sure that a class has only one instance and it provides a single point of access to it. The pattern specifies that the class should be responsible itself for keeping track of its sole instance


//NOTE: Care about Modular design - breaking this code into something manageable/responsible

// the solution to this problem i.e where everytime you add a method you might to break other modules is faily simple.
// 1. use extension - i.e we can have generic method /execute(request)/ then every module has its own apiClient Extension with whatever method they need

import UIKit

// API Module

class ApiClient {
    static let shared = ApiClient()
    
    // have generic function
    func execute(_ : URLRequest, completion: (Data) -> Void) {}
}

// Login Module

struct LoggedInUser {}

extension ApiClient {
    func login(completion: (LoggedInUser) -> Void) {
        //this will call the execute function(the generic method)
    }
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

// Feed Module

struct FeedItems {}

extension ApiClient {
     func loadFeed(completion: ([FeedItems]) -> Void) {
         //this will call the execute function(the generic method)
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
