Return-Path: <stable+bounces-228852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFT3CdZpwWmoSwQAu9opvQ
	(envelope-from <stable+bounces-228852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:27:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673D2F81AF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D80323992B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741A1A5B84;
	Mon, 23 Mar 2026 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wQ8ymCeF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EE267B07;
	Mon, 23 Mar 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277308; cv=none; b=cxX8LpNBJEsN/4NsqEXO7MMim6X7DYken/dVkOF6Ht1X0mzr8YoBs/6aYELcTd+wM8vZsbik547OFPTtltPPaRGAIIY9VcnoJ89aW/Q9kpPBE7Z832jCT3fPKGn/p38K2XtqsHMRnDAIUXTTcUUTv7cAgIxIW5DwwyTKkXiXZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277308; c=relaxed/simple;
	bh=NXVNsShYt0ryBRXWtNZi9LOUQI1NFMrzhHvTPc8cT8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfqXCOTFCuAkFVzfBXfolEY7za6UrSHr3XTM31ovirT0oEWuhAyn+yu0FvaCYJLhPDXpq9YNpiNMjLRorrzRYNqoJo5Pe6S0HUSHK6pZB6yVJ3ozbOfiD+ULIVpyRUMsjmjkePqfmSHFkTlpDOVUfEtIKlk8Yuyr5k8bgMCt3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wQ8ymCeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D909C2BC9E;
	Mon, 23 Mar 2026 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277307;
	bh=NXVNsShYt0ryBRXWtNZi9LOUQI1NFMrzhHvTPc8cT8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wQ8ymCeF81UJkGaXFo+xfsHF6VKsm1JdRVCrMjrZHb3t8HQw09Yf35391h4UAzm3W
	 584xf6RZHgjQ5OQw9scQ3Tu7tUW8mkc78vxdV85EJGaG2MWTNGoffz0fbKfBUXUkTD
	 TiL/2mvNlVvcNOHfPdalx+7yFNZg0SO+yKsYIosM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 392/460] netfilter: ctnetlink: remove refcounting in expectation dumpers
Date: Mon, 23 Mar 2026 14:46:28 +0100
Message-ID: <20260323134536.201240670@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-228852-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,netfilter.org:email,strlen.de:email]
X-Rspamd-Queue-Id: 8673D2F81AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 1492e3dcb2be3aa46d1963da96aa9593e4e4db5a ]

Same pattern as previous patch: do not keep the expectation object
alive via refcount, only store a cookie value and then use that
as the skip hint for dump resumption.

AFAICS this has the same issue as the one resolved in the conntrack
dumper, when we do
  if (!refcount_inc_not_zero(&exp->use))

to increment the refcount, there is a chance that exp == last, which
causes a double-increment of the refcount and subsequent memory leak.

Fixes: cf6994c2b981 ("[NETFILTER]: nf_conntrack_netlink: sync expectation dumping with conntrack table dumping")
Fixes: e844a928431f ("netfilter: ctnetlink: allow to dump expectation per master conntrack")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 5cb81eeda909 ("netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_netlink.c | 41 ++++++++++++----------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 18a91c031554c..13836723223e0 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3146,23 +3146,27 @@ ctnetlink_expect_event(unsigned int events, const struct nf_exp_event *item)
 	return 0;
 }
 #endif
-static int ctnetlink_exp_done(struct netlink_callback *cb)
+
+static unsigned long ctnetlink_exp_id(const struct nf_conntrack_expect *exp)
 {
-	if (cb->args[1])
-		nf_ct_expect_put((struct nf_conntrack_expect *)cb->args[1]);
-	return 0;
+	unsigned long id = (unsigned long)exp;
+
+	id += nf_ct_get_id(exp->master);
+	id += exp->class;
+
+	return id ? id : 1;
 }
 
 static int
 ctnetlink_exp_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
-	struct nf_conntrack_expect *exp, *last;
 	struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
 	u_int8_t l3proto = nfmsg->nfgen_family;
+	unsigned long last_id = cb->args[1];
+	struct nf_conntrack_expect *exp;
 
 	rcu_read_lock();
-	last = (struct nf_conntrack_expect *)cb->args[1];
 	for (; cb->args[0] < nf_ct_expect_hsize; cb->args[0]++) {
 restart:
 		hlist_for_each_entry_rcu(exp, &nf_ct_expect_hash[cb->args[0]],
@@ -3174,7 +3178,7 @@ ctnetlink_exp_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 				continue;
 
 			if (cb->args[1]) {
-				if (exp != last)
+				if (ctnetlink_exp_id(exp) != last_id)
 					continue;
 				cb->args[1] = 0;
 			}
@@ -3183,9 +3187,7 @@ ctnetlink_exp_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 						    cb->nlh->nlmsg_seq,
 						    IPCTNL_MSG_EXP_NEW,
 						    exp) < 0) {
-				if (!refcount_inc_not_zero(&exp->use))
-					continue;
-				cb->args[1] = (unsigned long)exp;
+				cb->args[1] = ctnetlink_exp_id(exp);
 				goto out;
 			}
 		}
@@ -3196,32 +3198,30 @@ ctnetlink_exp_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 out:
 	rcu_read_unlock();
-	if (last)
-		nf_ct_expect_put(last);
-
 	return skb->len;
 }
 
 static int
 ctnetlink_exp_ct_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct nf_conntrack_expect *exp, *last;
 	struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
 	struct nf_conn *ct = cb->data;
 	struct nf_conn_help *help = nfct_help(ct);
 	u_int8_t l3proto = nfmsg->nfgen_family;
+	unsigned long last_id = cb->args[1];
+	struct nf_conntrack_expect *exp;
 
 	if (cb->args[0])
 		return 0;
 
 	rcu_read_lock();
-	last = (struct nf_conntrack_expect *)cb->args[1];
+
 restart:
 	hlist_for_each_entry_rcu(exp, &help->expectations, lnode) {
 		if (l3proto && exp->tuple.src.l3num != l3proto)
 			continue;
 		if (cb->args[1]) {
-			if (exp != last)
+			if (ctnetlink_exp_id(exp) != last_id)
 				continue;
 			cb->args[1] = 0;
 		}
@@ -3229,9 +3229,7 @@ ctnetlink_exp_ct_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 					    cb->nlh->nlmsg_seq,
 					    IPCTNL_MSG_EXP_NEW,
 					    exp) < 0) {
-			if (!refcount_inc_not_zero(&exp->use))
-				continue;
-			cb->args[1] = (unsigned long)exp;
+			cb->args[1] = ctnetlink_exp_id(exp);
 			goto out;
 		}
 	}
@@ -3242,9 +3240,6 @@ ctnetlink_exp_ct_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->args[0] = 1;
 out:
 	rcu_read_unlock();
-	if (last)
-		nf_ct_expect_put(last);
-
 	return skb->len;
 }
 
@@ -3263,7 +3258,6 @@ static int ctnetlink_dump_exp_ct(struct net *net, struct sock *ctnl,
 	struct nf_conntrack_zone zone;
 	struct netlink_dump_control c = {
 		.dump = ctnetlink_exp_ct_dump_table,
-		.done = ctnetlink_exp_done,
 	};
 
 	err = ctnetlink_parse_tuple(cda, &tuple, CTA_EXPECT_MASTER,
@@ -3313,7 +3307,6 @@ static int ctnetlink_get_expect(struct sk_buff *skb,
 		else {
 			struct netlink_dump_control c = {
 				.dump = ctnetlink_exp_dump_table,
-				.done = ctnetlink_exp_done,
 			};
 			return netlink_dump_start(info->sk, skb, info->nlh, &c);
 		}
-- 
2.51.0




