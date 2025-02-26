//
//  MainWindow.swift
//  CloserToYou
//
//  Created by Daniel Pinilla on 1/3/25.
//

import SwiftUI

struct MainWindow: View {
    @State var User: User
    @State var partner: User?
    @State var changeMood: Bool = false
    @State var tempUser: User?
    @State public var userFound: Bool = true
    @State var LogOut: Bool = false
    @State var mainUseraColor: Color = .clear
    @State var partnerColor: Color = .clear
    @State var whichWin: Int = 0
    var body: some View {
        NavigationView{
            if  LogOut{
                ContentView()
            }
            else {
                
                if changeMood {
                    
                    SetMoodPage(mainUser: User, partner: partner ?? CloserToYou.User(firstName: "test", password: "daa", points: 0, mood: Mood(id: nil, Name: "sad", emoji: "🤖", color: "black"), partnerID: 0, email: "dada", pairingCode: 0), changeMood: $changeMood)
                    
                } else{
                    
                    
                    ZStack{
                        Rectangle().foregroundStyle(Color.black).ignoresSafeArea()
                        Rectangle().ignoresSafeArea().foregroundStyle(LinearGradient(colors: [Color.purple.opacity(0.6), Color.red.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                        if whichWin == 1{
                            Rectangle().foregroundStyle(Color.black).ignoresSafeArea()
                        }
                        VStack{
                            
                            if  whichWin == 0{
                                Text("Happy \(currentDayOfWeek()) \(User.firstName)!")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding()
                                    .foregroundColor(.white)
                                    .italic()
                                    .shadow(color: .white, radius: 10)
                                
                                HStack{
                                    Button {
                                        changeMood = true
                                        
                                    } label: {
                                        
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 20).fill(mainUseraColor.opacity(0.7)).frame(width: 170, height:170)
                                            RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 170, height:170)
                                            VStack{
                                                Text("\(User.mood.emoji)").font(.largeTitle)
                                                Text("\(User.mood.Name )").padding(.top).font(.title3).foregroundStyle(Color.white)
                                                
                                            }
                                        }
                                    }
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 20).fill(partnerColor.opacity(0.7)).frame(width: 170, height:170)
                                        RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 170, height:170)
                                        VStack{
                                            Text("\(partner?.mood.emoji ?? "😢")").font(.largeTitle)
                                            Text("\(partner?.mood.Name ?? "Sad")").padding(.top).font(.title3).foregroundStyle(Color.white)
                                        }
                                    }
                                    
                                }.padding(.top).onAppear{
                                    
                                    
                                    fetchUserAndSave() { fetchedUser in
                                        DispatchQueue.main.async {
                                            if fetchedUser != nil{
                                                self.User = fetchedUser!
                                                mainUseraColor = getColor(mainUser: User)
                                                fetchPartnerAndSave() { fetchedPartner in
                                                    DispatchQueue.main.async {
                                                        if fetchedPartner != nil{
                                                            self.partner = fetchedPartner!
                                                            partnerColor = getColor(mainUser: partner!)
                                                        }
                                                        else {
                                                            logout()
                                                            LogOut = true
                                                        }
                                                    }
                                                }
                                            }
                                            else {
                                                logout()
                                                LogOut = true
                                            }
                                        }
                                    }
                                }
                            }
                            
                            else if (whichWin == 1) {
                                
                                Garden()
                            }
                            // Sticky navigation bar
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {whichWin = 0}) {
                                    Image(systemName: "house")
                                        .padding()
                                        .foregroundColor(whichWin == 0 ? Color.red :Color.white)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }
                                
                                Spacer()
                                Button(action: {whichWin = 1}) {
                                    Image(systemName: "leaf")
                                        .padding()
                                        .foregroundColor(whichWin == 1 ? Color .purple :Color.white)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }
                                
                                Spacer()
                                Button(action: {whichWin = 2}) {
                                    Image(systemName: "flame")
                                        .padding()
                                        .foregroundColor(whichWin == 2 ? Color .red :Color.white)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }
                                
                                Spacer()
                                
                                Button(action: {whichWin = 3}){
                        Image(systemName: "gear")
                            .padding()
                            .foregroundColor(whichWin == 3 ? Color .red :Color.white)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                                
                                
                                
                                Spacer()
                                
                            }
                            .padding()
                            .frame(height: 70) // Adjust the height of the navigation bar as needed
                            .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
                            .edgesIgnoringSafeArea(.bottom) // Extend the navigation bar to the bottom
                            
                        }
                        
                    }
                }
            }
        }
        
    }
    func logout()->Void {
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        UserDefaults.standard.removeObject(forKey: "username")
       
      //  persistenceManager.clearItems()
    }
        func fetchUserAndSave( completion: @escaping (User?) -> Void) {
            guard let apiUrl = URL(string: "\(Constants.baseURL)couplesUser/userCouple?email=\(User.email)&password=\(User.password)") else {
                
                print("failed tp fetch user url")
                return
            }
            
            URLSession.shared.dataTask(with: apiUrl) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
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
                }
            }.resume()
        }
    func fetchPartnerAndSave( completion: @escaping (User?) -> Void) {
        guard let apiUrl = URL(string: "\(Constants.baseURL)couplesUser/getPartnerInfo?pairingCode=\(User.partnerID)") else {
            
            print("failed tp fetch user url")
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let user = try JSONDecoder().decode(CloserToYou.User.self, from: data)
               
                DispatchQueue.main.async {
                    completion(user) // ✅ Pass the fetched user
                }
            } catch {
                
                print("Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }

    
    
    func saveUserToDefaults(_ user: User) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: "savedUser")
        }
    }
   
    

    func fetchPartner(forKey key: String) -> User? {
        let decoder = JSONDecoder()
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decodedUser = try? decoder.decode(CloserToYou.User.self, from: savedData) {
            print("User fetched successfully!")
            return decodedUser
        } else {
            print("Failed to fetch partner user.")
            return nil
        }
    }
    func getUserFromDefaults() -> User? {
        if let savedUserData = UserDefaults.standard.data(forKey: "savedUser") {
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(CloserToYou.User.self, from: savedUserData)
                return user
            } catch {
                print("Failed to decode User from UserDefaults: \(error.localizedDescription)")
                return nil
            }
        }
        return nil
    }



    func currentDayOfWeek() -> String {
        let date = Date()
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: date)
        
        // Convert the numerical representation of the day to a string
        let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        
        
        return weekdays[dayOfWeek - 1] // Adjusting for 1-based index in weekdays array
    }
}

#Preview {
    MainWindow(User: CloserToYou.User(firstName: "test", password: "daa", points: 0, mood: Mood(id: nil, Name: "sad", emoji: "🤖", color: "black"), partnerID: 0, email: "dada", pairingCode: 0))
}
