
// Are singletons and global instances damaging your system design and testability?
// how singletons and global state can damage app architecture and make app harder to test. Especially in the networking layer

// there are better ways and better solutions.

// 1. How can I test the network layer?
// 2. Should I be using Singletons?

// what are singletons pattern? - is a way to make sure that a class has only one instance and it provides a single point of access to it. The pattern specifies that the class should be responsible itself for keeping track of its sole instance


//NOTE: Care about Modular design - breaking this code into something manageable/responsible

// the solution to this problem i.e where everytime you add a method you might to break other modules is faily simple.
// 1. use extension - i.e we can have generic method /execute(request)/ then every module has its own apiClient Extension with whatever method they need


// NOTE:2  - We are not yet safe from change. The ApiClient is still shared in all the modules. You might break the client when you add new method.

// To add a little more flexibility, to make this more reusable without breaking the clients, now we talk about inverting dependencies. Instead of the modules(Login, Followers, Feed) depending on concrete ApiClient, we make the concrete ApiClient, depend on the modules. This will give us the freedom that we want.

// Note: most application stop at solution 2 - where they use extension. With time it gets messy, solution is to re-write the entire codebase

// ApiClient is just a detail - what is important to the business is not ApiClient implementation and Api requests
// Best method is to have contained logic in Modules and Details(ApiClient) depends on the features

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
