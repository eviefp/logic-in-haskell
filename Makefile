package = haskell

stack_yaml = STACK_YAML="stack.yaml"
stack = $(stack_yaml) stack
pattern = ""

build:
	$(stack) build $(package)

build-dirty:
	$(stack) build --ghc-options=-fforce-recomp --pedantic $(package)

run:
	$(stack) build --pedantic --fast && $(stack) exec -- $(package)

install:
	$(stack) install

ghci:
	$(stack) ghci $(package)

test:
	$(stack) test $(package) --test-arguments "--hide-successes"

testp:
	$(stack) test --test-arguments '-p "$(pattern)"'

test-ghci:
	$(stack) ghci $(package):test:$(package)-test

pedantic:
	$(stack) build --haddock --no-haddock-deps --coverage --bench --no-run-benchmarks --test --no-run-tests --pedantic

ghcid:
	$(stack) exec -- ghcid -c "stack ghci $(package) --test --ghci-options='-Wall -Wincomplete-uni-patterns -fobject-code -fno-warn-unused-do-bind' --main-is $(package):$(package)"

# TODO(Vladimir): remove 'hyperlink-source' when we upgrade from lts-12.10 (8.4.3)
hoogle-gen:
	$(stack) haddock; $(stack) hoogle generate --rebuild --no-haddock-hyperlink-source  -- --local

hoogle:
	$(stack) hoogle server -- --local --port 8000

dev-deps:
	stack install ghcid

tags:
	hasktags -e .

.PHONY : build build-dirty run install ghci test test-ghci ghcid dev-deps
