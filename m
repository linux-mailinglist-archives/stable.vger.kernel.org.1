Return-Path: <stable+bounces-103793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55A9EF935
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA5F28565E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A940226542;
	Thu, 12 Dec 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ozjpmUyf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7E22540B;
	Thu, 12 Dec 2024 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025620; cv=none; b=dQPPRuIXL5hpoCka3CSakgcAijQ7OscnvnznQsw214yIbzk+TGvZlGmwJaC4JYmIPd2RVS/Wp2SpVHz9PrO6rkAbZ8MrckXKwoC5NGkuqbkov+yDXiEhsLos3K3d5FiFH7LQJ575r1Mq4bFMVpHzl7yJtAJP9QWvEpBVlpLyMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025620; c=relaxed/simple;
	bh=KStDd1xSJnLrFu919j/vfywoXnxBAmulGhI5Gt+BND8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSVN6mKCa/SLbrHBqQNB9au+/wTw4ltyzUMaaNTrxkdX7dtNtqeE1n91zcpItYMPHvckfg2zxDwByGYIS7aru11Gx6PlHXcFl8UzznEkv5ti658tqHYKOf7oHIr/DOeUS01R6tHO2EXyNlgVXZC9qi8ULoOMpt3DCDnpQ/CcdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ozjpmUyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA4EC4CECE;
	Thu, 12 Dec 2024 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025619;
	bh=KStDd1xSJnLrFu919j/vfywoXnxBAmulGhI5Gt+BND8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozjpmUyfWgJb/QWjPoWbEecGjrgBRthC7nGKt+M+fE20zY1H11cRejUOoYNKVAjJY
	 UOeieXgnfA4O6qqpdJBLmGooEoRaZYk6cJ4qsR1Ug8iRgC1DIIHLSFjOTZD2V+KI2C
	 AgpnuqbcZ/z7fbx1eTKFBt01bYWQFOY19PkAlqpw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ying Xue <ying.xue@windreiver.com>,
	Jon Maloy <jon.maloy@ericsson.com>,
	Tuong Lien <tuong.t.lien@dektech.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 230/321] tipc: enable creating a "preliminary" node
Date: Thu, 12 Dec 2024 16:02:28 +0100
Message-ID: <20241212144239.060796679@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tuong Lien <tuong.t.lien@dektech.com.au>

[ Upstream commit 4cbf8ac2fe5a0846508fe02b95a5de1a90fa73f4 ]

When user sets RX key for a peer not existing on the own node, a new
node entry is needed to which the RX key will be attached. However,
since the peer node address (& capabilities) is unknown at that moment,
only the node-ID is provided, this commit allows the creation of a node
with only the data that we call as “preliminary”.

A preliminary node is not the object of the “tipc_node_find()” but the
“tipc_node_find_by_id()”. Once the first message i.e. LINK_CONFIG comes
from that peer, and is successfully decrypted by the own node, the
actual peer node data will be properly updated and the node will
function as usual.

In addition, the node timer always starts when a node object is created
so if a preliminary node is not used, it will be cleaned up.

The later encryption functions will also use the node timer and be able
to create a preliminary node automatically when needed.

Acked-by: Ying Xue <ying.xue@windreiver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tuong Lien <tuong.t.lien@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 6a2fa13312e5 ("tipc: Fix use-after-free of kernel socket in cleanup_bearer().")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/node.c | 99 +++++++++++++++++++++++++++++++++++--------------
 net/tipc/node.h |  1 +
 2 files changed, 73 insertions(+), 27 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 535a4a778640a..16de7a1b3b01f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -89,6 +89,7 @@ struct tipc_bclink_entry {
  * @links: array containing references to all links to node
  * @action_flags: bit mask of different types of node actions
  * @state: connectivity state vs peer node
+ * @preliminary: a preliminary node or not
  * @sync_point: sequence number where synch/failover is finished
  * @list: links to adjacent nodes in sorted list of cluster's nodes
  * @working_links: number of working links to node (both active and standby)
@@ -112,6 +113,7 @@ struct tipc_node {
 	int action_flags;
 	struct list_head list;
 	int state;
+	bool preliminary;
 	bool failover_sent;
 	u16 sync_point;
 	int link_cnt;
@@ -120,6 +122,7 @@ struct tipc_node {
 	u32 signature;
 	u32 link_id;
 	u8 peer_id[16];
+	char peer_id_string[NODE_ID_STR_LEN];
 	struct list_head publ_list;
 	struct list_head conn_sks;
 	unsigned long keepalive_intv;
@@ -245,6 +248,16 @@ u16 tipc_node_get_capabilities(struct net *net, u32 addr)
 	return caps;
 }
 
+u32 tipc_node_get_addr(struct tipc_node *node)
+{
+	return (node) ? node->addr : 0;
+}
+
+char *tipc_node_get_id_str(struct tipc_node *node)
+{
+	return node->peer_id_string;
+}
+
 static void tipc_node_kref_release(struct kref *kref)
 {
 	struct tipc_node *n = container_of(kref, struct tipc_node, kref);
@@ -274,7 +287,7 @@ static struct tipc_node *tipc_node_find(struct net *net, u32 addr)
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(node, &tn->node_htable[thash], hash) {
-		if (node->addr != addr)
+		if (node->addr != addr || node->preliminary)
 			continue;
 		if (!kref_get_unless_zero(&node->kref))
 			node = NULL;
@@ -400,17 +413,39 @@ static void tipc_node_assign_peer_net(struct tipc_node *n, u32 hash_mixes)
 
 static struct tipc_node *tipc_node_create(struct net *net, u32 addr,
 					  u8 *peer_id, u16 capabilities,
-					  u32 signature, u32 hash_mixes)
+					  u32 hash_mixes, bool preliminary)
 {
 	struct tipc_net *tn = net_generic(net, tipc_net_id);
 	struct tipc_node *n, *temp_node;
 	struct tipc_link *l;
+	unsigned long intv;
 	int bearer_id;
 	int i;
 
 	spin_lock_bh(&tn->node_list_lock);
-	n = tipc_node_find(net, addr);
+	n = tipc_node_find(net, addr) ?:
+		tipc_node_find_by_id(net, peer_id);
 	if (n) {
+		if (!n->preliminary)
+			goto update;
+		if (preliminary)
+			goto exit;
+		/* A preliminary node becomes "real" now, refresh its data */
+		tipc_node_write_lock(n);
+		n->preliminary = false;
+		n->addr = addr;
+		hlist_del_rcu(&n->hash);
+		hlist_add_head_rcu(&n->hash,
+				   &tn->node_htable[tipc_hashfn(addr)]);
+		list_del_rcu(&n->list);
+		list_for_each_entry_rcu(temp_node, &tn->node_list, list) {
+			if (n->addr < temp_node->addr)
+				break;
+		}
+		list_add_tail_rcu(&n->list, &temp_node->list);
+		tipc_node_write_unlock_fast(n);
+
+update:
 		if (n->peer_hash_mix ^ hash_mixes)
 			tipc_node_assign_peer_net(n, hash_mixes);
 		if (n->capabilities == capabilities)
@@ -438,7 +473,9 @@ static struct tipc_node *tipc_node_create(struct net *net, u32 addr,
 		pr_warn("Node creation failed, no memory\n");
 		goto exit;
 	}
+	tipc_nodeid2string(n->peer_id_string, peer_id);
 	n->addr = addr;
+	n->preliminary = preliminary;
 	memcpy(&n->peer_id, peer_id, 16);
 	n->net = net;
 	n->peer_net = NULL;
@@ -463,22 +500,14 @@ static struct tipc_node *tipc_node_create(struct net *net, u32 addr,
 	n->signature = INVALID_NODE_SIG;
 	n->active_links[0] = INVALID_BEARER_ID;
 	n->active_links[1] = INVALID_BEARER_ID;
-	if (!tipc_link_bc_create(net, tipc_own_addr(net),
-				 addr, U16_MAX,
-				 tipc_link_window(tipc_bc_sndlink(net)),
-				 n->capabilities,
-				 &n->bc_entry.inputq1,
-				 &n->bc_entry.namedq,
-				 tipc_bc_sndlink(net),
-				 &n->bc_entry.link)) {
-		pr_warn("Broadcast rcv link creation failed, no memory\n");
-		kfree(n);
-		n = NULL;
-		goto exit;
-	}
+	n->bc_entry.link = NULL;
 	tipc_node_get(n);
 	timer_setup(&n->timer, tipc_node_timeout, 0);
-	n->keepalive_intv = U32_MAX;
+	/* Start a slow timer anyway, crypto needs it */
+	n->keepalive_intv = 10000;
+	intv = jiffies + msecs_to_jiffies(n->keepalive_intv);
+	if (!mod_timer(&n->timer, intv))
+		tipc_node_get(n);
 	hlist_add_head_rcu(&n->hash, &tn->node_htable[tipc_hashfn(addr)]);
 	list_for_each_entry_rcu(temp_node, &tn->node_list, list) {
 		if (n->addr < temp_node->addr)
@@ -996,6 +1025,8 @@ u32 tipc_node_try_addr(struct net *net, u8 *id, u32 addr)
 {
 	struct tipc_net *tn = tipc_net(net);
 	struct tipc_node *n;
+	bool preliminary;
+	u32 sugg_addr;
 
 	/* Suggest new address if some other peer is using this one */
 	n = tipc_node_find(net, addr);
@@ -1011,9 +1042,11 @@ u32 tipc_node_try_addr(struct net *net, u8 *id, u32 addr)
 	/* Suggest previously used address if peer is known */
 	n = tipc_node_find_by_id(net, id);
 	if (n) {
-		addr = n->addr;
+		sugg_addr = n->addr;
+		preliminary = n->preliminary;
 		tipc_node_put(n);
-		return addr;
+		if (!preliminary)
+			return sugg_addr;
 	}
 
 	/* Even this node may be in conflict */
@@ -1030,7 +1063,7 @@ void tipc_node_check_dest(struct net *net, u32 addr,
 			  bool *respond, bool *dupl_addr)
 {
 	struct tipc_node *n;
-	struct tipc_link *l;
+	struct tipc_link *l, *snd_l;
 	struct tipc_link_entry *le;
 	bool addr_match = false;
 	bool sign_match = false;
@@ -1045,12 +1078,27 @@ void tipc_node_check_dest(struct net *net, u32 addr,
 	*dupl_addr = false;
 	*respond = false;
 
-	n = tipc_node_create(net, addr, peer_id, capabilities, signature,
-			     hash_mixes);
+	n = tipc_node_create(net, addr, peer_id, capabilities, hash_mixes,
+			     false);
 	if (!n)
 		return;
 
 	tipc_node_write_lock(n);
+	if (unlikely(!n->bc_entry.link)) {
+		snd_l = tipc_bc_sndlink(net);
+		if (!tipc_link_bc_create(net, tipc_own_addr(net),
+					 addr, U16_MAX,
+					 tipc_link_window(snd_l),
+					 n->capabilities,
+					 &n->bc_entry.inputq1,
+					 &n->bc_entry.namedq, snd_l,
+					 &n->bc_entry.link)) {
+			pr_warn("Broadcast rcv link creation failed, no mem\n");
+			tipc_node_write_unlock_fast(n);
+			tipc_node_put(n);
+			return;
+		}
+	}
 
 	le = &n->links[b->identity];
 
@@ -2135,6 +2183,8 @@ int tipc_nl_node_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	list_for_each_entry_rcu(node, &tn->node_list, list) {
+		if (node->preliminary)
+			continue;
 		if (last_addr) {
 			if (node->addr == last_addr)
 				last_addr = 0;
@@ -2654,11 +2704,6 @@ int tipc_nl_node_dump_monitor_peer(struct sk_buff *skb,
 	return skb->len;
 }
 
-u32 tipc_node_get_addr(struct tipc_node *node)
-{
-	return (node) ? node->addr : 0;
-}
-
 /**
  * tipc_node_dump - dump TIPC node data
  * @n: tipc node to be dumped
diff --git a/net/tipc/node.h b/net/tipc/node.h
index 30563c4f35d5c..1d4345ef49b44 100644
--- a/net/tipc/node.h
+++ b/net/tipc/node.h
@@ -72,6 +72,7 @@ enum {
 void tipc_node_stop(struct net *net);
 bool tipc_node_get_id(struct net *net, u32 addr, u8 *id);
 u32 tipc_node_get_addr(struct tipc_node *node);
+char *tipc_node_get_id_str(struct tipc_node *node);
 u32 tipc_node_try_addr(struct net *net, u8 *id, u32 addr);
 void tipc_node_check_dest(struct net *net, u32 onode, u8 *peer_id128,
 			  struct tipc_bearer *bearer,
-- 
2.43.0




