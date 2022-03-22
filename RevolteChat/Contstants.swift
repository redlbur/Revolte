//
//  Contstants.swift
//  RevolteChat
//
//  Created by Mederbek on 20/3/22.
//


struct K {
  
  private init() {}
  
  static let APP_NAME = "REVOLTE"
  static let REGISTER_SEGUE = "RegisterToChat"
  static let LOGIN_SEGUE = "LoginToChat"
  static let CELL_IDENTIFIRE = "ReusableCell"
  static let CELL_NIB_NAME = "MessageCell"
  
  struct FStore {
    static let COLLECTION_NAME = "messages"
    static let SENDER_FIELD = "sender"
    static let BODY_FIELD = "body"
    static let DATE_FIELD = "date"
  }
  
  struct Colors {
    static let WET_ASPHALT = "WetAsphalt"
    static let CLOUDS = "Clouds"
    static let ASBESTOS = "Asbestos"
    static let MIDNIGHT_BLUE = "MidnightBlue"
  }
}
