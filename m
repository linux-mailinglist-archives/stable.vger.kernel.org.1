Return-Path: <stable+bounces-167073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B753EB217A2
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6386B621468
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992462D8773;
	Mon, 11 Aug 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peD6+P6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31C311C2E;
	Mon, 11 Aug 2025 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948791; cv=none; b=dfxjnPDxkXfQyVNpYOIYMh/T5pm8qZY5PNI1C59ETnD4ih7MNsxBFy63gAQQsdspf6/K7QYi9srCXxNnF82wrRAWUDAwXC9AwrZQLFg+IMtlHsSOedpaQOxTO4Wc8usdTua3/M5S45fSmiwMvjiklTgSKYNJWEzsWy2cgjwgxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948791; c=relaxed/simple;
	bh=dwbcE24piVFzyakWr4kDnlPp4I+GUC8EOGb+5b4S2ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Faz2IOFXM2MT1reVq3xlMVdQvBtgedwkxKDvTLMwNTLOlJQVKNTjZBfq+Wk4/XwA/o9Hgzyf+xCxNM1SQzfEka0TFYkU9yZdWclbOqTs14SO6rvws95rtBDqoIVxTrrrHKfvl2ZhWFGx/CxYbrP6q54eDc6Ks0rCGCABJ3D6lkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peD6+P6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64DFC4CEED;
	Mon, 11 Aug 2025 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754948790;
	bh=dwbcE24piVFzyakWr4kDnlPp4I+GUC8EOGb+5b4S2ls=;
	h=From:To:Cc:Subject:Date:From;
	b=peD6+P6NOdX+quFRZFGfJcy+UTFln/T8CaW5z5o6u0WK/keFsvMabpux+ms9t9Hqk
	 Ff8twsoxxO8hiv3dy6SS8lwT1Jf+6YcZsPG0E8kqhCP1Pu7PhUXa4LcmlxTc9NB2Ra
	 8WC/EpHZIKDNlPg1lM5i+Osswg2Vk8GMxnYF4CwKOvfCvJOXvJLYhPVItWF0Ms1Mau
	 U70HSNIkP5PWpN/FuA24yYVki+Qg7dLmSdjP/u9jOm3YiwELuVXzq6ST1W3btkBFu6
	 1obCJrQFF5j4aK8gFBvqnu/a0Src9iNMmhuPRfFtYjvRI1G/wZ1RyQ/abSjje0aDq3
	 +1iduKRA/X8Dw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] rust: devres: fix leaking call to devm_add_action()
Date: Mon, 11 Aug 2025 23:44:48 +0200
Message-ID: <20250811214619.29166-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the data argument of Devres::new() is Err(), we leak the preceding
call to devm_add_action().

In order to fix this, call devm_add_action() in a unit type initializer in
try_pin_init!() after the initializers of all other fields.

Cc: stable@vger.kernel.org
Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index da18091143a6..bfccf4177644 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -119,6 +119,7 @@ pub struct Devres<T: Send> {
     // impls can be removed.
     #[pin]
     inner: Opaque<Inner<T>>,
+    _add_action: (),
 }
 
 impl<T: Send> Devres<T> {
@@ -140,7 +141,15 @@ pub fn new<'a, E>(
             dev: dev.into(),
             callback,
             // INVARIANT: `inner` is properly initialized.
-            inner <- {
+            inner <- Opaque::pin_init(try_pin_init!(Inner {
+                    devm <- Completion::new(),
+                    revoke <- Completion::new(),
+                    data <- Revocable::new(data),
+            })),
+            // TODO: Replace with "initializer code blocks" [1] once available.
+            //
+            // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
+            _add_action: {
                 // SAFETY: `this` is a valid pointer to uninitialized memory.
                 let inner = unsafe { &raw mut (*this.as_ptr()).inner };
 
@@ -153,12 +162,6 @@ pub fn new<'a, E>(
                 to_result(unsafe {
                     bindings::devm_add_action(dev.as_raw(), Some(callback), inner.cast())
                 })?;
-
-                Opaque::pin_init(try_pin_init!(Inner {
-                    devm <- Completion::new(),
-                    revoke <- Completion::new(),
-                    data <- Revocable::new(data),
-                }))
             },
         })
     }

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


