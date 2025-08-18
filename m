Return-Path: <stable+bounces-169948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16CB29E49
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCBA7B227F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B9D20766E;
	Mon, 18 Aug 2025 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wl7wXR7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7EC1A83F7
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510365; cv=none; b=pkrkA6aOLz5fc0d7kFE2rQ/Gh3jVBEL1oJq9gpM1Yi3Eggny7O44b6F41z7Ou5p6T8I+5LqqEjYRkLl8aEcdwnhGitV+xbR0y8Q+PriCgQvaP4R6mv8P1Z2bP4ns/vSTE2053B2sbqH34dHOjTqPNLQz4BVurQImfWwjzrYegPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510365; c=relaxed/simple;
	bh=aG1h7Spvk2Luhe0HhLg4L7ktMXWWEIMqHwaVxYBDgrg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OBIIEQR7SsTrz4TlbWrjZgAkcVOZ/MVqSBTPRc1gtvt37CvoRZ7sr1KSA7JuTskpaKp2vBDmE2ivwo4FSlO31yLPMPj7M99MJ7NNBgiYVc4Q96t9BiajUPYG2D7zzOhT5/fztyT3+Hyi+a1TameisCLqkcx5+azm3R7t0J9LtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wl7wXR7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA171C4CEEB;
	Mon, 18 Aug 2025 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755510364;
	bh=aG1h7Spvk2Luhe0HhLg4L7ktMXWWEIMqHwaVxYBDgrg=;
	h=Subject:To:Cc:From:Date:From;
	b=Wl7wXR7JJE2GSpDTbSER3ccJAvWy/hrxq0M4/9VM8rO1wFqqAkMHNS69B51JfNt05
	 VhQt+OC3sB0dtIXSiiIBHyi9oYRRhZOgrih/Go/fok104TsW8/y6Rg/zJe7HXWtxbZ
	 fakFDAAiDECUwVHOJ0wY6BrUzy82LKrxGIqXU/Rw=
Subject: FAILED: patch "[PATCH] rust: kbuild: clean output before running `rustdoc`" failed to apply to 6.12-stable tree
To: ojeda@kernel.org,daniel.almeida@collabora.com,tamird@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 11:45:58 +0200
Message-ID: <2025081858-zips-enchanted-3d3e@gregkh>
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
git cherry-pick -x 252fea131e15aba2cd487119d1a8f546471199e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081858-zips-enchanted-3d3e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 252fea131e15aba2cd487119d1a8f546471199e2 Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Sat, 26 Jul 2025 15:34:35 +0200
Subject: [PATCH] rust: kbuild: clean output before running `rustdoc`

`rustdoc` can get confused when generating documentation into a folder
that contains generated files from other `rustdoc` versions.

For instance, running something like:

    rustup default 1.78.0
    make LLVM=1 rustdoc
    rustup default 1.88.0
    make LLVM=1 rustdoc

may generate errors like:

    error: couldn't generate documentation: invalid template: last line expected to start with a comment
      |
      = note: failed to create or modify "./Documentation/output/rust/rustdoc/src-files.js"

Thus just always clean the output folder before generating the
documentation -- we are anyway regenerating it every time the `rustdoc`
target gets called, at least for the time being.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Reported-by: Daniel Almeida <daniel.almeida@collabora.com>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/near/527201113
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Link: https://lore.kernel.org/r/20250726133435.2460085-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/Makefile b/rust/Makefile
index d47f82588d78..bfa915b0e588 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -111,14 +111,14 @@ rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
 rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
     --extern proc_macro
-rustdoc-macros: $(src)/macros/lib.rs FORCE
+rustdoc-macros: $(src)/macros/lib.rs rustdoc-clean FORCE
 	+$(call if_changed,rustdoc)
 
 # Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
 # not be needed -- see https://github.com/rust-lang/rust/pull/128307.
 rustdoc-core: private skip_flags = --edition=2021 -Wrustdoc::unescaped_backticks
 rustdoc-core: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs)
-rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
+rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs rustdoc-clean FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
@@ -130,7 +130,8 @@ rustdoc-ffi: $(src)/ffi.rs rustdoc-core FORCE
 rustdoc-pin_init_internal: private rustdoc_host = yes
 rustdoc-pin_init_internal: private rustc_target_flags = --cfg kernel \
     --extern proc_macro --crate-type proc-macro
-rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs FORCE
+rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs \
+    rustdoc-clean FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-pin_init: private rustdoc_host = yes
@@ -148,6 +149,9 @@ rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-ffi rustdoc-macros \
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustdoc)
 
+rustdoc-clean: FORCE
+	$(Q)rm -rf $(rustdoc_output)
+
 quiet_cmd_rustc_test_library = $(RUSTC_OR_CLIPPY_QUIET) TL $<
       cmd_rustc_test_library = \
 	OBJTREE=$(abspath $(objtree)) \


