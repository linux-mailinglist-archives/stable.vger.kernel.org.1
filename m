Return-Path: <stable+bounces-269024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B3TAF4OkPmrfJQkAu9opvQ
	(envelope-from <stable+bounces-269024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:10:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFB56CECA2
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:10:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Ih7v5T3k;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269024-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269024-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E90F301F48A
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1C3F9F5C;
	Fri, 26 Jun 2026 16:10:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945CD3FAE19
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490219; cv=none; b=G0WOSly7ZUc+7oqWXwlPXTVuMkr1QcPze41r+2VgvLrxTCnAUltTLn8RBqVonAJuyTky6I/P9ka7BhsrL9Rt7l4ZMqJiQ0psNV4TeaBhA05wr98LVTla8Ihg5Wafm3YZBvy6WQLv/6CR6Pl7WcG3OH8DgneefSMTDSDzhlbqFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490219; c=relaxed/simple;
	bh=bNo82UxX3001eIpnirj+Og2LD41TP2wPQLAyQtr4wu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMusrp2yZIr5lhM9/DCO+t2zWRrPJXaEZgZ2baGQW3gwfoBhQSu3KI+2yOSkiBdMfqDuD5kZsg1dmeXGRbpEXCx7L1+cF77SQUCKucyuARyI95hRhrs+QYcab7393NncNAaFwHwCoOeNb3kS3tcNJPLo6v1ZEuxOEjRaXZ0gD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Ih7v5T3k; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id CAD462059B;
	Fri, 26 Jun 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOJANbmYHEhtjdVlcdlslLUj4fEfbSwK2KBH7SstuG8=;
	b=Ih7v5T3kprr186rBwKjUWY3yWOFqIH0VbZSsv5dFlhN5eLogXzFTzLx4OXB7FsEbdYf4lL
	7YobTZzJxuKFLkn+xeqVytOujZxWLnW6UF2xxdT2FlNr6rgGGAHqNOkFRhaKUJBbOFc/tx
	x907k/9noSr6jUE8Xd+2hz/wwwzS9OY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 15/23] batman-adv: tp_meter: restrict number of unacked list entries
Date: Fri, 26 Jun 2026 18:09:44 +0200
Message-ID: <20260626160952.123713-16-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626160952.123713-1-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org>
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
	TAGGED_FROM(0.00)[bounces-269024-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: BEFB56CECA2

commit e7c775110e1858e5a7471a23a9c9658c0af9df89 upstream.

When the unacked_list is unbound, an attacker could send messages with
small lengths and appropriated seqno + gaps to force the receiver to
allocate more and more unacked_list entries. And the end either causing an
out-of-memory situation or increase the management overhead for the (large)
list that significant portions of CPU cycles are wasted in searching
through the list.

When limiting the list to a specific number, it is important to still
correctly add a new entry to the list. But if the list became larger than
the limit, the last entry of the list (with the highest seqno) must be
dropped to still allow the earlier seqnos to finish and therefore to
continue the process. Otherwise, the process might get stuck with too high
seqnos which are not handled by batadv_tp_ack_unordered().

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Switch to pre-splitted tp_vars structure names ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 23 ++++++++++++++++++++++-
 net/batman-adv/types.h    |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ea5640242ddc2..c7de8dfe9b65b 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -86,6 +86,11 @@
 #define BATADV_TP_PLEN (BATADV_TP_PACKET_LEN - ETH_HLEN - \
 			sizeof(struct batadv_unicast_packet))
 
+/**
+ * BATADV_TP_MAX_UNACKED - maximum number of packets a receiver didn't yet ack
+ */
+#define BATADV_TP_MAX_UNACKED 100
+
 static u8 batadv_tp_prerandom[4096] __read_mostly;
 
 /**
@@ -1205,6 +1210,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
+		tp_vars->unacked_count--;
 	}
 	spin_unlock_bh(&tp_vars->unacked_lock);
 
@@ -1317,6 +1323,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 	/* if the list is empty immediately attach this new object */
 	if (list_empty(&tp_vars->unacked_list)) {
 		list_add(&new->list, &tp_vars->unacked_list);
+		tp_vars->unacked_count++;
 		goto out;
 	}
 
@@ -1347,12 +1354,24 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		 */
 		list_add(&new->list, &un->list);
 		added = true;
+		tp_vars->unacked_count++;
 		break;
 	}
 
 	/* received packet with smallest seqno out of order; add it to front */
-	if (!added)
+	if (!added) {
 		list_add(&new->list, &tp_vars->unacked_list);
+		tp_vars->unacked_count++;
+	}
+
+	/* remove the last (biggest) unacked seqno when list is too large */
+	if (tp_vars->unacked_count > BATADV_TP_MAX_UNACKED) {
+		un = list_last_entry(&tp_vars->unacked_list,
+				     struct batadv_tp_unacked, list);
+		list_del(&un->list);
+		kfree(un);
+		tp_vars->unacked_count--;
+	}
 
 out:
 	spin_unlock_bh(&tp_vars->unacked_lock);
@@ -1389,6 +1408,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 
 		list_del(&un->list);
 		kfree(un);
+		tp_vars->unacked_count--;
 	}
 	spin_unlock_bh(&tp_vars->unacked_lock);
 }
@@ -1438,6 +1458,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	spin_lock_init(&tp_vars->unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->unacked_list);
+	tp_vars->unacked_count = 0;
 
 	kref_get(&tp_vars->refcount);
 	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 28f239421f74a..b12b0851df6e7 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1508,6 +1508,9 @@ struct batadv_tp_vars {
 	/** @unacked_lock: protect unacked_list */
 	spinlock_t unacked_lock;
 
+	/** @unacked_count: number of unacked entries */
+	size_t unacked_count;
+
 	/** @last_recv_time: time (jiffies) a msg was received */
 	unsigned long last_recv_time;
 
-- 
2.47.3


