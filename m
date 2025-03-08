Return-Path: <stable+bounces-121519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079AA5769D
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 01:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90BD188AA9C
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912F013A3F2;
	Sat,  8 Mar 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mq1KKxvb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="911nkO5p"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D584D34;
	Sat,  8 Mar 2025 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392498; cv=none; b=QeQoEd+ndbSK+OAjceSlkFzenNJoZMofzE2UD0JuCwHvb7u1m/RvQjwwc+We1wKWOHbOUJ28Z1/Jgfhedr7i7LVIKDRWDSOEAJoQxuCb7rXCILXauHWUP1IRFuvgjwbh9fXCR6KNvWwkMqk3ag7RZDgySSz38SNnEvi/DHAgH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392498; c=relaxed/simple;
	bh=5D35/4ohmfpcis5XOvEhRdcwDHLDWNRtFM9y/samnV0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s0DFqrMyOo+B+r+D8rUp2RFia8HQd9o6xDpKkkx51zaBGTmIIhPj+njapcGru8m9E5efdCEJ2ftMKW7obFi8Jiq19iC98Qbx1n3yKCvES8XHycgJDYfivPJovlTycGTvjGG91KVxnNuk2ubwYH6FPTGU0tGfgJb/pf9uyWXGnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mq1KKxvb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=911nkO5p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4C35lSxeLOZfgjchJTfD0Qtk0qHxMzTuXFzGkO9UQ9c=;
	b=Mq1KKxvb8V5/ywQak72ZKzRq/lc+yE89403C4tp/5C2l2YbrG/uCDoyHolXcpRUCEGmAAJ
	i0s6H32J12yoy39IdvIBWEbEGgVlcqyblUvE/wjH8BUrsynWEVjVZB8/yV1tR9s7ty1/aL
	n6PhcvhuUoulG9CYVAvzun9I/hwXM6uu98VljOQaaSSqnR2rROiaC/A64eeP86NElK3I/A
	lTnxCv7Pw1SXJ9cO/V5LrjG06TD3irxZOwUhPZjZSTEJA9jBSGE+w2pQGgIiCuG0RxVe0N
	07RKioC5Tvrj+ocELhAhbuJ5e9gCMbiLMWYxrsr9zqmZuigISiReUOn81EzjrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4C35lSxeLOZfgjchJTfD0Qtk0qHxMzTuXFzGkO9UQ9c=;
	b=911nkO5p241RyvkjjPmN8ptsGrxKA+o3kAR0I3rIn964OZ+c4XLTpoBtd8ZmaKL2saJH2n
	guG44w9nOIENFMDg==
From: "tip-bot2 for Mitchell Levy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
Cc: Alice Ryhl <aliceryhl@google.com>, Mitchell Levy <levymitchell0@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Benno Lossin <benno.lossin@proton.me>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-11-boqun.feng@gmail.com>
References: <20250307232717.1759087-11-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139249455.14745.13816550054744263008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     966944f3711665db13e214fef6d02982c49bb972
Gitweb:        https://git.kernel.org/tip/966944f3711665db13e214fef6d02982c49bb972
Author:        Mitchell Levy <levymitchell0@gmail.com>
AuthorDate:    Fri, 07 Mar 2025 15:27:00 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:52:00 +01:00

rust: lockdep: Remove support for dynamically allocated LockClassKeys

Currently, dynamically allocated LockCLassKeys can be used from the Rust
side without having them registered. This is a soundness issue, so
remove them.

Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250307232717.1759087-11-boqun.feng@gmail.com
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

