Return-Path: <stable+bounces-26424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09196870E86
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A952B21F7A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA1E78B69;
	Mon,  4 Mar 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/byfuuB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30010A35;
	Mon,  4 Mar 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588683; cv=none; b=m56rHYwNUAU2d2nGjEsNBShRZO7Waw9BCuBNPDYaP0znDgX2WzE/MfAI+y8Del/RSQogpEAAmDymc/T0aqFOQQ46yPdNyFMzgf3Zx6ilGpNU9BW/L3MwC6weNaYmunV8G0q1PzXe7qnSzDRb8i1Cneso79K2pa05E1X4UVTGrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588683; c=relaxed/simple;
	bh=s9A7M78eW4Yf2cC3fij4bbO9OBbE2uTIFqf1q2Ii4JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jN44c8plIdjbN47KpRz76zqge3jXh0odAuXeBJP9bLSpVU1eo5JQBqqVj12kwJDxqB+Koa/hsOAb7ldVajY3GHJzenDX4dwDO8kDNg+kVD5mKnt+msZZKCJyBPcEk5mjSHGRL+n91r5k3K7Q9YSPpqlULiebOu9HqcKuxFPzUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/byfuuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDD6C433C7;
	Mon,  4 Mar 2024 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588682;
	bh=s9A7M78eW4Yf2cC3fij4bbO9OBbE2uTIFqf1q2Ii4JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/byfuuBCwkYAasqdr5q16HzFx8vix/rHzmnBOO37AGEdTWWzU8RTLby90oiAxWLf
	 W5oVcJyv0GeV7CFSbtxFlr3a+pOac51SVEaTq/2zHArs3c/9NEXDBWYAf8/UFMMpF0
	 xbH/D3/bHG9P9dAmDvriHGvTRJO4AHRdyKxaDqn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Russel King <linux@armlinux.org.uk>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/215] netfilter: let reset rules clean out conntrack entries
Date: Mon,  4 Mar 2024 21:22:00 +0000
Message-ID: <20240304211558.789609848@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 2954fe60e33da0f4de4d81a4c95c7dddb517d00c ]

iptables/nftables support responding to tcp packets with tcp resets.

The generated tcp reset packet passes through both output and postrouting
netfilter hooks, but conntrack will never see them because the generated
skb has its ->nfct pointer copied over from the packet that triggered the
reset rule.

If the reset rule is used for established connections, this
may result in the conntrack entry to be around for a very long
time (default timeout is 5 days).

One way to avoid this would be to not copy the nf_conn pointer
so that the rest packet passes through conntrack too.

Problem is that output rules might not have the same conntrack
zone setup as the prerouting ones, so its possible that the
reset skb won't find the correct entry.  Generating a template
entry for the skb seems error prone as well.

Add an explicit "closing" function that switches a confirmed
conntrack entry to closed state and wire this up for tcp.

If the entry isn't confirmed, no action is needed because
the conntrack entry will never be committed to the table.

Reported-by: Russel King <linux@armlinux.org.uk>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 62e7151ae3eb ("netfilter: bridge: confirm multicast packets before passing them up the stack")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter.h              |  3 +++
 include/net/netfilter/nf_conntrack.h   |  8 ++++++
 net/ipv4/netfilter/nf_reject_ipv4.c    |  1 +
 net/ipv6/netfilter/nf_reject_ipv6.c    |  1 +
 net/netfilter/core.c                   | 16 ++++++++++++
 net/netfilter/nf_conntrack_core.c      | 12 +++++++++
 net/netfilter/nf_conntrack_proto_tcp.c | 35 ++++++++++++++++++++++++++
 7 files changed, 76 insertions(+)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index bef8db9d6c085..c8e03bcaecaaa 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -437,11 +437,13 @@ nf_nat_decode_session(struct sk_buff *skb, struct flowi *fl, u_int8_t family)
 #include <linux/netfilter/nf_conntrack_zones_common.h>
 
 void nf_ct_attach(struct sk_buff *, const struct sk_buff *);
+void nf_ct_set_closing(struct nf_conntrack *nfct);
 struct nf_conntrack_tuple;
 bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 			 const struct sk_buff *skb);
 #else
 static inline void nf_ct_attach(struct sk_buff *new, struct sk_buff *skb) {}
+static inline void nf_ct_set_closing(struct nf_conntrack *nfct) {}
 struct nf_conntrack_tuple;
 static inline bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 				       const struct sk_buff *skb)
@@ -459,6 +461,7 @@ struct nf_ct_hook {
 	bool (*get_tuple_skb)(struct nf_conntrack_tuple *,
 			      const struct sk_buff *);
 	void (*attach)(struct sk_buff *nskb, const struct sk_buff *skb);
+	void (*set_closing)(struct nf_conntrack *nfct);
 };
 extern const struct nf_ct_hook __rcu *nf_ct_hook;
 
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 6a2019aaa4644..3dbf947285be2 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -125,6 +125,12 @@ struct nf_conn {
 	union nf_conntrack_proto proto;
 };
 
+static inline struct nf_conn *
+nf_ct_to_nf_conn(const struct nf_conntrack *nfct)
+{
+	return container_of(nfct, struct nf_conn, ct_general);
+}
+
 static inline struct nf_conn *
 nf_ct_tuplehash_to_ctrack(const struct nf_conntrack_tuple_hash *hash)
 {
@@ -175,6 +181,8 @@ nf_ct_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
 
 void nf_ct_destroy(struct nf_conntrack *nfct);
 
+void nf_conntrack_tcp_set_closing(struct nf_conn *ct);
+
 /* decrement reference count on a conntrack */
 static inline void nf_ct_put(struct nf_conn *ct)
 {
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 4073762996e22..fc761915c5f6f 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -279,6 +279,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		goto free_nskb;
 
 	nf_ct_attach(nskb, oldskb);
+	nf_ct_set_closing(skb_nfct(oldskb));
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* If we use ip_local_out for bridged traffic, the MAC source on
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 433d98bbe33f7..71d692728230e 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -344,6 +344,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, otcph, otcplen);
 
 	nf_ct_attach(nskb, oldskb);
+	nf_ct_set_closing(skb_nfct(oldskb));
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* If we use ip6_local_out for bridged traffic, the MAC source on
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 55a7f72d547cd..edf92074221e2 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -707,6 +707,22 @@ void nf_conntrack_destroy(struct nf_conntrack *nfct)
 }
 EXPORT_SYMBOL(nf_conntrack_destroy);
 
+void nf_ct_set_closing(struct nf_conntrack *nfct)
+{
+	const struct nf_ct_hook *ct_hook;
+
+	if (!nfct)
+		return;
+
+	rcu_read_lock();
+	ct_hook = rcu_dereference(nf_ct_hook);
+	if (ct_hook)
+		ct_hook->set_closing(nfct);
+
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(nf_ct_set_closing);
+
 bool nf_ct_get_tuple_skb(struct nf_conntrack_tuple *dst_tuple,
 			 const struct sk_buff *skb)
 {
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 7960262966094..6d30c64a5fe86 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2772,11 +2772,23 @@ int nf_conntrack_init_start(void)
 	return ret;
 }
 
+static void nf_conntrack_set_closing(struct nf_conntrack *nfct)
+{
+	struct nf_conn *ct = nf_ct_to_nf_conn(nfct);
+
+	switch (nf_ct_protonum(ct)) {
+	case IPPROTO_TCP:
+		nf_conntrack_tcp_set_closing(ct);
+		break;
+	}
+}
+
 static const struct nf_ct_hook nf_conntrack_hook = {
 	.update		= nf_conntrack_update,
 	.destroy	= nf_ct_destroy,
 	.get_tuple_skb  = nf_conntrack_get_tuple_skb,
 	.attach		= nf_conntrack_attach,
+	.set_closing	= nf_conntrack_set_closing,
 };
 
 void nf_conntrack_init_end(void)
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index e0092bf273fd0..9480e638e5d15 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -913,6 +913,41 @@ static bool tcp_can_early_drop(const struct nf_conn *ct)
 	return false;
 }
 
+void nf_conntrack_tcp_set_closing(struct nf_conn *ct)
+{
+	enum tcp_conntrack old_state;
+	const unsigned int *timeouts;
+	u32 timeout;
+
+	if (!nf_ct_is_confirmed(ct))
+		return;
+
+	spin_lock_bh(&ct->lock);
+	old_state = ct->proto.tcp.state;
+	ct->proto.tcp.state = TCP_CONNTRACK_CLOSE;
+
+	if (old_state == TCP_CONNTRACK_CLOSE ||
+	    test_bit(IPS_FIXED_TIMEOUT_BIT, &ct->status)) {
+		spin_unlock_bh(&ct->lock);
+		return;
+	}
+
+	timeouts = nf_ct_timeout_lookup(ct);
+	if (!timeouts) {
+		const struct nf_tcp_net *tn;
+
+		tn = nf_tcp_pernet(nf_ct_net(ct));
+		timeouts = tn->timeouts;
+	}
+
+	timeout = timeouts[TCP_CONNTRACK_CLOSE];
+	WRITE_ONCE(ct->timeout, timeout + nfct_time_stamp);
+
+	spin_unlock_bh(&ct->lock);
+
+	nf_conntrack_event_cache(IPCT_PROTOINFO, ct);
+}
+
 static void nf_ct_tcp_state_reset(struct ip_ct_tcp_state *state)
 {
 	state->td_end		= 0;
-- 
2.43.0




