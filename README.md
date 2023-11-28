# README

*Note:* The current branch you are looking at (i.e. `cocooned-2.0.4`)
has already fixed the original issue https://github.com/notus-sh/cocooned/issues/47. See the `main` branch for the original code before the fix where the issue presented itself.

This app was built as a minimal reproducible example of deeply nested cocoons
for usage with the cocooned gem and companion npm package from: https://github.com/notus-sh/cocooned/ when using with hotwired/stimulus and `esbuild`.

For information on Stimulus see:

- https://stimulus.hotwired.dev/
- https://github.com/hotwired/stimulus

For more information on the original discussion see: https://github.com/notus-sh/cocooned/issues/47.

### How this app was built
This app was built with:

- Ruby 3.2.2 (`rbenv install 3.2.2`)
- Rails 7.1.1 (`gem install rails`) with command: `rails new cocooned_deeply_nested --css tailwind --js esbuild`

An overview of the steps performed to write this app (just as a reference):

```bash
bundle add cocooned
yarn add @notus.sh/cocooned

rails g scaffold List name
rails g scaffold Item name list:references
rails g scaffold Subitem name item:references
rails g scaffold Microitem name subitem:references
```

Then, added `app/javascript/controllers/cocooned_controller.js`
and updated the stimulus controller index through
```bash
./bin/rails stimulus:manifest:update
```
Which automatically updates `app/javascript/controllers/index.js`.

And basically just used cocooned on list/new such
that we create a nested structure like "List > Items > Subitems > Microitems".

## Manual testing

To manully test this app:

```bash
git clone git@github.com:gato-omega/cocooned_deeply_nested.git
cd cocooned_deeply_nested
bundle install
rails db:setup
rails db:seed
./bin/dev
```

Then go to [http://localhost:3000/lists](http://localhost:3000/lists)

You'll see that we already created a list when the database was seeded, just for convenience. Click on 'Edit' for 'Test list A' or navigate directly to [http://localhost:3000/lists/1/edit](http://localhost:3000/lists/1/edit)

### Observations:

- When creating a new list with items and subitems, everything works just fine as you would expect.
- The issue of multiple added forms is `SUPPOSED TO BE` noticed whenever you are editing an
existing list which already has deeply nested items, since the wrapping forms
have added the event listeners multiple times when originally rendering them.

_IMPORTANT UPDATE: This app does not behave like the original app the issue was found on. Everything actually works fine here, which leaves me a bit puzzled on why it does not work over there. (!)._


### Relevant code from this app to check for is at:

- app/javascript/controllers/cocooned_controller.js
- app/views/lists/*

### Notes

- Please note that there is no `Cocooned.start()` call anywhere because we want stimulus to take care of any DOM elements that we "tag" with the controller such that those
are dynamically cocooned on an individual basis (regardless of whether they were already rendered on the page or are created dynamically afterwards by any other means.)
- The fact that we are using `esbuild` is just to have it be identical to where the original issue was observed, but I would suspect it works the same if you use importmaps too.

#### Some relevant parts of the npm package code (as of commit c830acf2324d4bfe313f30cf32b4bf68fdc71fc3)

_IMPORTANT UPDATE: This app does not behave like the original app the issue was found on (!). This means that some of the following comments are no longer well-based (!!!)_


From https://github.com/notus-sh/cocooned/blob/main/npm/src/cocooned/base.js#L99
```javascript
  get items () {
    return Array.from(this.container.querySelectorAll(this._selector('item')))
      .filter(item => this.toContainer(item) === this.container)
      .filter(item => !('display' in item.style && item.style.display === 'none'))
  }
```

I actually debugged this code and found that the filtering was not working when deeply nested containers were present (i.e. all items still recognized as belonging to any parent container), so I changed it to:

```javascript
  get items () {
    const immediateChildrenSelector = immediateChildrenSelectorFor(this._selector('item'));
    
    return Array.from(this.container.querySelectorAll(immediateChildrenSelector))
      .filter(item => this.toContainer(item) === this.container)
      .filter(item => !('display' in item.style && item.style.display === 'none'));
  }
```

_UPDATE: Even though the issue does not present itself in this app, I could actually confirm that the filtering was not happening (in the original setup, not this app)_


Where the function `immediateChildrenSelectorFor()` just appends a `:scope >` to every existing selector and it is implemented like this:

```javascript
function immediateChildrenSelectorFor (selector) {
  return selector.split(', ').map((item_selector) => `:scope > ${item_selector}`).join(', ');
}
```

Although note that this approach assumes the items are always direct children of the container (assuming that's the case for the majority of use cases, but I guess we cannot assume that for everybody?).

Which fixes the filtering (and actually, the tests pass), but still doesn't resolve the issue and I think it is because of another reason relating to the following code:

From https://github.com/notus-sh/cocooned/blob/main/npm/src/cocooned/plugins/core.js#L17
```javascript
    this.addTriggers = Array.from(this.container.ownerDocument.querySelectorAll(this._selector('triggers.add')))
      .map(element => Add.create(element, this))
      .filter(trigger => this.toContainer(trigger.insertionNode) === this.container)

    this.addTriggers.forEach(add => add.trigger.addEventListener(
      'click',
      clickHandler((e) => add.handle(e))
    ))
```

Here it seems like the issue could be because the querySelectorAll has to get all `cocooned_add_item_link/button`  from the document, and then filtering them as it was happening in the code above.

BTW, the `cocooned_remove_item_link/button` does work just fine since at https://github.com/notus-sh/cocooned/blob/main/npm/src/cocooned/plugins/core.js#L26
```javascript
    this.container.addEventListener(
      'click',
      delegatedClickHandler(this._selector('triggers.remove'), (e) => {
        const trigger = new Remove(e.target, this)
        trigger.handle(e)
      })
    )
```

I can see that it is already scoped to the container and furthermore, when removing an item it will search for the closest item which is generally the one you want to remove, so it coincides just fine, even if the event listener was added multiple items through some other cocooned initializer.

I guess since the links to add/remove might be placed anywhere because of styling/UX concerns we can't just assume they will be placed as direct children or anything similar, so I wouldn't be sure how to modify the code from here to make the scoping more directly tied to the specific container.