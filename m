Return-Path: <stable+bounces-261341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9izAASpIJWraFwIAu9opvQ
	(envelope-from <stable+bounces-261341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:30:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1EF64FB67
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:30:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lpPbYtm8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261341-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261341-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CA413004698
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8C2EEE76;
	Sun,  7 Jun 2026 10:29:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300DA4071E3;
	Sun,  7 Jun 2026 10:29:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828178; cv=none; b=Y1NeOc7HqFkUkNRo6Idbo8tCtmtUpHSv7JMH/SQaQapZW1ocZFVnCU9HaDOW7HQVuJdayB71aJwp15RkVD2Uz0ryPMt98iyUvGNwAJtm/Esik5pibThhA6w7jze5nye4ZzgFgPZbfVBTN7GQZNHeO74LEdsoh141GlhHTPSo2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828178; c=relaxed/simple;
	bh=OyqxCUvIM7lqLKg6h0iChMLbaR7O78h7yYopTG1PfGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAJ1+/+X9BDGufCRN5HRXfB3BEeXtB3NU9bS8O4Rq4OJF4sblvIrO1rlrCEsdPnXbP/F7BLdMhMwhwVaMaoJonhDsGAZ0f512cBBO/OBScmeCovSS6Dtn6g0EOWQ926N6cnKnFn9tTRFwxDDwcG0xM81H4qTGAdjYk/JbmE7DHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lpPbYtm8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B86E1F00893;
	Sun,  7 Jun 2026 10:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828177;
	bh=hx7AwKF8bQTtZq1lKzzKum8xu0Kl2CV5YXIWpOzeAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpPbYtm85ZI0vuhnMkxcKJ0j73PCzoAsEgmZnJYQS9/hdOmj0arjTFzSAIWRp3R0n
	 7UZ1mELktC6BjWjINNmV2SKozTK6WQYzmOYo5BZtl0kAeTUjqXZ8ACrUnsKL8+hTXK
	 UiKxEk+pAjdrvaaBSIWg6zO8h7ucUhZopKGuJBBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Stevens <stevensd@google.com>,
	Matthew Maurer <mmaurer@google.com>,
	stable <stable@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Carlos Llamas <cmllamas@google.com>
Subject: [PATCH 6.18 138/315] rust_binder: Avoid holding lock when dropping delivered_death
Date: Sun,  7 Jun 2026 11:58:45 +0200
Message-ID: <20260607095732.674036613@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261341-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stevensd@google.com,m:mmaurer@google.com,m:stable@kernel.org,m:aliceryhl@google.com,m:cmllamas@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C1EF64FB67

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Maurer <mmaurer@google.com>

commit f6d8fea9e3953151a4adb4f603503dc3dc9c69da upstream.

In 6c37bebd8c926, we switched to looping over the list and dropping each
individual node, ostensibly without the lock held in the loop body.

If the kernel were using Rust Edition 2024, the comment would be
accurate, and the lock would not be held across the drop. However, the
kernel is currently using 2021, so tail expression lifetime extension
results in the lock being held across the drop. Explicitly binding the
expression result to a variable makes the lockguard no longer part of a
tail expression, causing the lock to be dropped before entering the loop
body.

This was detected via `CONFIG_PROVE_LOCKING` identifying an invalid wait
context at the drop site.

Reported-by: David Stevens <stevensd@google.com>
Signed-off-by: Matthew Maurer <mmaurer@google.com>
Cc: stable <stable@kernel.org>
Fixes: 6c37bebd8c92 ("rust_binder: avoid mem::take on delivered_deaths")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
Link: https://patch.msgid.link/20260403-lockhold-v1-1-c332b56cd8ae@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder/process.rs |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1366,7 +1366,12 @@ impl Process {
         // Clear delivered_deaths list.
         //
         // Scope ensures that MutexGuard is dropped while executing the body.
-        while let Some(delivered_death) = { self.inner.lock().delivered_deaths.pop_front() } {
+        while let Some(delivered_death) = {
+            // Explicitly bind to avoid tail expression lifetime extension of the lockguard
+            // Can be removed when the kernel moves to edition 2024
+            let maybe_death = self.inner.lock().delivered_deaths.pop_front();
+            maybe_death
+        } {
             drop(delivered_death);
         }
 



