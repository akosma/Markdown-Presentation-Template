#  This makefile generates all the output files from the source Markdown files.

#  Constants
DIR = _build
PRESENTATION = presentation
EXTENSIONS = --from=markdown+fenced_code_blocks+fenced_code_attributes
HTMLOPTS = --self-contained --standalone --highlight-style pygments
S5OPTS = --to=s5 --output=s5.html
SLIDYOPTS = --to=slidy --output=slidy.html
SLIDEOUSOPTS = --to=slideous --output=slideous.html
DZSLIDESOPTS = --to=dzslides --output=dzslides.html
REVEALJSOPTS = --to=revealjs --output=revealjs.html
PDFOPTS = --to=beamer --output=beamer.pdf


#  ---------------------------------
#  Public targets
all: clean create_html create_pdf remove_files

html: clean create_html remove_files

pdf: clean create_pdf remove_files

clean:
	if [ -d "${DIR}" ]; \
		then rm -r ${DIR}; \
	fi; \


#  ---------------------------------
#  Private targets
#  If the build directory does not exist, create it
create_folder:
	if [ ! -d "${DIR}" ]; then \
		mkdir ${DIR}; \
		cp -R images ${DIR}; \
		cp -R libs/* ${DIR}; \
		cp ${PRESENTATION}.md ${DIR}; \
	fi; \


#  Generate HTML
create_html: create_folder
	cd ${DIR}; \
	pandoc ${S5OPTS} ${HTMLOPTS} ${EXTENSIONS} ${PRESENTATION}.md; \
	pandoc ${SLIDYOPTS} ${HTMLOPTS} ${EXTENSIONS} ${PRESENTATION}.md; \
	pandoc ${SLIDEOUSOPTS} ${HTMLOPTS} ${EXTENSIONS} ${PRESENTATION}.md; \
	pandoc ${DZSLIDESOPTS} ${HTMLOPTS} ${EXTENSIONS} ${PRESENTATION}.md; \
	pandoc ${REVEALJSOPTS} ${HTMLOPTS} ${EXTENSIONS} ${PRESENTATION}.md; \


#  Generate PDF
create_pdf: create_folder
	cd ${DIR}; \
	pandoc ${PDFOPTS} ${PRESENTATION}.md; \


#  Clean up, so that only the product files remain
remove_files: create_folder
	cd ${DIR}; \
	rm -rf reveal.js; \
	rm -rf s5; \
	rm -rf slideous; \
	rm -rf images; \
	rm -f *.md; \

