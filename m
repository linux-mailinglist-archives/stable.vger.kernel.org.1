Return-Path: <stable+bounces-120179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA4FA4CB4C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 19:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FA33A1D2D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899DA22FDEF;
	Mon,  3 Mar 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUhYAG2v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJW4Dtpk"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35321DE2BF;
	Mon,  3 Mar 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027925; cv=none; b=b/U4ssUflUf3IU448aXWJOotLePulA2kMaGmEuIYbivVVyasnibYYHEL7bBKuex91RpI1w5n1TABUCBV2OmAmHLH+siPJ4c6tGS0n5TiwWSNz+Z4iqiMYBsv57gqjQy5wlz3vT3HDXwNv+BslaVvnbK2tL6SWidQSCsukRZ9KvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027925; c=relaxed/simple;
	bh=1yhqGBnCfjY0KGgjkxu73wTI8tWMX8VrGb3opBXDEbQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jg8uK/DwYusuXx23nrlptNwLJYJshmbB4mRZYcMDduoW4m+JOnT1Au0IwIkZamUhMJVRn5sFH7LpZu3IL4DDwOkeOWgMZ8K6FdUhsY04hocDDhk0LiIEWUijONBHXaYK2JiZvrhKBWp/2sMbr+sO7gta+YaTVvTx+6DrNlOPGDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUhYAG2v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bJW4Dtpk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r97iOpjc8uEnhwCRhQJtUxIn9RXKAsNVZFjKDhwF9C0=;
	b=EUhYAG2v9BNuWDMFKBA6bPYgd/cfEIpix5fpLxskiIo6eYB89DQT2JY3LPSamyaXcbaryp
	xiiwZP8mMS1+Sl1kQMcwJD1Y8eqldPPFQVp3nU7YNA68lCmhbAThCUHMKnBx6o96AnNjij
	fVWo4j86EZkU9zEGhA/Rnzbx2zqI79j6GNknjVbYkSYiH6t72RXFvVNRON6dI6RlA1mvtj
	QszNNYkr4dDWEa+AgjwtCjUxDEibD1z5BbeYqpVshBRZf45kInuCySToI/VJPBWgfW0OyO
	H+4eXRQb52BzmcLc6nT2GUPZdHSEMKq6dy/dVwjUli9+rqB96JjL2X823ZNrbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r97iOpjc8uEnhwCRhQJtUxIn9RXKAsNVZFjKDhwF9C0=;
	b=bJW4DtpkFeEyyI66ZqBUBue+SFqZ54CEfkbnXcxzS7R7tW7RqqX4O3bJW/DuTtR5JnsNk6
	YHqY3rGaaDfcj1CQ==
From: "tip-bot2 for Mitchell Levy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
Cc: Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org,
 Benno Lossin <benno.lossin@proton.me>,
 Mitchell Levy <levymitchell0@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250207-rust-lockdep-v4-1-7a50a7e88656@gmail.com>
References: <20250207-rust-lockdep-v4-1-7a50a7e88656@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791462.14745.6426418387057210113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5fc1506d33db23894e74caf048ba5591f4986767
Gitweb:        https://git.kernel.org/tip/5fc1506d33db23894e74caf048ba5591f4986767
Author:        Mitchell Levy <levymitchell0@gmail.com>
AuthorDate:    Fri, 07 Feb 2025 16:39:08 -08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 25 Feb 2025 08:53:08 -08:00

rust: lockdep: Remove support for dynamically allocated LockClassKeys

Currently, dynamically allocated LockCLassKeys can be used from the Rust
side without having them registered. This is a soundness issue, so
remove them.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/
Cc: stable@vger.kernel.org
Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250207-rust-lockdep-v4-1-7a50a7e88656@gmail.com
---
 rust/kernel/sync.rs | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 3498fb3..16eab91 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -30,28 +30,20 @@ pub struct LockClassKey(Opaque<bindings::lock_class_key>);
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
-    /// Creates a new lock class key.
-    pub const fn new() -> Self {
-        Self(Opaque::uninit())
-    }
-
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.0.get()
     }
 }
 
-impl Default for LockClassKey {
-    fn default() -> Self {
-        Self::new()
-    }
-}
-
 /// Defines a new static lock class and returns a pointer to it.
 #[doc(hidden)]
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
+        static CLASS: $crate::sync::LockClassKey =
+            // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
+            // lock_class_key
+            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
         &CLASS
     }};
 }

