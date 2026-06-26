Return-Path: <stable+bounces-269068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ItxdDIOlPmpFJgkAu9opvQ
	(envelope-from <stable+bounces-269068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:14:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F76CEDB2
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:14:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YftuBvtH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269068-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269068-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A9D130D0D75
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4073F824B;
	Fri, 26 Jun 2026 16:11:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F433993
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490290; cv=none; b=Mjt7qBjWGCjBAi0JoI3X7oEBBjXViiTC0NOinvsD2BaUdjBU/d2r8npOG6nVJtZZbzRk6A//jfjhduPqcMFU9CN7jJfs3erHq6Xf74fOCGV/IJdSiaeYiyJgY5NfNe96WRgmZ6BUY0Hw3QgABRpHHPwXzigNgjVHerek10baE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490290; c=relaxed/simple;
	bh=aSdsrK2/6a/tNUU7dv+thMORcs0EFDtVnYZbVyz9odg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJMfA6IHraltjE/lepVKR/9WjBJ2AuoHXfGeSNe9jmFLjhZIUe7rcuIJicstQX3uvbAdN5d04lVbyxaEhvw5Pwkc5XKC9kmSszHaAgVcTEHnuTVUOmCJD0BG2Ne/bjj1kt70kD5Qb2Kq6k28pyi29Y7K0PP/0t0ELFOM8O9toBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=YftuBvtH; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id E3FD3202D1;
	Fri, 26 Jun 2026 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDgUNjA2JtgMoIFe0i2GTqIOE3nTZk6bP7m5K0wZj0w=;
	b=YftuBvtHqI/ipw9OyA6B0BBOrnv3IuOi5dFiuGNh7qT3a8oV4/hap80a8V9BkEnHHNIQiq
	QL3Ly/eNLPe5cbMxmk1dQrpkAG6vdN6+qdkzEduyd6rS5ZZWsf7Q88bsAIpgAurXpAn2bm
	aHF3IrmC0/15HhfRoWF54+92HdMMEok=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 08/25] batman-adv: tp_meter: add only finished tp_vars to lists
Date: Fri, 26 Jun 2026 18:11:06 +0200
Message-ID: <20260626161123.124273-9-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269068-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 962F76CEDB2

commit 15ccbf685222274f5add1387af58c2a41a95f81e upstream.

When the receiver variables (aka "session") are initialized, then they are
added to the list of sessions before the timer is set up. A RCU protected
reader could therefore find the entry and run mod_setup before
batadv_tp_init_recv() finished the timer initialization.

The same is true for batadv_tp_start(), which must first initialize the
finish_work and the test_length to avoid a similar problem.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 089ac7cc9fbeb..2bba53fc6da5c 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1096,21 +1096,21 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->prerandom_offset = 0;
 	spin_lock_init(&tp_vars->prerandom_lock);
 
-	kref_get(&tp_vars->refcount);
-	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
-	spin_unlock_bh(&bat_priv->tp_list_lock);
-
 	tp_vars->test_length = test_length;
 	if (!tp_vars->test_length)
 		tp_vars->test_length = BATADV_TP_DEF_TEST_LENGTH;
 
+	/* init work item for finished tp tests */
+	INIT_DELAYED_WORK(&tp_vars->finish_work, batadv_tp_sender_finish);
+
+	kref_get(&tp_vars->refcount);
+	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
+	spin_unlock_bh(&bat_priv->tp_list_lock);
+
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: starting throughput meter towards %pM (length=%ums)\n",
 		   dst, test_length);
 
-	/* init work item for finished tp tests */
-	INIT_DELAYED_WORK(&tp_vars->finish_work, batadv_tp_sender_finish);
-
 	/* start tp kthread. This way the write() call issued from userspace can
 	 * happily return and avoid to block
 	 */
@@ -1430,10 +1430,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	INIT_LIST_HEAD(&tp_vars->unacked_list);
 
 	kref_get(&tp_vars->refcount);
-	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
+	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
 
 	kref_get(&tp_vars->refcount);
-	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
+	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
 
 	batadv_tp_reset_receiver_timer(tp_vars);
 
-- 
2.47.3


