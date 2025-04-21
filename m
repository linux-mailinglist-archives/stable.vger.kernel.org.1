Return-Path: <stable+bounces-134788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461BA95115
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162A53A4F1E
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB6264F8F;
	Mon, 21 Apr 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kERGqX/g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F1CA5E
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239079; cv=none; b=eK9fZQbJ6WCkrQSw1n40K0ovyDhztGDOWQOg7XVNTzBMcTUzO57hyPDLarDUAHfGmSglZ91VFzpkLA6ZlagvJ6qbu9LtgevXMF3+frOf5gaDbhv0IY9Lm5GqLM96yYh/BBPPuaQUBwJWwtJJhTdbFX5XZ6YMtVawWUFNhsE/zlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239079; c=relaxed/simple;
	bh=eCQVdC9txgrsGrTUrqNRuVqtwoVGBG8Uup5jVepAmX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX2eHPpBLJF5iJQV5q4SYKrWZwkjAulnJUWx0gqGSHB7YAkdLJanvThyKgOdRpbQB2ucNSYF1hm3dDBo2aJDZAo/38dX7XaY6AngWZmcARlZhDt/r9kKggtZD/prqxi9KEppOWMkeNcugwAWPlFUAU+Rrvu5kjhHvNKpIok7YxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kERGqX/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC05C4CEEA;
	Mon, 21 Apr 2025 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745239079;
	bh=eCQVdC9txgrsGrTUrqNRuVqtwoVGBG8Uup5jVepAmX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kERGqX/gj6rKhDA1PjsdEK3MjlKKVVy5/WKYZ9krgxC3Jwmy9ZjAlGRJPZ6YY38Y4
	 s30Vr3XPsoXSfML33YkKhogtf1aEHPpgFX4KvRnOsNqqqVHzNgT5GMYLKhn3AdNoJJ
	 X7F99htC5aEyagwnukdx2w1H/vILIFLIgPD38pDs7PQv8HPagb1XVb88hyMz24gDgh
	 aYim3LS0dgkEWKmBYHOPycDfn08vmAZej+GxMz1agGVg+IihPSV3NCe3akSsY4z1/y
	 HyFLyjh27CskWOmxiP3nLv82TcGPxc8jI3OfXdrHMKdD5o9ap25Qo7gbCEIBJ7phAG
	 x/re9b1c/oTHQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Fischer <kernel@o1oo11oo.de>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12.y] scripts: generate_rust_analyzer: Add ffi crate
Date: Mon, 21 Apr 2025 14:37:43 +0200
Message-ID: <20250421123743.3147213-1-ojeda@kernel.org>
In-Reply-To: <2025042132-trial-subtext-ae03@gregkh>
References: <2025042132-trial-subtext-ae03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Fischer <kernel@o1oo11oo.de>

commit 05a2b0011c4b6cbbc9b577f6abebe4e9333b0cf6 upstream.

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
[ Fixed conflicts. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/generate_rust_analyzer.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index d1f5adbf33f9..690f9830f064 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -90,6 +90,12 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         ["core", "compiler_builtins"],
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
@@ -109,9 +115,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             "exclude_dirs": [],
         }
 
-    append_crate_with_generated("bindings", ["core"])
-    append_crate_with_generated("uapi", ["core"])
-    append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "uapi"])
+    append_crate_with_generated("bindings", ["core", "ffi"])
+    append_crate_with_generated("uapi", ["core", "ffi"])
+    append_crate_with_generated("kernel", ["core", "macros", "build_error", "ffi", "bindings", "uapi"])
 
     def is_root_crate(build_file, target):
         try:
-- 
2.49.0


