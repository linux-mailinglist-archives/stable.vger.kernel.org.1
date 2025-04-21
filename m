Return-Path: <stable+bounces-134769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC71A95021
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9277A6E68
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C1263F22;
	Mon, 21 Apr 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YYNIDD2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93A19ADA4
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234683; cv=none; b=FOWMIibAtlUS3egP4qHqhsuRnh+bNz2+3nJLiSm6qdnBRwJ4fxz34Mj8DIprLbThPCK21rG5/asqROURg90jXL/uQ+1F2RzXYzSF+sAFjomWiIDW2K2ylXzAvy7ssUllxsgwYe3k+vAeq+vlVrcacEFNXdGSKRG4HihS//O4PmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234683; c=relaxed/simple;
	bh=G0it26TtpzY8WxVE03osThepTeUhPAM42N1l7GhfaQo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gcJRj3a68QgiYijiPqoC4wsvleE83Xeem4F3aupmh79k/yjdH8O11RwH441pEeeNHTrI4eM+3+OOfoyErI+sAUq8dwe1VkSopKFgHcZOOjKdzY5VesghwJaRp2b7/tysdVRg+GjfItIEh5WZ/8vzKITtE1x97p5lRJroCF270Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YYNIDD2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0374C4CEED;
	Mon, 21 Apr 2025 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745234683;
	bh=G0it26TtpzY8WxVE03osThepTeUhPAM42N1l7GhfaQo=;
	h=Subject:To:Cc:From:Date:From;
	b=YYNIDD2AWDHX1XwxpRt4At+RlD3DRHzdAFjlSjwvz0kMurlRQD6NgqZqW/RBTn1BY
	 gjtNAeSEHyleI56zDCL0N+N9UHzEOX+9L/+ceeNF2vuSLd4b+J1IHszK1YVPKnHCNU
	 TGABww6D03K7LJrO4rzlFkqW2Y0PKjtjg5NJzEKA=
Subject: FAILED: patch "[PATCH] scripts: generate_rust_analyzer: Add ffi crate" failed to apply to 6.12-stable tree
To: kernel@o1oo11oo.de,ojeda@kernel.org,tamird@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 13:24:32 +0200
Message-ID: <2025042132-trial-subtext-ae03@gregkh>
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
git cherry-pick -x 05a2b0011c4b6cbbc9b577f6abebe4e9333b0cf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042132-trial-subtext-ae03@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05a2b0011c4b6cbbc9b577f6abebe4e9333b0cf6 Mon Sep 17 00:00:00 2001
From: Lukas Fischer <kernel@o1oo11oo.de>
Date: Fri, 4 Apr 2025 14:51:51 +0200
Subject: [PATCH] scripts: generate_rust_analyzer: Add ffi crate

Commit d072acda4862 ("rust: use custom FFI integer types") did not
update rust-analyzer to include the new crate.

To enable rust-analyzer support for these custom ffi types, add the
`ffi` crate as a dependency to the `bindings`, `uapi` and `kernel`
crates, which all directly depend on it.

Fixes: d072acda4862 ("rust: use custom FFI integer types")
Signed-off-by: Lukas Fischer <kernel@o1oo11oo.de>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250404125150.85783-2-kernel@o1oo11oo.de
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index cd41bc906fbd..fe663dd0c43b 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -112,6 +112,12 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         cfg=["kernel"],
     )
 
+    append_crate(
+        "ffi",
+        srctree / "rust" / "ffi.rs",
+        ["core", "compiler_builtins"],
+    )
+
     def append_crate_with_generated(
         display_name,
         deps,
@@ -131,9 +137,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             "exclude_dirs": [],
         }
 
-    append_crate_with_generated("bindings", ["core"])
-    append_crate_with_generated("uapi", ["core"])
-    append_crate_with_generated("kernel", ["core", "macros", "build_error", "pin_init", "bindings", "uapi"])
+    append_crate_with_generated("bindings", ["core", "ffi"])
+    append_crate_with_generated("uapi", ["core", "ffi"])
+    append_crate_with_generated("kernel", ["core", "macros", "build_error", "pin_init", "ffi", "bindings", "uapi"])
 
     def is_root_crate(build_file, target):
         try:


