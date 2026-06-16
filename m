Return-Path: <stable+bounces-265360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JCO9AfeIMWq0lwUAu9opvQ
	(envelope-from <stable+bounces-265360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:33:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215969340C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:33:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fMvlH0MQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265360-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265360-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78F5C302601A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17BE47A0B0;
	Tue, 16 Jun 2026 17:26:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A2305688;
	Tue, 16 Jun 2026 17:26:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630803; cv=none; b=mhJ4qmj55yRAHKPUfQDS0YoeHqH8aNQnKSl9DShmNI4Fy0YYtyCuFdzwS9u59wqMUEb9d480g82ParoZ/43Y1JE38Flg4Yvce4vBFLr/k6T1ZKAs1r02zrjwbsKbCBuY0AKWIWkxBkTGYuijbfIDTe1dJRULW2YAQzQjQ8Fh/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630803; c=relaxed/simple;
	bh=hK1xlJ4w140PhK6Ow/OsKY6jyZYnVJ+FSi9ssrR9UuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyK+32RXEfl2P4oMyuge45kkSvl3cQyKz1K30KLojdQ75Zdc0UxVlj8qvitwWevBEbSKV/3Y2W59r1rf6ZWup3rtwJFRUwhx5PXu59QXYjtawJq38k355RXfnbSxUPCYt24hMw83D8qf3qKstx5bbwU6EN8YZFixq13sZ+uGQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fMvlH0MQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F801F000E9;
	Tue, 16 Jun 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630802;
	bh=OHTRMb3t7KHU2151NMnM1KYTcGpjEXLLExL3ASqks1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMvlH0MQPlEstx0uBVAcG0LFkzrPRFs6BC/AvIrerz1EvMD9Mv5Teil+gQtdk6eaN
	 ozaw/Dxs2pNOJ3xJSTgmEN9arYWhrbOYR6A6tPWVZFywqEed82xG2ZLgZcsMmGf5S+
	 KwjOLxem4TtnorjDRrIxhN1oujWG+QTJND0/lB84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Bilal <meatuni001@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 098/522] Bluetooth: ISO: fix UAF in iso_recv_frame
Date: Tue, 16 Jun 2026 20:24:05 +0530
Message-ID: <20260616145130.486431290@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265360-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:meatuni001@gmail.com,m:luiz.von.dentz@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1215969340C

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Bilal <meatuni001@gmail.com>

commit 47f23a259517abbdb8032c057a1e8a6bf3734878 upstream.

iso_recv_frame reads conn->sk under iso_conn_lock but releases the lock
before using sk, with no reference held. A concurrent iso_sock_kill()
can free sk in that window, causing use-after-free on sk->sk_state and
sock_queue_rcv_skb().

Fix by replacing the bare pointer read with iso_sock_hold(conn), which
calls sock_hold() while the spinlock is held, atomically elevating the
refcount before the lock drops. Add a drop_put label so sock_put() is
called on all exit paths where the hold succeeded.

Fixes: ccf74f2390d60a2f9a75ef496d2564abb478f46a ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/iso.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -445,7 +445,7 @@ static void iso_recv_frame(struct iso_co
 	struct sock *sk;
 
 	iso_conn_lock(conn);
-	sk = conn->sk;
+	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
 	if (!sk)
@@ -454,11 +454,15 @@ static void iso_recv_frame(struct iso_co
 	BT_DBG("sk %p len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
-		goto drop;
+		goto drop_put;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sock_queue_rcv_skb(sk, skb)) {
+		sock_put(sk);
 		return;
+	}
 
+drop_put:
+	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }



