Return-Path: <stable+bounces-120434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0411A5008C
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D65189401D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710E24889F;
	Wed,  5 Mar 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GWwmNM4l"
X-Original-To: stable@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261D2459F4;
	Wed,  5 Mar 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181354; cv=none; b=iaOipVbx+P+A47/LMKrYpDxmTVICUIYJD4FKN7UK2DK6/iPATCYO5EXZ9WfR5k0eFv1jlZMfjcsvSO8AoiTL4xmQIpkRJhyahviKLMuaeGYKjPl1w/Jw52aw5QgDK0pUlQ4hhx9t2Qs/4461/6BJkC4u4tqE2Iljx4REd+953V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181354; c=relaxed/simple;
	bh=4m3lsk3diPdi+pXnlMOPu66YINy014+l1ZqCdwvE+zY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BuXgz8DtAt3yW50FO0rLM+F91ANbXF6snPqsQ1lPELc5m/jJDp9wURIJ6H6Y5/cT/A7y9z6vqtp83FDLUU8uwq+PVsw+u22XOV42tdYMYmoMX92v9FJPh2HIDlABM+RunepZmt20JYVxrijXJEnlzB6W5YtI5b4NX7ELd77a268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GWwmNM4l; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741181348; x=1741440548;
	bh=VLRuq+zLi3QgzPU0fq1VXCBryN9TCDq6Mg2zpj1ReCg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=GWwmNM4lNNstyWlFysdFMIZvbZt6jCpaq1UHZAxQNF1Fr6oTvR91TWnV9D4UEbEyO
	 bplPBXXgPXoKdipJrHfIdEEEKzDi3BR3UtxseEY4EIwzZUJEQnGNe328Zjd/k3OANY
	 4SnN/EKcQaWlOAyAlvGfEfcUVjoyzEfsfzxgGbKVIaRopX1fIDtfo5Peebf/MYbjmO
	 fC9l7K3TXO867LBafW3iaDIFj1L3Hv5Jc8TlZMUxKibhFkS5cIDyFjbxkaKCK1lHep
	 Z2gIIP6JROra80QkVdCbCIrFk/do5XHsxi5I14xpn47+rh5bjl07ZYFLHdZqbmEw6h
	 ssIpcI73/CD9w==
Date: Wed, 05 Mar 2025 13:29:01 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<KBox<T>>`
Message-ID: <20250305132836.2145476-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d1e529b8444b826cfa13a136a432f83cb566a8c5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
such as our custom `KBox<T>` have the null pointer optimization only if
`T: Sized`. Thus remove the `Zeroable` implementation for the unsized
case.

Link: https://doc.rust-lang.org/stable/std/option/index.html#representation=
 [1]
Cc: stable@vger.kernel.org # v6.12+ (a custom patch will be needed for 6.6.=
y)
Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed` f=
unction")
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 7fd1ea8265a5..8bbd5e3398fc 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1418,17 +1418,14 @@ macro_rules! impl_zeroable {
     // SAFETY: `T: Zeroable` and `UnsafeCell` is `repr(transparent)`.
     {<T: ?Sized + Zeroable>} UnsafeCell<T>,
=20
-    // SAFETY: All zeros is equivalent to `None` (option layout optimizati=
on guarantee).
+    // SAFETY: All zeros is equivalent to `None` (option layout optimizati=
on guarantee:
+    // https://doc.rust-lang.org/stable/std/option/index.html#representati=
on).
     Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZ=
eroU64>,
     Option<NonZeroU128>, Option<NonZeroUsize>,
     Option<NonZeroI8>, Option<NonZeroI16>, Option<NonZeroI32>, Option<NonZ=
eroI64>,
     Option<NonZeroI128>, Option<NonZeroIsize>,
-
-    // SAFETY: All zeros is equivalent to `None` (option layout optimizati=
on guarantee).
-    //
-    // In this case we are allowed to use `T: ?Sized`, since all zeros is =
the `None` variant.
-    {<T: ?Sized>} Option<NonNull<T>>,
-    {<T: ?Sized>} Option<KBox<T>>,
+    {<T>} Option<NonNull<T>>,
+    {<T>} Option<KBox<T>>,
=20
     // SAFETY: `null` pointer is valid.
     //

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.48.1



