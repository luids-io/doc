# Makefile for build static site

# Used to populate version in antora
VERSION=$(shell git describe --match 'v[0-9]*' --dirty='.m' --always | sed 's/^v//')
DATEBUILD=$(shell date +%FT%T%z)

# Antora args
ANTORAOPTS:=
ANTORAARGS:=--attribute docs-version=$(VERSION) --attribute docs-date=$(DATEBUILD)

# Resease opts
GITHUB_ORG:=luids-io

# Print output
WHALE = "+"

.PHONY: site products clean
all: site products

FORCE:

site:
	@echo "$(WHALE) $@"
	antora $(ANTORAOPTS) site.yml $(ANTORAARGS)

products:
	@echo "$(WHALE) $@"
	cd products/es ; ./generate.sh

clean:
	@echo "$(WHALE) $@"
	rm -rf .cache
	rm -rf public
	rm -rf products/es/output

.PHONY: github-push
github-push:
	@echo Releasing: $(VERSION)
	@$(eval RELEASE:=$(shell curl -s -d '{"tag_name": "v$(VERSION)", "name": "v$(VERSION)"}' -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" "https://api.github.com/repos/$(GITHUB_ORG)/$(NAME)/releases" | grep -m 1 '"id"' | tr -cd '[[:digit:]]'))
	@echo ReleaseID: $(RELEASE)
	@( cd products/es/output; for asset in `ls -A *pdf`; do \
	    echo $$asset; \
	    curl -o /dev/null -X POST \
	      -H "Content-Type: application/gzip" \
	      -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" \
	      --data-binary "@$$asset" \
	      "https://uploads.github.com/repos/$(GITHUB_ORG)/$(NAME)/releases/$(RELEASE)/assets?name=$${asset}" ; \
	done )
