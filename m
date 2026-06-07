Return-Path: <stable+bounces-261317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VUMFHB9JJWpxGAIAu9opvQ
	(envelope-from <stable+bounces-261317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DD64FCBA
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BkXpzY8D;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261317-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261317-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B093C3054F71
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211431E832;
	Sun,  7 Jun 2026 10:28:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AD326951;
	Sun,  7 Jun 2026 10:28:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828087; cv=none; b=ZArRh4ZIKOZZ3bIrBGXsKyzXyqII/cjB9LDzsn30/WlH+yxRUSfD2+IPctXQT3T/Cd3lkheTQsKmZlFNG7XK8DwSrTYUqhMwNtPlJIXcNZMh7710R6SUqoYd7VhVKlgMOYU854EGvT4a/JP8NuLSw9wIWMN49m7C1GhgNufHt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828087; c=relaxed/simple;
	bh=rjR2ESKyhJFW8CCgE3cqCuDsVU5qEEUIub9o3b7GK8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcECkoDjC2CWoTc94570hpsKJPZ8KMFS7v5JtdfUvP62jboaxwRQ2bC6FysBhvgCp8P5jX8F4WQIU8AODMKh2ohyc1Irk+u6wDRcC+akMRqijo39xDxMd0GwBc5Usp2NI0tGZ1bgD9t2O3wcl2kV5Cl0rMNVItzDVH+XZu6a+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkXpzY8D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040A01F00893;
	Sun,  7 Jun 2026 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828086;
	bh=P0ar7ynTHgkUi46b6EvdHHBTvuCSZg55+ieRiVHi8Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkXpzY8D071gZZ6ZZoWGcvocICg4IKkG0OvmAPkKqnjTPr4YLzbvMPGbP3Crmz69X
	 wwf141OoFj0s3sTsTPwIj1S6Rs+Es5CKEGaxFylwBZ702f0kqferCxl9fK24UlsjWe
	 1ifB52Mi9SA8k3j3Po0O59RLsetezYzaHQ6mFPoc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Bilal <meatuni001@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 7.0 150/332] Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock
Date: Sun,  7 Jun 2026 11:58:39 +0200
Message-ID: <20260607095733.600147403@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261317-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:meatuni001@gmail.com,m:luiz.von.dentz@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F37DD64FCBA

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Bilal <meatuni001@gmail.com>

commit 4b5f8e608749b7e8fa386c6e4301cf9272595859 upstream.

iso_sock_close() calls iso_sock_clear_timer() before acquiring
lock_sock(sk).

iso_sock_clear_timer() reads iso_pi(sk)->conn twice without the
socket lock held:

    if (!iso_pi(sk)->conn)
        return;
    cancel_delayed_work(&iso_pi(sk)->conn->timeout_work);

Concurrently, iso_conn_del() executes under lock_sock(sk) and calls
iso_chan_del(), which sets iso_pi(sk)->conn to NULL and may result in
the final reference to the connection being dropped:

    CPU0                         CPU1
    ----                         ----
    iso_sock_clear_timer()
      if (conn != NULL) ...      lock_sock(sk)
                                   iso_chan_del()
                                   iso_pi(sk)->conn = NULL
      cancel_delayed_work(conn)  /* NULL deref or UAF */

iso_pi(sk)->conn is not stable across the unlock window, causing a
NULL pointer dereference or use-after-free.

Serialize iso_sock_clear_timer() with the socket lock by moving it
inside lock_sock()/release_sock(), matching the pattern used in
iso_conn_del() and all other call sites.

Fixes: ccf74f2390d60a2f9a75ef496d2564abb478f46a ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/iso.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -872,8 +872,8 @@ static void __iso_sock_close(struct sock
 /* Must be called on unlocked socket. */
 static void iso_sock_close(struct sock *sk)
 {
-	iso_sock_clear_timer(sk);
 	lock_sock(sk);
+	iso_sock_clear_timer(sk);
 	__iso_sock_close(sk);
 	release_sock(sk);
 	iso_sock_kill(sk);



