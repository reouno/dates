.SILENT:

PRJ_NAME=dates
API_DOC_FILE=./docs/api.md

.PHONY: all
all: build/be build/fe

### backend ###
.PHONY: build-back
build/be: stack-build graph stat-complexity generate-docs

.PHONY: stack-build
stack-build:
	echo '🏗  stack build'; \
	stack build

.PHONY: graph
graph:
	echo '🔀 exporting dependency graph to ./data/modules.pdf and ./data/modules.png'; \
	find src -name "*.hs" | xargs graphmod -q -p | dot -Tpdf > data/modules.pdf; \
	find src -name "*.hs" | xargs graphmod -q -p | dot -Tpng -Gdpi=300 > data/modules.png

.PHONY: stat-complexity
stat-complexity:
	echo '➿ Complexity analysis stats:\n'; \
	homplexity-cli app/Main.hs src/ && echo '\n'

.PHONY: generate-docs
generate-docs:
	echo '📚 Generating docs...'; \
	stack runghc src/App/Util/GenerateApiDocs.hs $(API_DOC_FILE); \
	echo '👉 Exported to $(API_DOC_FILE)'

.PHONY: run
run:
	echo '🏃 running...'; \
	stack exec ${PRJ_NAME}-exe

.PHONY: init-db
init-db: create-db migrate-db seeds-db

.PHONY: create-db
create-db:
	./db/create.sh

.PHONY: migrate-db
migrate-db:
	./db/migrate.sh

.PHONY: seeds-db
seeds-db:
	./db/seeds.sh

.PHONY: dump-schema
dump-schema:
	./db/dump.sh

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
	cp -r ./dist/ ../dist/

.PHONY: run/fe
run/fe:
	echo '🏃 running fronend...'; \
	cd front; \
	yarn client
