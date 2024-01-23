Return-Path: <stable+bounces-15446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF2838544
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0281F24415
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A6D7E774;
	Tue, 23 Jan 2024 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1XkxFxd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904237E770;
	Tue, 23 Jan 2024 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975782; cv=none; b=ZAlkEYU6peEm5NiLRyOA2oEhIyxLeKeUWPGiHkI89dguDzCq8sTyR4fZjjMTuzmUhcmPyZ/yDFEoV8dLcGyasmVO9hxXFwW4xPi2qka0VUu9EQijOIHgNjQnDQM2VWTEmWCWBVf1um7ZVssma5w4sq+fW1gvDXcDrox+oN0OnaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975782; c=relaxed/simple;
	bh=YRPOyZ98iKSjTGbW1ip9IiXNrIRUTfumWtMYqpxjhs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0T9rulITgLK0/yr+omxYfU2sX1NS3b4s3WcmEhW8dk/zCTaH1uhW1CSDBhAVAU/e7M4mRwPIIEUZT2kg/42kyhgvOge8xPIvmCI9mjJ3cKlDJjlfWZ2LPlxLFw7k0jq17fISREyCDXC8jEig6czLQ8H3GOCGDK6QksWdaCXFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1XkxFxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F38CC433C7;
	Tue, 23 Jan 2024 02:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975782;
	bh=YRPOyZ98iKSjTGbW1ip9IiXNrIRUTfumWtMYqpxjhs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x1XkxFxdM6Ou3rvuUMvi7L1JBR3BAgHGK77vTbLfXgF6ho4rhBNIFoMMP5m83IeBt
	 Jcx+pJBPSVV0k791aSVxDO6c4Os4zR6C06B8qRbqZkmHpX6lhS8akZXrETZ79tExYn
	 wCWiY0oXXGp+DK0lUeLCyQXNpV/cTwLM7RAaoTts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 565/583] netfilter: bridge: replace physindev with physinif in nf_bridge_info
Date: Mon, 22 Jan 2024 16:00:16 -0800
Message-ID: <20240122235829.453848456@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

[ Upstream commit 9874808878d9eed407e3977fd11fee49de1e1d86 ]

An skb can be added to a neigh->arp_queue while waiting for an arp
reply. Where original skb's skb->dev can be different to neigh's
neigh->dev. For instance in case of bridging dnated skb from one veth to
another, the skb would be added to a neigh->arp_queue of the bridge.

As skb->dev can be reset back to nf_bridge->physindev and used, and as
there is no explicit mechanism that prevents this physindev from been
freed under us (for instance neigh_flush_dev doesn't cleanup skbs from
different device's neigh queue) we can crash on e.g. this stack:

arp_process
  neigh_update
    skb = __skb_dequeue(&neigh->arp_queue)
      neigh_resolve_output(..., skb)
        ...
          br_nf_dev_xmit
            br_nf_pre_routing_finish_bridge_slow
              skb->dev = nf_bridge->physindev
              br_handle_frame_finish

Let's use plain ifindex instead of net_device link. To peek into the
original net_device we will use dev_get_by_index_rcu(). Thus either we
get device and are safe to use it or we don't get it and drop skb.

Fixes: c4e70a87d975 ("netfilter: bridge: rename br_netfilter.c to br_netfilter_hooks.c")
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter_bridge.h    |  4 +--
 include/linux/skbuff.h              |  2 +-
 net/bridge/br_netfilter_hooks.c     | 42 +++++++++++++++++++++++------
 net/bridge/br_netfilter_ipv6.c      | 14 +++++++---
 net/ipv4/netfilter/nf_reject_ipv4.c |  9 ++++---
 net/ipv6/netfilter/nf_reject_ipv6.c | 11 +++++---
 6 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/include/linux/netfilter_bridge.h b/include/linux/netfilter_bridge.h
index e927b9a15a55..743475ca7e9d 100644
--- a/include/linux/netfilter_bridge.h
+++ b/include/linux/netfilter_bridge.h
@@ -42,7 +42,7 @@ static inline int nf_bridge_get_physinif(const struct sk_buff *skb)
 	if (!nf_bridge)
 		return 0;
 
-	return nf_bridge->physindev ? nf_bridge->physindev->ifindex : 0;
+	return nf_bridge->physinif;
 }
 
 static inline int nf_bridge_get_physoutif(const struct sk_buff *skb)
@@ -60,7 +60,7 @@ nf_bridge_get_physindev(const struct sk_buff *skb, struct net *net)
 {
 	const struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 
-	return nf_bridge ? nf_bridge->physindev : NULL;
+	return nf_bridge ? dev_get_by_index_rcu(net, nf_bridge->physinif) : NULL;
 }
 
 static inline struct net_device *
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 97bfef071255..ddfe86deb4e7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -295,7 +295,7 @@ struct nf_bridge_info {
 	u8			bridged_dnat:1;
 	u8			sabotage_in_done:1;
 	__u16			frag_max_size;
-	struct net_device	*physindev;
+	int			physinif;
 
 	/* always valid & non-NULL from FORWARD on, for physdev match */
 	struct net_device	*physoutdev;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 033034d68f1f..92dae4c4922c 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -279,8 +279,17 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
 
 		if ((READ_ONCE(neigh->nud_state) & NUD_CONNECTED) &&
 		    READ_ONCE(neigh->hh.hh_len)) {
+			struct net_device *br_indev;
+
+			br_indev = nf_bridge_get_physindev(skb, net);
+			if (!br_indev) {
+				neigh_release(neigh);
+				goto free_skb;
+			}
+
 			neigh_hh_bridge(&neigh->hh, skb);
-			skb->dev = nf_bridge->physindev;
+			skb->dev = br_indev;
+
 			ret = br_handle_frame_finish(net, sk, skb);
 		} else {
 			/* the neighbour function below overwrites the complete
@@ -352,12 +361,18 @@ br_nf_ipv4_daddr_was_changed(const struct sk_buff *skb,
  */
 static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb->dev;
+	struct net_device *dev = skb->dev, *br_indev;
 	struct iphdr *iph = ip_hdr(skb);
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct rtable *rt;
 	int err;
 
+	br_indev = nf_bridge_get_physindev(skb, net);
+	if (!br_indev) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	nf_bridge->frag_max_size = IPCB(skb)->frag_max_size;
 
 	if (nf_bridge->pkt_otherhost) {
@@ -397,7 +412,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 		} else {
 			if (skb_dst(skb)->dev == dev) {
 bridged_dnat:
-				skb->dev = nf_bridge->physindev;
+				skb->dev = br_indev;
 				nf_bridge_update_protocol(skb);
 				nf_bridge_push_encap_header(skb);
 				br_nf_hook_thresh(NF_BR_PRE_ROUTING,
@@ -410,7 +425,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 			skb->pkt_type = PACKET_HOST;
 		}
 	} else {
-		rt = bridge_parent_rtable(nf_bridge->physindev);
+		rt = bridge_parent_rtable(br_indev);
 		if (!rt) {
 			kfree_skb(skb);
 			return 0;
@@ -419,7 +434,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 		skb_dst_set_noref(skb, &rt->dst);
 	}
 
-	skb->dev = nf_bridge->physindev;
+	skb->dev = br_indev;
 	nf_bridge_update_protocol(skb);
 	nf_bridge_push_encap_header(skb);
 	br_nf_hook_thresh(NF_BR_PRE_ROUTING, net, sk, skb, skb->dev, NULL,
@@ -456,7 +471,7 @@ struct net_device *setup_pre_routing(struct sk_buff *skb, const struct net *net)
 	}
 
 	nf_bridge->in_prerouting = 1;
-	nf_bridge->physindev = skb->dev;
+	nf_bridge->physinif = skb->dev->ifindex;
 	skb->dev = brnf_get_logical_dev(skb, skb->dev, net);
 
 	if (skb->protocol == htons(ETH_P_8021Q))
@@ -553,7 +568,11 @@ static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff
 		if (skb->protocol == htons(ETH_P_IPV6))
 			nf_bridge->frag_max_size = IP6CB(skb)->frag_max_size;
 
-		in = nf_bridge->physindev;
+		in = nf_bridge_get_physindev(skb, net);
+		if (!in) {
+			kfree_skb(skb);
+			return 0;
+		}
 		if (nf_bridge->pkt_otherhost) {
 			skb->pkt_type = PACKET_OTHERHOST;
 			nf_bridge->pkt_otherhost = false;
@@ -897,6 +916,13 @@ static unsigned int ip_sabotage_in(void *priv,
 static void br_nf_pre_routing_finish_bridge_slow(struct sk_buff *skb)
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
+	struct net_device *br_indev;
+
+	br_indev = nf_bridge_get_physindev(skb, dev_net(skb->dev));
+	if (!br_indev) {
+		kfree_skb(skb);
+		return;
+	}
 
 	skb_pull(skb, ETH_HLEN);
 	nf_bridge->bridged_dnat = 0;
@@ -906,7 +932,7 @@ static void br_nf_pre_routing_finish_bridge_slow(struct sk_buff *skb)
 	skb_copy_to_linear_data_offset(skb, -(ETH_HLEN - ETH_ALEN),
 				       nf_bridge->neigh_header,
 				       ETH_HLEN - ETH_ALEN);
-	skb->dev = nf_bridge->physindev;
+	skb->dev = br_indev;
 
 	nf_bridge->physoutdev = NULL;
 	br_handle_frame_finish(dev_net(skb->dev), NULL, skb);
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index 550039dfc31a..ad268bd19d5b 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -102,9 +102,15 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct rtable *rt;
-	struct net_device *dev = skb->dev;
+	struct net_device *dev = skb->dev, *br_indev;
 	const struct nf_ipv6_ops *v6ops = nf_get_ipv6_ops();
 
+	br_indev = nf_bridge_get_physindev(skb, net);
+	if (!br_indev) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	nf_bridge->frag_max_size = IP6CB(skb)->frag_max_size;
 
 	if (nf_bridge->pkt_otherhost) {
@@ -122,7 +128,7 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 		}
 
 		if (skb_dst(skb)->dev == dev) {
-			skb->dev = nf_bridge->physindev;
+			skb->dev = br_indev;
 			nf_bridge_update_protocol(skb);
 			nf_bridge_push_encap_header(skb);
 			br_nf_hook_thresh(NF_BR_PRE_ROUTING,
@@ -133,7 +139,7 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 		ether_addr_copy(eth_hdr(skb)->h_dest, dev->dev_addr);
 		skb->pkt_type = PACKET_HOST;
 	} else {
-		rt = bridge_parent_rtable(nf_bridge->physindev);
+		rt = bridge_parent_rtable(br_indev);
 		if (!rt) {
 			kfree_skb(skb);
 			return 0;
@@ -142,7 +148,7 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 		skb_dst_set_noref(skb, &rt->dst);
 	}
 
-	skb->dev = nf_bridge->physindev;
+	skb->dev = br_indev;
 	nf_bridge_update_protocol(skb);
 	nf_bridge_push_encap_header(skb);
 	br_nf_hook_thresh(NF_BR_PRE_ROUTING, net, sk, skb,
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 297000b05f18..fc761915c5f6 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -239,7 +239,6 @@ static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
 void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		   int hook)
 {
-	struct net_device *br_indev __maybe_unused;
 	struct sk_buff *nskb;
 	struct iphdr *niph;
 	const struct tcphdr *oth;
@@ -289,9 +288,13 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	 * build the eth header using the original destination's MAC as the
 	 * source, and send the RST packet directly.
 	 */
-	br_indev = nf_bridge_get_physindev(oldskb, net);
-	if (br_indev) {
+	if (nf_bridge_info_exists(oldskb)) {
 		struct ethhdr *oeth = eth_hdr(oldskb);
+		struct net_device *br_indev;
+
+		br_indev = nf_bridge_get_physindev(oldskb, net);
+		if (!br_indev)
+			goto free_nskb;
 
 		nskb->dev = br_indev;
 		niph->tot_len = htons(nskb->len);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 0a5ef7abf583..71d692728230 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -278,7 +278,6 @@ static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
-	struct net_device *br_indev __maybe_unused;
 	struct sk_buff *nskb;
 	struct tcphdr _otcph;
 	const struct tcphdr *otcph;
@@ -354,9 +353,15 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	 * build the eth header using the original destination's MAC as the
 	 * source, and send the RST packet directly.
 	 */
-	br_indev = nf_bridge_get_physindev(oldskb, net);
-	if (br_indev) {
+	if (nf_bridge_info_exists(oldskb)) {
 		struct ethhdr *oeth = eth_hdr(oldskb);
+		struct net_device *br_indev;
+
+		br_indev = nf_bridge_get_physindev(oldskb, net);
+		if (!br_indev) {
+			kfree_skb(nskb);
+			return;
+		}
 
 		nskb->dev = br_indev;
 		nskb->protocol = htons(ETH_P_IPV6);
-- 
2.43.0




