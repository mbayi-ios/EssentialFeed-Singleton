
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

// NOTE: 3
// And to do so - we need to introduce protocols or closures or any type of for the modules.
// For example,
// - Login Module - it needs a function or a type that implements a function that talk to an API
// - Feed Module - will need a function to load the feed
// - Followers Module - Will need a function to load the followers
// thats all they need - it doesnt need to know where they come from

// i.e when you have a concrete type dependency i.e the Login module directly reference the ApiClient, we depend on ApiClient, we need to know how to locate the instance(ApiClient.shared) then now we invoke the function that we want. But all we want is a function.
// why dont we just depend on a function or protocol that implements the function.

// here we have specialization - what do i need, as a Login Module, as a Feed Module, as a Follower Module - I dont care about anything else.

// NOTE: 4
// We can do a little bit deeper in our implementation
// - you have your generic ApiClient
// - you have your modules with only what they need
// - then implement the adapters
// - this is completely modular i.e you can use the ApiClient Module in other applications, you can use Login Module in other applications, you can use the Followers Module in other context, you can use Feed Module in other context as well.
// - You can just compose all those modules together and when you are testing you compose them with mocks or with stubs


import UIKit

// Main Module

extension ApiClient {
    func login(completion: (LoggedInUser) -> Void) { }
}

extension ApiClient {
     func loadFeed(completion: ([FeedItem]) -> Void) {
         //this will call the execute function(the generic method)
     }
}

// API Module

class ApiClient {
    static let shared = ApiClient()
    
    // have generic function
    func execute(_ : URLRequest, completion: (Data) -> Void) {}
}

// Login Module

struct LoggedInUser {}

class LoginViewController: UIViewController {
    var login: (((LoggedInUser) -> Void) -> Void)?
    
    func didTapLoginButton() {
        login?{ user in
            // show feed screen
        }
    }
}

// Feed Module

struct FeedItem {}

// this doesnt need to be a viewController; it can be a Service

class FeedService {
    
    var loadFeed: ((([FeedItem]) -> Void) -> Void)?
    
    func load() {
        loadFeed? { loadedItems in
            // update UI
        }
    }
}
