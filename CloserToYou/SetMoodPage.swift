//
//  SetMoodPage.swift
//  CloserToYou
//
//  Created by Daniel Pinilla on 1/21/25.
//

import SwiftUI

struct SetMoodPage: View {
    @State var mainUser: User
    @State var partner: User
    @Binding var changeMood: Bool
    @State var newMood = Mood(id: nil, Name: "test", emoji: "🔴", color: "red")
    @State var colorUser = Color.purple
    @State var colorPartner = Color.purple
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle().foregroundStyle(Color.black).ignoresSafeArea()
                Rectangle().ignoresSafeArea().foregroundStyle(LinearGradient(colors: [colorUser.opacity(0.5), colorPartner.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                VStack{
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 20).fill(colorUser).frame(width: 170, height:170)
                        RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 170, height:170)
                        
                        VStack{
                            Text("\(mainUser.mood.emoji)").font(.largeTitle)
                            Text("\(mainUser.mood.Name)").padding(.top).font(.title3).foregroundStyle(Color.white).bold()
                        }
                        
                    }.padding(.top)
                    ScrollView{
                        HStack{
                            Button {
                                newMood.Name = "Chill"
                                newMood.emoji = "😎"
                                newMood.color = "cyan"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                                
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.cyan).frame(width: 50, height:5)
                                    VStack{
                                        Text("😎").font(.title)
                                        Text("Chill").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                newMood.Name = "Missing you"
                                newMood.emoji = "💞"
                                newMood.color = "pink"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                                
                            
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.pink).frame(width: 50, height:5)
                                    VStack{
                                        Text("💞").font(.title)
                                        Text("Missing you").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                newMood.Name = "Excited"
                                newMood.emoji = "🤩"
                                newMood.color = "orange"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                ZStack{
                                   
                                RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(Color.orange).frame(width: 50, height:5)
                                VStack{
                                    Text("🤩").font(.title)
                                    Text("Excited").padding(.top).font(.body).foregroundStyle(Color.white)
                                }
                            }.padding(.top)
                            }
                            
                        }
                        HStack{
                            Button {
                                newMood.Name = "Tired"
                                newMood.emoji = "🥱"
                                newMood.color = "gray"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                   
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.gray).frame(width: 50, height:5)
                                    VStack{
                                        Text("🥱").font(.title)
                                        Text("Tired").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                newMood.Name = "Worried"
                                newMood.emoji = "😖"
                                newMood.color = "green"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.green).frame(width: 50, height:5)
                                    VStack{
                                        Text("😖").font(.title)
                                        Text("Worried").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                newMood.Name = "Overwhelmed"
                                newMood.emoji = "🙃"
                                newMood.color = "purple"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.purple).frame(width: 50, height:5)
                                    VStack{
                                        Text("🙃").font(.title2)
                                        Text("Overwhelmed").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            
                        }
                        HStack{
                            Button {
                                newMood.Name = "Hungry"
                                newMood.emoji = "🍕"
                                newMood.color = "orange"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.orange).frame(width: 50, height:5)
                                    VStack{
                                        Text("🍕").font(.title)
                                        Text("Hungry").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                newMood.Name = "Drunk"
                                newMood.emoji = "🍹"
                                newMood.color = "purple"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                   
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.purple).frame(width: 50, height:5)
                                    VStack{
                                        Text("🍹").font(.title)
                                        Text("Drunk").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                newMood.Name = "Studying"
                                newMood.emoji = "📚"
                                newMood.color = "cyan"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.cyan).frame(width: 50, height:5)
                                    VStack{
                                        Text("📚").font(.title)
                                        Text("Studying").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            
                        }
                        HStack{
                            Button {
                                newMood.Name = "Focused"
                                newMood.emoji = "🤓"
                                newMood.color = "cyan"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.cyan).frame(width: 50, height:5)
                                    VStack{
                                        Text("🤓").font(.title)
                                        Text("Focused").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                newMood.Name = "Bored"
                                newMood.emoji = "😎"
                                newMood.color = "gray"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.gray).frame(width: 50, height:5)
                                    VStack{
                                        Text("🧍‍♀️").font(.title)
                                        Text("Bored").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                newMood.Name = "Cuddly"
                                newMood.emoji = "🫂"
                                newMood.color = "pink"
                                Task{
                                    updateUserMood(user: mainUser)
                                }
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    RoundedRectangle(cornerRadius: 20).fill(.pink).frame(width: 50, height:5)
                                    VStack{
                                        Text("🫂").font(.title)
                                        Text("Cuddly").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            
                        }
                        HStack{
                            Button {
                                
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    VStack{
                                        Text("😁").font(.title)
                                        Text("Happy").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    VStack{
                                        Text("😁").font(.title)
                                        Text("Happy").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    VStack{
                                        Text("😁").font(.title)
                                        Text("Happy").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            
                        }
                        HStack{
                            Button {
                                
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    VStack{
                                        Text("😁").font(.title)
                                        Text("Happy").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    VStack{
                                        Text("😁").font(.title)
                                        Text("Happy").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            Button {
                                
                            } label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 100, height:120)
                                    VStack{
                                        Text("😁").font(.title)
                                        Text("Happy").padding(.top).font(.body).foregroundStyle(Color.white)
                                    }
                                }.padding(.top)
                            }
                            
                        }
                    }
                    Spacer()
                }
                
            }
        }.onAppear{
            
            fetchUserAndSave() { fetchedUser in
                DispatchQueue.main.async {
                    if fetchedUser != nil{
                        self.mainUser = fetchedUser!
                        colorUser = getColor(mainUser: mainUser)
                        fetchPartnerAndSave() { fetchedPartner in
                            DispatchQueue.main.async {
                                if fetchedPartner != nil{
                                    self.partner = fetchedPartner!
                                    colorPartner = getColor(mainUser: partner)
                                }
                                
                            }
                        }
                    }
                    
                }
            }
            
            
            
        }
    }
    
    func fetchUserAndSave( completion: @escaping (User?) -> Void) {
        guard let apiUrl = URL(string: "\(Constants.baseURL)couplesUser/userCouple?email=\(mainUser.email)&password=\(mainUser.password)") else {
            
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
    guard let apiUrl = URL(string: "\(Constants.baseURL)couplesUser/getPartnerInfo?pairingCode=\(mainUser.partnerID)") else {
        
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


    func updateUserMood(user: User) {
        guard let url = URL(string: "\(Constants.baseURL)couplesUser/updateMood") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mainUser.mood = newMood
        
        do {
           
            let jsonData = try JSONEncoder().encode(mainUser)
            print(mainUser)
            request.httpBody = jsonData
        } catch {
            print("Encoding error: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request failed: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("User mood updated successfully!")
                changeMood = false
            }
            
            guard let apiUrl = URL(string: "\(Constants.baseURL)couplesUser/userCouple?email=\(mainUser.email)&password=\(mainUser.password)") else {
                
              print("failed tp fetch user url")
                return
            }

        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                saveUserToDefaults(user) // Save user to UserDefaults
                DispatchQueue.main.async {
                   
                }
            } catch {
                print("Decoding error: \(error)")
                
            }
        }.resume()
            
        }.resume()
    }
    func saveUserToDefaults(_ user: User) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: "savedUser")
        }
    }
}


func getColor(mainUser: User) -> Color {
    switch mainUser.mood.color{
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        case "yellow": return .yellow
        case "purple": return .purple
        case "orange": return .orange
        case "pink": return .pink
        case "black": return .black
        case "white": return .white
        case "cyan" : return.cyan
        case "teal" : return Color.teal
        default: return .gray // Default if color is unknown
        }
    }
