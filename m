Return-Path: <stable+bounces-256770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG8PNXP1GWp/0AgAu9opvQ
	(envelope-from <stable+bounces-256770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:22:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5210A60875B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 313F2313832D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955453451B5;
	Fri, 29 May 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="e4W5eEzF"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396B332628
	for <stable@vger.kernel.org>; Fri, 29 May 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085300; cv=none; b=lI9AOQGtptW91xnic1uGzp300ebNYn5dM8Yo8bYGttTRWWeJc9YWfUZvVDq1ksXtb5u/MgJYXi+jIsaghAFulCd8rY8Hl65TxJdDoQtOx1csZXzC+yVeszVgcKs0BX3aJfaRsFUzDdtYugYx1maHhoGdG3hUnIeVRptqcYlPc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085300; c=relaxed/simple;
	bh=Z9XWkIHNGADeUZMKjX6eE8AZ3w0h8BCvNjrd/uatWAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9ak5b1zA/WqT7Nffk0PLqRjdF0hfv5xz9EE5+oWKD3mTlXZ5YHkrtx3z0RvBKpTtGAl8Ie9bwHxdw74AApFnJ4Rdf1vB7KwYYnVQ63QQdNhMO4sms88+F2ENMubs4UAtmofaGP+EyQYKYJOfT8ynKXUEJfhjeYoR9Q5lXZVMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=e4W5eEzF; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 473E91FFF5;
	Fri, 29 May 2026 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780085297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w345XCE416c/NSsTK/b6jCk8FED98T1KNLF6rrAgDqk=;
	b=e4W5eEzFcLvs1tC4hf9gy/H4AT6KWeuft25mmrPV/+XfPI1QMBETHUC2cVSOUXgyuz5qAK
	lgNkgCVTjeEvI8ZRPyeMZwGJirYJIsBg7i8I99oo4Qv0GCLgI6X1h3APjcZgrZTxwOAwqs
	BIOiH9UQvqZxDBLlSySvmLwoTtEQia8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: [PATCH 5.15.y] batman-adv: bla: avoid double decrement of bla.num_requests
Date: Fri, 29 May 2026 22:08:08 +0200
Message-ID: <20260529200808.478271-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026052855-penny-duckbill-07bc@gregkh>
References: <2026052855-penny-duckbill-07bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256770-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,narfation.org:email,narfation.org:mid,narfation.org:dkim]
X-Rspamd-Queue-Id: 5210A60875B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 83ab69bd12b80f6ea169c8bea6977701b53a043d upstream.

The bla.num_requests is increased when no request_sent was in progress. And
it is decremented in various places (announcement was received, backbone is
purged, periodic work). But the check if the request_sent is actually set
to a specific state and the atomic_dec/_inc are not safe because they are
not atomic (TOCTOU) and multiple such code portions can run concurrently.

At the same time, it is necessary to modify request_sent (state) and
bla.num_requests atomically. Otherwise batadv_bla_send_request() might set
request_sent to 1 and is interrupted.  batadv_handle_announce() can then
set request_sent back to 0 and decrement num_requests before
batadv_bla_send_request() incremented it.

The two operations must therefore be locked. And since state (request_sent)
and wait_periods are only accessed inside this lock, they can be converted
to simpler datatypes. And to avoid that the bla.num_requests is touched by
a parallel running context with a valid backbone_gw reference after
batadv_bla_purge_backbone_gw() ran, a third state "stopped" is required to
correctly signal that a backbone_gw is in the state of being cleaned up.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 51 ++++++++++++++++++--------
 net/batman-adv/soft-interface.c        |  1 +
 net/batman-adv/types.h                 | 39 ++++++++++++++++----
 3 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f768a4e0bc0f4..92c9679f38437 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -513,8 +513,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
 	spin_lock_init(&entry->crc_lock);
-	atomic_set(&entry->request_sent, 0);
-	atomic_set(&entry->wait_periods, 0);
+	entry->state = BATADV_BLA_BACKBONE_GW_SYNCED;
+	entry->wait_periods = 0;
 	ether_addr_copy(entry->orig, orig);
 	INIT_WORK(&entry->report_work, batadv_bla_loopdetect_report);
 	kref_init(&entry->refcount);
@@ -543,9 +543,13 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 		batadv_bla_send_announce(bat_priv, entry);
 
 		/* this will be decreased in the worker thread */
-		atomic_inc(&entry->request_sent);
-		atomic_set(&entry->wait_periods, BATADV_BLA_WAIT_PERIODS);
-		atomic_inc(&bat_priv->bla.num_requests);
+		spin_lock_bh(&bat_priv->bla.num_requests_lock);
+		if (entry->state == BATADV_BLA_BACKBONE_GW_SYNCED) {
+			entry->state = BATADV_BLA_BACKBONE_GW_UNSYNCED;
+			entry->wait_periods = BATADV_BLA_WAIT_PERIODS;
+			atomic_inc(&bat_priv->bla.num_requests);
+		}
+		spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 	}
 
 	return entry;
@@ -648,10 +652,12 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 			      backbone_gw->vid, BATADV_CLAIM_TYPE_REQUEST);
 
 	/* no local broadcasts should be sent or received, for now. */
-	if (!atomic_read(&backbone_gw->request_sent)) {
+	spin_lock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
+	if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_SYNCED) {
+		backbone_gw->state = BATADV_BLA_BACKBONE_GW_UNSYNCED;
 		atomic_inc(&backbone_gw->bat_priv->bla.num_requests);
-		atomic_set(&backbone_gw->request_sent, 1);
 	}
+	spin_unlock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
 }
 
 /**
@@ -872,10 +878,12 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		/* if we have sent a request and the crc was OK,
 		 * we can allow traffic again.
 		 */
-		if (atomic_read(&backbone_gw->request_sent)) {
+		spin_lock_bh(&bat_priv->bla.num_requests_lock);
+		if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_UNSYNCED) {
+			backbone_gw->state = BATADV_BLA_BACKBONE_GW_SYNCED;
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
 		}
+		spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 	}
 
 	batadv_backbone_gw_put(backbone_gw);
@@ -1254,9 +1262,13 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 				purged = true;
 
 				/* don't wait for the pending request anymore */
-				if (atomic_read(&backbone_gw->request_sent))
+				spin_lock_bh(&bat_priv->bla.num_requests_lock);
+				if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_UNSYNCED)
 					atomic_dec(&bat_priv->bla.num_requests);
 
+				backbone_gw->state = BATADV_BLA_BACKBONE_GW_STOPPED;
+				spin_unlock_bh(&bat_priv->bla.num_requests_lock);
+
 				batadv_bla_del_backbone_claims(backbone_gw);
 
 				hlist_del_rcu(&backbone_gw->hash_entry);
@@ -1507,7 +1519,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 				batadv_bla_send_loopdetect(bat_priv,
 							   backbone_gw);
 
-			/* request_sent is only set after creation to avoid
+			/* state is only set to unsynced after creation to avoid
 			 * problems when we are not yet known as backbone gw
 			 * in the backbone.
 			 *
@@ -1516,14 +1528,21 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 			 * some grace time.
 			 */
 
-			if (atomic_read(&backbone_gw->request_sent) == 0)
-				continue;
+			spin_lock_bh(&bat_priv->bla.num_requests_lock);
+			if (backbone_gw->state != BATADV_BLA_BACKBONE_GW_UNSYNCED)
+				goto unlock_next;
 
-			if (!atomic_dec_and_test(&backbone_gw->wait_periods))
-				continue;
+			if (backbone_gw->wait_periods > 0)
+				backbone_gw->wait_periods--;
 
+			if (backbone_gw->wait_periods > 0)
+				goto unlock_next;
+
+			backbone_gw->state = BATADV_BLA_BACKBONE_GW_SYNCED;
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
+
+unlock_next:
+			spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index bff86ccadc2cc..b46480ec7bd1d 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -785,6 +785,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
+	spin_lock_init(&bat_priv->bla.num_requests_lock);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index dc589ffbee297..f1a835edd115c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1027,6 +1027,12 @@ struct batadv_priv_bla {
 	/** @num_requests: number of bla requests in flight */
 	atomic_t num_requests;
 
+	/**
+	 * @num_requests_lock: locks update num_requests +
+	 * batadv_backbone_gw::state + batadv_backbone_gw::wait_periods update
+	 */
+	spinlock_t num_requests_lock;
+
 	/**
 	 * @claim_hash: hash table containing mesh nodes this host has claimed
 	 */
@@ -1794,6 +1800,27 @@ struct batadv_socket_packet {
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 
+enum batadv_bla_backbone_gw_state {
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_STOPPED: backbone gw is being removed
+	 * and it must not longer work on requests
+	 */
+	BATADV_BLA_BACKBONE_GW_STOPPED,
+
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_UNSYNCED: backbone was detected out
+	 * of sync and a request was send. No traffic is forwarded until the
+	 * situation is resolved
+	 */
+	BATADV_BLA_BACKBONE_GW_UNSYNCED,
+
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_SYNCED: backbone is consider to be in
+	 * sync. traffic can be forwarded
+	 */
+	BATADV_BLA_BACKBONE_GW_SYNCED,
+};
+
 /**
  * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
  */
@@ -1819,16 +1846,12 @@ struct batadv_bla_backbone_gw {
 	/**
 	 * @wait_periods: grace time for bridge forward delays and bla group
 	 *  forming at bootup phase - no bcast traffic is formwared until it has
-	 *  elapsed
+	 *  elapsed. Must only be access with num_requests_lock.
 	 */
-	atomic_t wait_periods;
+	u8 wait_periods;
 
-	/**
-	 * @request_sent: if this bool is set to true we are out of sync with
-	 *  this backbone gateway - no bcast traffic is formwared until the
-	 *  situation was resolved
-	 */
-	atomic_t request_sent;
+	/** @state: sync state. Must only be access with num_requests_lock. */
+	enum batadv_bla_backbone_gw_state state;
 
 	/** @crc: crc16 checksum over all claims */
 	u16 crc;
-- 
2.47.3


