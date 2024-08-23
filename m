Return-Path: <stable+bounces-70000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E095CF05
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B621F234D2
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE631198A1A;
	Fri, 23 Aug 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUEGgCqf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109C198A0E;
	Fri, 23 Aug 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421814; cv=none; b=V9nSjmAIQ632yVulXE9oaZjM2T4VV8IUGpeNOXH9mjZx8LKCmNxMk1qQbNjcLIWBDlnn+X14mL8xDHsjZEzl4Ue/Rp4ykDSFzQ4UjBF9wo2D7i3UaQow/JyL92VYIId2UtTPR/PRnfsmAwkzqMq498jd0Qly3gANoft2hSH46E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421814; c=relaxed/simple;
	bh=lGrsBWzdm1BuLDIslzhYFqNiKFN3zkGBzaOPQb/Y4hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSGsqVJOYu4jn4AVRq0DDgSyIymIHj57FHIuRFkoJi/+d5CiRbid+qDJKLk+XRwZ+i9AZTFBR9lRPYCx5zeX137gXQ+1fwzzDehAo7kFee+8EQjUzqd9jqvFwqqcKmZpkXWyDAPvPqpMoidaCSAJtVYha1Fou63UFRiCie4o31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUEGgCqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2DBC4AF0F;
	Fri, 23 Aug 2024 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421814;
	bh=lGrsBWzdm1BuLDIslzhYFqNiKFN3zkGBzaOPQb/Y4hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUEGgCqf+t7OMRUr1UFTor6nlEvlYXw7PVWixp+Wjx9BeM2XjJNayLZ5ZtEuiIAyd
	 F9IVE2Tm8uotcEWkN+aukguGQbLyInLj6/5EKc82Sy3wNrtiEm/UMb9MsM7/iUmRFB
	 ASr98L4oNL+lssoEqX2EufQAQ3lcXVQGXngP+LezerB1LZNWJXjl22+HnwoUSpyvWB
	 575w8w0A/3vKcIKyFNHQhaneIq1tO8htoO68YUiqGUOvNsYWypKv2wZD4ZUNV2uBzv
	 gzV1Ur7jpPEBQvYn3foOzNa6/31+mHXYoiEcwFuizat/6CXIKssVbKfDKjibGCZrSv
	 hrbUr58+SeKFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	nathan@kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 09/20] rust: add intrinsics to fix `-Os` builds
Date: Fri, 23 Aug 2024 10:02:23 -0400
Message-ID: <20240823140309.1974696-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
Content-Transfer-Encoding: 8bit

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit 02dfd63afe65f7bacad543ba2b10f77083ae7929 ]

Alice reported [1] that an arm64 build failed with:

    ld.lld: error: undefined symbol: __extendsfdf2
    >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
    >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
    >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
    >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a

    ld.lld: error: undefined symbol: __truncdfsf2
    >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
    >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a

Rust 1.80.0 or later together with `CONFIG_CC_OPTIMIZE_FOR_SIZE=y`
is what triggers it.

In addition, x86_64 builds also fail the same way.

Similarly, compiling with Rust 1.82.0 (currently in nightly) makes
another one appear, possibly due to the LLVM 19 upgrade there:

    ld.lld: error: undefined symbol: __eqdf2
    >>> referenced by core.20495ea57a9f069d-cgu.0
    >>>               rust/core.o:(<f64>::next_up) in archive vmlinux.a
    >>> referenced by core.20495ea57a9f069d-cgu.0
    >>>               rust/core.o:(<f64>::next_down) in archive vmlinux.a

Gary adds [1]:

> Usually the fix on rustc side is to mark those functions as `#[inline]`
>
> All of {midpoint,next_up,next_down} are indeed unstable functions not
> marked as inline...

Fix all those by adding those intrinsics to our usual workaround.

[ Trevor quickly submitted a fix to upstream Rust [2] that has already
  been merged, to be released in Rust 1.82.0 (2024-10-17). - Miguel ]

Cc: Gary Guo <gary@garyguo.net>
Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/near/455637364 [1]
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://github.com/rust-lang/rust/pull/128749 [2]
Link: https://lore.kernel.org/r/20240806150619.192882-1-ojeda@kernel.org
[ Shortened Zulip link. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/Makefile             | 4 ++--
 rust/compiler_builtins.rs | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 060ba8cfa9149..9e0939b8fa78b 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -411,8 +411,8 @@ rust-analyzer:
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
 
 redirect-intrinsics = \
-	__addsf3 __eqsf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __unordsf2 \
-	__adddf3 __ledf2 __ltdf2 __muldf3 __unorddf2 \
+	__addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __truncdfsf2 __unordsf2 \
+	__adddf3 __eqdf2 __ledf2 __ltdf2 __muldf3 __unorddf2 \
 	__muloti4 __multi3 \
 	__udivmodti4 __udivti3 __umodti3
 
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index bba2922c6ef77..f14b8d7caf899 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -40,16 +40,19 @@ pub extern "C" fn $ident() {
 define_panicking_intrinsics!("`f32` should not be used", {
     __addsf3,
     __eqsf2,
+    __extendsfdf2,
     __gesf2,
     __lesf2,
     __ltsf2,
     __mulsf3,
     __nesf2,
+    __truncdfsf2,
     __unordsf2,
 });
 
 define_panicking_intrinsics!("`f64` should not be used", {
     __adddf3,
+    __eqdf2,
     __ledf2,
     __ltdf2,
     __muldf3,
-- 
2.43.0


