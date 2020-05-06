/*新しいシートビューをモーダルとして表示する
ユーザーがベルボタンをタップしたときに新しく作成されたSheetViewを表示するには、ContentViewで2つの処理を行う必要があります。

SheetViewを表示するかどうかを制御するContentViewに、showSheetView という新しいブール@State変数を追加します。
isPresentedバインディング（showSheetView状態変数を指す）に基づいてシートを提示するsheet（isPresented :)修飾子を使用します。*/

// NavigationView { .navigationBarItems { Button { print

import SwiftUI

struct ContentView: View {
    
    @State var showSheetView: Bool = false
// 2.바아이템의 버튼함수안에서 showSheetView의 Bool값이 변경되면, @State프로퍼티는 그 변화를 감지, 그 변경된 값을 가르키고, 변경된 값을 담고 있는 @State프로퍼티의 변수에 $를 붙여서 isPresented Agument에 지금의 변화된 상태를 전달한다 "isPresented: Binding<Bool> <- 이자리에"
    var body: some View {
        NavigationView {
            Text("Content")
            .navigationBarTitle("Tutorials")
            .navigationBarItems(trailing:
                
                Button(action: {
                    self.showSheetView.toggle()
// 1.ボタンをタップしたとき, .toggle에 의해showSheetView의 값은 @State에서 지정한것의 반대의 Bool값을 가짐
                }) {
                    Image(systemName: "bell.circle.fill")
                        .font(Font.system(.title))
                    // SFシンボルを使用할때 폰트크기조절
                }
            )
        }.sheet(isPresented: $showSheetView) {
            return SheetView(showSsheetView: self.$showSheetView) // 7.참조하기 위해 self를 명시해야한다. 예상이지만 새로운뷰에가 닫혔을때 다시 이 기본 화면이 보여지기 위함일것같다.
            
// 3.false에서 true로 값이변한 $showSheetView는 '참'이되어 {} 안의 리턴문을 실핸한다
          
// 4.{}의 새로운뷰를 실행하며 아규먼트가 있는지를 체크한다 이와 같이 Missing "argument" for parameter 'showSsheetView' in call. 아규먼트를 불러와야한다는건 @Binding 프로퍼티를 새로운뷰가 지니고 있다는 뜻으로 그 뷰에서도 값을 바꾸어 상태를 변화시킬수 있다는 뜻이다. 즉 이 구문이 실행됬다면 화면에는 새로운뷰가 표시되어진다.
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SheetView: View {
    
    @Binding var showSsheetView: Bool
// 6.@Binding 프로퍼티는 Bool 타입만을 갖는다
    var body: some View {
        NavigationView {
            Text("List of notifications")
                .navigationBarTitle(
                    Text("Notifications"), displayMode:
                    .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                    print("Dismissing sheet view...")
                         return self.showSsheetView=false
// 5.@Binding로 선언된 변수 .showSsheetView는 self로 지정되어 버튼함수가 눌러졌을때 false값을 가지므로 이 새로운 뷰는 닫힌다
                }) {
                    Text("Done")
                        .bold()
                })
        }
    }
}

//struct SheetView: View {
//    var body: some View {
//        NavigationView {
//            Text("List of notifications")
//                .navigationBarTitle(
//                    Text("Notifications"), displayMode:
//                    .inline)
//        }
//    }
//}
