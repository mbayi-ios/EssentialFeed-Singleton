# EssentialFeed-Singleton
## Solution  - 1 
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/18a81020-238b-45e0-8299-e8b38813202a" width="75%" />

- Login doesnt care about loadFeed(), loadFollowers()
- Followers doesnt care about login(), loadFeed()
- Feed doesnt care about login(), loadFollowers()

BUT we have ApiClient module being shared by the other three different modules(Login, Followers, Feed) 
ApiClient is concrete time ApiClient - there is source code dependencies. You cant move Login(module) to different context/application without bringing in

## Solution - 2
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/39437efe-caad-4914-92d2-608178908b75" width="75%">

NOTE: Care about Modular design - breaking this code into something manageable/responsible

 The solution to this problem i.e where everytime you add a method you might to break other modules is faily simple.
 1. use extension - i.e we can have generic method /execute(request)/ then every module has its own apiClient Extension with whatever method they need


## Solution - 3
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/0420da06-36ce-46c0-b783-110d5d65b792" width="" />

NOTE:  - We are not yet safe from change. The ApiClient is still shared in all the modules. You might break the client when you add new method.

To add a little more flexibility, to make this more reusable without breaking the clients, now we talk about inverting dependencies. Instead of the modules(Login, Followers, Feed) depending on concrete ApiClient, we make the concrete ApiClient, depend on the modules. This will give us the freedom that we want.

Note: most application stop at solution 2 - where they use extension. With time it gets messy, solution is to re-write the entire codebase

ApiClient is just a detail - what is important to the business is not ApiClient implementation and Api requests
Best method is to have contained logic in Modules and Details(ApiClient) depends on the features
