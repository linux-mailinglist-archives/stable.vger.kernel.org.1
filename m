Return-Path: <stable+bounces-254927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLRmL+0tGGqyfQgAu9opvQ
	(envelope-from <stable+bounces-254927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:58:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D85F1B2F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4263F30F2E29
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC283C5522;
	Thu, 28 May 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G6g2w+W0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BF3E5EC7
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969302; cv=none; b=fUusm40liAPjA7GI0vlQwMwClLFDydVzCRkuGZLiiw8LyFy/6la07PwLjanskbGYFakerJmBxOok/A1u6XcF0sUDYVk3kvnme5JajsA0SZn1pD9Sa40WMFMyjwyUzFedAd3OHlwB7Gm5+8P0G3BbKFQ11yYru7cTAqpDwHddacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969302; c=relaxed/simple;
	bh=ddlB0Bp20RfhiSkkn80D3ABeqqFzI+E+u3+ErYBoLAQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RLgrTKx44rOy2d9yPAyHGuilDVB0p8cHPaIc/KzkNRizZS5P9BvraxE54FcO9yrLRHy1Gf5WJqvYnAWHjxxS/YyIrLnsXP+O8We26C9HBqJXd1mSOOW0SAHO84NrQBxhWO05sW2V/dTaXKo0sqPyWpwBO93a6WuWGStZxfcT/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G6g2w+W0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD5A1F000E9;
	Thu, 28 May 2026 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779969300;
	bh=ypcuVxIVXmNhAPFq5oqHOjKKxRlW+cUQuJ4tSlx1aYU=;
	h=Subject:To:Cc:From:Date;
	b=G6g2w+W0q/u8jxk1Y1W8VrmNY3NvbWdHfNmGr+jTQFRGhbpW85fQM1RUZdtBpvb+A
	 ho7y3jZHBEwLPUQbEeZIAac99D7xP6B/xW/LO58O1d9aKkXp/c+pBYJInvEzen6KFe
	 VOml5HcpNR5yON7oNoGCp5PPzFhDV/q3RrBDMol8=
Subject: FAILED: patch "[PATCH] batman-adv: bla: avoid double decrement of bla.num_requests" failed to apply to 5.10-stable tree
To: sven@narfation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:53:56 +0200
Message-ID: <2026052856-hesitate-premium-8982@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254927-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:email,narfation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 005D85F1B2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 83ab69bd12b80f6ea169c8bea6977701b53a043d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052856-hesitate-premium-8982@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83ab69bd12b80f6ea169c8bea6977701b53a043d Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 09:13:31 +0200
Subject: [PATCH] batman-adv: bla: avoid double decrement of bla.num_requests

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

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index df1dfdf4a1a1..1bef12e659cb 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -514,8 +514,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
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
@@ -544,9 +544,13 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
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
@@ -649,10 +653,12 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
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
@@ -873,10 +879,12 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
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
@@ -1255,9 +1263,13 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
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
@@ -1508,7 +1520,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 				batadv_bla_send_loopdetect(bat_priv,
 							   backbone_gw);
 
-			/* request_sent is only set after creation to avoid
+			/* state is only set to unsynced after creation to avoid
 			 * problems when we are not yet known as backbone gw
 			 * in the backbone.
 			 *
@@ -1517,14 +1529,21 @@ static void batadv_bla_periodic_work(struct work_struct *work)
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
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 56ca1c1b83f2..e7aa45bc6b7a 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -787,6 +787,7 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
+	spin_lock_init(&bat_priv->bla.num_requests_lock);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 821ada05d86a..a01ee46d97f3 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1026,6 +1026,12 @@ struct batadv_priv_bla {
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
@@ -1672,6 +1678,27 @@ struct batadv_priv {
 
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
@@ -1697,16 +1724,12 @@ struct batadv_bla_backbone_gw {
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


