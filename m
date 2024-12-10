Return-Path: <stable+bounces-100390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CE9EAD38
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CA4287FBB
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA623DE8C;
	Tue, 10 Dec 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGBOpstJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7F23DE88
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824524; cv=none; b=p/FCjFmxikbPy8ba7QB0uC1sNk2aamRgAw1t7z7mQJ8JpC3n8YO8WLNfBQ6SRm2DwRUl/gof0NTgEVMAydIlx+B1nUhVbnqWwxXbjp/K+8Y+rdrMyE2UZzSxFkXED6lyYNneIGkxQ8R1G/0mmJkT9ljE+n+9nkS/aZWJYgh2dNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824524; c=relaxed/simple;
	bh=XtVsTPW3n8ltcX1rBI4u9o78LYNF74+3vZbmfAvZtYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vi5MzDbGgjHwwVr7t2AE43FqBY11J6KxC6fAdVLaN4CfoNKpsyl9t/MMGRTqctgx+pmXO2BtmdFpLWpMtHvWsCbK150ZDMsMsXP/XkKqLmbANHUzVRCFashw1G28s4fyh3IvF1fF3rcap0hC0BAuv9PNLOwjya0VEVxCnJabMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGBOpstJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D4CC4CED6;
	Tue, 10 Dec 2024 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733824523;
	bh=XtVsTPW3n8ltcX1rBI4u9o78LYNF74+3vZbmfAvZtYY=;
	h=From:To:Cc:Subject:Date:From;
	b=eGBOpstJ+TwsQCrZHhgwwBKGy/lGALG30p6X1itMPHfJYfSsr92OrFD2LWzluIZu5
	 BsdDdInA9QiilKGTNLgu5e3AlSKcHgzOLBHumKgFp1Nh1CrTosO+z9jF91iqdEn/aN
	 zJ88wsyrGC+BPVNv8VS/dVcKjUEUXAyYKjt22PyJag0PGh37Znj704qbPhZP5cALRJ
	 z95bBzDkcaLs5Clig7SO902r/YQjUf6BgcyA+zMOfTt+ARhvFziSYqL7VZprOrH2oX
	 SBirB+zBnctnYlAnP3Q2AswkR9GtejW8WqCUz5SAsFaF9ceXjCnR1pBQa/8Pv45a2X
	 bR9Pf75qPDgGg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Adrian Taylor <ade@hohum.me.uk>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH] rust: enable arbitrary_self_types and remove `Receiver`
Date: Tue, 10 Dec 2024 10:55:06 +0100
Message-ID: <20241210095506.2027071-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

[ Upstream commit c95bbb59a9b22f9b838b15d28319185c1c884329 ]

The term "receiver" means that a type can be used as the type of `self`,
and thus enables method call syntax `foo.bar()` instead of
`Foo::bar(foo)`. Stable Rust as of today (1.81) enables a limited
selection of types (primitives and types in std, e.g. `Box` and `Arc`)
to be used as receivers, while custom types cannot.

We want the kernel `Arc` type to have the same functionality as the Rust
std `Arc`, so we use the `Receiver` trait (gated behind `receiver_trait`
unstable feature) to gain the functionality.

The `arbitrary_self_types` RFC [1] (tracking issue [2]) is accepted and
it will allow all types that implement a new `Receiver` trait (different
from today's unstable trait) to be used as receivers. This trait will be
automatically implemented for all `Deref` types, which include our `Arc`
type, so we no longer have to opt-in to be used as receiver. To prepare
us for the change, remove the `Receiver` implementation and the
associated feature. To still allow `Arc` and others to be used as method
receivers, turn on `arbitrary_self_types` feature instead.

This feature gate is introduced in 1.23.0. It used to enable both
`Deref` types and raw pointer types to be used as receivers, but the
latter is now split into a different feature gate in Rust 1.83 nightly.
We do not need receivers on raw pointers so this change would not affect
us and usage of `arbitrary_self_types` feature would work for all Rust
versions that we support (>=1.78).

Cc: Adrian Taylor <ade@hohum.me.uk>
Link: https://github.com/rust-lang/rfcs/pull/3519 [1]
Link: https://github.com/rust-lang/rust/issues/44874 [2]
Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20240915132734.1653004-1-gary@garyguo.net
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Please consider applying to 6.12.y.

It is meant to support the upcoming Rust 1.84.0 compiler (to be
released in a month), since 6.12 LTS is the first stable kernel that
supports a minimum Rust version, thus users may use newer compilers.
Older LTSs do not need it, for that reason.

 rust/kernel/lib.rs      | 2 +-
 rust/kernel/list/arc.rs | 3 ---
 rust/kernel/sync/arc.rs | 6 ------
 scripts/Makefile.build  | 2 +-
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 032c9089e686..e936254531fd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -12,10 +12,10 @@
 //! do so first instead of bypassing this crate.

 #![no_std]
+#![feature(arbitrary_self_types)]
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
-#![feature(receiver_trait)]
 #![feature(unsize)]

 // Ensure conditional compilation based on the kernel configuration works;
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index d801b9dc6291..3483d8c232c4 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ -441,9 +441,6 @@ fn as_ref(&self) -> &Arc<T> {
     }
 }

-// This is to allow [`ListArc`] (and variants) to be used as the type of `self`.
-impl<T, const ID: u64> core::ops::Receiver for ListArc<T, ID> where T: ListArcSafe<ID> + ?Sized {}
-
 // This is to allow coercion from `ListArc<T>` to `ListArc<U>` if `T` can be converted to the
 // dynamically-sized type (DST) `U`.
 impl<T, U, const ID: u64> core::ops::CoerceUnsized<ListArc<U, ID>> for ListArc<T, ID>
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3021f30fd822..28743a7c74a8 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -171,9 +171,6 @@ unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
     }
 }

-// This is to allow [`Arc`] (and variants) to be used as the type of `self`.
-impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
-
 // This is to allow coercion from `Arc<T>` to `Arc<U>` if `T` can be converted to the
 // dynamically-sized type (DST) `U`.
 impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> for Arc<T> {}
@@ -480,9 +477,6 @@ pub struct ArcBorrow<'a, T: ?Sized + 'a> {
     _p: PhantomData<&'a ()>,
 }

-// This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
-impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
-
 // This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
 // `ArcBorrow<U>`.
 impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8f423a1faf50..880785b52c04 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -248,7 +248,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------

-rust_allowed_features := new_uninit
+rust_allowed_features := arbitrary_self_types,new_uninit

 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree

base-commit: 61baee2dc5341c936e7fa7b1ca33c5607868de69
--
2.47.1

