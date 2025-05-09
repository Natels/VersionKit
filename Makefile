@PHONY: test
test:
	@echo "Running tests..."
	@swift test -q

@PHONY: format
format:
	@swift format -ir --configuration .swift-format .
	
@PHONY: lint
lint:
	@swift format lint -r --configuration .swift-format .

@PHONY: precommit
precommit: test lint
