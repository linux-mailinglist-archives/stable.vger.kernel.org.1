Return-Path: <stable+bounces-154562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B4ADDAFD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2007AD80B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68F26F44F;
	Tue, 17 Jun 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5CZ180I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D8156C6F
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750183091; cv=none; b=q2Ge+Ig/ANNpIWtD0hovrvZgpQwo+pCqdy6YuA8IU1Ki42LtvQujBwbuza9s6jbwYEdUHw3h1eu9tDjdvehmVuEtJa3zMYciDqmOJWXzLd2vFvjzqPYJTABgs30/sTz+C7zlGe5Mvh7U9iSwhOfkjKG+L/3Xa48RaK/Q1oCs/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750183091; c=relaxed/simple;
	bh=MZBWcONIdd2h6xV2VFozgR3NZ26PtD33Dl/sGtld9ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5LUwk6zzz8AliuRJNvhRrsBQWuPCP8a/aSO3aAyDaVrGytBSuL8JkPYU2tHKlmM6mRslgZ2HcbswIyxWqxVeotmZDnV83uhW1oCDZ1VH8qPgBJvl2WouiNkbcSBqRtZ1zedUCwTLIvLQjXtSfhi/K5PsggNSSkeixIkCqPKAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5CZ180I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB500C4CEE7;
	Tue, 17 Jun 2025 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750183090;
	bh=MZBWcONIdd2h6xV2VFozgR3NZ26PtD33Dl/sGtld9ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5CZ180ISjMmQZCf0woXQSkoY1aN46hyhhTlhIK4NV85epga7PsfOw2cx/B6szBl/
	 cKpcFZK0AK8ZZRUrvE8veuYEH0EzZQXWsJP+p2bIHIcYObPwdQ0JFZnOJBGHlK5kBo
	 E0ovlrR2qwxc7i9RaXw09/dbHB/D+vX9/+ZarX4Fh1UXt2EJCYiJKRuNFsV8S0RxTT
	 FqoflGOQQ2iHFgWRcpHwLVbjRDU/FxdQIhgi0cIypVMaeUzODoUxj7IK0JzcxCS+QQ
	 40KCVJQN7m0jJg/gOw9CNcBL1rl0Ooy25WfIynjg6j+hESo0ktZRYkzafKq+KtILG1
	 HMO0jCW3ScfhA==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Gary Guo <gary@garyguo.net>,
	est31 <est31@protonmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12.y 2/2] rust: compile libcore with edition 2024 for 1.87+
Date: Tue, 17 Jun 2025 19:58:00 +0200
Message-ID: <20250617175800.1865653-2-ojeda@kernel.org>
In-Reply-To: <20250617175800.1865653-1-ojeda@kernel.org>
References: <2025061734-shale-reliably-8969@gregkh>
 <20250617175800.1865653-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

commit f4daa80d6be7d3c55ca72a8e560afc4e21f886aa upstream.

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
[ Solved conflicts for 6.12.y backport. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile                     | 14 ++++++++------
 scripts/generate_rust_analyzer.py | 13 ++++++++-----
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 1b00e16951ee..93650b2ee7d5 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -53,6 +53,8 @@ endif
 core-cfgs = \
     --cfg no_fp_fmt_parse
 
+core-edition := $(if $(call rustc-min-version,108700),2024,2021)
+
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -95,8 +97,8 @@ rustdoc-macros: $(src)/macros/lib.rs FORCE
 
 # Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
 # not be needed -- see https://github.com/rust-lang/rust/pull/128307.
-rustdoc-core: private skip_flags = -Wrustdoc::unescaped_backticks
-rustdoc-core: private rustc_target_flags = $(core-cfgs)
+rustdoc-core: private skip_flags = --edition=2021 -Wrustdoc::unescaped_backticks
+rustdoc-core: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs)
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 	+$(call if_changed,rustdoc)
 
@@ -372,7 +374,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
       cmd_rustc_library = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
-		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags)) \
+		$(filter-out $(skip_flags),$(rust_flags)) $(rustc_target_flags) \
 		--emit=dep-info=$(depfile) --emit=obj=$@ \
 		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
 		--crate-type rlib -L$(objtree)/$(obj) \
@@ -383,7 +385,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 
 rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
-		--cfgs='core=$(core-cfgs)' \
+		--cfgs='core=$(core-cfgs)' $(core-edition) \
 		$(realpath $(srctree)) $(realpath $(objtree)) \
 		$(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
@@ -407,9 +409,9 @@ define rule_rustc_library
 endef
 
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
index 690f9830f064..f9c9a2117632 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -18,7 +18,7 @@ def args_crates_cfgs(cfgs):
 
     return crates_cfgs
 
-def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
+def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edition):
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -34,7 +34,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     crates_indexes = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
-    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
+    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False, edition="2021"):
         crates_indexes[display_name] = len(crates)
         crates.append({
             "display_name": display_name,
@@ -43,7 +43,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             "is_proc_macro": is_proc_macro,
             "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
             "cfg": cfg,
-            "edition": "2021",
+            "edition": edition,
             "env": {
                 "RUST_MODFILE": "This is only for rust-analyzer"
             }
@@ -53,6 +53,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         display_name,
         deps,
         cfg=[],
+        edition="2021",
     ):
         append_crate(
             display_name,
@@ -60,12 +61,13 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -155,6 +157,7 @@ def main():
     parser = argparse.ArgumentParser()
     parser.add_argument('--verbose', '-v', action='store_true')
     parser.add_argument('--cfgs', action='append', default=[])
+    parser.add_argument("core_edition")
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot", type=pathlib.Path)
@@ -171,7 +174,7 @@ def main():
     assert args.sysroot in args.sysroot_src.parents
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs, args.core_edition),
         "sysroot": str(args.sysroot),
     }
 
-- 
2.50.0


