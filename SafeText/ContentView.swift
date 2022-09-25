//
//  ContentView.swift
//  SafeText
//
//  Created by Shaurya Gupta on 2022-09-21.
//

import SwiftUI
import Lottie
import LocalAuthentication

struct ContentView: View {
    // Change this to false after
    @State private var isUnlocked = false
    @AppStorage("info") private var confidencialInfo = ""
    @AppStorage("needAuth") private var needAuth = true
    @State private var presentAlert = false
    var body: some View {
        ZStack {
            Color(UIColor(red: 1.00, green: 0.98, blue: 0.90, alpha: 1.00))
                .ignoresSafeArea()
            VStack {
                if isUnlocked == false && needAuth == true {
                    NavigationStack {
                        // MARK: Title
                        VStack(alignment: .leading) {
                            Text("Welcome,")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.black.opacity(0.5))
                            Text("Authenticate to begin")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.black.opacity(0.8))
                                .padding(.top, -25)
                        }
                        LottieAnimationView(animationName: "secure", loopMode: .loop)
                            .frame(width: 400, height: 400)
                        Button {
                            // MARK: Authenticate User
                            let localAuthenticationContext = LAContext()
                            localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"
                            
                            var authorizationError: NSError?
                            let reason = "Authentication is required to continue."
                            if localAuthenticationContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &authorizationError) {
                                
                                // Which biometry is supported?
                                let biometricType = localAuthenticationContext.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
                                print("\(biometricType) is supported")
                                
                                localAuthenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reason) { (success, evaluationError) in
                                    if success {
                                        // Set isUnlocked to true so that we can switch screens
                                        print("Success!")
                                        isUnlocked = true
                                        
                                    } else {
                                        // Error
                                        print("Error \(evaluationError!.localizedDescription)")
                                    }
                                }
                                
                            } else {
                                // No biometrics
                                print("User has not enrolled into using Biometrics")
                            }
                        } label: {
                            // MARK: Auth button label
                            Text("Authenticate")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(.horizontal, 100)
                                .padding(.vertical, 10)
                        }
                        .background(.blue)
                        .cornerRadius(5)
                    }
                    .background(.blue)
                    .scrollContentBackground(.hidden)
                    .preferredColorScheme(.light)
                    .toolbarColorScheme(.light, for: .navigationBar)
                } else {
                    withAnimation(.easeInOut) {
                        NavigationStack {
                            VStack {
                                    Text("Your text goes here:")
                                        .foregroundColor(.black.opacity(0.7))
                                        .padding(.bottom, -40)
                                        .padding(.leading, -130)
                                
                                TextEditor(text: $confidencialInfo)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                    .padding(.leading, 5)
                                    .frame(height: 400)
                                    .border(LinearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing), width: 2)
                                    .padding()
                                    .autocorrectionDisabled(false)
                                    .textInputAutocapitalization(.never)
                                    .foregroundColor(.black)
                                Button {
                                    // Save Data
                                    UserDefaults.standard.set(confidencialInfo, forKey: "info")
                                    presentAlert = true
                                } label: {
                                    HStack {
                                        Text("Save")
                                            .foregroundColor(.white)
                                    }
                                }
                                .alert(isPresented: $presentAlert, content: {
                                    Alert(title: Text("Saved Successfully!"), dismissButton: .default(Text("OK"), action: {
                                        isUnlocked = false
                                    }))
                                })
                                .font(.title3)
                                .padding(.horizontal, 160)
                                .padding(.vertical, 10)
                                .background(.blue)
                                .cornerRadius(5)
                                
                                Toggle("Ask for biometry next time?", isOn: $needAuth)
                                    .padding(.horizontal, 70)
                                    .padding(.top, 15)
                                    .font(.headline)
                                    .fontWeight(.medium)
                            }
                        }
                        .background(.blue)
                        .scrollContentBackground(.hidden)
                        .navigationTitle("SafeText")
                        .preferredColorScheme(.light)
                        .toolbarColorScheme(.light, for: .navigationBar)
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
