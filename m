Return-Path: <stable+bounces-220908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJsQMZ5bo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:18:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBB31C8E8D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E721036E2A26
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536142A7A5;
	Sat, 28 Feb 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc+8xAOv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFA42A79B;
	Sat, 28 Feb 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300797; cv=none; b=hmU3zzzqjZutwMonCVTa+g8Vln7/UD5uSHAcZrNE7zmU16T/gDQcKGDSYL5nhk5kDIps1fLcqq0LHYoSHMIIE2LEIewGvUCR89iWkiuyCyP1Ms6wKZ+fiwjjlopdAShuVV0CbEZi+BKwy3B0P5SHyG3/ZyyjQvorFTsa0CYFqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300797; c=relaxed/simple;
	bh=+iy7ptYSLkD1fYrg74BQKN/mzogfPzwxLiHBiEWfsOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eG1jzKWP5VYAeHMvF25mfP+7EMlJCq9eZ4CMp2MtVJHLnlJ4EPqfS9i3u2VpmdaLGMJ9idGIuriM3CR1OKZ8Y9r7Ksgir+dO3eG2pdtqVsruKj7zGha+X9hHbc+kt/Yg2zG73tWRJB8tXyg3VTDl1DaXFItFL3UC6HW2YfYwTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc+8xAOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEEAC116D0;
	Sat, 28 Feb 2026 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300796;
	bh=+iy7ptYSLkD1fYrg74BQKN/mzogfPzwxLiHBiEWfsOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sc+8xAOvb33lqZNTPgNA7h1/5pFruC6MwAci8/Rkmt8QqwUJEAw2GuC3M7OkAA1jP
	 F3PPap9UKXOaF3gTIDYgc3lG7XZzyJuk9Kb4bk8qlMvnmnhJd9ucx/j0xa8MfmyhH4
	 bH4cG5Jjed7GwwjQs4SWZHjLcCFE+2+/BQ03FmZBGHKZcXBJhm0NoOWVNiAfFSsRT/
	 vUvB5bOc6W8OBdTiaWgCBLMDz01DAsY2WGTxB+ZSHMTuMmvna1pSdMUSUFktzDIuvh
	 uqyL/JDaLzN+k84z9W7M5hR+6Lco6EdX8sKLA29r8AQAzvHLrR9XAFzK3UrkNzls5O
	 ctyAn1ThOzD7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 829/844] rust: irq: add `'static` bounds to irq callbacks
Date: Sat, 28 Feb 2026 12:32:22 -0500
Message-ID: <20260228173244.1509663-830-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220908-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,garyguo.net:email,collabora.com:email]
X-Rspamd-Queue-Id: 1EBB31C8E8D
X-Rspamd-Action: no action

From: Benno Lossin <lossin@kernel.org>

[ Upstream commit 621609f1e5ca43a75edd497dd1c28bd84aa66433 ]

These callback functions take a generic `T` that is used in the body as
the generic argument in `Registration` and `ThreadedRegistration`. Those
types require `T: 'static`, but due to a compiler bug this requirement
isn't propagated to the function. Thus add the bound. This was caught in
the upstream Rust CI [1].

[ The three errors looked similar and will start appearing with Rust
  1.95.0 (expected 2026-04-16). The first one was:

      error[E0310]: the parameter type `T` may not live long enough
      Error:    --> rust/kernel/irq/request.rs:266:43
          |
      266 |     let registration = unsafe { &*(ptr as *const Registration<T>) };
          |                                           ^^^^^^^^^^^^^^^^^^^^^^
          |                                           |
          |                                           the parameter type `T` must be valid for the static lifetime...
          |                                           ...so that the type `T` will meet its required lifetime bounds
          |
      help: consider adding an explicit lifetime bound
          |
      264 | unsafe extern "C" fn handle_irq_callback<T: Handler + 'static>(_irq: i32, ptr: *mut c_void) -> c_uint {
          |                                                     +++++++++

    - Miguel ]

Link: https://github.com/rust-lang/rust/pull/149389 [1]
Signed-off-by: Benno Lossin <lossin@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 29e16fcd67ee ("rust: irq: add &Device<Bound> argument to irq callbacks")
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/20260217222425.8755-1-cole@unwrap.rs/
Link: https://patch.msgid.link/20260214092740.3201946-1-lossin@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/irq/request.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index b150563fdef80..2ceeaeb0543a4 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -261,7 +261,10 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_irq`.
-unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
+unsafe extern "C" fn handle_irq_callback<T: Handler + 'static>(
+    _irq: i32,
+    ptr: *mut c_void,
+) -> c_uint {
     // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
     let registration = unsafe { &*(ptr as *const Registration<T>) };
     // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
@@ -480,7 +483,7 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_threaded_irq`.
-unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler>(
+unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler + 'static>(
     _irq: i32,
     ptr: *mut c_void,
 ) -> c_uint {
@@ -496,7 +499,10 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 /// # Safety
 ///
 /// This function should be only used as the callback in `request_threaded_irq`.
-unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
+unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler + 'static>(
+    _irq: i32,
+    ptr: *mut c_void,
+) -> c_uint {
     // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
     let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
     // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
-- 
2.51.0


