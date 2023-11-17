# EssentialFeed-Singleton
## Solution / Problem - 1 
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
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/0420da06-36ce-46c0-b783-110d5d65b792" width="50%" />

NOTE:  - We are not yet safe from change. The ApiClient is still shared in all the modules. You might break the client when you add new method.

To add a little more flexibility, to make this more reusable without breaking the clients, now we talk about inverting dependencies. Instead of the modules(Login, Followers, Feed) depending on concrete ApiClient, we make the concrete ApiClient, depend on the modules. This will give us the freedom that we want.

Note: most application stop at solution 2 - where they use extension. With time it gets messy, solution is to re-write the entire codebase

ApiClient is just a detail - what is important to the business is not ApiClient implementation and Api requests
Best method is to have contained logic in Modules and Details(ApiClient) depends on the features

## Solution - 4
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/47462132-62ed-4975-8893-d5ff645dd79f" width = "75%" />

 NOTE: 3
And to do so - we need to introduce protocols or closures or any type of for the modules.
 For example,
 - Login Module - it needs a function or a type that implements a function that talk to an API
 - Feed Module - will need a function to load the feed
 - Followers Module - Will need a function to load the followers
 thats all they need - it doesnt need to know where they come from

 i.e when you have a concrete type dependency i.e the Login module directly reference the ApiClient, we depend on ApiClient, we need to know how to locate the instance(ApiClient.shared) then now we invoke the function that we want. But all we want is a function.
 why dont we just depend on a function or protocol that implements the function.

// here we have specialization - what do i need, as a Login Module, as a Feed Module, as a Follower Module - I dont care about anything else.

## Solution - 5
<img src="https://github.com/mbayi-ios/EssentialFeed-Singleton/assets/91916741/e7db08f3-fee7-4d9f-b45e-1864d87372eb" width="100%" />

// NOTE: 4
// We can do a little bit deeper in our implementation
// - you have your generic ApiClient
// - you have your modules with only what they need
// - then implement the adapters
// - this is completely modular i.e you can use the ApiClient Module in other applications, you can use Login Module in other applications, you can use the Followers Module in other context, you can use Feed Module in other context as well.
// - You can just compose all those modules together and when you are testing you compose them with mocks or with stubs

This has the final code

