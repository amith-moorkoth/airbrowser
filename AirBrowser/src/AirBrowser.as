import mx.containers.*;
import mx.controls.*;

public var tabs:Object = {};
public var numchildren:Number = 0;
public var oid:Number = 0;

public function init():void {
  winresize();
}

public function winresize():void {
  butnew.x = nativeWindow.width - butnew.width - 10;
  tab1.width = nativeWindow.width - 20;
  tab1.height = nativeWindow.height - 90;
}

public function newtab():Number {
  var tmpvbox:VBox = new VBox();
  var tmphbox:HBox = new HBox();
  var tmptxt:TextInput = new TextInput();
  var tmpbutgo:Button = new Button();
  var tmpbutstop:Button = new Button();
  var tmpbutclose:Button = new Button();
  var tmphtml:HTML = new HTML();
  var tmpid:Number = 0;
  tmpid = oid;
  oid = oid + 1;
  numchildren = numchildren + 1;
  tmpvbox.label = "none";
  tmptxt.id = "tabtext-" + tmpid;
  tmptxt.text = "http://";
  tmptxt.addEventListener(KeyboardEvent.KEY_DOWN, txtsubenter);
  tmphbox.addChild(tmptxt);
  tmpbutgo.id = "butgo-" + tmpid;
  tmpbutgo.label = "Go";
  tmpbutgo.addEventListener(MouseEvent.CLICK, butgoclicked);
  tmphbox.addChild(tmpbutgo);
  tmpbutstop.id = "butstop-" + tmpid;
  tmpbutstop.label = "Stop";
  tmpbutstop.addEventListener(MouseEvent.CLICK, butstopclicked);
  tmphbox.addChild(tmpbutstop);
  tmpbutclose.id = "butclose-" + tmpid;
  tmpbutclose.label = "Close";
  tmpbutclose.addEventListener(MouseEvent.CLICK, butcloseclicked);
  tmphbox.addChild(tmpbutclose);
  tmpvbox.addChild(tmphbox);
  tmphtml.id = "html-" + tmpid;
  tmphtml.location = "about:blank";
  tmphtml.addEventListener(Event.COMPLETE, htmlloaded);
  tmpvbox.addChild(tmphtml);
  tab1.addChild(tmpvbox);
  tabs[tmpid] = {'txturlinput': tmptxt, 'htmlwindow': tmphtml, 'pane': tmpvbox};
  return tmpid;
}

public function txtsubenter(evt:KeyboardEvent):void {
  if (evt.keyCode == 13) {
    var res:Array = evt.currentTarget.id.split(/-/);
    var tmpn:Number = res[1];
    tabs[tmpn].htmlwindow.location = tabs[tmpn].txturlinput.text;
  }
}

public function htmlloaded(evt:Event):void {
  var res:Array = evt.currentTarget.id.split(/-/);
  var tmpn:Number = res[1];
  tabs[tmpn].txturlinput.text = tabs[tmpn].htmlwindow.location;
  var resb:Array = tabs[tmpn].txturlinput.text.split(/\//);
  tabs[tmpn].pane.label = resb[2];
}

public function butgoclicked(evt:Event):void {
  var res:Array = evt.currentTarget.id.split(/-/);
  var tmpid:Number = res[1];
  tabs[tmpid].htmlwindow.location = tabs[tmpid].txturlinput.text;
}

public function butstopclicked(evt:Event):void {
  var res:Array = evt.currentTarget.id.split(/-/);
  var tmpid:Number = res[1];
  tabs[tmpid].htmlwindow.cancelLoad();
}

public function butcloseclicked(evt:Event):void {
  var res:Array = evt.currentTarget.id.split(/-/);
  var tmpid:Number = res[1];
  tab1.removeChild(tabs[tmpid].pane);
  tabs[tmpid] = null;
  numchildren = numchildren - 1;
}