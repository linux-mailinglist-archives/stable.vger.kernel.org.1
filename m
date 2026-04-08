Return-Path: <stable+bounces-234310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLYjFXed1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:24:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D63C0A6D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE817301B853
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E543ACA41;
	Wed,  8 Apr 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f9PIEukW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BB324B1F;
	Wed,  8 Apr 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672527; cv=none; b=Z7FkAhwm0gtmvA41sXQR+TlTP0XKfjkXHNY/lFHRiDFTL+vd+lZX/tZQxtgp2Q8bBvs3Uiz8PGqeyK15GtDjg2CqXuLQYMXka33Hqg+dIqE4XateJNxoZsvT0HwZltQJpiqIUD0tExDNmTg2zW/xOGL/2E+xHlcHA+03pS5RVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672527; c=relaxed/simple;
	bh=IMx1FBI4LVS9waVTGL964wOW5t4OFw2dAeaUsVNMXcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzKJ1jEinsoFtsr0/d51yZgFzNPCrCC1l2Ln5dBH5eIw5wVBwapZoZiu/qcUgt+Sc7UL3IJ5b2HP0MLghwbIWp5dykoTp3L79aKZctnNRszrbfmt2aNVH7rlxCabVe1VVACxcTtiKnMorNJEwIwYWd8swMVf3LoFZk/5I9TVI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f9PIEukW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9AFC19421;
	Wed,  8 Apr 2026 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672527;
	bh=IMx1FBI4LVS9waVTGL964wOW5t4OFw2dAeaUsVNMXcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9PIEukWsVeFYKu/XlEQmhGQgDOscWFDsfb9TN+TC0gT1MVJ/zVDQe3zIyop/T1gT
	 hpXCyYSks5aGBb+MoYjuVi9c9B2FvVIHLjx4UdWGX44JIm+PRc3sMTcLplB8yY3ePi
	 vHW5BHeALkWcuRVNVO7n0Q8qCnifS5/qmlYRx/+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 042/160] netfilter: nf_conntrack_expect: store netns and zone in expectation
Date: Wed,  8 Apr 2026 20:02:09 +0200
Message-ID: <20260408175914.780728795@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234310-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,netfilter.org:email,strlen.de:email]
X-Rspamd-Queue-Id: 739D63C0A6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 02a3231b6d82efe750da6554ebf280e4a6f78756 ]

__nf_ct_expect_find() and nf_ct_expect_find_get() are called under
rcu_read_lock() but they dereference the master conntrack via
exp->master.

Since the expectation does not hold a reference on the master conntrack,
this could be dying conntrack or different recycled conntrack than the
real master due to SLAB_TYPESAFE_RCU.

Store the netns, the master_tuple and the zone in struct
nf_conntrack_expect as a safety measure.

This patch is required by the follow up fix not to dump expectations
that do not belong to this netns.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 917b61fa2042 ("netfilter: ctnetlink: ignore explicit helper on new expectations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_expect.h | 18 +++++++++++++++++-
 net/netfilter/nf_conntrack_broadcast.c      |  6 +++++-
 net/netfilter/nf_conntrack_expect.c         |  9 +++++++--
 net/netfilter/nf_conntrack_netlink.c        |  5 +++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_expect.h b/include/net/netfilter/nf_conntrack_expect.h
index 1b01400b10bdb..e9a8350e7ccfb 100644
--- a/include/net/netfilter/nf_conntrack_expect.h
+++ b/include/net/netfilter/nf_conntrack_expect.h
@@ -22,10 +22,16 @@ struct nf_conntrack_expect {
 	/* Hash member */
 	struct hlist_node hnode;
 
+	/* Network namespace */
+	possible_net_t net;
+
 	/* We expect this tuple, with the following mask */
 	struct nf_conntrack_tuple tuple;
 	struct nf_conntrack_tuple_mask mask;
 
+#ifdef CONFIG_NF_CONNTRACK_ZONES
+	struct nf_conntrack_zone zone;
+#endif
 	/* Usage count. */
 	refcount_t use;
 
@@ -62,7 +68,17 @@ struct nf_conntrack_expect {
 
 static inline struct net *nf_ct_exp_net(struct nf_conntrack_expect *exp)
 {
-	return nf_ct_net(exp->master);
+	return read_pnet(&exp->net);
+}
+
+static inline bool nf_ct_exp_zone_equal_any(const struct nf_conntrack_expect *a,
+					    const struct nf_conntrack_zone *b)
+{
+#ifdef CONFIG_NF_CONNTRACK_ZONES
+	return a->zone.id == b->id;
+#else
+	return true;
+#endif
 }
 
 #define NF_CT_EXP_POLICY_NAME_LEN	16
diff --git a/net/netfilter/nf_conntrack_broadcast.c b/net/netfilter/nf_conntrack_broadcast.c
index 721b3e87416be..d44d9379a8a08 100644
--- a/net/netfilter/nf_conntrack_broadcast.c
+++ b/net/netfilter/nf_conntrack_broadcast.c
@@ -21,6 +21,7 @@ int nf_conntrack_broadcast_help(struct sk_buff *skb,
 				unsigned int timeout)
 {
 	const struct nf_conntrack_helper *helper;
+	struct net *net = read_pnet(&ct->ct_net);
 	struct nf_conntrack_expect *exp;
 	struct iphdr *iph = ip_hdr(skb);
 	struct rtable *rt = skb_rtable(skb);
@@ -71,7 +72,10 @@ int nf_conntrack_broadcast_help(struct sk_buff *skb,
 	exp->flags                = NF_CT_EXPECT_PERMANENT;
 	exp->class		  = NF_CT_EXPECT_CLASS_DEFAULT;
 	rcu_assign_pointer(exp->helper, helper);
-
+	write_pnet(&exp->net, net);
+#ifdef CONFIG_NF_CONNTRACK_ZONES
+	exp->zone = ct->zone;
+#endif
 	nf_ct_expect_related(exp, 0);
 	nf_ct_expect_put(exp);
 
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index e0eb844c2cdcb..70bcddfc17ccc 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -112,8 +112,8 @@ nf_ct_exp_equal(const struct nf_conntrack_tuple *tuple,
 		const struct net *net)
 {
 	return nf_ct_tuple_mask_cmp(tuple, &i->tuple, &i->mask) &&
-	       net_eq(net, nf_ct_net(i->master)) &&
-	       nf_ct_zone_equal_any(i->master, zone);
+	       net_eq(net, read_pnet(&i->net)) &&
+	       nf_ct_exp_zone_equal_any(i, zone);
 }
 
 bool nf_ct_remove_expect(struct nf_conntrack_expect *exp)
@@ -321,6 +321,7 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 {
 	struct nf_conntrack_helper *helper = NULL;
 	struct nf_conn *ct = exp->master;
+	struct net *net = read_pnet(&ct->ct_net);
 	struct nf_conn_help *help;
 	int len;
 
@@ -338,6 +339,10 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 		helper = rcu_dereference(help->helper);
 
 	rcu_assign_pointer(exp->helper, helper);
+	write_pnet(&exp->net, net);
+#ifdef CONFIG_NF_CONNTRACK_ZONES
+	exp->zone = ct->zone;
+#endif
 	exp->tuple.src.l3num = family;
 	exp->tuple.dst.protonum = proto;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 2a601dc58b856..d7acd3e967425 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3510,6 +3510,7 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 		       struct nf_conntrack_tuple *tuple,
 		       struct nf_conntrack_tuple *mask)
 {
+	struct net *net = read_pnet(&ct->ct_net);
 	struct nf_conntrack_expect *exp;
 	struct nf_conn_help *help;
 	u32 class = 0;
@@ -3549,6 +3550,10 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 
 	exp->class = class;
 	exp->master = ct;
+	write_pnet(&exp->net, net);
+#ifdef CONFIG_NF_CONNTRACK_ZONES
+	exp->zone = ct->zone;
+#endif
 	if (!helper)
 		helper = rcu_dereference(help->helper);
 	rcu_assign_pointer(exp->helper, helper);
-- 
2.53.0




