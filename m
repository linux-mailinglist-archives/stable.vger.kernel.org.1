Return-Path: <stable+bounces-247609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAkRB5bfBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:55:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8854BCD3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EC513001FA8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0E351C22;
	Fri, 15 May 2026 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0DJg8Ddv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076A625
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834689; cv=none; b=SSWx8/QUrpTFCfmln7RdEIs254eoX5FV3sY8TA/+siEEG12d1Yt82+2XG23igyQgvadXUfbOLNUjfjr+e4c3oex99owBdUCiZ0PhAD66byoxhHGmwxYZ4m41MzCIG5e/VZTpFbKo1AFaNALl6R75Wy3Qx5eAK0NWcD4cXgC9VSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834689; c=relaxed/simple;
	bh=zATbDcOGQkU+NgU+Mv69YEmkRxAVnjo+TMxufp4Ef9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PT0dQw8oGn+N2jpFEVT/0YmJ3Iohm6vlP+GLcTf4X47m6JuuDx6fslKU1GGSr5QwcZJcaexSGQmDFJR9AqNE92C7KU85wOg67/sZerhcZYmkypJt+R9axw+1A/DvACI5BK7zw0SO4BBTJf5hvCOfX3MmCyHYpLLsXTD1GgmQpRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0DJg8Ddv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A20C2BCB0;
	Fri, 15 May 2026 08:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834689;
	bh=zATbDcOGQkU+NgU+Mv69YEmkRxAVnjo+TMxufp4Ef9g=;
	h=Subject:To:Cc:From:Date:From;
	b=0DJg8Ddv7lJFZX8DEi5Gqpa6MVColSTsFC5KXOPk5cdsWe6SBYTy/SathXDuKy5k9
	 U+dPIA3zXVqyR1XIsEVDA72vOnFYFlQBIFOgov8Xb64rVo9EyNrgxQRPM2lTGYECo4
	 AC9K0NrtTdnBDvjY0YyryqzxkaCYqxTH3ndZL51c=
Subject: FAILED: patch "[PATCH] batman-adv: stop tp_meter sessions during mesh teardown" failed to apply to 6.12-stable tree
To: wangjiexun2025@gmail.com,bird@lzu.edu.cn,n05ec@lzu.edu.cn,sven@narfation.org,tomapufckgml@gmail.com,tr0jan@lzu.edu.cn,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:44:53 +0200
Message-ID: <2026051553-whoopee-footbath-743e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BA8854BCD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247609-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lzu.edu.cn,narfation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3d3cf6a7314aca4df0a6dde28ce784a2a30d0166
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051553-whoopee-footbath-743e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d3cf6a7314aca4df0a6dde28ce784a2a30d0166 Mon Sep 17 00:00:00 2001
From: Jiexun Wang <wangjiexun2025@gmail.com>
Date: Mon, 27 Apr 2026 14:43:34 +0800
Subject: [PATCH] batman-adv: stop tp_meter sessions during mesh teardown

TP meter sessions remain linked on bat_priv->tp_list after the netlink
request has already finished. When the mesh interface is removed,
batadv_mesh_free() currently tears down the mesh without first draining
these sessions.

A running sender thread or a late incoming tp_meter packet can then keep
processing against a mesh instance which is already shutting down.
Synchronize tp_meter with the mesh lifetime by stopping all active
sessions from batadv_mesh_free() and waiting for sender threads to exit
before teardown continues.

Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3a35aadd8b41..a4d33ee0fda5 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -249,6 +249,7 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
+	batadv_tp_stop_all(bat_priv);
 
 	batadv_gw_node_free(bat_priv);
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index d9a80e459c2e..58ca59a2799e 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -12,6 +12,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/etherdevice.h>
@@ -365,23 +366,38 @@ static void batadv_tp_vars_put(struct batadv_tp_vars *tp_vars)
 }
 
 /**
- * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
- * @bat_priv: the bat priv with all the mesh interface information
- * @tp_vars: the private data of the current TP meter session to cleanup
+ * batadv_tp_list_detach() - remove tp session from mesh session list once
+ * @tp_vars: the private data of the current TP meter session
  */
-static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
-				     struct batadv_tp_vars *tp_vars)
+static void batadv_tp_list_detach(struct batadv_tp_vars *tp_vars)
 {
-	cancel_delayed_work(&tp_vars->finish_work);
+	bool detached = false;
 
 	spin_lock_bh(&tp_vars->bat_priv->tp_list_lock);
-	hlist_del_rcu(&tp_vars->list);
+	if (!hlist_unhashed(&tp_vars->list)) {
+		hlist_del_init_rcu(&tp_vars->list);
+		detached = true;
+	}
 	spin_unlock_bh(&tp_vars->bat_priv->tp_list_lock);
 
+	if (!detached)
+		return;
+
+	atomic_dec(&tp_vars->bat_priv->tp_num);
+
 	/* drop list reference */
 	batadv_tp_vars_put(tp_vars);
+}
 
-	atomic_dec(&tp_vars->bat_priv->tp_num);
+/**
+ * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
+ * @tp_vars: the private data of the current TP meter session to cleanup
+ */
+static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
+{
+	cancel_delayed_work_sync(&tp_vars->finish_work);
+
+	batadv_tp_list_detach(tp_vars);
 
 	/* kill the timer and remove its reference */
 	timer_delete_sync(&tp_vars->timer);
@@ -886,7 +902,8 @@ static int batadv_tp_send(void *arg)
 	batadv_orig_node_put(orig_node);
 
 	batadv_tp_sender_end(bat_priv, tp_vars);
-	batadv_tp_sender_cleanup(bat_priv, tp_vars);
+	batadv_tp_sender_cleanup(tp_vars);
+	complete(&tp_vars->finished);
 
 	batadv_tp_vars_put(tp_vars);
 
@@ -918,7 +935,8 @@ static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
 		batadv_tp_vars_put(tp_vars);
 
 		/* cleanup of failed tp meter variables */
-		batadv_tp_sender_cleanup(bat_priv, tp_vars);
+		batadv_tp_sender_cleanup(tp_vars);
+		complete(&tp_vars->finished);
 		return;
 	}
 
@@ -1024,6 +1042,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->start_time = jiffies;
 
 	init_waitqueue_head(&tp_vars->more_bytes);
+	init_completion(&tp_vars->finished);
 
 	spin_lock_init(&tp_vars->unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->unacked_list);
@@ -1126,14 +1145,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 		   "Shutting down for inactivity (more than %dms) from %pM\n",
 		   BATADV_TP_RECV_TIMEOUT, tp_vars->other_end);
 
-	spin_lock_bh(&tp_vars->bat_priv->tp_list_lock);
-	hlist_del_rcu(&tp_vars->list);
-	spin_unlock_bh(&tp_vars->bat_priv->tp_list_lock);
-
-	/* drop list reference */
-	batadv_tp_vars_put(tp_vars);
-
-	atomic_dec(&bat_priv->tp_num);
+	batadv_tp_list_detach(tp_vars);
 
 	spin_lock_bh(&tp_vars->unacked_lock);
 	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
@@ -1496,6 +1508,52 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 	consume_skb(skb);
 }
 
+/**
+ * batadv_tp_stop_all() - stop all currently running tp meter sessions
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
+void batadv_tp_stop_all(struct batadv_priv *bat_priv)
+{
+	struct batadv_tp_vars *tp_vars[BATADV_TP_MAX_NUM];
+	struct batadv_tp_vars *tp_var;
+	size_t count = 0;
+	size_t i;
+
+	spin_lock_bh(&bat_priv->tp_list_lock);
+	hlist_for_each_entry(tp_var, &bat_priv->tp_list, list) {
+		if (WARN_ON_ONCE(count >= BATADV_TP_MAX_NUM))
+			break;
+
+		if (!kref_get_unless_zero(&tp_var->refcount))
+			continue;
+
+		tp_vars[count++] = tp_var;
+	}
+	spin_unlock_bh(&bat_priv->tp_list_lock);
+
+	for (i = 0; i < count; i++) {
+		tp_var = tp_vars[i];
+
+		switch (tp_var->role) {
+		case BATADV_TP_SENDER:
+			batadv_tp_sender_shutdown(tp_var,
+						  BATADV_TP_REASON_CANCEL);
+			wake_up(&tp_var->more_bytes);
+			wait_for_completion(&tp_var->finished);
+			break;
+		case BATADV_TP_RECEIVER:
+			batadv_tp_list_detach(tp_var);
+			if (timer_shutdown_sync(&tp_var->timer))
+				batadv_tp_vars_put(tp_var);
+			break;
+		}
+
+		batadv_tp_vars_put(tp_var);
+	}
+
+	synchronize_net();
+}
+
 /**
  * batadv_tp_meter_init() - initialize global tp_meter structures
  */
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index f0046d366eac..4e97cd10cd02 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -17,6 +17,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		     u32 test_length, u32 *cookie);
 void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 		    u8 return_value);
+void batadv_tp_stop_all(struct batadv_priv *bat_priv);
 void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb);
 
 #endif /* _NET_BATMAN_ADV_TP_METER_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8fc5fe0e9b05..daa06f421154 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -14,6 +14,7 @@
 #include <linux/average.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/kref.h>
@@ -1328,6 +1329,9 @@ struct batadv_tp_vars {
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
 
+	/** @finished: completion signaled when a sender thread exits */
+	struct completion finished;
+
 	/** @test_length: test length in milliseconds */
 	u32 test_length;
 


