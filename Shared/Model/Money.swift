import Foundation
import Tagged

//TODO: we could decode/encode e.g. `0.0001ETH`
//protocol CurrencyFormat {
//  static var format
//}

enum Currency {
  enum Fiat {
    enum USD { }
  }
  enum Crypto {
    enum BTC { }
    enum ETH/*: CurrencyFormat*/ {
    }
  }
}

typealias Money<Tag> = Tagged<Tag, Decimal>
typealias ETH = Money<Currency.Crypto.ETH>

extension ETH {
  typealias Address = Tagged<Self, String>
}
