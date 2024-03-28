Return-Path: <stable+bounces-26633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9640A870F6F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9761C2109D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA778B4C;
	Mon,  4 Mar 2024 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iJN158M/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970271C6AB;
	Mon,  4 Mar 2024 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589277; cv=none; b=uYZ11bh8L1cIxgwMGXiviMU2oMOBnVjpnp/E07aMRfqYONGXsbwn6EMl250nlbLXPK+U8VpStgFSN55j6m3UGEVdH0RyV+hBHeA7TfLHT5s7VKLqByKlqnUPpSGpaRi/ifntbmFWPd9pe0cZaAygaAZpVuk10bGaLyGQ0GuDtkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589277; c=relaxed/simple;
	bh=++VUFxvspSsfzjgyAgGF5Gs/90sYEVbfP41CN6sxBzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axcsODnGIyJatnjL/4MIX/uebWstDQDwR7fuQbJUGohmvXRP8emKlitOH3KiqdrAq2YnUe4KDNqOSPD13j/qPmjlzd7fupuNwFBE2aMGwSkY5/vvfXs9wVPKAH+CmhqnFL901C32TKFzWozk5149djNPFTWEZ1ne3zl6KGoI7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iJN158M/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2763BC433C7;
	Mon,  4 Mar 2024 21:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589277;
	bh=++VUFxvspSsfzjgyAgGF5Gs/90sYEVbfP41CN6sxBzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJN158M/DeS/rN+w4HDCCppGdf4uFimW8q1Q7TF6bZqmd0EKvrSRI2XDdrpQAoQ5S
	 ueAt9JB7tgX4Gis9ifv59DFfboBmS23lrgAHlCY5lSQI6k2p6/+zurjulsSiZemMvd
	 1N+CWZG4IbpKD/GFaj+aLYUXZnxw7EQvmHHt3arg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Russel King <linux@armlinux.org.uk>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 23/84] netfilter: let reset rules clean out conntrack entries
Date: Mon,  4 Mar 2024 21:23:56 +0000
Message-ID: <20240304211543.097262040@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 5a665034c30be..c92bb1580f419 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -436,11 +436,13 @@ nf_nat_decode_session(struct sk_buff *skb, struct flowi *fl, u_int8_t family)
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
@@ -458,6 +460,7 @@ struct nf_ct_hook {
 	bool (*get_tuple_skb)(struct nf_conntrack_tuple *,
 			      const struct sk_buff *);
 	void (*attach)(struct sk_buff *nskb, const struct sk_buff *skb);
+	void (*set_closing)(struct nf_conntrack *nfct);
 };
 extern const struct nf_ct_hook __rcu *nf_ct_hook;
 
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 34c266502a50e..39541ab912a16 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -123,6 +123,12 @@ struct nf_conn {
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
@@ -173,6 +179,8 @@ nf_ct_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
 
 void nf_ct_destroy(struct nf_conntrack *nfct);
 
+void nf_conntrack_tcp_set_closing(struct nf_conn *ct);
+
 /* decrement reference count on a conntrack */
 static inline void nf_ct_put(struct nf_conn *ct)
 {
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index f2edb40c0db00..350aaca126181 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -278,6 +278,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		goto free_nskb;
 
 	nf_ct_attach(nskb, oldskb);
+	nf_ct_set_closing(skb_nfct(oldskb));
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* If we use ip_local_out for bridged traffic, the MAC source on
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index dffeaaaadcded..c0057edd84cfc 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -345,6 +345,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, otcph, otcplen);
 
 	nf_ct_attach(nskb, oldskb);
+	nf_ct_set_closing(skb_nfct(oldskb));
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* If we use ip6_local_out for bridged traffic, the MAC source on
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index aa3f7d3228fda..fe81824799d95 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -674,6 +674,22 @@ void nf_conntrack_destroy(struct nf_conntrack *nfct)
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
index 2a4222eefc894..e0f4f76439d3d 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2833,11 +2833,23 @@ int nf_conntrack_init_start(void)
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
index 1ecfdc4f23be8..f33e6aea7f4da 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -870,6 +870,41 @@ static bool tcp_can_early_drop(const struct nf_conn *ct)
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




