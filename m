Return-Path: <stable+bounces-152769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50942ADC943
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2E3ACB5F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF35C96;
	Tue, 17 Jun 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBWTKQuM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675028A70A
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750159423; cv=none; b=uxirw2mwXQ3mi/WTGWme+DdlS7CFqLtwM1L+iXGlWUd6F9dq0rQdgWc5hDGHUjquiHwmdDSgyA7TJM6z1jrSRiwReyZ+4I4+2kx6WDz1fEhTnj0Z4zrxSsyxDos1njryRAbiaT5jJk/dVSnGSEcr/4q2xTPHoSvam67EYvL/fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750159423; c=relaxed/simple;
	bh=R7tWGmDnY+rSPycFekBGw3TsRy/H5esWN0hP4INwJlU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TnfxxgJ0vWf/Ju3ll7bzw5UnimDAJzLtFoEnlxuC8No6+T2OlY4Rc6/aWSJJpIfREEtyyRFF23ocB2CaXh1YXw3wg8gryj5ksDvqtcfk5tyrHl0Z2HRfpX7ND2IUCFz2zvfwwAXqrhDaD9kngFl8g8zhkISK/KkTXZ0Shvd9MvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBWTKQuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F58C4CEE3;
	Tue, 17 Jun 2025 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750159423;
	bh=R7tWGmDnY+rSPycFekBGw3TsRy/H5esWN0hP4INwJlU=;
	h=Subject:To:Cc:From:Date:From;
	b=XBWTKQuMKNV0pH/o7anY+/Xu78MwumvMCYMUhvMGj/ukyMJDDrc6nPoLnb7KzLI8c
	 jwrx+4EkIJJZSJdJQ8JDjMGA9CZzcBU0fVzO1dyV4H+poK31FV+yM3xnn2rp/2zvCo
	 7LbzPrI1/0qtarvr++qTibcjyR0D/4GMf1Ar6D4U=
Subject: FAILED: patch "[PATCH] rust: compile libcore with edition 2024 for 1.87+" failed to apply to 6.12-stable tree
To: gary@garyguo.net,est31@protonmail.com,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 13:23:34 +0200
Message-ID: <2025061734-shale-reliably-8969@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f4daa80d6be7d3c55ca72a8e560afc4e21f886aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061734-shale-reliably-8969@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4daa80d6be7d3c55ca72a8e560afc4e21f886aa Mon Sep 17 00:00:00 2001
From: Gary Guo <gary@garyguo.net>
Date: Sat, 17 May 2025 09:55:59 +0100
Subject: [PATCH] rust: compile libcore with edition 2024 for 1.87+

Rust 1.87 (released on 2025-05-15) compiles core library with edition
2024 instead of 2021 [1]. Ensure that the edition matches libcore's
expectation to avoid potential breakage.

[ J3m3 reported in Zulip [2] that the `rust-analyzer` target was
  broken after this patch -- indeed, we need to avoid `core-cfgs`
  since those are passed to the `rust-analyzer` target.

  So, instead, I tweaked the patch to create a new `core-edition`
  variable and explicitly mention the `--edition` flag instead of
  reusing `core-cfg`s.

  In addition, pass a new argument using this new variable to
  `generate_rust_analyzer.py` so that we set the right edition there.

  By the way, for future reference: the `filter-out` change is needed
  for Rust < 1.87, since otherwise we would skip the `--edition=2021`
  we just added, ending up with no edition flag, and thus the compiler
  would default to the 2015 one.

  [2] https://rust-for-linux.zulipchat.com/#narrow/channel/291565/topic/x/near/520206547

    - Miguel ]

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/pull/138162 [1]
Reported-by: est31 <est31@protonmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1163
Signed-off-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/r/20250517085600.2857460-1-gary@garyguo.net
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/Makefile b/rust/Makefile
index f207ba0ed466..d62b58d0a55c 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -60,6 +60,8 @@ endif
 core-cfgs = \
     --cfg no_fp_fmt_parse
 
+core-edition := $(if $(call rustc-min-version,108700),2024,2021)
+
 # `rustc` recognizes `--remap-path-prefix` since 1.26.0, but `rustdoc` only
 # since Rust 1.81.0. Moreover, `rustdoc` ICEs on out-of-tree builds since Rust
 # 1.82.0 (https://github.com/rust-lang/rust/issues/138520). Thus workaround both
@@ -106,8 +108,8 @@ rustdoc-macros: $(src)/macros/lib.rs FORCE
 
 # Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
 # not be needed -- see https://github.com/rust-lang/rust/pull/128307.
-rustdoc-core: private skip_flags = -Wrustdoc::unescaped_backticks
-rustdoc-core: private rustc_target_flags = $(core-cfgs)
+rustdoc-core: private skip_flags = --edition=2021 -Wrustdoc::unescaped_backticks
+rustdoc-core: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs)
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 	+$(call if_changed,rustdoc)
 
@@ -416,7 +418,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
       cmd_rustc_library = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
-		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags)) \
+		$(filter-out $(skip_flags),$(rust_flags)) $(rustc_target_flags) \
 		--emit=dep-info=$(depfile) --emit=obj=$@ \
 		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
 		--crate-type rlib -L$(objtree)/$(obj) \
@@ -427,7 +429,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 
 rust-analyzer:
 	$(Q)MAKEFLAGS= $(srctree)/scripts/generate_rust_analyzer.py \
-		--cfgs='core=$(core-cfgs)' \
+		--cfgs='core=$(core-cfgs)' $(core-edition) \
 		$(realpath $(srctree)) $(realpath $(objtree)) \
 		$(rustc_sysroot) $(RUST_LIB_SRC) $(if $(KBUILD_EXTMOD),$(srcroot)) \
 		> rust-project.json
@@ -483,9 +485,9 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $(recordmcount_source) FORCE
 $(obj)/exports.o: private skip_gendwarfksyms = 1
 
 $(obj)/core.o: private skip_clippy = 1
-$(obj)/core.o: private skip_flags = -Wunreachable_pub
+$(obj)/core.o: private skip_flags = --edition=2021 -Wunreachable_pub
 $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
-$(obj)/core.o: private rustc_target_flags = $(core-cfgs)
+$(obj)/core.o: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \
     $(wildcard $(objtree)/include/config/RUSTC_VERSION_TEXT) FORCE
 	+$(call if_changed_rule,rustc_library)
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index fe663dd0c43b..7c3ea2b55041 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -19,7 +19,7 @@ def args_crates_cfgs(cfgs):
 
     return crates_cfgs
 
-def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
+def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edition):
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -35,7 +35,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     crates_indexes = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
-    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
+    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False, edition="2021"):
         crate = {
             "display_name": display_name,
             "root_module": str(root_module),
@@ -43,7 +43,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             "is_proc_macro": is_proc_macro,
             "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
             "cfg": cfg,
-            "edition": "2021",
+            "edition": edition,
             "env": {
                 "RUST_MODFILE": "This is only for rust-analyzer"
             }
@@ -61,6 +61,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         display_name,
         deps,
         cfg=[],
+        edition="2021",
     ):
         append_crate(
             display_name,
@@ -68,12 +69,13 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             deps,
             cfg,
             is_workspace_member=False,
+            edition=edition,
         )
 
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
-    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
+    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []), edition=core_edition)
     append_sysroot_crate("alloc", ["core"])
     append_sysroot_crate("std", ["alloc", "core"])
     append_sysroot_crate("proc_macro", ["core", "std"])
@@ -177,6 +179,7 @@ def main():
     parser = argparse.ArgumentParser()
     parser.add_argument('--verbose', '-v', action='store_true')
     parser.add_argument('--cfgs', action='append', default=[])
+    parser.add_argument("core_edition")
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot", type=pathlib.Path)
@@ -193,7 +196,7 @@ def main():
     assert args.sysroot in args.sysroot_src.parents
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs, args.core_edition),
         "sysroot": str(args.sysroot),
     }
 


