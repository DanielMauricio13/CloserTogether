//
//  FinalSubmit.swift
//  CloserToYou
//
//  Created by Daniel Pinilla on 2/9/25.
//

import SwiftUI

struct FinalSubmit: View {
    @State var submit: Bool = false
    @State var pres: Bool  = false
    @State private var isAgreed: Bool = false
    var name: String
    var  password: String
    var Birthday: Date
    var email: String
    
    var body: some View {
       
            if submit {
                ContentView().navigationBarBackButtonHidden(true)
            } else if pres {
                LoadingView()
            } else{
                ZStack{
                    LinearGradient(colors: [Color.blue.opacity(0.7),Color.purple.opacity(0.7)],startPoint: .topLeading,endPoint: .bottomTrailing).ignoresSafeArea()
                    Circle().frame(width: 300).foregroundStyle(Color.blue.opacity(0.3)).blur(radius: 10).offset(x: -10, y: -150)
                    Circle().frame(width: 300).foregroundStyle(Color.white.opacity(0.3)).blur(radius: 10).offset(x: 10, y: 250)
                    VStack{
                        HStack{
                            Toggle(isOn: $isAgreed) {
                                Text("I agree to the")
                                NavigationLink(destination: ContentView()){
                                    Text("Privacy Policy").bold().underline()
                                }
                            }
                            .toggleStyle(CheckboxToggleStyle())
                        }
                        
                        Button{
                            pres = true
                            Task{ try await submitUserData()}
                        }label: {
                            Text("Create account ").foregroundColor(.white).font(.title).background(Rectangle().clipShape(.buttonBorder)).padding(.top)
                        }
                    }
                }
            
        }
    }
    func submitUserData() async throws {
        if isAgreed {
           
            
            let urlString = Constants.baseURL + EndPoints.couple
            guard let url = URL(string: urlString) else {
                throw HttpEroor.badURL
            }
            let user = User(firstName: self.name, password: self.password, points: 0, mood: Mood(id: nil, Name: "happy", emoji: "😃", color: "blue"), partnerID: 0, email: self.email, pairingCode: 0)
//            let user = SendUser(id: nil, firstName: self.name, password: self.password, points: 0, email: self.email)
            print("sedningdata")
            print(user)
            try await HttpClient.shared.sendData(to: url, object: user, httpMethod: HttpMethods.POST.rawValue)
            submit = true
        }
    }
}

#Preview {
    FinalSubmit(name: "Test", password: "test", Birthday: Date(), email: "1")
}


struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView("Creating your account\n this may take a minute...")
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5, anchor: .center)
            Spacer()
        }
        .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
    }
}



struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
