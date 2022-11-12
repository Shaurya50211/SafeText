//
//  CardView.swift



import SwiftUI

struct CardView: View {
    
    var image: String
    var title: String
    var des: String
    
    var body: some View {
        
        VStack {
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom)
            
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(title)
                        .font(.title)
                        .fontWeight(.black)
                    
                    Text(des)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                }.layoutPriority(100)
                
                Spacer()
            }.padding()
            
        }
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), lineWidth: 1))
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "password", title: "What makes a good password?", des: "Here are a few tips: \n1. Is at least 12 characters long. The longer your password is - the better.\n2. Uses uppercase and lowercase letters, numbers and special symbols. Passwords that consist of mixed characters are harder to crack.\n3. Doesn't contain memorable keyboard paths.")
    }
}
