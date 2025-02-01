.PHONY: webapp
webapp:
	cd lyra/webapp && npm run dev

.PHONY: status
status:
	meta git status
