#!/bin/sh

scriptPath=$(readlink -f "$0")

classpathDir=$(dirname $(dirname "$scriptPath"))/lib

if [ $# -lt 1 ]; then
	echo
	echo Usage: ./convert.sh \[Markdown file to convert\] or ./convert.sh \[Markdown file to convert\] \[HTML file to be written\]
	echo
	echo Run the convert.sh script from the liferay-docs directory or any subdirectory.
	echo
	echo The first argument is the path to the Markdown file to convert to HTML.
	echo
	echo The second argument is optional. It specifies the path to the HTML file to be created. If this argument is omitted, the HTML file to be created is created in the same directory as the Markdown file and has the same filename as the Markdown file except that the .markdown file extension is replaced by the .html file extension.  
	echo
	exit 1
elif [ $# -lt 2 ]; then
	htmlFile=$1
	htmlFile=$(echo "${htmlFile}" | sed 's/[^.]*$//')
	htmlFile=${htmlFile}html
	#echo "java -cp "${classpathDir}/*" com.liferay.documentation.util.MarkdownToHtml $1 ${htmlFile}"
	#java -cp "${classpathDir}/*" com.liferay.documentation.util.MarkdownToHtml $1 ${htmlFile}
	echo "java -cp "${classpathDir}/*" com.liferay.knowledge.base.markdown.converter.cli.MarkdownConverterCLI $1 > ${htmlFile}"
	java -cp "${classpathDir}/*" com.liferay.knowledge.base.markdown.converter.cli.MarkdownConverterCLI $1 > ${htmlFile}
	exit 0
else
	java -cp "${classpathDir}/*" com.liferay.documentation.util.MarkdownToHtml $1 > $2
	exit 0
fi
