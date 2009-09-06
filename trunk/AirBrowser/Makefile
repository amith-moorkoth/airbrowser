

FLEXSDK=/Flex/flexSDK-4
FLEXBIN=$(FLEXSDK)/bin

MXMLC=$(FLEXBIN)/mxmlc
AMXMLC=$(FLEXBIN)/amxmlc

APPNAME=AirBrowser
KEYFILE=private/distribution_key
KEYPASS=AirBrowser
APPXML=src/application.xml
MXML=src/AirBrowser.mxml
AIRSWF=bin/AirBrowser.swf
AIRAPP=dist/AirBrowser.air
INCDIR=src/
ASSETS=images/logo_128.png

FLEXARGS=-optimize -headless-server -incremental -source-path=$(INCDIR) -source-path=/Flex/greensock-tweening-as3 -source-path=/Flex/as3crypto -source-path=/Flex/assql

all: $(AIRSWF) $(AIRAPP)

$(AIRSWF): $(MXML)
	$(AMXMLC) $(FLEXARGS) -output $(AIRSWF) $(MXML)

## Package the Air .app
$(AIRAPP): $(AIRSWF) $(APPXML)
	adt -package -storetype pkcs12 -keystore $(KEYFILE) -storepass $(KEYPASS) $(AIRAPP) $(APPXML) $(AIRSWF) $(ASSETS)

clean:
	rm -f bin/* dist/*
