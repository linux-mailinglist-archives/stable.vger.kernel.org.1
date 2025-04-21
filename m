Return-Path: <stable+bounces-134768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B7A95020
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EB63B142C
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD1263F22;
	Mon, 21 Apr 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="omRgloKx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814419ADA4
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234675; cv=none; b=BJdiBe6bjVq4Tsvai1shLn9yGJD9gW6Uj0JM3AR2NtMd8uhNWUtM8Ft++ZlFJA1M+/gARruM9ATb3A7uk5EI9J9KnGl6IzVWYRAo3LrBMhGc4GwJEeqRO8lQk08cVz4FTkJ9TCSsY2cqLbAfYlefRXn+JmUtPVNc8G5E0bHnX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234675; c=relaxed/simple;
	bh=x3rD4iWp/cVT5DkwH4xo7xi5vfqZz0c+SaWEZoZtpws=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oTAmh5+VB/rubRoHlgmZyqR0/X2TzZZ9iRfyecFJ/EO1qW8KpBbGfdXR17m1+AAVTB8JhzI+UhLZpumkWVk24qAEyGWHES6Kjjb5wdteeSNQ6EZWPp3AfUpnDJUs8VyRyPfVFAigGLTBUr8T2DzChBhv94D4R6mIMHLrq8iu79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=omRgloKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3BDC4CEE4;
	Mon, 21 Apr 2025 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745234674;
	bh=x3rD4iWp/cVT5DkwH4xo7xi5vfqZz0c+SaWEZoZtpws=;
	h=Subject:To:Cc:From:Date:From;
	b=omRgloKxzFHSCzYkegxaHUlHL5u3H6Bq+sytZum8//V2K4Jf4etq5SeuOGv0QlY1D
	 KBB5NKuzZJf+NYm2GfLJZXynvngw2iWVacULLf/oYeJRamLad1KblIZJ+YUH0MzKq9
	 wHE76fx+QDFWgu+0W1mHaVZtuznWPFmNLmrQHYGU=
Subject: FAILED: patch "[PATCH] scripts: generate_rust_analyzer: Add ffi crate" failed to apply to 6.14-stable tree
To: kernel@o1oo11oo.de,ojeda@kernel.org,tamird@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 13:24:32 +0200
Message-ID: <2025042132-everglade-smasher-1ef2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 05a2b0011c4b6cbbc9b577f6abebe4e9333b0cf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042132-everglade-smasher-1ef2@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

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


