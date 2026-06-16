Return-Path: <stable+bounces-264331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xoIxAMNyMWp0jgUAu9opvQ
	(envelope-from <stable+bounces-264331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D8A69196D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pz5EKcbH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264331-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264331-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6B3F3045009
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0F544E02A;
	Tue, 16 Jun 2026 15:55:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07444D03B;
	Tue, 16 Jun 2026 15:55:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625341; cv=none; b=EnYLY294TDg3xzIcF3DYacfxB8O/GBChQ6RUHkTkW7oHe5RaAxnh2bek1BfIJmTy+gQgUwSGeNvhvGsMq+5unl/AbWg9lSgSjdtVVoVoOQhnm31HKU6FBVFZp8H+GyBr8hlOJ6T9r2QI3UYSD77Ks2hDlaiKsLQy537wdAKHkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625341; c=relaxed/simple;
	bh=d5taYKki5HIG/hvDav6DmyUZ7FSctresIZVkQPpfbfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/ooqr+VGwUUfiSKTXO2JlFQOSwD4EnKsC5BpY7QW/MKwEWV62mKDzcIa7ElTD4D+o9uzCcrCfzF+dkdQdIXIrWKB9qBgn3EWEgk+RlsBefemdyQAnDW81PPpUEcnd85jxtvLZiMpSO0FE5MGtp5M8u4LTYcLyK/a7NO35Yc/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pz5EKcbH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D384B1F00A3D;
	Tue, 16 Jun 2026 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625339;
	bh=vkEFDOrfauel3yyO1khiwhnDHuqr9xKKABwaLs0uhC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pz5EKcbH3Cbiz264AEJY6ej+UO3CbUhII1nSJ/+zCXbzTgmgeKV0gGJU9FGA+8U4V
	 AGzIzHYnzZsMjQJPyX1xFXj8Y9jZeJ51WuGpVUlCzdwy+oKCymHaBk4SpS3jxzwRj1
	 X9YGb+jLVdRYkgbbLXclagqnN1dAOgVdjnRVUBvw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jian Zhou <eilaimemedsnaimel@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 124/325] netfilter: revalidate bridge ports
Date: Tue, 16 Jun 2026 20:28:40 +0530
Message-ID: <20260616145103.893440494@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,strlen.de,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-264331-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:eilaimemedsnaimel@gmail.com,m:fw@strlen.de,m:pablo@netfilter.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78D8A69196D

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit ccb9fd4b87538ccf19ccff78ee26700526d94867 ]

ebt_redirect_tg() dereferences br_port_get_rcu() return without a
NULL check, causing a kernel panic when the bridge port has been
removed between the original hook invocation and an NFQUEUE
reinject.

A mere NULL check isn't sufficient, however.  As sashiko review
points out userspace can not only remove the port from the bridge,
it could also place the device in a different virtual device, e.g.
macvlan.

If this happens, we must drop the packet, there is no way for us to
reinject it into the bridge path.

Switch to _upper API, we don't need the bridge port structure.
Also, this fix keeps another bug intact:

Both nfnetlink_log and nfnetlink_queue use CONFIG_BRIDGE_NETFILTER
too aggressive, which prevents certain logging features when queueing
in bridge family: NETFILTER_FAMILY_BRIDGE can be enabled while the old
CONFIG_BRIDGE_NETFILTER cruft is off.

Fixes tag is a common ancestor, this was always broken.

Fixes: f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bridge_port pointer")
Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebt_dnat.c     |  4 +-
 net/bridge/netfilter/ebt_redirect.c | 16 +++++---
 net/netfilter/nfnetlink_log.c       | 23 +++++++++--
 net/netfilter/nfnetlink_queue.c     | 64 +++++++++++++++++++++++++----
 4 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/net/bridge/netfilter/ebt_dnat.c b/net/bridge/netfilter/ebt_dnat.c
index 3fda71a8579d13..73f185cccd63df 100644
--- a/net/bridge/netfilter/ebt_dnat.c
+++ b/net/bridge/netfilter/ebt_dnat.c
@@ -39,7 +39,9 @@ ebt_dnat_tg(struct sk_buff *skb, const struct xt_action_param *par)
 			dev = xt_in(par);
 			break;
 		case NF_BR_PRE_ROUTING:
-			dev = br_port_get_rcu(xt_in(par))->br->dev;
+			dev = netdev_master_upper_dev_get_rcu(xt_in(par));
+			if (!dev) /* bridge port removed? */
+				return EBT_DROP;
 			break;
 		default:
 			dev = NULL;
diff --git a/net/bridge/netfilter/ebt_redirect.c b/net/bridge/netfilter/ebt_redirect.c
index 307790562b4929..83486cd4d564b1 100644
--- a/net/bridge/netfilter/ebt_redirect.c
+++ b/net/bridge/netfilter/ebt_redirect.c
@@ -24,12 +24,18 @@ ebt_redirect_tg(struct sk_buff *skb, const struct xt_action_param *par)
 	if (skb_ensure_writable(skb, 0))
 		return EBT_DROP;
 
-	if (xt_hooknum(par) != NF_BR_BROUTING)
-		/* rcu_read_lock()ed by nf_hook_thresh */
-		ether_addr_copy(eth_hdr(skb)->h_dest,
-				br_port_get_rcu(xt_in(par))->br->dev->dev_addr);
-	else
+	if (xt_hooknum(par) != NF_BR_BROUTING) {
+		const struct net_device *dev;
+
+		dev = netdev_master_upper_dev_get_rcu(xt_in(par));
+		if (!dev)
+			return EBT_DROP;
+
+		ether_addr_copy(eth_hdr(skb)->h_dest, dev->dev_addr);
+	} else {
 		ether_addr_copy(eth_hdr(skb)->h_dest, xt_in(par)->dev_addr);
+	}
+
 	skb->pkt_type = PACKET_HOST;
 	return info->target;
 }
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index b1f3eda85989cd..25a30bf722c69a 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -450,6 +450,23 @@ static int nfulnl_put_bridge(struct nfulnl_instance *inst, const struct sk_buff
 	return -1;
 }
 
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+static int nflog_put_master_ifindex(struct sk_buff *nlskb, int attr,
+				    const struct net_device *dev)
+{
+	const struct net_device *upper;
+
+	if (dev && !netif_is_bridge_port(dev))
+		return 0;
+
+	upper = netdev_master_upper_dev_get_rcu((struct net_device *)dev);
+	if (upper && nla_put_be32(nlskb, attr, htonl(upper->ifindex)))
+		return -EMSGSIZE;
+
+	return 0;
+}
+#endif
+
 /* This is an inline function, we don't really care about a long
  * list of arguments */
 static inline int
@@ -504,8 +521,7 @@ __build_packet_message(struct nfnl_log_net *log,
 			/* rcu_read_lock()ed by nf_hook_thresh or
 			 * nf_log_packet.
 			 */
-			    nla_put_be32(inst->skb, NFULA_IFINDEX_INDEV,
-					 htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
+			    nflog_put_master_ifindex(inst->skb, NFULA_IFINDEX_INDEV, indev))
 				goto nla_put_failure;
 		} else {
 			int physinif;
@@ -541,8 +557,7 @@ __build_packet_message(struct nfnl_log_net *log,
 			/* rcu_read_lock()ed by nf_hook_thresh or
 			 * nf_log_packet.
 			 */
-			    nla_put_be32(inst->skb, NFULA_IFINDEX_OUTDEV,
-					 htonl(br_port_get_rcu(outdev)->br->dev->ifindex)))
+			    nflog_put_master_ifindex(inst->skb, NFULA_IFINDEX_OUTDEV, outdev))
 				goto nla_put_failure;
 		} else {
 			struct net_device *physoutdev;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index d42e8ac3062fb1..0a5aa6b90fc271 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -426,10 +426,47 @@ static bool nf_ct_drop_unconfirmed(const struct nf_queue_entry *entry, bool *is_
 	return false;
 }
 
+static bool nf_bridge_port_valid(const struct net_device *dev)
+{
+	if (!dev)
+		return true;
+
+	return netif_is_bridge_port(dev);
+}
+
+/* queued skbs leave rcu protection.  We bump device refcount so that
+ * the device cannot go away.  However, while packet was out the port
+ * could have been removed from the bridge.
+ *
+ * Ensure in+outdev are still part of a bridge at reinject time.
+ *
+ * The device rx_handler_data could even be pointing at data that is
+ * not a net_bridge_port structure.
+ */
+static bool nf_bridge_ports_valid(const struct nf_queue_entry *entry)
+{
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	if (!nf_bridge_port_valid(entry->physin) ||
+	    !nf_bridge_port_valid(entry->physout))
+		return false;
+#endif
+	if (entry->state.pf != PF_BRIDGE)
+		return true;
+
+	if (!nf_bridge_port_valid(entry->state.in) ||
+	    !nf_bridge_port_valid(entry->state.out))
+		return false;
+
+	return true;
+}
+
 static void nfqnl_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 {
 	const struct nf_ct_hook *ct_hook;
 
+	if (!nf_bridge_ports_valid(entry))
+		verdict = NF_DROP;
+
 	if (verdict == NF_ACCEPT ||
 	    verdict == NF_REPEAT ||
 	    verdict == NF_STOP) {
@@ -622,6 +659,23 @@ static int nf_queue_checksum_help(struct sk_buff *entskb)
 	return skb_checksum_help(entskb);
 }
 
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+static int nfqnl_put_master_ifindex(struct sk_buff *nlskb, int attr,
+				    const struct net_device *dev)
+{
+	const struct net_device *upper;
+
+	if (dev && !netif_is_bridge_port(dev))
+		return 0;
+
+	upper = netdev_master_upper_dev_get_rcu((struct net_device *)dev);
+	if (upper && nla_put_be32(nlskb, attr, htonl(upper->ifindex)))
+		return -EMSGSIZE;
+
+	return 0;
+}
+#endif
+
 static struct sk_buff *
 nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 			   struct nf_queue_entry *entry,
@@ -757,10 +811,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 			 * netfilter_bridge) */
 			if (nla_put_be32(skb, NFQA_IFINDEX_PHYSINDEV,
 					 htonl(indev->ifindex)) ||
-			/* this is the bridge group "brX" */
-			/* rcu_read_lock()ed by __nf_queue */
-			    nla_put_be32(skb, NFQA_IFINDEX_INDEV,
-					 htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
+			    nfqnl_put_master_ifindex(skb, NFQA_IFINDEX_INDEV, indev))
 				goto nla_put_failure;
 		} else {
 			int physinif;
@@ -791,10 +842,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 			 * netfilter_bridge) */
 			if (nla_put_be32(skb, NFQA_IFINDEX_PHYSOUTDEV,
 					 htonl(outdev->ifindex)) ||
-			/* this is the bridge group "brX" */
-			/* rcu_read_lock()ed by __nf_queue */
-			    nla_put_be32(skb, NFQA_IFINDEX_OUTDEV,
-					 htonl(br_port_get_rcu(outdev)->br->dev->ifindex)))
+			    nfqnl_put_master_ifindex(skb, NFQA_IFINDEX_OUTDEV, outdev))
 				goto nla_put_failure;
 		} else {
 			int physoutif;
-- 
2.53.0




