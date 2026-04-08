Return-Path: <stable+bounces-234503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOIVFuai1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:48:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC23C1946
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3AE5311BDAE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794B3D8904;
	Wed,  8 Apr 2026 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZu4jUKK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA323D88F7;
	Wed,  8 Apr 2026 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673029; cv=none; b=DZZEjCj3rr8Z6nPcGa9qnyxzqBxAOoTNpPb/qOzxjl4X4oE4MdRhVBijb9aaHRcnQ2jJzZFqQ3LrfbIJPyey8IMVI7ZOFVNGukpUzsRlZK+sjyqjUe0RiSkUcrJZcvu7AqOvdbtLNbdNntOtbSaZj8lJoZJcEGu74EbuOXfy5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673029; c=relaxed/simple;
	bh=16AUHWGiixnIzLX36sTAB06uOoSOuanRutZqTm51rVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mn/5RyURYsOY7TyqdoGp9yJ3pw6U5XqDJfWqtpLRHpkuifKsI8Ocj7gVp66sEaspI6INwzpKAovytXz4opmJFsXF28ybkuPsZjNts5sgKlGr89k5+6IjAvlr3vLYE4Chw4dIcY+oGDrRqErmvscW3W2xlKtKwDZQJq5J88bjOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GZu4jUKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E55C19421;
	Wed,  8 Apr 2026 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673029;
	bh=16AUHWGiixnIzLX36sTAB06uOoSOuanRutZqTm51rVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZu4jUKK0ACSPcK8uZiTa1eUfFSqpT2wkh3cd7QlkkZCoBXt8Q6W2YC6B2uiO02Zz
	 88/JrlVoAKxxsocKclZ6Wcgj1gElimrTABaBTf/+pACMUtwHP1EyA3e676VGFjLgCo
	 kfEhM/dXtM74si2FwHNifIy8lqlAkJ/XC9KSGATY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 072/277] netfilter: nf_conntrack_expect: honor expectation helper field
Date: Wed,  8 Apr 2026 20:00:57 +0200
Message-ID: <20260408175936.550515155@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234503-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9FC23C1946
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 9c42bc9db90a154bc61ae337a070465f3393485a ]

The expectation helper field is mostly unused. As a result, the
netfilter codebase relies on accessing the helper through exp->master.

Always set on the expectation helper field so it can be used to reach
the helper.

nf_ct_expect_init() is called from packet path where the skb owns
the ct object, therefore accessing exp->master for the newly created
expectation is safe. This saves a lot of updates in all callsites
to pass the ct object as parameter to nf_ct_expect_init().

This is a preparation patches for follow up fixes.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 917b61fa2042 ("netfilter: ctnetlink: ignore explicit helper on new expectations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_expect.h |  2 +-
 net/netfilter/nf_conntrack_broadcast.c      |  2 +-
 net/netfilter/nf_conntrack_expect.c         | 14 +++++++++++++-
 net/netfilter/nf_conntrack_h323_main.c      | 12 ++++++------
 net/netfilter/nf_conntrack_helper.c         |  7 ++++++-
 net/netfilter/nf_conntrack_netlink.c        |  2 +-
 net/netfilter/nf_conntrack_sip.c            |  2 +-
 7 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_expect.h b/include/net/netfilter/nf_conntrack_expect.h
index 165e7a03b8e9d..1b01400b10bdb 100644
--- a/include/net/netfilter/nf_conntrack_expect.h
+++ b/include/net/netfilter/nf_conntrack_expect.h
@@ -40,7 +40,7 @@ struct nf_conntrack_expect {
 			 struct nf_conntrack_expect *this);
 
 	/* Helper to assign to new connection */
-	struct nf_conntrack_helper *helper;
+	struct nf_conntrack_helper __rcu *helper;
 
 	/* The conntrack of the master connection */
 	struct nf_conn *master;
diff --git a/net/netfilter/nf_conntrack_broadcast.c b/net/netfilter/nf_conntrack_broadcast.c
index a7552a46d6acf..1964c596c6468 100644
--- a/net/netfilter/nf_conntrack_broadcast.c
+++ b/net/netfilter/nf_conntrack_broadcast.c
@@ -70,7 +70,7 @@ int nf_conntrack_broadcast_help(struct sk_buff *skb,
 	exp->expectfn             = NULL;
 	exp->flags                = NF_CT_EXPECT_PERMANENT;
 	exp->class		  = NF_CT_EXPECT_CLASS_DEFAULT;
-	exp->helper               = NULL;
+	rcu_assign_pointer(exp->helper, helper);
 
 	nf_ct_expect_related(exp, 0);
 	nf_ct_expect_put(exp);
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 227fb5dc39e27..6739b48c644fc 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -309,12 +309,19 @@ struct nf_conntrack_expect *nf_ct_expect_alloc(struct nf_conn *me)
 }
 EXPORT_SYMBOL_GPL(nf_ct_expect_alloc);
 
+/* This function can only be used from packet path, where accessing
+ * master's helper is safe, because the packet holds a reference on
+ * the conntrack object. Never use it from control plane.
+ */
 void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 		       u_int8_t family,
 		       const union nf_inet_addr *saddr,
 		       const union nf_inet_addr *daddr,
 		       u_int8_t proto, const __be16 *src, const __be16 *dst)
 {
+	struct nf_conntrack_helper *helper = NULL;
+	struct nf_conn *ct = exp->master;
+	struct nf_conn_help *help;
 	int len;
 
 	if (family == AF_INET)
@@ -325,7 +332,12 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 	exp->flags = 0;
 	exp->class = class;
 	exp->expectfn = NULL;
-	exp->helper = NULL;
+
+	help = nfct_help(ct);
+	if (help)
+		helper = rcu_dereference(help->helper);
+
+	rcu_assign_pointer(exp->helper, helper);
 	exp->tuple.src.l3num = family;
 	exp->tuple.dst.protonum = proto;
 
diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index e35814d68ce30..bd7e9e13e4f68 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -642,7 +642,7 @@ static int expect_h245(struct sk_buff *skb, struct nf_conn *ct,
 			  &ct->tuplehash[!dir].tuple.src.u3,
 			  &ct->tuplehash[!dir].tuple.dst.u3,
 			  IPPROTO_TCP, NULL, &port);
-	exp->helper = &nf_conntrack_helper_h245;
+	rcu_assign_pointer(exp->helper, &nf_conntrack_helper_h245);
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
@@ -766,7 +766,7 @@ static int expect_callforwarding(struct sk_buff *skb,
 	nf_ct_expect_init(exp, NF_CT_EXPECT_CLASS_DEFAULT, nf_ct_l3num(ct),
 			  &ct->tuplehash[!dir].tuple.src.u3, &addr,
 			  IPPROTO_TCP, NULL, &port);
-	exp->helper = nf_conntrack_helper_q931;
+	rcu_assign_pointer(exp->helper, nf_conntrack_helper_q931);
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
@@ -1233,7 +1233,7 @@ static int expect_q931(struct sk_buff *skb, struct nf_conn *ct,
 				&ct->tuplehash[!dir].tuple.src.u3 : NULL,
 			  &ct->tuplehash[!dir].tuple.dst.u3,
 			  IPPROTO_TCP, NULL, &port);
-	exp->helper = nf_conntrack_helper_q931;
+	rcu_assign_pointer(exp->helper, nf_conntrack_helper_q931);
 	exp->flags = NF_CT_EXPECT_PERMANENT;	/* Accept multiple calls */
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
@@ -1305,7 +1305,7 @@ static int process_gcf(struct sk_buff *skb, struct nf_conn *ct,
 	nf_ct_expect_init(exp, NF_CT_EXPECT_CLASS_DEFAULT, nf_ct_l3num(ct),
 			  &ct->tuplehash[!dir].tuple.src.u3, &addr,
 			  IPPROTO_UDP, NULL, &port);
-	exp->helper = nf_conntrack_helper_ras;
+	rcu_assign_pointer(exp->helper, nf_conntrack_helper_ras);
 
 	if (nf_ct_expect_related(exp, 0) == 0) {
 		pr_debug("nf_ct_ras: expect RAS ");
@@ -1522,7 +1522,7 @@ static int process_acf(struct sk_buff *skb, struct nf_conn *ct,
 			  &ct->tuplehash[!dir].tuple.src.u3, &addr,
 			  IPPROTO_TCP, NULL, &port);
 	exp->flags = NF_CT_EXPECT_PERMANENT;
-	exp->helper = nf_conntrack_helper_q931;
+	rcu_assign_pointer(exp->helper, nf_conntrack_helper_q931);
 
 	if (nf_ct_expect_related(exp, 0) == 0) {
 		pr_debug("nf_ct_ras: expect Q.931 ");
@@ -1576,7 +1576,7 @@ static int process_lcf(struct sk_buff *skb, struct nf_conn *ct,
 			  &ct->tuplehash[!dir].tuple.src.u3, &addr,
 			  IPPROTO_TCP, NULL, &port);
 	exp->flags = NF_CT_EXPECT_PERMANENT;
-	exp->helper = nf_conntrack_helper_q931;
+	rcu_assign_pointer(exp->helper, nf_conntrack_helper_q931);
 
 	if (nf_ct_expect_related(exp, 0) == 0) {
 		pr_debug("nf_ct_ras: expect Q.931 ");
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 9d7d36ac83083..a21c976701f79 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -399,7 +399,7 @@ static bool expect_iter_me(struct nf_conntrack_expect *exp, void *data)
 	const struct nf_conntrack_helper *me = data;
 	const struct nf_conntrack_helper *this;
 
-	if (exp->helper == me)
+	if (rcu_access_pointer(exp->helper) == me)
 		return true;
 
 	this = rcu_dereference_protected(help->helper,
@@ -421,6 +421,11 @@ void nf_conntrack_helper_unregister(struct nf_conntrack_helper *me)
 
 	nf_ct_expect_iterate_destroy(expect_iter_me, me);
 	nf_ct_iterate_destroy(unhelp, me);
+
+	/* nf_ct_iterate_destroy() does an unconditional synchronize_rcu() as
+	 * last step, this ensures rcu readers of exp->helper are done.
+	 * No need for another synchronize_rcu() here.
+	 */
 }
 EXPORT_SYMBOL_GPL(nf_conntrack_helper_unregister);
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 82d5abae0ad1f..4d720552d43df 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3566,7 +3566,7 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 
 	exp->class = class;
 	exp->master = ct;
-	exp->helper = helper;
+	rcu_assign_pointer(exp->helper, helper);
 	exp->tuple = *tuple;
 	exp->mask.src.u3 = mask->src.u3;
 	exp->mask.src.u.all = mask->src.u.all;
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 17af0ff4ea7ab..5bddee342e122 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1303,7 +1303,7 @@ static int process_register_request(struct sk_buff *skb, unsigned int protoff,
 	nf_ct_expect_init(exp, SIP_EXPECT_SIGNALLING, nf_ct_l3num(ct),
 			  saddr, &daddr, proto, NULL, &port);
 	exp->timeout.expires = sip_timeout * HZ;
-	exp->helper = helper;
+	rcu_assign_pointer(exp->helper, helper);
 	exp->flags = NF_CT_EXPECT_PERMANENT | NF_CT_EXPECT_INACTIVE;
 
 	hooks = rcu_dereference(nf_nat_sip_hooks);
-- 
2.53.0




