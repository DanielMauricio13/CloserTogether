//
//  matchPartner.swift
//  CloserToYou
//
//  Created by Daniel Pinilla on 2/13/25.
//

import SwiftUI

struct matchPartner: View {
    var mainUser: User
    @Binding var part: Bool
    @State var pairingCode: String = "000000"
    var body: some View {
        ZStack{
            Rectangle().foregroundStyle(Color.black).ignoresSafeArea()
            Rectangle().ignoresSafeArea().foregroundStyle(LinearGradient(colors: [Color.red.opacity(0.4) ,Color.gray.opacity(0.9)], startPoint: .topLeading, endPoint: .bottom))
            VStack{
                Spacer()
                Text("Match with your partner").font(.largeTitle).bold().fontDesign(.rounded).padding(.top)
                Spacer()
                Text("Your code").font(.title).foregroundStyle(Color.white).fontDesign(.rounded).bold().padding(.bottom)
                ZStack{
                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 300, height:100)
                    Text(formatPairingCodee(mainUser.pairingCode)).foregroundStyle(Color.white).font(.title).bold().fontDesign(.rounded)

                }
                Text("Enter partner's code").font(.title).bold().fontDesign(.rounded).foregroundStyle(Color.white).padding(.top).padding(.bottom)
                ZStack{
                    RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 300, height:100)
                   
                    
                        Spacer()
                    TextField("", text: $pairingCode)
                                   .font(.largeTitle)
                                   .foregroundColor(.red)
                                   .frame(width: 200, height: 60) // Adjust size
                                   .multilineTextAlignment(.center)
                                   .keyboardType(.numberPad)
                                   .onChange(of: pairingCode) { oldValue, newValue in
                                       let formattedCode = formatPairingCode(newValue, oldValue: oldValue)
                                               if formattedCode.count <= 6 { // Prevents exceeding 6 characters
                                                   pairingCode = formattedCode
                                               } else {
                                                   pairingCode = String(formattedCode.prefix(6)) // Trim to 6 digits
                                               }
                                   }
                                   .padding()
                    
                }
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        Task{
                            updateUserPartner()
                            fetchUserAndSave() { fetchedUser in
                                DispatchQueue.main.async {
                                    if fetchedUser != nil{
                                        if fetchedUser?.partnerID != 0 {
                                            part = true
                                        }
                                      
                                    }
                                }
                            }
                            
                        }
                    }label: {
                        Text("Pair").background(RoundedRectangle(cornerRadius: 40).fill(Color.accentColor).frame(width: 150, height: 40)).foregroundStyle(Color.white)
                    }
                    Spacer()
                    Button{
                        
                        fetchUserAndSave() { fetchedUser in
                            DispatchQueue.main.async {
                                if fetchedUser != nil{
                                    if fetchedUser?.partnerID != 0 {
                                        part = true
                                    }
                                  
                                }
                            }
                        }
                        
                        
                    }label: {
                        Text("Shared").background(RoundedRectangle(cornerRadius: 40).fill(Color.accentColor).frame(width: 150, height: 40)).foregroundStyle(Color.white)
                    }
                    Spacer()
                }
                Spacer(minLength: 200)
                
            }
        }
    }
    func updateUserPartner() {
        guard let url = URL(string: "\(Constants.baseURL)couplesUser/postPartner") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var sendUser = mainUser
        sendUser.partnerID = Int(pairingCode)!
        
        do {
           
            let jsonData = try JSONEncoder().encode(sendUser)
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
                
            }
            
        }.resume()
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
                DispatchQueue.main.async {
                    completion(user) // ✅ Pass the fetched user
                }
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

func formatPairingCodee(_ code: Int) -> String {
    let codeString = String(format: "%06d", code) // Ensure 5-digit formatting (e.g., "00000")
    return codeString.map { String($0) }.joined(separator: "   ") // Add spaces between digits
}

func formatPairingCode(_ newValue: String, oldValue: String) -> String {
    let numbersOnly = newValue.filter { $0.isNumber } // Allow only digits
    let limited = String(numbersOnly.prefix(6)) // Ensure max length of 6 digits
    return limited // Return formatted string
}



//func formatPairingCode(_ newValue: String, oldValue: String) -> String {
//        let numbersOnly = newValue.filter { $0.isNumber } // Allow only digits
//        let limited = String(numbersOnly.suffix(6)) // Ensure max length of 6 digits
//
//        if limited.count == 6 {
//            return limited // If already 6 digits, return as is
//        }
//
//        // Keep leading zeros and insert numbers from right to left
//        let paddingNeeded = max(0, 6 - limited.count)
//
//        return String(repeating: "0", count: paddingNeeded) + limited
//    }


