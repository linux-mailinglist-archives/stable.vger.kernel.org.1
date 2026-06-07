Return-Path: <stable+bounces-261349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PXoQCzhIJWrlFwIAu9opvQ
	(envelope-from <stable+bounces-261349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:30:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792864FB86
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:30:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=piOVVPYp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261349-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261349-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8036F3001F88
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8731E842;
	Sun,  7 Jun 2026 10:30:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1FE328B56;
	Sun,  7 Jun 2026 10:30:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828208; cv=none; b=JIzjF/VIHGaf7Ro63FzCVC6730SoW0tos3+OpeellBLtgi+vJoOmKEas/3/nfyISdh4exUE+EWGKf4FdUBCp8FRRzKbPTup3SeByn7ZXUiGc3PvSN/kYdISVo/NpB3cViqB2xtmWN1mkVLAZCLsXI5pKaWj4yRoh8f8WnTJJ+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828208; c=relaxed/simple;
	bh=2NNiiAPKeUoo+VlcEtRtIWazth0MHgBbU+g91Q6CT/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe1G07j5njO+ZqhmBUVlHDljT+MHTM/P/A+C7ZsXOs0w8D+ue+TdhzEYNbc72dI18g5ld2a14jD+rFhrQN9Hp9du+m+W5gMqIYJ3TXbr9+wx+79aWWX8ljspp5tgOc2ESPP7oHK6OrRiYMipYCdQknHqh3uFQmaoxY4QzpeUj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=piOVVPYp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9211F00893;
	Sun,  7 Jun 2026 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828207;
	bh=tFMnrzUnQx57ItrtXcuoqdHLm+hMeHZYPEbauvyzjN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=piOVVPYpa4+kIJCCkH52OiF1/3Ys40EZYKclw63sLKAfZ7EdKn68D852SNAStT/HT
	 i1ZF9a9TXjgTbriAsI/V12I45Fvx82iu5skUtEnNwBf5/jnP1ip+SN4NKr+YdEt4Ch
	 9vPPw388tHSkxRvxhugrVu0I68xPbJO5SLWdnDpU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Stevens <stevensd@google.com>,
	Matthew Maurer <mmaurer@google.com>,
	stable <stable@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Carlos Llamas <cmllamas@google.com>
Subject: [PATCH 7.0 156/332] rust_binder: Avoid holding lock when dropping delivered_death
Date: Sun,  7 Jun 2026 11:58:45 +0200
Message-ID: <20260607095733.812569932@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261349-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stevensd@google.com,m:mmaurer@google.com,m:stable@kernel.org,m:aliceryhl@google.com,m:cmllamas@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2792864FB86

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1402,7 +1402,12 @@ impl Process {
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
 



