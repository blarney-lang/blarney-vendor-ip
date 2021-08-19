module Blarney.VendorIP.PipelinedDivider where

-- Blarney imports
import Blarney
import Blarney.Core.BV

-- | Intel pipelined divider megafunction
pipelinedDivider :: forall n. KnownNat n =>
     Int
     -- ^ Pipeline depth / latency
  -> Bit n
     -- ^ Numerator
  -> Bit n
     -- ^ Denominator
  -> (Bit n, Bit n)
     -- ^ Quotient, remainder
pipelinedDivider latency num denom = (FromBV quot, FromBV rem)
  where
    width = valueOf @n

    custom =
      Custom {
        customName      = "PipelinedDivider"
      , customInputs    = [("numer", width), ("denom", width)]
      , customOutputs   = [("quotient", width), ("remain", width)]
      , customParams    = [ "LATENCY" :-> show latency
                          , "DATA_WIDTH" :-> show width
                          ]
      , customIsClocked = True
      , customResetable = False
      , customNetlist   = Nothing
      }

    [quot, rem] =
      makePrim custom [toBV num, toBV denom]
                      [Just "quotient", Just "remain"]
