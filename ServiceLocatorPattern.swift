protocol DataStoreService {
    func save(data: Data)
    func retrieve() -> Data?
}

final class CacheService: DataStoreService {
    //** save and fetch data using cache
    func save(data: Data) {
        
    }
    
    func retrieve() -> Data? {
        "some-data-from-cache".data(using: .utf8)
    }
}

final class DatabaseService: DataStoreService {
    //** save and fetch data using disk
    func save(data: Data) {
        
    }
    
    func retrieve() -> Data? {
        "some-data-from-disk".data(using: .utf8)
    }
}

final class DataService {
    private var service: DataStoreService?
    static let shared = DataService()
    private init() { }
    
    func register(service: DataStoreService) {
        self.service = service
    }
    
    func get() -> DataStoreService? {
        service
    }
}

final class CatListViewModel {
    private var dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func retrieve() -> Data? {
        dataService.get()?.retrieve()
    }
    
    func save(data: Data) {
        dataService.get()?.save(data: data)
    }
}


//Usage  
let dataService = DataService.shared
dataService.register(service: DatabaseService()) //register the alternate service interface remains the same - loose coupling
let viewModel = CatListViewModel(dataService: dataService)
