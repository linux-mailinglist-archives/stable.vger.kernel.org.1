Return-Path: <stable+bounces-118323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62BA3C809
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 19:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACC5177F00
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77053214A7F;
	Wed, 19 Feb 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="htH3ICmW"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FD1E4AB
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991338; cv=none; b=TzKH2/bjr/cy3l7o9b6Y2dCxBpR3oRSYnovOg/f71ApcogCn9K0VPvloS7viGfUt5zCikKaZZAshHSzy3mqK4kY484K/IwME4hRAe1CDAsFyGCYwYeY0VOxIiZGvvPs7sAd/QC7fg/abDaJQ+QIG6xVQyCFsp8D8FQlxON5Yb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991338; c=relaxed/simple;
	bh=DjGi9xU+SlcrCCiYt1eFuU26AbeIjiKSJJeG+mIZJS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3qtaPqySsgxHIrG/Fa+tbNdKl9wm2NzNpCGGMPn/1VYFYRd11trQHZFIVGglr2btGdmwtC0duSdSvJnF+SwrAdfGo07GUpalx6oSp33AouLRc18ruSoFPrhS51snPNUVX4YH66FCCLPB18eGr53jNvyOh4b6sTuduhv6oi/Wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=htH3ICmW; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1739991332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkSDYqbsDjMBOdsSitOx2gZBd1JcCdfz0D+iWZI5Vh0=;
	b=htH3ICmWTOsdtzCyTCxI2rOFpn1X2xQMDw3f6filMhSLIc7P7bxnVwL/z8RZ/12tg75XXp
	w0xZr+TXi7CN6vEUIOTPwwYd7llJ1cyoDy0XnZEOKrmNhUx7ov1wu+VxTrroBYj+nq699b
	2QKlNCQMWL/e9xgs9KcJClUh3FyP8NI=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.10.y] batman-adv: Drop unmanaged ELP metric worker
Date: Wed, 19 Feb 2025 19:55:19 +0100
Message-Id: <20250219185519.840435-1-sven@narfation.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025021841-atrium-settle-8b58@gregkh>
References: <2025021841-atrium-settle-8b58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8c8ecc98f5c65947b0070a24bac11e12e47cc65d upstream.

The ELP worker needs to calculate new metric values for all neighbors
"reachable" over an interface. Some of the used metric sources require
locks which might need to sleep. This sleep is incompatible with the RCU
list iterator used for the recorded neighbors. The initial approach to work
around of this problem was to queue another work item per neighbor and then
run this in a new context.

Even when this solved the RCU vs might_sleep() conflict, it has a major
problems: Nothing was stopping the work item in case it is not needed
anymore - for example because one of the related interfaces was removed or
the batman-adv module was unloaded - resulting in potential invalid memory
accesses.

Directly canceling the metric worker also has various problems:

* cancel_work_sync for a to-be-deactivated interface is called with
  rtnl_lock held. But the code in the ELP metric worker also tries to use
  rtnl_lock() - which will never return in this case. This also means that
  cancel_work_sync would never return because it is waiting for the worker
  to finish.
* iterating over the neighbor list for the to-be-deactivated interface is
  currently done using the RCU specific methods. Which means that it is
  possible to miss items when iterating over it without the associated
  spinlock - a behaviour which is acceptable for a periodic metric check
  but not for a cleanup routine (which must "stop" all still running
  workers)

The better approch is to get rid of the per interface neighbor metric
worker and handle everything in the interface worker. The original problems
are solved by:

* creating a list of neighbors which require new metric information inside
  the RCU protected context, gathering the metric according to the new list
  outside the RCU protected context
* only use rcu_trylock inside metric gathering code to avoid a deadlock
  when the cancel_delayed_work_sync is called in the interface removal code
  (which is called with the rtnl_lock held)

Cc: stable@vger.kernel.org
Fixes: c833484e5f38 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c     |  2 --
 net/batman-adv/bat_v_elp.c | 74 +++++++++++++++++++++++++-------------
 net/batman-adv/bat_v_elp.h |  2 --
 net/batman-adv/types.h     |  3 --
 4 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 0ecaf1bb0068..7e985f827a94 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -115,8 +115,6 @@ static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
-	INIT_WORK(&hardif_neigh->bat_v.metric_work,
-		  batadv_v_elp_throughput_metric_update);
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUGFS
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 980badecf251..f4aa0964961b 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -18,6 +18,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/nl80211.h>
 #include <linux/prandom.h>
@@ -26,6 +27,7 @@
 #include <linux/rcupdate.h>
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -41,6 +43,18 @@
 #include "routing.h"
 #include "send.h"
 
+/**
+ * struct batadv_v_metric_queue_entry - list of hardif neighbors which require
+ *  and metric update
+ */
+struct batadv_v_metric_queue_entry {
+	/** @hardif_neigh: hardif neighbor scheduled for metric update */
+	struct batadv_hardif_neigh_node *hardif_neigh;
+
+	/** @list: list node for metric_queue */
+	struct list_head list;
+};
+
 /**
  * batadv_v_elp_start_timer() - restart timer for ELP periodic work
  * @hard_iface: the interface for which the timer has to be reset
@@ -137,11 +151,19 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 		goto default_throughput;
 	}
 
+	memset(&link_settings, 0, sizeof(link_settings));
+
+	/* only use rtnl_trylock because the elp worker will be cancelled while
+	 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+	 * wait forever when the elp work_item was started and it is then also
+	 * trying to rtnl_lock
+	 */
+	if (!rtnl_trylock())
+		return false;
+
 	/* if not a wifi interface, check if this device provides data via
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
-	memset(&link_settings, 0, sizeof(link_settings));
-	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
 	if (ret == 0) {
@@ -176,31 +198,19 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 /**
  * batadv_v_elp_throughput_metric_update() - worker updating the throughput
  *  metric of a single hop neighbour
- * @work: the work queue item
+ * @neigh: the neighbour to probe
  */
-void batadv_v_elp_throughput_metric_update(struct work_struct *work)
+static void
+batadv_v_elp_throughput_metric_update(struct batadv_hardif_neigh_node *neigh)
 {
-	struct batadv_hardif_neigh_node_bat_v *neigh_bat_v;
-	struct batadv_hardif_neigh_node *neigh;
 	u32 throughput;
 	bool valid;
 
-	neigh_bat_v = container_of(work, struct batadv_hardif_neigh_node_bat_v,
-				   metric_work);
-	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
-			     bat_v);
-
 	valid = batadv_v_elp_get_throughput(neigh, &throughput);
 	if (!valid)
-		goto put_neigh;
+		return;
 
 	ewma_throughput_add(&neigh->bat_v.throughput, throughput);
-
-put_neigh:
-	/* decrement refcounter to balance increment performed before scheduling
-	 * this task
-	 */
-	batadv_hardif_neigh_put(neigh);
 }
 
 /**
@@ -274,14 +284,16 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
  */
 static void batadv_v_elp_periodic_work(struct work_struct *work)
 {
+	struct batadv_v_metric_queue_entry *metric_entry;
+	struct batadv_v_metric_queue_entry *metric_safe;
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
 	struct batadv_elp_packet *elp_packet;
+	struct list_head metric_queue;
 	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
 	u32 elp_interval;
-	bool ret;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -317,6 +329,8 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
+	INIT_LIST_HEAD(&metric_queue);
+
 	/* The throughput metric is updated on each sent packet. This way, if a
 	 * node is dead and no longer sends packets, batman-adv is still able to
 	 * react timely to its death.
@@ -341,16 +355,28 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 		/* Reading the estimated throughput from cfg80211 is a task that
 		 * may sleep and that is not allowed in an rcu protected
-		 * context. Therefore schedule a task for that.
+		 * context. Therefore add it to metric_queue and process it
+		 * outside rcu protected context.
 		 */
-		ret = queue_work(batadv_event_workqueue,
-				 &hardif_neigh->bat_v.metric_work);
-
-		if (!ret)
+		metric_entry = kzalloc(sizeof(*metric_entry), GFP_ATOMIC);
+		if (!metric_entry) {
 			batadv_hardif_neigh_put(hardif_neigh);
+			continue;
+		}
+
+		metric_entry->hardif_neigh = hardif_neigh;
+		list_add(&metric_entry->list, &metric_queue);
 	}
 	rcu_read_unlock();
 
+	list_for_each_entry_safe(metric_entry, metric_safe, &metric_queue, list) {
+		batadv_v_elp_throughput_metric_update(metric_entry->hardif_neigh);
+
+		batadv_hardif_neigh_put(metric_entry->hardif_neigh);
+		list_del(&metric_entry->list);
+		kfree(metric_entry);
+	}
+
 restart_timer:
 	batadv_v_elp_start_timer(hard_iface);
 out:
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 4358d436be2a..f814f87f3a6a 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -10,7 +10,6 @@
 #include "main.h"
 
 #include <linux/skbuff.h>
-#include <linux/workqueue.h>
 
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
@@ -19,6 +18,5 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
-void batadv_v_elp_throughput_metric_update(struct work_struct *work);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7d47fe7534c1..cc3334afbdd0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -606,9 +606,6 @@ struct batadv_hardif_neigh_node_bat_v {
 	 *  neighbor
 	 */
 	unsigned long last_unicast_tx;
-
-	/** @metric_work: work queue callback item for metric update */
-	struct work_struct metric_work;
 };
 
 /**
-- 
2.39.5


