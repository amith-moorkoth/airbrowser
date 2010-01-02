
FLEXSDK=/Flex/flexSDK-4
FLEXBIN=$(FLEXSDK)/bin

MXMLC=$(FLEXBIN)/mxmlc
AMXMLC=$(FLEXBIN)/amxmlc
ADT=$(FLEXBIN)/adt
ADL=$(FLEXBIN)/adl

DEVVC=git
PROVC=svn

APPNAME=AirBrowser
KEYFILE=private/distribution_key
KEYPASS=AirBrowser
APPXML=src/${APPNAME}-app.xml
MXML=src/${APPNAME}.mxml
AIRSWF=bin/${APPNAME}.swf
AIRAPP=dist/${APPNAME}.air
INCDIR=src/
ASSETS=images/logo_128.png

FLEXCONFIG=${FLEXSDK}/frameworks/air-config.xml
FLEXLIBS=-source-path=/Flex/greensock-tweening-as3 -source-path=/Flex/as3crypto -source-path=/Flex/assql -source-path=/Flex/facebook
FLEXARGS=-load-config ${FLEXCONFIG} -optimize -headless-server -incremental -source-path=$(INCDIR) $(FLEXLIBS)
# -library-path+=:

all: $(AIRSWF) $(AIRAPP)

run: $(AIRSWF)
	$(ADL) $(APPXML) ./

$(AIRSWF): src/*
	$(AMXMLC) $(FLEXARGS) -output $(AIRSWF) $(MXML)

$(AIRAPP): $(AIRSWF) $(APPXML) $(KEYFILE)
	$(ADT) -package -storetype pkcs12 -keystore $(KEYFILE) -storepass $(KEYPASS) $(AIRAPP) $(APPXML) $(AIRSWF) $(ASSETS)

$(KEYFILE):
	$(ADT) -certificate -cn dan.f-box.org -ou dev -o "f-box" -c GB 2048-RSA $(KEYFILE) $(KEYPASS)

clean:
	rm -f bin/* dist/*

distclean:
	rm -f private/*

status:
	$(DEVVC) status ./
	$(PROVC) status ./

commit:
	$(DEVVC) commit ./
	$(PROVC) commit ./

devstatus:
	$(DEVVC) status ./

devcommit:
	$(DEVVC) commit ./

prodstatus:
	$(PROVC) status ./

prodcommit:
	$(PROVC) commit ./
