import { Controller } from "@hotwired/stimulus";
import Cocooned from '@notus.sh/cocooned'

export default class extends Controller {
  connect() {
    // The element needs to be marked with "data-cocooned-options=..." or
    // whatever the new `cocooned_container` helper tags it with.
    Cocooned.create(this.element);
  }
}
