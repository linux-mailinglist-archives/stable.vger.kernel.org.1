Return-Path: <stable+bounces-248352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EAHKKpVB2oHzAIAu9opvQ
	(envelope-from <stable+bounces-248352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:19:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D1554D53
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0A6C30D0494
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4CC3FBB40;
	Fri, 15 May 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ch5jlPxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECE3F929A;
	Fri, 15 May 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861514; cv=none; b=Trgy3dU6aTkInXOosjycjIiYmYbNX6cGgM8GoYqDooYyGL7BfU4UDMUJapcLjfv/AJLni42BMtBLOWdKbU6ni0kQ6erTAPwrp22EDcnKeYYcmqTTtixeHztgWpnWOUhpYOrYBRNOxAvdcdad98VUp6zrWxZhvRGPPieLSkJqbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861514; c=relaxed/simple;
	bh=0+/asUX2DNGWvpNjjPbJQsYpgtzKAHUU4k/SvFm4seY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnw7oruWFiy8bwtRcedVUAx8cBK3yf0qlXV7WXaVX/l4nr0ZSlYRsjUfvoPKyYej0Onw56El782neEOcna5VBmpwlqpsGuu5fdICtDVBaBrdmkFcRDFmIeXhe9FgWZBqIqSB1IvR8s2qs1YCvHFlcLKNJ2JwwOVWhUs5iBgoUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ch5jlPxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042FBC2BCB0;
	Fri, 15 May 2026 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861514;
	bh=0+/asUX2DNGWvpNjjPbJQsYpgtzKAHUU4k/SvFm4seY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ch5jlPxb+Ar+MCuoLY3iaL7Mb1MXFj/K7TAQqpMDZJ867JQQTRCpQhPwZtHcNdwD+
	 p/NRptaTxDrfi3V/nmsySsuHEY8eDENDVzevz9TJz1FJLYM85rstSO9YGNlctypRSg
	 wEwV+7H75yha1Tu/F8k4HzdP/9Rh/U9UXzh+7EMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 358/474] batman-adv: stop caching unowned originator pointers in BAT IV
Date: Fri, 15 May 2026 17:47:47 +0200
Message-ID: <20260515154722.765877308@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 353D1554D53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,narfation.org];
	TAGGED_FROM(0.00)[bounces-248352-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,lzu.edu.cn:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiexun Wang <wangjiexun2025@gmail.com>

commit f03e8583532941b07761c5429de7d50766fa3110 upstream.

BAT IV keeps the last-hop neighbor address in each neigh_node, but some
paths also cache an originator pointer derived from a temporary lookup.
That pointer is not owned by the neigh_node and may no longer refer to a
live originator entry after purge handling runs.

Stop storing the auxiliary originator pointer in the BAT IV neighbor
state. When BAT IV needs the neighbor originator data, resolve it from
the stored neighbor address and drop the reference again after use.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
[sven: avoid bonding logic for outgoing OGM]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_iv_ogm.c |   83 +++++++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 24 deletions(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -172,19 +172,12 @@ free_orig_node_hash:
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr,
-			struct batadv_orig_node *orig_node,
-			struct batadv_orig_node *orig_neigh)
+			struct batadv_orig_node *orig_node)
 {
 	struct batadv_neigh_node *neigh_node;
 
 	neigh_node = batadv_neigh_node_get_or_create(orig_node,
 						     hard_iface, neigh_addr);
-	if (!neigh_node)
-		goto out;
-
-	neigh_node->orig_node = orig_neigh;
-
-out:
 	return neigh_node;
 }
 
@@ -901,6 +894,31 @@ static u8 batadv_iv_orig_ifinfo_sum(stru
 }
 
 /**
+ * batadv_iv_ogm_neigh_ifinfo_sum() - Get bcast_own sum for a last-hop neighbor
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @neigh_node: last-hop neighbor of an originator
+ *
+ * Return: Number of replied (rebroadcasted) OGMs for the originator currently
+ * announced by the neighbor. Returns 0 if the neighbor's originator entry is
+ * not available anymore.
+ */
+static u8 batadv_iv_ogm_neigh_ifinfo_sum(struct batadv_priv *bat_priv,
+					 const struct batadv_neigh_node *neigh_node)
+{
+	struct batadv_orig_node *orig_neigh;
+	u8 sum;
+
+	orig_neigh = batadv_orig_hash_find(bat_priv, neigh_node->addr);
+	if (!orig_neigh)
+		return 0;
+
+	sum = batadv_iv_orig_ifinfo_sum(orig_neigh, neigh_node->if_incoming);
+	batadv_orig_node_put(orig_neigh);
+
+	return sum;
+}
+
+/**
  * batadv_iv_ogm_orig_update() - use OGM to update corresponding data in an
  *  originator
  * @bat_priv: the bat priv with all the soft interface information
@@ -969,17 +987,9 @@ batadv_iv_ogm_orig_update(struct batadv_
 	}
 
 	if (!neigh_node) {
-		struct batadv_orig_node *orig_tmp;
-
-		orig_tmp = batadv_iv_ogm_orig_get(bat_priv, ethhdr->h_source);
-		if (!orig_tmp)
-			goto unlock;
-
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     ethhdr->h_source,
-						     orig_node, orig_tmp);
-
-		batadv_orig_node_put(orig_tmp);
+						     orig_node);
 		if (!neigh_node)
 			goto unlock;
 	} else {
@@ -1031,10 +1041,9 @@ batadv_iv_ogm_orig_update(struct batadv_
 	 */
 	if (router_ifinfo &&
 	    neigh_ifinfo->bat_iv.tq_avg == router_ifinfo->bat_iv.tq_avg) {
-		sum_orig = batadv_iv_orig_ifinfo_sum(router->orig_node,
-						     router->if_incoming);
-		sum_neigh = batadv_iv_orig_ifinfo_sum(neigh_node->orig_node,
-						      neigh_node->if_incoming);
+		sum_orig = batadv_iv_ogm_neigh_ifinfo_sum(bat_priv, router);
+		sum_neigh = batadv_iv_ogm_neigh_ifinfo_sum(bat_priv,
+							   neigh_node);
 		if (sum_orig >= sum_neigh)
 			goto out;
 	}
@@ -1100,7 +1109,6 @@ static bool batadv_iv_ogm_calc_tq(struct
 	if (!neigh_node)
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     orig_neigh_node->orig,
-						     orig_neigh_node,
 						     orig_neigh_node);
 
 	if (!neigh_node)
@@ -1297,6 +1305,32 @@ out:
 }
 
 /**
+ * batadv_orig_to_direct_router() - get direct next hop neighbor to an orig address
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @orig_addr: the originator MAC address to search the best next hop router for
+ * @if_outgoing: the interface where the OGM should be sent to
+ *
+ * Return: A neighbor node which is the best router towards the given originator
+ * address. Bonding candidates are ignored.
+ */
+static struct batadv_neigh_node *
+batadv_orig_to_direct_router(struct batadv_priv *bat_priv, u8 *orig_addr,
+			     struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_orig_node *orig_node;
+
+	orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+	if (!orig_node)
+		return NULL;
+
+	neigh_node = batadv_orig_router_get(orig_node, if_outgoing);
+	batadv_orig_node_put(orig_node);
+
+	return neigh_node;
+}
+
+/**
  * batadv_iv_ogm_process_per_outif() - process a batman iv OGM for an outgoing
  *  interface
  * @skb: the skb containing the OGM
@@ -1366,8 +1400,9 @@ batadv_iv_ogm_process_per_outif(const st
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
 	if (router) {
-		router_router = batadv_orig_router_get(router->orig_node,
-						       if_outgoing);
+		router_router = batadv_orig_to_direct_router(bat_priv,
+							     router->addr,
+							     if_outgoing);
 		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
 	}
 



