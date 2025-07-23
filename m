Return-Path: <stable+bounces-164369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C565B0E99A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C116C5B6B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48E3149C7B;
	Wed, 23 Jul 2025 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKI/wRaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663F2AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245226; cv=none; b=f2TOv4iWZ/IhcHxFla0HrJO4ktVZeyTlOyJQ1IdaHe0D5VkZ6B7Hp9yOc86Jq8Plh8C6E/i/B03eBnlclsFrgKeYTF8IVmPBpnuOTUjPOwWfGQG3F+Z8pdph2yANQEjYQKSI9+6pQxQnFsfHz6sx1g3n5Fhb7AUiS2U741DcUn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245226; c=relaxed/simple;
	bh=3yaTfZVaBkAJD/FsBVY163t1F7F/n1kQux4ktbAyQ7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Luv4J1Cx1UvPvz+W/Ygy9yvnNz/oUnaC8mnmnEzKhT/FxkKeZgyXZP39u8G04Tts20LLzA9+V2hdKSaDzZJV1p3U00DIhUrH1CC4Hv8lhBGPQcGv1dXaxDc+VhMTluArY5dcgq5JL53j3NsV2M8EyoKYdTduVlV9Flu3WE9N1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKI/wRaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1A9C4CEF7;
	Wed, 23 Jul 2025 04:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245226;
	bh=3yaTfZVaBkAJD/FsBVY163t1F7F/n1kQux4ktbAyQ7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKI/wRaqhYhWyCpG7fhccaRG+RRz/W6ZktCdenUxEMf1T8ET2AWlIDz6GNTUqKHQS
	 8lmQ8GvsQrfPLfIWhMLLIgTzIFFDeXaEUBcjoruenv+4g7b4GX6+obQseQtRF4DcRJ
	 EZEGg4kgVnk/bMfNM/1uN09F6xHZNlptNQP9h3It4NmUML5lUdhlf8++rsk157BMxv
	 7D0ZRv9ZqNDc61dM9ZM4tr/U+FD1F9TJeW/Z/fCw/gQKOtpeP6LqPwh/VfEWuqM8mJ
	 L2GX+uVvEL0Pa6Wt0DS1z6c3HCkykPRz3QpqSi3vd0GkUOzYAaKVr59lp978AiMsAP
	 nL6sjdHXuE+/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0
Date: Wed, 23 Jul 2025 00:33:43 -0400
Message-Id: <1753235098-80a9355f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721194736.1150349-1-ojeda@kernel.org>
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

Status in newer kernel trees:
6.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  749815922677 ! 1:  9212c12e784b rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0
    @@ Commit message
         Acked-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
         Link: https://lore.kernel.org/r/20250712160103.1244945-3-ojeda@kernel.org
         Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
    +    (cherry picked from commit 7498159226772d66f150dd406be462d75964a366)
    +    Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
     
      ## rust/Makefile ##
     @@ rust/Makefile: quiet_cmd_rustdoc_test = RUSTDOC T $<
    - 	RUST_MODFILE=test.rs \
    +       cmd_rustdoc_test = \
      	OBJTREE=$(abspath $(objtree)) \
      	$(RUSTDOC) --test $(rust_common_flags) \
     +		-Zcrate-attr='feature(used_with_arg)' \
    @@ rust/Makefile: quiet_cmd_rustdoc_test = RUSTDOC T $<
      		$(rustc_target_flags) $(rustdoc_test_target_flags) \
      		$(rustdoc_test_quiet) \
     
    - ## rust/kernel/firmware.rs ##
    -@@ rust/kernel/firmware.rs: macro_rules! module_firmware {
    -             };
    - 
    -             #[link_section = ".modinfo"]
    --            #[used]
    -+            #[used(compiler)]
    -             static __MODULE_FIRMWARE: [u8; $($builder)*::create(__MODULE_FIRMWARE_PREFIX)
    -                 .build_length()] = $($builder)*::create(__MODULE_FIRMWARE_PREFIX).build();
    -         };
    -
    - ## rust/kernel/kunit.rs ##
    -@@ rust/kernel/kunit.rs: macro_rules! kunit_unsafe_test_suite {
    -                     is_init: false,
    -                 };
    - 
    --            #[used]
    -+            #[used(compiler)]
    -             #[allow(unused_unsafe)]
    -             #[cfg_attr(not(target_os = "macos"), link_section = ".kunit_test_suites")]
    -             static mut KUNIT_TEST_SUITE_ENTRY: *const ::kernel::bindings::kunit_suite =
    -
      ## rust/kernel/lib.rs ##
     @@
    - // Expected to become stable.
    - #![feature(arbitrary_self_types)]
    - //
    -+// To be determined.
    + #![feature(inline_const)]
    + #![feature(lint_reasons)]
    + #![feature(unsize)]
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
                      {cfg}
                      #[doc(hidden)]
    -                 #[cfg_attr(not(target_os = \"macos\"), link_section = \".modinfo\")]
    +                 #[link_section = \".modinfo\"]
     -                #[used]
     +                #[used(compiler)]
                      pub static __{module}_{counter}: [u8; {length}] = *{string};
    @@ rust/macros/module.rs: mod __module_init {{
     +                    #[used(compiler)]
                          static __IS_RUST_MODULE: () = ();
      
    -                     static mut __MOD: ::core::mem::MaybeUninit<{type_}> =
    +                     static mut __MOD: Option<{type_}> = None;
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
    --rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,raw_ref_op
    -+rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,raw_ref_op,used_with_arg
    + # Compile Rust sources (.rs)
    + # ---------------------------------------------------------------------------
    + 
    +-rust_allowed_features := arbitrary_self_types,lint_reasons
    ++rust_allowed_features := arbitrary_self_types,lint_reasons,used_with_arg
      
      # `--out-dir` is required to avoid temporaries being created by `rustc` in the
      # current working directory, which may be not accessible in the out-of-tree

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

