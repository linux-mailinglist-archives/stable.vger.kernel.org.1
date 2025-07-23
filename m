Return-Path: <stable+bounces-164382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA619B0E9A5
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF397563AA5
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B61DFE0B;
	Wed, 23 Jul 2025 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cts1o8Kh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6A2AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245264; cv=none; b=P5scCQgNbWwuLZ6TW4WlxaZvOQHBSUc+e+1eoS5a9nNY6M6ocYircGfX726CBTm83OkZAjZ2Qi69p1Lcz1Y95F/HLGYvOBP31003JVLcO4d8dl8mf5CiSEEl4Q83t+qRlz/CMir4XyZ1MPeEc81aflECWVQ3slIebFboO9JbKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245264; c=relaxed/simple;
	bh=YicwHJh3KBNxK8lLhro7oLRTTfqqzyRVxNbUQqAXWuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8jk0jFMBOjumvOGlHOMk0zjPbfjp1RDA6qXYYC3Br9B7sjCMiIkjEepvP+uMQgsRJs31KHoWUvdJtIsHGoaJwkzuOhqGgieYXLBPEF0PvP0+epPQ4hC+ch1xolww3dH6F7bzDkEDUl8zQ1ysvAFUvXxlU8fb/bUD+g8rxYafnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cts1o8Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E472DC4CEE7;
	Wed, 23 Jul 2025 04:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245264;
	bh=YicwHJh3KBNxK8lLhro7oLRTTfqqzyRVxNbUQqAXWuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cts1o8KhqDLlqCcjoEQd1tSFTTc7O6mUmqXm5A98PmB63BWmbW/HX+MjKgMUn2gka
	 VpPGcChZOAYnOuO8hhxgZ5zYzOEiDPd5VL269dBx12mlBY4U3zj+2Lvzg3mCIF3ibV
	 VleS4MkpmF5j6fK6arCoHUwTO5lAFhG9R5ylb2sCMMewWXscsTqKsrINcXgJXQccmC
	 yv5UWQZFRPIZZpgyA8h5zMe7C5Pycqd4VAYUCSVLfS+gQtOtWU7CDuKKkmtadP1qQd
	 pdXIGyhJpZL7SMSNfpA7OyRnFeFYVVrdcMchOJZ0PAFUJBKfLVOHC2qqCsw6kUWgCY
	 Fd6TIJH8GTzag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y] rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0
Date: Wed, 23 Jul 2025 00:34:22 -0400
Message-Id: <1753234834-a2642eb2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721194904.1150898-1-ojeda@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 7498159226772d66f150dd406be462d75964a366

Note: The patch differs from the upstream commit:
---
1:  749815922677 ! 1:  a3a4555a1d32 rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0
    @@ Commit message
         Acked-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
         Link: https://lore.kernel.org/r/20250712160103.1244945-3-ojeda@kernel.org
         Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
    +    (cherry picked from commit 7498159226772d66f150dd406be462d75964a366)
    +    Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
     
      ## rust/Makefile ##
     @@ rust/Makefile: quiet_cmd_rustdoc_test = RUSTDOC T $<
    @@ rust/kernel/kunit.rs: macro_rules! kunit_unsafe_test_suite {
     
      ## rust/kernel/lib.rs ##
     @@
    - // Expected to become stable.
    - #![feature(arbitrary_self_types)]
    - //
    + #![feature(const_mut_refs)]
    + #![feature(const_ptr_write)]
    + #![feature(const_refs_to_cell)]
     +// To be determined.
     +#![feature(used_with_arg)]
    -+//
    - // `feature(derive_coerce_pointee)` is expected to become stable. Before Rust
    - // 1.84.0, it did not exist, so enable the predecessor features.
    - #![cfg_attr(CONFIG_RUSTC_HAS_COERCE_POINTEE, feature(derive_coerce_pointee))]
    + 
    + // Ensure conditional compilation based on the kernel configuration works;
    + // otherwise we may silently break things like initcall handling.
     
      ## rust/macros/module.rs ##
     @@ rust/macros/module.rs: fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
    @@ rust/macros/module.rs: mod __module_init {{
     +                    #[used(compiler)]
                          static __IS_RUST_MODULE: () = ();
      
    -                     static mut __MOD: ::core::mem::MaybeUninit<{type_}> =
    +                     static mut __MOD: core::mem::MaybeUninit<{type_}> =
     @@ rust/macros/module.rs: mod __module_init {{
      
                          #[cfg(MODULE)]
    @@ rust/macros/module.rs: mod __module_init {{
                          #[link_section = \"{initcall_section}\"]
     -                    #[used]
     +                    #[used(compiler)]
    -                     pub static __{ident}_initcall: extern \"C\" fn() ->
    -                         ::kernel::ffi::c_int = __{ident}_init;
    +                     pub static __{name}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name}_init;
      
    +                     #[cfg(not(MODULE))]
     
      ## scripts/Makefile.build ##
     @@ scripts/Makefile.build: $(obj)/%.lst: $(obj)/%.c FORCE
    - #   - Stable since Rust 1.82.0: `feature(asm_const)`, `feature(raw_ref_op)`.
    - #   - Stable since Rust 1.87.0: `feature(asm_goto)`.
    - #   - Expected to become stable: `feature(arbitrary_self_types)`.
    -+#   - To be determined: `feature(used_with_arg)`.
    - #
    - # Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
    - # the unstable features in use.
    + # Compile Rust sources (.rs)
    + # ---------------------------------------------------------------------------
    + 
     -rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,raw_ref_op
     +rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,raw_ref_op,used_with_arg
      

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.15.y       | Success     | Success    |

