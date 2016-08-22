//
//  UIComboBox.swift
//  Utilities
//
//  Created by Daniel Garcia on 6/29/16.
//  Copyright © 2016 Daniel Garcia. All rights reserved.
//

import UIKit

enum UIComboBoxStyle: Int {
    case DropDownComboBox = 0
    case SimpleComboBox = 1
    case DropDownList = 2
}

@IBDesignable class UIComboBox: UITextField {
    
    // *** Public IB Properties ***
    @IBInspectable var dropDownHeight:CGFloat = 100.0
    @IBInspectable var displayArrow:Bool = true {
        didSet{
            
        }
    }
    

    // *** Private Properties ***
    private let cornerRadius:CGFloat = 5.0
    private var listVisible:Bool = false
    private let borderWith:CGFloat = 0.5
    private var borderColor:CGColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).CGColor//UIColor.lightGrayColor().CGColor
        //UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).CGColor
    
    
    // *** Public Properties ***
    public var sorted:Bool = false
    public var displayButton:Bool = true
    
    
    // *** Private Variables ***
    let arrowView = UIView()
    var comboBoxListView:ComboBoxListController!
    private var tapGesture :UITapGestureRecognizer!
    
    // *** Public Variables ***
    public var items:[String] = [] {
        didSet{
            print("set items")
            reloadItems(items)
        }
    }
    public var listIndex:Int = -1
    public var listCount = 0
    public var selText:String = ""
    public var notificationCenter = NSNotificationCenter.defaultCenter()
    
    
    // *** Public Events ***
    public let ComboBoxTextChangedNotification = "ComboBoxTextChangedNotification"
    public let ComboBoxSelectedIndexChangedNotification = "ComboBoxSelectedIndexChangedNotification"
    public let ComboBoxGotFocusNotification = "ComboBoxGotFocusNotification"
    internal let ComboBoxLostFocusNotification = "ComboBoxLostFocusNotification"
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    
    func setup(){
        super.clipsToBounds = false
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIComboBox.comboBoxButtonTapped))
        tapGesture.cancelsTouchesInView = false
        drawArrow()
        drawList()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    
    
    func drawArrow(){
        
        arrowView.frame = CGRectMake(self.frame.width - self.frame.height, 0.0 , self.frame.height, self.frame.height)
        arrowView.backgroundColor = UIColor.lightGrayColor()
        //arrowView.layer.cornerRadius = 5.0
    
        
        let buttonMaskLayer = CAShapeLayer()
        buttonMaskLayer.frame = arrowView.bounds
        buttonMaskLayer.path = UIBezierPath(roundedRect: arrowView.bounds, byRoundingCorners: [.TopRight, .BottomRight], cornerRadii: CGSize(width: 5.0, height: 5.0)).CGPath
        arrowView.layer.mask = buttonMaskLayer
        
        
        let xPos:CGFloat = 15.0
        let yPos:CGFloat = 20.0
        let size:CGFloat = 7.5
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, xPos, yPos)
        
        CGPathAddLineToPoint(path, nil, xPos + size, yPos - size)
        CGPathAddLineToPoint(path, nil, xPos - size, yPos - size)
        CGPathAddLineToPoint(path, nil, xPos, yPos)
        
        let triangle = CAShapeLayer()
        triangle.frame = arrowView.bounds
        triangle.path = path
        triangle.lineWidth = 0.5
        triangle.strokeColor = UIColor.darkGrayColor().CGColor
        triangle.fillColor = UIColor.darkGrayColor().CGColor
        
        arrowView.layer.insertSublayer(triangle, atIndex: 0)
        
        
        self.addSubview(arrowView)
        
        
        arrowView.addGestureRecognizer(tapGesture)
    }
    
    func drawList(){
        print("drawList")
        print(items.count)
        comboBoxListView = ComboBoxListController(items: items, font: self.font!)
        comboBoxListView.tableView.frame = CGRectMake(0.0, self.frame.height + 3.0, self.frame.width, 100.0)
        
        
        comboBoxListView.tableView.hidden = !listVisible
        
        /*comboBoxListView.allowsSelection = true
        comboBoxListView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ComboBoxTableCell")
        comboBoxListView.delegate = self
        comboBoxListView.dataSource = self*/
        
        self.addSubview(comboBoxListView.tableView)
        
        
        
        
    }
    
    // *** Private Methods ***
    internal func comboBoxButtonTapped() {
        if !listVisible {
            listVisible = true
            showList()
            
        }else{
            listVisible = false
            hideList()
        }
    }
    
    private func showList() {
        print("showList")
        self.comboBoxListView.tableView.hidden = !self.listVisible

        UIView.animateWithDuration(0.5, animations: {
            self.comboBoxListView.tableView.alpha = 1.0
        })
    }
    
    private func hideList() {
        print("hideList")
        UIView.animateWithDuration(0.5, animations: {
            self.comboBoxListView.tableView.alpha = 0.0
        }, completion: { (value: Bool) in
             self.comboBoxListView.tableView.hidden = !self.listVisible
        })
    }
    
    // *** Public Methods ***
    internal func add(item:String) {
        items.append(item)
    }
    
    internal func remove(index:Int) {
        items.removeAtIndex(index)
    }
    
    internal func clear() {
        items.removeAll()
    }
    
    internal func reloadItems(items:[String]){
        comboBoxListView.items = items
    }
    
    
    // *** Events ***
    
    private func comboBoxTextChanged(selectedIndex:Int, selectedText: String) -> Void {
        self.listIndex = selectedIndex
        self.text = selectedText
    }
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}



class ComboBoxListController: UITableViewController {
    var items:[String] = []
    var font:UIFont!
    
    
    private let cornerRadius:CGFloat = 5.0
    private let borderWith:CGFloat = 0.5
    private var borderColor:CGColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0).CGColor
    
    init(items:[String], font:UIFont) {
        super.init(style: .Plain)
        self.items = items
        print("slef.items: \(self.items)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ComboBoxCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = true
        
        self.tableView.layer.cornerRadius = self.cornerRadius
        self.tableView.layer.borderWidth = self.borderWith
        self.tableView.layer.borderColor = self.borderColor
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.items.count)
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ComboBoxCell") as UITableViewCell!
        
        /*if cell == nil {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ComboBoxCell")
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ComboBoxCell")
        }*/
        
        cell.textLabel?.text = self.items[indexPath.row]
        cell.textLabel?.font = self.font

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //comboBoxTextChanged(indexPath.row, selectedText: self.items[indexPath.row])
        //self.hideList()
        print("item selected")
    }

}

