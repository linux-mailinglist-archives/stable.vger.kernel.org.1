Return-Path: <stable+bounces-271256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NdEgAiuaRmpaZwsAu9opvQ
	(envelope-from <stable+bounces-271256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:04:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA06FAF22
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=TEuTzY8d;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271256-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271256-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28DCB316A216
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE813331EB7;
	Thu,  2 Jul 2026 16:51:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13CF82866;
	Thu,  2 Jul 2026 16:51:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011071; cv=none; b=qud7S0hPi+N4bZI4m7bBkJt9u0+WmAF+0IJireP4zjQkd/6Qx/H7aOoNsrdZ9BpaPI/krwihwZID6NPbBUPhuxMP4zXgqnX1cRCFemMdgQIXbEHqIoFrBhUstoJUkTkEW1FLVWc8WCsao/rvfYMCxaKM9VkvBZmm9L6Yjoq+Je0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011071; c=relaxed/simple;
	bh=GyXz0CnoalnnWKlFJT1dvxp9N5/+PyLNWCxFIZQ2ObE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gokxPCfvxVBGjWu5Yfx69XGazCaKimUVO/Uhf5ircBiKIDF2XKQ2N0nBzGqUysa9cnSW439yzH7oCqkClAIQOySypjQnGqH+I0ntEiH71/aY44IucueCqghdT7RQhRg4pLZE2ngx2cmQ+mYxFYS7YynxM3tGtsUM2Yi2KrXFsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TEuTzY8d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327FF1F000E9;
	Thu,  2 Jul 2026 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011070;
	bh=MZJbXExgMIIAHMlHqQDXz8VJ0/DJXT/0gO9jb+Pok/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEuTzY8d2m9kNAB0Ep/S8P8JZg9Jelh2VcapwtTTezd+NX8sUx/PpPYm4vhuXpga9
	 vUXD4zwijDC1SL06vBf6dKogac8X1wjyGdKf3paJ3Mb/yu3a6sX3PpgNwEIjYxdYh/
	 rMFga3usjJX94lBaVWUFLIiczW+iCkQBLvi2/+JI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 101/175] batman-adv: tp_meter: initialize last_recv_time during init
Date: Thu,  2 Jul 2026 18:20:02 +0200
Message-ID: <20260702155117.897664665@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271256-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69EA06FAF22

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 811cb00fa8cdc3f0a7f6eefc000a6888367c8c8f upstream.

The last_recv_time is the most important indicator for a receiver session
to figure out whether a session timed out or not. But this information was
only initialized after the session was added to the tp_receiver_list and
after the timer was started.

In the worst case, the timer (function) could have tried to access this
information before the actual initialization was reached. Like rest of the
variables of the tp_meter receiver session, this field has to be filled out
before any other (parallel running) context has the chance to access it.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/tp_meter.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 2bba53fc6da5c0..133eed2fa9507f 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1403,8 +1403,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
 					      icmp->session, BATADV_TP_RECEIVER);
-	if (tp_vars)
+	if (tp_vars) {
+		tp_vars->last_recv_time = jiffies;
 		goto out_unlock;
+	}
 
 	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM)) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
@@ -1432,6 +1434,8 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	kref_get(&tp_vars->refcount);
 	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
 
+	tp_vars->last_recv_time = jiffies;
+
 	kref_get(&tp_vars->refcount);
 	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
 
@@ -1480,9 +1484,9 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 				   icmp->orig);
 			goto out;
 		}
-	}
 
-	tp_vars->last_recv_time = jiffies;
+		tp_vars->last_recv_time = jiffies;
+	}
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
-- 
2.53.0




