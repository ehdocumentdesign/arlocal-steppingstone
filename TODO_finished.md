# A&R.Local To-Do List


## Possibly finished

- _Grid layout fixes many of the other admin:welcome content pages._

Album.duration(round_to_seconds) should have new option variable instead of boolean. And should be properly written.
**Not sure what the problem was here, or if anything short of a `Duration` object would be a *proper* fix.**
album.duration(rounded_to: :seconds) is better syntax/semantics

route/controller/etc for various _join_by_keyword **seems okay**

Possibly some bugs remaining here.

- review video picture import-- does it still fail? Check upload too.
- Fixed, BUT:
  - Video :has_one picture as a thumbnail
  -   by comparison,
  - Event :has_many pictures as a collection
  -   therefore
  - The supplementary methods for importing will look different.
  - Should this remain, or should Video-Picture be a :has_many relationship?
  - **Probably should be a :has_many relationship for consistency.**
  - ***Is that certain? Video only needs a thumbnail.***
  - but it might be useful to have a collection of stills, just as an event can have several pictures.
  - db table already video_pictures, just add video_order.


## Probably finished

finish admin renovation:
  - TEST EVERY ACTION. LOTS OF CODE GOT RENAMED.
    - live trials suggest this is complete.
  - `admin/#{resource}/edit` category panes have crazy border
  - admin pages: html subtitle could benefit from including resource class ("editing album @album.title")


- admin display review
  - refactor index_joined_resource view templates
    fallout: keyword_statement_items_count methods might be unused now
    (replaced by resource_statement_items_count)
    - looks like it from Album and Picture helpers
    - in `_form_[resource]`

_Looks related to migrations; keep as a reminder_
Renaming source_imported etc resulted in a naming collision
  - resource_model: audio.source_imported_file_path for relative to public/portfolio
  - source_imported_helper: source_imported_file_path(audio) for absolute path to look for file
because Audio.file_exists? is dependent on both the source type and the config.x.arlocal configuration setting for public/portfolio

jplayer_playlist
  - uploaded attachment gives null filename

- Keyword Admin:
  - #edit margins too big? _(narrow viewport)_ `.arm_forms` needed a width declaration
  - #show missing _narrow viewport_ directive

- pictures without titles show empty quotes in html title tag

look into other ways to generate/metaprogram the javascript for jplayer
_No, wait to see if a switch to videojs ensures future operability before working on jplayer scripts_

- drop column article#text_markup, #markup_parser
 (was replaced by #content_*)

Why don't video coverpictures show in the index?

migration:   - video rename_column source_catalog_file_path source_imported_file_path

- *Links#index* doesn't see joined infopages
- *Links#show* needs standardization.

- More useful 'index' action for resources **almost done**
  - **Remove `_index` and `_show` partials when done.**

- drop table info_page_links

- about_arlocal
  - formatting for markup types, esp. for narrow width

***Admin Pictures Index - make default button => pin icon***

views/shared is now views/public/shared

- admin_header_nav

- video -> keywords CSS in join table headings and data

- keyword.title_with_[rsource]_count
  - are these still being used? **Yes. in `_form_[]_join_by_keyword`**
  - anything remaining reason to keep this? no?

- Consider ActionText (sp?) for text_markup fields. No, requires webpacker &c.

clean up colors
  errors.scss
  events_index .arl_events_index_by_year
no more @includes for layout

clean up fonts (public)
clean up fonts (admin)
neighbor nav button css
isrc#review switch between index (for easy copy/paste) and edit
picture selection
views/shared vs view/form_elements
html_head_helper
  put favicon and javascript logic into respective layout templates
  is google analytics still a thing?
css image/border mixins

see:
resource.visibility
  ['indexed','unlisted','private'] (2,1,0)
  see album
  also Enum?
    https://guides.rubyonrails.org/active_record_querying.html#scopes
    https://guides.rubyonrails.org/active_record_querying.html#enums
    (although probably not.)
  source_attachment_attachment -> source_upload_attachment
  infopage.published database attribute

Is query_info_page.rb still in use? **No.**

- views/admin/shared/_index_joined
  - is this used beyond Picture? **No.**
  - app/views/admin/pictures/_show_joined_resources.haml
  - previous plan was for shared partials showing joined resources
  - is this still the plan, or should this be refactored into individual resource view partials?
    - contrast with `_admin_[resource]_stats.haml`
  - **Decision** _these partials have view logic that should be kept DRY. Consider including with other `admin#resource#show`, especially Keyword._
  - **In fact,** already being addressed in admin view overhaul.

- review routes for semantic/logical cohesion
  - obsolete routes are commented. I think all of them.
  - some are not currently in use.

***more useful 'show' action for resources***
  **"Album" is the model.**

- the 'source_attachment_attachment' syntax looks horrible. Is this really the best way to distinguish source_attachment from source_catalog?

Content storage descriptions

picture_helper has a few sus methods
**They're all called somewhere in app/*, but recent refactoring might have made some inactive calls.**

- Rails 7 upgrade
  - does importmap-rails apply? **Probably not.**
  - does jsbundling-rails apply? **Probably not.**

pictures -> video **DONE**
  and
    import to video
    upload to video

- what is this: in `app/assets/stylesheets/evo/2_public/jplayer/1_jp_audio.scss :: 2`
  *Doesn't matter now that evo is gone*
  > // TODO: figure out why this doesn't render border-bottom or border-top
  > // see .jp-type-playlist for border-bottom.
  > // see .arl_albums_show_player for border-top.

  audio: why are durations `super.to_i`? *historical reasons. refactor to where integers are necessary, leave attribute method alone.*
  wording mismatch between album.duration and audio.duration
  `rounded_to` implies data manipulation **More accurate wording**
  `precision` implies observation
    - album has `duration(rounded_to: :units)`
    - audio has `duration_as_text(precision: :units)`
    also look at album_audio, event_audio, etc.
    does events need event.playlist_duration or something similar? *yagni…y*

  album_audio.rb &c
  there are singleton methods that might not reflect the current reality.
  e.g. line 10-28  `# TODO: Is this still a potentially useful method or code pattern?` **no.**

  several joined_resource models have wrapper methods to prevent failure if joined is nil
  is this pattern obsolete? **YES.**
  - Why does PictureKeyword have an `id_public` method? It's not even directly accessible.
    - related: are the redundant join methods such as `PictureKeyword#picture_title #picture_id #picture_slug` still needed?

  - autokeyword formatting
  - audio/picture not found -- clearer indicator *maybe a preceeding question mark*

  resource.visibility:
    "private" isn't really private, there is still a direct URL if a file is in storage
    - see visibility_helper
    - choose new name?
      - indexed
      - attachable
      - unlisted
      - private
    - **NO. IT GETS TOO COMPLICATED.**
      - keep ['public','unlisted','private']
      - add a disclaimer

javascript_helper could be split into jplayer_helper. *No. Just remove obsolete google analytics methods.*
would be nice to look into other ways to generate/metaprogram the javascript for jplayer *Yes, but low priority.* **It's easy. `require 'json'` do it**

keyword scopes
Picture queries rely on instance methods rather than databse attributes
    effective datetime value, for example, selects from a hierarchy of three values (manual entry, exif, file)
  harder to refactor into model scopes w/o corresponding database attribute
    **Maybe bypass model scopes and just use a sorted array?**
  should this change?
Video scope
  sort_by_keyword -> can this be refactored into model scope?
**Some complex queries return a hash rather than an ActiveRecord::Association array.**
**Maybe they should be kept separate from the ActiveRecord#scope methods?**
***Conclusion***
  - keep scopes for visibility: indexable, linkable, published, etc.
  - use collection variable in `fields_for` blocks, &c.
  - assume that the query will deliver an enumerable

Ongoing debate:
**When to use model scope vs. When to use Query method?**
  - some query results depend on values from instance methods rather than activerecord:query interface
  - some queries return a hash with result from database attribute or instance method as its keys
    - for example, calendar of events by year
  - compare picture (Query) w audio (scope)
  - Since we're using additional Query classes, move display-order methods to the Query class for consistency
    and reserve scopes for categorical distinctions (e.g. visibility)
**Still needs:**
  - Album v-
  - Event v-
  - Keyword v-
  - Video v-
**Possible fallout from removing scopes. Especially `Class.options_for_select_admin`**
  which itself could be optimized with a `.select` or `.pluck` to get only the needed fields for a form select element
*Comment out scopes but don't remove yet.*

Why does VideoBuilder include CatalogHelper? It seems unneeded and it breaks loading.

page html_head titles are inconsistent. Maybe just a single method ONE TIME, not a cumulative array.
`HtmlHelper.html_head_title_extend!` line 37
  - where does yield(:html_head_meta_description) get value?
    - look for `content_for :html_head_meta_description`

- why does infopages have an index_dup? is that project complete?
