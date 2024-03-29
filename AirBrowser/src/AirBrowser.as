import mx.containers.*;
import mx.controls.*;

public var tabs:Object = {};
public var numchildren:Number = 0;
public var oid:Number = 0;
public var cid:Number = 0;

public function init():void {
  winresize();
}

public function winresize():void {
  butnew.x = nativeWindow.width - butnew.width - 10;
  tab1.width = nativeWindow.width - 20;
  tab1.height = nativeWindow.height - 90;
  if(tabs[cid] != undefined) {
    tabs[cid]['htmlwindow'].width = tab1.width - 5;
    tabs[cid]['htmlwindow'].height = tab1.height - 65;
  }
}

public function newtab():Number {
  var tmpvbox:VBox = new VBox();
  var tmphbox:HBox = new HBox();
  var tmptxt:TextInput = new TextInput();
  var tmpbutgo:Button = new Button();
  var tmpbutstop:Button = new Button();
  var tmpbutrefresh:Button = new Button();
  var tmpbutclose:Button = new Button();
  var tmphtml:HTML = new HTML();
  var tmpid:Number = 0;

  tmpid = oid;
  var tmpc:Number = 0;
  while(tabs[oid] != null && tabs[oid] != undefined) {
    oid = oid + 1;
    if(oid > 1024) {
      tmpc = tmpc + 1;
      oid = 0;
    }
    if(tmpc == 2) {
      return -1;
    }
    tmpid = oid;
  }
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
  tmpbutrefresh.id = "butrefresh-" + tmpid;
  tmpbutrefresh.label = "Refresh";
  tmpbutrefresh.addEventListener(MouseEvent.CLICK, butrefreshclicked);
  tmphbox.addChild(tmpbutrefresh);
  tmpbutclose.id = "butclose-" + tmpid;
  tmpbutclose.label = "Close";
  tmpbutclose.addEventListener(MouseEvent.CLICK, butcloseclicked);
  tmphbox.addChild(tmpbutclose);
  tmpvbox.addChild(tmphbox);
  tmphtml.id = "html-" + tmpid;
  tmphtml.location = "http://";
  tmphtml.addEventListener(Event.COMPLETE, htmlloaded);
  tmphtml.width = tab1.width - 5;
  tmphtml.height = tab1.height - 65;
  tmpvbox.addChild(tmphtml);
  tab1.addChild(tmpvbox);
  tabs[tmpid] = {'txturlinput': tmptxt, 'htmlwindow': tmphtml, 'pane': tmpvbox};
  return tmpid;
}

public function txtsubenter(evt:KeyboardEvent):void {
  if (evt.keyCode == 13) {
    var res:Array = evt.currentTarget.id.split(/-/);
    var tmpn:Number = res[1];
    cid = tmpn;
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
  cid = tmpid;
  tabs[tmpid].htmlwindow.location = tabs[tmpid].txturlinput.text;
}

public function butrefreshclicked(evt:Event):void {
  var res:Array = evt.currentTarget.id.split(/-/);
  var tmpid:Number = res[1];
  cid = tmpid;
  tabs[tmpid].htmlwindow.reload();
}

public function butstopclicked(evt:Event):void {
  var res:Array = evt.currentTarget.id.split(/-/);
  var tmpid:Number = res[1];
  cid = tmpid;
  tabs[tmpid].htmlwindow.cancelLoad();
}

public function butcloseclicked(evt:Event):void {
  var res:Array = evt.currentTarget.id.split(/-/);
  var tmpid:Number = res[1];
  tab1.removeChild(tabs[tmpid].pane);
  tabs[tmpid] = null;
  numchildren = numchildren - 1;
}
