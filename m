Return-Path: <stable+bounces-255096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GeaBO2YGGqklQgAu9opvQ
	(envelope-from <stable+bounces-255096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:35:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1FD5F7330
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2BBE3018406
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A339B30E851;
	Thu, 28 May 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="tuzFKhlJ"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2AF1946DA
	for <stable@vger.kernel.org>; Thu, 28 May 2026 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996905; cv=none; b=Ii6ta76UI+4Tu7v7awnEw1tavgL/DeCrW+eP25FKtWPGeIDGpwy/z1tpTvGOHzyJ5lLNO6+DcvDAF8lGAhYLlAz5lFWmIiBXklYjOzBASMcoiXOTv/01LhR6O9Qi+6LlQ7oAL6JXlJJ0c/Iw4RDYDbXsGBY5Se+RilRLi+ewbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996905; c=relaxed/simple;
	bh=6AOkpGftGMG0nKtksHO5YJz9MLtobfF6Pz7QJ8ltGWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBBozVoIJ3PZdBJZ6WY/OR4Z8qG7VtNqk467gTZ2W1yZsnvWzoVsrKksaWBSWHSuDKabA3e5R5wj2VJatjWrwxUl8f+i0GGEyJar70CGxQhHRgd6X1+sEt5Be+a1a2bkmdXyv7dv658ZbNXUXd3y3d399+Ii2kTjL7E6H4ssVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=tuzFKhlJ; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id A829420044;
	Thu, 28 May 2026 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779996901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1qZvmgBm/VuzSx71cLvx5XdiiqzR/we8sX7TdavOkQ=;
	b=tuzFKhlJkX2KiApgio/UhUtTkkHiPfgOzUlpxG3ayYqUvTDEG/wjha/plAFC0J0dyOtOrm
	hxi75CzZxdJ2MSHhnlSS4pBmbfOWPwj8ge6RWHD6qa/LgwjEj3IB4syfF7n9Zh73EslfLE
	Gq0KcviOb/1nn/EKvRr4G6q3XEdeQkA=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>
Subject: [PATCH 5.15.y] batman-adv: v: stop OGMv2 on disabled interface
Date: Thu, 28 May 2026 21:34:43 +0200
Message-ID: <20260528193443.195417-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026052859-hardy-exemplify-13bc@gregkh>
References: <2026052859-hardy-exemplify-13bc@gregkh>
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
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[narfation.org,kernel.org,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-255096-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6E1FD5F7330
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit f8ce8b8331a1bc44ad4905886a482214d428b253 upstream.

When a batadv_hard_iface is disabled, its mesh_iface pointer is set to
NULL. However, batadv_v_ogm_send_meshif() may still dispatch OGMs via
batadv_v_ogm_queue_on_if() for interfaces that have since lost their
mesh_iface association. This results in a NULL pointer dereference when
batadv_v_ogm_queue_on_if() unconditionally calls netdev_priv() on the
now NULL hard_iface->mesh_iface to retrieve the batadv_priv.

It is necessary to ensure that the batadv_v_ogm_queue_on_if() checks that
it is using the same mesh_iface for which batadv_v_ogm_send_meshif() was
called.

Cc: stable@kernel.org
Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reviewed-by: Yuan Tan <yuantan098@gmail.com>
[ switch to old "mesh_iface" name "soft_iface" ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_ogm.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index c357cf72396e..742959156533 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -116,14 +116,14 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 
 /**
  * batadv_v_ogm_send_to_if() - send a batman ogm using a given interface
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to send
  * @hard_iface: the interface to use to send the OGM
  */
-static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
+static void batadv_v_ogm_send_to_if(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-
 	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
 		kfree_skb(skb);
 		return;
@@ -190,6 +190,7 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_v_ogm_aggr_send() - flush & send aggregation queue
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hard_iface: the interface with the aggregation queue to flush
  *
  * Aggregates all OGMv2 packets currently in the aggregation queue into a
@@ -199,7 +200,8 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
  *
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
-static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
+static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
+				   struct batadv_hard_iface *hard_iface)
 {
 	unsigned int aggr_len = hard_iface->bat_v.aggr_len;
 	struct sk_buff *skb_aggr;
@@ -229,27 +231,32 @@ static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
 		consume_skb(skb);
 	}
 
-	batadv_v_ogm_send_to_if(skb_aggr, hard_iface);
+	batadv_v_ogm_send_to_if(bat_priv, skb_aggr, hard_iface);
 }
 
 /**
  * batadv_v_ogm_queue_on_if() - queue a batman ogm on a given interface
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to queue
  * @hard_iface: the interface to queue the OGM on
  */
-static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
+static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
+				     struct sk_buff *skb,
 				     struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	if (hard_iface->soft_iface != bat_priv->soft_iface) {
+		kfree_skb(skb);
+		return;
+	}
 
 	if (!atomic_read(&bat_priv->aggregated_ogms)) {
-		batadv_v_ogm_send_to_if(skb, hard_iface);
+		batadv_v_ogm_send_to_if(bat_priv, skb, hard_iface);
 		return;
 	}
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
-		batadv_v_ogm_aggr_send(hard_iface);
+		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
@@ -348,7 +355,7 @@ static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
 			break;
 		}
 
-		batadv_v_ogm_queue_on_if(skb_tmp, hard_iface);
+		batadv_v_ogm_queue_on_if(bat_priv, skb_tmp, hard_iface);
 		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
@@ -388,12 +395,14 @@ void batadv_v_ogm_aggr_work(struct work_struct *work)
 {
 	struct batadv_hard_iface_bat_v *batv;
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
 
 	batv = container_of(work, struct batadv_hard_iface_bat_v, aggr_wq.work);
 	hard_iface = container_of(batv, struct batadv_hard_iface, bat_v);
+	bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
-	batadv_v_ogm_aggr_send(hard_iface);
+	batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 
 	batadv_v_ogm_start_queue_timer(hard_iface);
@@ -583,7 +592,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 		   if_outgoing->net_dev->name, ntohl(ogm_forward->throughput),
 		   ogm_forward->ttl, if_incoming->net_dev->name);
 
-	batadv_v_ogm_queue_on_if(skb, if_outgoing);
+	batadv_v_ogm_queue_on_if(bat_priv, skb, if_outgoing);
 
 out:
 	batadv_orig_ifinfo_put(orig_ifinfo);
-- 
2.47.3


