
### frontend ###
.PHONY: install/fe
install/fe:
	echo '🌞 install frontend dependencies...'; \
	cd dates-fe; \
	yarn install

.PHONY: build/fe
build/fe:
	echo '🏗  build frontend'; \
	cd dates-fe; \
	yarn build; \
	cp -r ./dist/ ../dates-be/dist/

.PHONY: run/fe
run/fe:
	echo '🏃 running fronend...'; \
	cd front; \
	yarn client
