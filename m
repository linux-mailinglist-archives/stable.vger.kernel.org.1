Return-Path: <stable+bounces-221803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGphOyKZo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B36E71CB4E5
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A176302198D
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4AE2DCBFA;
	Sun,  1 Mar 2026 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByC5RRTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7811E0B86;
	Sun,  1 Mar 2026 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329175; cv=none; b=BubMhdNXK5ZNlbRoQFT+7MUoVD4qFoCh2jezYrEGXq0c9VvelmH5NcVzBeIvn7wryqJn6nKmakcXGnKuzvkCdTIpSp0XojGSdjAAAtMb1BEr0pgwGpBZ2RFGlLPdGmgoryxARe72idEfyYioe4iT3YEKE6QElfpuL9bZt3Tw8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329175; c=relaxed/simple;
	bh=PwDTssfiLj812mcKn94XQrPq6Lkqg5ltegmZDIuOI/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgSzbLS/OBa0XflqRuZ7Sg7b+Jmpft+ghWEGdtP9qYDZE9HFgJdo0nkx/9WkbvFwzgpo0Fj2BEWx21ObBvuM1eeClVFeS0moow2wd7/oknKsQy6/Uzh7LWDv+OIWwSGQo/Gp/aDk7Pk+gfAmjHubJgOcicCBJb9u06Tu5qX9dRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByC5RRTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF8BC19421;
	Sun,  1 Mar 2026 01:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329175;
	bh=PwDTssfiLj812mcKn94XQrPq6Lkqg5ltegmZDIuOI/M=;
	h=From:To:Cc:Subject:Date:From;
	b=ByC5RRTSjTrPbME/Y1GtTonDApx2e9eWOXCFUw+TZwlLEqKlhV1+xO2hWMPGGX2Ai
	 5MqvL2P+30n9Lc9Vm9rX6tXVy6RzGLWvOsjKWdt5LDIsEsAkRwsvalHymmS5FFbfVF
	 TOybuxgWbhdnHXXDFeGnBjSwBqfYssBWZJJnhXdgfhJM9PLf+Z886ngTAQbpk9BovH
	 PQsH0QppwZP3tIanWId56YevG5WhUCAjSLiEJ6KBPkYn0OlglZZHym1ZP0nPkTPmWp
	 oHDJYkwWPVo19cQtBqpWAuhe9iTpi06I+gONXUOz52+1bFh9BaOfM7WHwVI75y42Mn
	 ZVTCGxNEpnJWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lossin@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org
Subject: FAILED: Patch "rust: pin-init: replace clippy `expect` with `allow`" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:33 -0500
Message-ID: <20260301013933.1700585-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-221803-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B36E71CB4E5
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a58b8764aed9648357b1c5b6368c9943ba33b7f9 Mon Sep 17 00:00:00 2001
From: Benno Lossin <lossin@kernel.org>
Date: Sun, 15 Feb 2026 14:22:30 +0100
Subject: [PATCH] rust: pin-init: replace clippy `expect` with `allow`

`clippy` has changed behavior in [1] (Rust 1.95) where it no longer
warns about the `let_and_return` lint when a comment is placed between
the let binding and the return expression. Nightly thus fails to build,
because the expectation is no longer fulfilled.

Thus replace the expectation with an `allow`.

[ The errors were:

      error: this lint expectation is unfulfilled
          --> rust/pin-init/src/lib.rs:1279:10
           |
      1279 | #[expect(clippy::let_and_return)]
           |          ^^^^^^^^^^^^^^^^^^^^^^
           |
           = note: `-D unfulfilled-lint-expectations` implied by `-D warnings`
           = help: to override `-D warnings` add `#[allow(unfulfilled_lint_expectations)]`

      error: this lint expectation is unfulfilled
          --> rust/pin-init/src/lib.rs:1295:10
           |
      1295 | #[expect(clippy::let_and_return)]
           |          ^^^^^^^^^^^^^^^^^^^^^^

    - Miguel ]

Link: https://github.com/rust-lang/rust-clippy/pull/16461 [1]
Signed-off-by: Benno Lossin <lossin@kernel.org>
Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
Link: https://patch.msgid.link/20260215132232.1549861-1-lossin@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/pin-init/src/lib.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 8dc9dd5ac6fd3..3da65db9e2dd3 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -1276,13 +1276,13 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 ///
 /// - `*mut U` must be castable to `*mut T` and any value of type `T` written through such a
 ///   pointer must result in a valid `U`.
-#[expect(clippy::let_and_return)]
 pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
     // SAFETY: initialization delegated to a valid initializer. Cast is valid by function safety
     // requirements.
     let res = unsafe { pin_init_from_closure(|ptr: *mut U| init.__pinned_init(ptr.cast::<T>())) };
     // FIXME: remove the let statement once the nightly-MSRV allows it (1.78 otherwise encounters a
     // cycle when computing the type returned by this function)
+    #[allow(clippy::let_and_return)]
     res
 }
 
@@ -1292,13 +1292,13 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 ///
 /// - `*mut U` must be castable to `*mut T` and any value of type `T` written through such a
 ///   pointer must result in a valid `U`.
-#[expect(clippy::let_and_return)]
 pub const unsafe fn cast_init<T, U, E>(init: impl Init<T, E>) -> impl Init<U, E> {
     // SAFETY: initialization delegated to a valid initializer. Cast is valid by function safety
     // requirements.
     let res = unsafe { init_from_closure(|ptr: *mut U| init.__init(ptr.cast::<T>())) };
     // FIXME: remove the let statement once the nightly-MSRV allows it (1.78 otherwise encounters a
     // cycle when computing the type returned by this function)
+    #[allow(clippy::let_and_return)]
     res
 }
 
-- 
2.51.0





