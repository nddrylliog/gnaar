
/* libs */
use dye
import dye/[core, input, sprite, text, math, primitives]

use yaml
import yaml/[Document]

import math
import structs/[ArrayList, Stack, HashMap, List]

use deadlogger
import deadlogger/[Log, Logger]

/* internal */
import gnaar/[editor, ui, loader, saver, dialogs, objects, utils]

PropFactory: class extends ObjectFactory {

    init: func (.layer) {
        super(layer, "prop")
    }

    spawn: func (name: String, pos: Vec2) -> GnObject {
        layer add(PropObject new(name, pos))
    }

}

PropObject: class extends ImageObject {

    init: func (.name, initPos: Vec2) {
        super("prop", name, initPos, "assets/png/%s.png" format(name))
    }

    clone: func -> This {
        new(name, pos)
    }

}

PropLayer: class extends DragLayer {

    init: func (.editor, .name) {
        super(editor, name)

        addFactory(PropFactory new(this))
    }

    insert: func {
        editor frame push(InputDialog new(editor frame, "Enter prop name", |name|
            spawn("prop", name, editor handPos())
        ))
    }

}

