//
//  Tips.swift
//  SafeText
//
//  Created by Shaurya Gupta on 2022-11-11.
//

import SwiftUI

struct Tips: View {
    var body: some View {
            VStack {
                CardView(image: "password", title: "What makes a good password?", des: "Here are a few tips: \n1. Is at least 12 characters long. The longer your password is - the better.\n2. Uses uppercase and lowercase letters, numbers and special symbols. Passwords that consist of mixed characters are harder to crack.\n3. Doesn't contain memorable keyboard paths.")
            }
    }
}

struct Tips_Previews: PreviewProvider {
    static var previews: some View {
        Tips()
    }
}
