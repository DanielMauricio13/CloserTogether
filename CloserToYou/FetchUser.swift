//
//  MainWindow.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 8/15/23.
//

import SwiftUI
//import KeychainAccess


struct FetchUser: View {
    let email: String
    let password: String
    @State private var mainUser: User?
      @State private var isLoading = true // Track loading state
    var exercises: [Exercise] = []
    @State var excer: [String: Any]?
    @State var whichDay:Int?
    @State var numDayssUs: Int? = 1
    @State public var userFound: Bool = true
    @State var part = false
    
    var body: some View {
        
        
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                if isLoading {
                    ZStack{
                        Rectangle().fill(Color.black).ignoresSafeArea()
                        Text("Loading...").foregroundColor(.white)
                    }
                } else {
                    //                    VStack{
                    //                        Text("Which day are you working?")
                    //                        for i in numDayssUs {
                    //                            Button{
                    //
                    //                            }label: {
                    //                                Text(
                    //                            }
                    //                        }
                    //                    }
                    if userFound {
                        if mainUser?.partnerID == 0 && !part{
                            matchPartner(mainUser: mainUser ??  User(firstName: "sdd", password: "Dsad", points: 0, mood: Mood(id: nil, Name: "happy", emoji: "😃", color: "blue"), partnerID: 0, email: "dsdd", pairingCode: 0), part: $part)
                        }else{
                            MainWindow(User: mainUser!)
                        }
                    }
                    else{
                        
                        ContentView()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                fetchUserAndSave() { fetchedUser in
                    DispatchQueue.main.async {
                        if fetchedUser == nil {
                            logout()
                        }else{
                            self.mainUser = fetchedUser
                            isLoading = false
                            userFound = true
                        }
                    }
                }
                
            
        }
            
        }
    }

    func fetchUserAndSave( completion: @escaping (User?) -> Void) {
        guard let apiUrl = URL(string: "\(Constants.baseURL)couplesUser/userCouple?email=\(self.email)&password=\(self.password)") else {
            
            print("failed tp fetch user url")
            logout()
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                logout()
                return
            }
            
            do {
                let user = try JSONDecoder().decode(CloserToYou.User.self, from: data)
                saveUserToDefaults(user) // Save user to UserDefaults
                DispatchQueue.main.async {
                    completion(user) // ✅ Pass the fetched user
                }
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
                logout()
            }
        }.resume()
    }
    
  
    func saveUserToDefaults(_ user: User) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: "savedUser")
        }
    }
    func getUserFromDefaults() -> User? {
        if let savedUserData = UserDefaults.standard.data(forKey: "savedUser") {
            let decoder = JSONDecoder()
            return try? decoder.decode(User.self, from: savedUserData)
        }
        return nil
    }


    

    // Define a custom error type for network errors
    enum NetworkError: Error {
        case invalidResponse
        case noData
        case noToken
    }
    enum APIError: Error {
        case networkError(Error)
        case invalidResponse
        case noData
        case decodingError(Error)
    }
    struct Exercise: Decodable {
        var day: String
        var title: String
        var items: [ExerciseItem]
    }

    struct ExerciseItem: Decodable {
        var title: String
        var sets: String
        var repetitions: String
    }

    func logout()->Void {
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        UserDefaults.standard.removeObject(forKey: "username")
        userFound = false
      //  persistenceManager.clearItems()
    }
}


