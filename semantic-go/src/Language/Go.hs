-- | Semantic functionality for Go programs.
module Language.Go
( Term(..)
, TreeSitter.Go.tree_sitter_go
) where


import qualified Language.Go.Tags as GoTags
import qualified Tags.Tagging.Precise as Tags
import qualified TreeSitter.Go (tree_sitter_go)
import qualified TreeSitter.Go.AST as Go
import qualified TreeSitter.Unmarshal as TS

newtype Term a = Term { getTerm :: Go.SourceFile a }

instance TS.SymbolMatching Term where
  showFailure _ _ = "failed for Term"

instance TS.Unmarshal Term where
  matchers = fmap (TS.hoist Term) TS.matchers

instance Tags.ToTags Term where
  tags src = Tags.runTagging src . GoTags.tags . getTerm
