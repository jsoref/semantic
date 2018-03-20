import "hint" HLint.Default
import "hint" HLint.Dollar
import "hint" HLint.Generalise

ignore "Use mappend"
ignore "Redundant do"
-- TODO: investigate whether cost-center analysis is better with lambda-case than it was
ignore "Use lambda-case"
-- Hlint chokes and dies on certain where-clause annotations with type operators. TODO file a bug
ignore "Parse error"

error "generalize ++" = (++) ==> (<>)
-- AMP fallout
error "generalize mapM"  = mapM  ==> traverse
error "generalize mapM_" = mapM_ ==> traverse_
error "generalize forM"  = forM  ==> for
error "generalize forM_" = forM_ ==> for_
error "Avoid return" =
    return ==> pure
    where note = "return is obsolete as of GHC 7.10"

error "use extract" = termAnnotation . unTerm ==> extract
error "use unwrap" = termOut . unTerm ==> unwrap

error "avoid head" = head
  where note = "head is partial; consider using Data.Maybe.listToMaybe"

error "avoid tail" = tail
  where note = "tail is partial; consider pattern-matching"

error "avoid init" = init
  where note = "init is partial; consider pattern-matching"

error "avoid last" = last
  where note = "last is partial; consider pattern-matching"
