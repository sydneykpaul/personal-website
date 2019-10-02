SHELL:=/bin/bash
BASEDIR=$(CURDIR)
OUTPUTDIR=public
.PHONY: all
all: clean get_repository build deploy
.PHONY: clean
clean:
	@echo "Removing public directory"
	rm -rf $(BASEDIR)/$(OUTPUTDIR)
.PHONY: get_repository
get_repository:
	@echo "Getting public repository"
	git clone https://github.com/sydneykpaul/sydneykpaul.github.io.git publi
.PHONY: build
build:
	@echo "Generating site"
	hugo --gc --minify
.PHONY: deploy
deploy:
	@echo "Preparing commit"
	@cd $(OUTPUTDIR) \
	 && git config user.email "sydneytheengineer@gmail.com" \
	 && git config user.name "Sydney Paul" \
	 && git add . \
	 && git add -u . \
	 && git status \
	 && git commit -m "Deploy via Makefile" \
	 && git push -f -q https://$(GITHUB_TOKEN)@github.com/sydneykpaul/sydneykpaul.github.io.git master
	@echo "Pushed to remote"
