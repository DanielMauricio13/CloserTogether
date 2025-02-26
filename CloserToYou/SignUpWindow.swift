//
//  SignUpWindow.swift
//  CloserToYou
//
//  Created by Daniel Pinilla on 2/9/25.
//

import SwiftUI

struct SignUpWindow: View {
    
    @State var firstName: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
  @State  var email: String = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var nameEmpty = 0
    @State var isDataSaved: Bool = false
    @State var Birthday = Date()
    
    var body: some View {
        if isDataSaved {
            FinalSubmit(name: firstName, password: password, Birthday: Birthday, email: self.email)
        }else{
            NavigationView{
                ZStack {
                    Rectangle().fill(.black)
                    LinearGradient(colors: [Color.red.opacity(0.8),Color.cyan.opacity(0.2)],startPoint: .topLeading,endPoint: .bottomTrailing).ignoresSafeArea()
                    Circle().frame(width: 300).foregroundStyle(Color.blue.opacity(0.3)).blur(radius: 10).offset(x: -100, y: -150).animation(.snappy, value: 10)
                    Circle().frame(width: 300).foregroundStyle(Color.purple.opacity(0.3)).blur(radius: 10).offset(x: 150, y: 250)
                    RoundedRectangle(cornerRadius: 30,style: .continuous).frame(width: 500,height: 500).foregroundStyle(LinearGradient(colors: [Color.purple, .blue], startPoint: .top, endPoint: .bottom)).offset(x:300,y: -200).blur(radius: 30).rotationEffect(.degrees(170))
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial).frame(width: 350, height:650)
                        VStack{
                            Text("Create Account").foregroundStyle(LinearGradient(colors: [.accentColor,.purple], startPoint: .topLeading, endPoint: .bottomTrailing)).font(.system(size: 35, weight: .bold, design: .default))
                            Form{
                                Section(header: Text("Name"),footer: Text("Enter a name").opacity(CGFloat(nameEmpty)).foregroundStyle(.red)) {
                                    TextField("First Name", text: $firstName).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white).cornerRadius(10)
                                    
                                }
                                Section(header: Text("Email"), footer: Text("Email already registered or empty").opacity(CGFloat(wrongEmail)).foregroundStyle(Color.red)){
                                    TextField("Email", text: $email).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white).cornerRadius(10).listRowBackground(Rectangle().clipShape(.capsule).border(Color.red, width: CGFloat(wrongEmail)))
                                }
                                
                                Section(header: Text("Password"), footer: Text("Passwords do not match or is empty").opacity(CGFloat(wrongPassword)).foregroundStyle(Color.red)){
                                    SecureField("Password", text: $password).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white)
                                    SecureField("Confirm password", text: $confirmPassword).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white)
                                }
                                Section{
                                    DatePicker("Birthday",selection: $Birthday, displayedComponents: .date)
                                }header: {
                                    Text("Birthday")
                                }
                                
                            }.scrollContentBackground(.hidden).frame(width: 350, height: 470)
                            
                            Button{
                                Task{
                                    try await checkEmail(self.email)
                                }
                            }label: {
                                Text("Create account \(firstName)").foregroundColor(.white).font(.title).background(Rectangle().clipShape(.buttonBorder)).frame(width: 500, height: 50)
                            }
                        }
                        
                        
                    }
                    
                }.onAppear{}
                    .ignoresSafeArea()
            }
        }
    }
    func checkEmail(_ email: String) async throws -> Void {

        guard let url = URL(string: "\(Constants.baseURL)\(EndPoints.couple)/checkEmail?email=\(email)") else {
             print("error")
            return
        }
        print(Birthday)
        
        self.email = email.uppercased()
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    wrongEmail = 1
                    print("found")
                case 401:
                    wrongEmail = 0
                default:
                    wrongEmail = 0
                }

            }
            if firstName == ""{
                nameEmpty = 1
            }
            if email == ""{
                wrongEmail = 1
            }
            if password != confirmPassword || password == "" {
                wrongPassword = 1
            }else{
                wrongPassword = 0
            }
            
            if wrongEmail == 0 && wrongPassword == 0{
                isDataSaved = true
            }
        }
        
        task.resume()
        return
    }
}

#Preview {
    SignUpWindow()
}
