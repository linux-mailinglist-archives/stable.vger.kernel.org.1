Return-Path: <stable+bounces-128773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56858A7EF04
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 22:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1418C189A8C6
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE420B7EF;
	Mon,  7 Apr 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FlsLcZua"
X-Original-To: stable@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAA222597;
	Mon,  7 Apr 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057110; cv=none; b=o8lwCU3QDtzYKckRqbC87aGskUrB+sItb2hvdhnOA+tJ6VFwyEDVI2FBHKQGPUH0UzgXFFLxJvD+4NBASaeMNFXJTMT70JDW6sy5KSmGaUfC8hzI/Rii/gfdEEIjnfqXBIA44meVLWdeiSyy0PEQDlTgmOirTfoy9SPf5IuQku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057110; c=relaxed/simple;
	bh=pokdKQsoUfnHlCVbA/BSywoVD9+PRKu7nsKM8bDuwE0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zf0Mq+X1bF21yE9qUL2WfvMPSGOnjZ1HMdOSHEuDZnxuZp3vPZ5iQGfVkufQnfsy3ClBQ4o99+797Ceu7CnZWh9Re0BIfUAKhjcJMYv7QZfRE0qh7gL6gZwItqNwnlus2BUMlM9g9G/+MeRM7wolOMkTP8ogGwQk3G5qyLz9ooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FlsLcZua; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744057106; x=1744316306;
	bh=snP7gjeU3YyTTNo+TLTC0FBLFD/vHl4orLCkPUeZL/E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FlsLcZuaGEuaWUe0PL5wi854eOh8FJJN2ySPbXr4wOCHLW6i7W1cGp9Bkd3PcywF7
	 EwJh+0A/NRYRJsc0zqaCQVWB8obQIkosoaget0F76DGeHbIP8o5z7pLJ/ks/AUh8fs
	 aC3CS8FRu2yzbS69DziJjFL3+DSgq2nV/uuUwkKaU9nYjEXKJtNXB2kRyaa9m3wnTc
	 974DAEPNOOOKhujhsBBop1NUHfTZmVA4Q5tmqUk/u9kdFzCGChioT2Lqn9vMe3IlT2
	 2Qsc+orVStcTQGLkzOJXGMu4Q6BkIQgz+qRDJHU6s604EiVd1fMlpaCMmSiZeA6j7C
	 pHvKst7UjDHJQ==
Date: Mon, 07 Apr 2025 20:18:21 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>
From: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: pin-init: alloc: restrict `impl ZeroableOption` for `Box` to `T: Sized`
Message-ID: <20250407201755.649153-2-benno.lossin@proton.me>
In-Reply-To: <20250407201755.649153-1-benno.lossin@proton.me>
References: <20250407201755.649153-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 47c13476485a5c2e470f2c3ccb770f4ab4d68301
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Miguel Ojeda <ojeda@kernel.org>

Similar to what was done for `Zeroable<NonNull<T>>` in commit
df27cef15360 ("rust: init: fix `Zeroable` implementation for
`Option<NonNull<T>>` and `Option<KBox<T>>`"), the latest Rust
documentation [1] says it guarantees that `transmute::<_,
Option<T>>([0u8; size_of::<T>()])` is sound and produces
`Option::<T>::None` only in some cases. In particular, it says:

    `Box<U>` (specifically, only `Box<U, Global>`) when `U: Sized`

Thus restrict the `impl` to `Sized`, and use similar wording as in that
commit too.

Link: https://doc.rust-lang.org/stable/std/option/index.html#representation=
 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/pin-init/pull/32/commits/a6007cf555=
e5946bcbfafe93a6468c329078acd8
Fixes: 9b2299af3b92 ("rust: pin-init: add `std` and `alloc` support from th=
e user-space version")
Cc: stable@vger.kernel.org
[ Adjust mentioned commit to the one from the kernel. - Benno ]
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/src/alloc.rs | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/rust/pin-init/src/alloc.rs b/rust/pin-init/src/alloc.rs
index e16baa3b434e..5017f57442d8 100644
--- a/rust/pin-init/src/alloc.rs
+++ b/rust/pin-init/src/alloc.rs
@@ -17,11 +17,9 @@
=20
 pub extern crate alloc;
=20
-// SAFETY: All zeros is equivalent to `None` (option layout optimization g=
uarantee).
-//
-// In this case we are allowed to use `T: ?Sized`, since all zeros is the =
`None` variant and there
-// is no problem with a VTABLE pointer being null.
-unsafe impl<T: ?Sized> ZeroableOption for Box<T> {}
+// SAFETY: All zeros is equivalent to `None` (option layout optimization g=
uarantee:
+// <https://doc.rust-lang.org/stable/std/option/index.html#representation>=
).
+unsafe impl<T> ZeroableOption for Box<T> {}
=20
 /// Smart pointer that can initialize memory in-place.
 pub trait InPlaceInit<T>: Sized {
--=20
2.48.1



