module ArlocalMarkupExamples
  MARKUP_EXAMPLES = {
    markdown: {
      title: 'markdown (commonmarker)',
      description: ['Markdown is a method of writing plain text that conveys presentation details.','CommonMarker is the name of the parser utility gem.'],
      examples: {
        hx: '# Heading 1' + "\n" + '## Heading 2',
        i: '_italics_ and *italics*',
        b: '__bold__ and **bold**',
        a: 'link to [about A&R.local](http://arlocal.info)',
        br: 'No' + "\n" + 'linebreak' + "\n\n" + 'Force a linebreak  ' + "\n" + 'with two spaces at end of line  ' + "\n" + '(select text in left column to see)',
        hr: 'Horizontal rule' + "\n" + '*****',
        p: 'Paragraph are divided by an empty line.' + "\n\n" + 'Paragraphs can include _inline_ elements',
        blockquote: 'An extended quote can get its own block element.' + "\n\n" + '> If you\'re not careful, the newspapers will have you hating the people who are being oppressed, and loving the people who are doing the oppressing.' + "\n\n" + '> _– Malcolm X_',
        ol: '+ list item' + "\n" + '- list item' + "\n" + '* list item',
        ul: '1. list item' + "\n" + '2. list item' + "\n" + '3. list item'
      }
    },
    none: {
      title: 'No formatting',
      description: 'No formatting',
      examples: {
        hx: '<h1>Heading</h1>' + "\n" + '<h2>Heading 2</h2>',
        i: '<i>italics</i>',
        b: '<b>bold</b>',
        a: 'link to <a href="http://arlocal.info" target="_blank">about A&R.local</a>',
        p_br: '<p>Paragraph</p>' + "\n\n" + '<p>Paragraphs won\'t have' + "\n" + 'linebreaks' + "\n" + '<br>' + "\n" + 'unless specifically coded.</p>',
      }
    },
    simple_format: {
      title: 'simple_format (rails)',
      description: ['simple_format is a utility in the underlying Rails framework that interprets paragraphs without additional markup (inline HTML optional)'],
      examples: {
        p_br: 'Paragraphs are divided by a blank line.' + "\n\n" + 'Linebreaks are indicated' + "\n" + 'simply by starting a new line.',
        inline: '<i>Valid</i> inline <tt>HTML</tt> syntax is interpreted.'
      }
    }
  }
end
