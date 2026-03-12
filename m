Return-Path: <stable+bounces-224907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPaCL4wHs2kMRwAAu9opvQ
	(envelope-from <stable+bounces-224907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 19:35:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C98277307
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 19:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F313C3061765
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692573FCB1E;
	Thu, 12 Mar 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov8RMgFD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01E351C39
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340553; cv=none; b=QJwtartEa6X/oFwx2NmXZU0zbgbycOT/RUTsj6nXUrpyv1YjFKTKtDusVfB8QunrKuRBj9AIQsEHUyoMLGNzw5xSMAj3q1f3SQNYIAz5vvAFouthBeQaq3SKAGtxOMcUqscKc26ANxPa5F8yROef0Z8HiAOMcO7gQy6kEhhUgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340553; c=relaxed/simple;
	bh=sSMVdopdFED0cDsOwwGPaU3TLSS2hd18CMseo5liuPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwanBBdFpBhg0kwAsuQ1K+WBMy7/OVAu6RcxwkLuf0RsrMznGP7E7zZh/+ZJUyn6n85bytFpQBvIQRZ3w0bHpcMS5XdaYmSiCo8fjxwCk7UHRyszZWeaWnAB6UC0Zf/HGAGagRGtof8HSt+PB53yg1cJnXKRdY3DDppMHD2d7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov8RMgFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C882C4CEF7;
	Thu, 12 Mar 2026 18:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773340552;
	bh=sSMVdopdFED0cDsOwwGPaU3TLSS2hd18CMseo5liuPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ov8RMgFDBYEv5vIHHWkSM8vDtlD4G9uAqq4HJscrkmZFdg1EBZW3e26UEvLPSyC+c
	 FwFb1IDeww1grPbfvnuLfMIlhTosWe+kJdc/dw8of2/GxXsGefP1Jz7EgXVGJwf1ye
	 unV/HAEtVKlwdLCAMRn+pEDUoYNEnzEbQXoEQRrlfH+jKOto0jMHPpB8jBDGQo1upC
	 eC7CKRMgeeca+eefezCLTg4TlreXv2egiUY8QpfUdPTvU2Edcj4ij6BbxxPknaovRw
	 E2F84uegE3B5Dy+wUjMk4zn++S5IDMgzn0tzG4HZiXT3n8muq0Bl6jZwe2UcGm2qoI
	 On9JmN3ITAaDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Victor Nogueira <victor@mojatatu.com>,
	GangMin Kim <km.kim1503@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks
Date: Thu, 12 Mar 2026 14:35:50 -0400
Message-ID: <20260312183550.1823006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031222-subway-snowy-9a66@gregkh>
References: <2026031222-subway-snowy-9a66@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224907-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 46C98277307
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Victor Nogueira <victor@mojatatu.com>

[ Upstream commit 11cb63b0d1a0685e0831ae3c77223e002ef18189 ]

As Paolo said earlier [1]:

"Since the blamed commit below, classify can return TC_ACT_CONSUMED while
the current skb being held by the defragmentation engine. As reported by
GangMin Kim, if such packet is that may cause a UaF when the defrag engine
later on tries to tuch again such packet."

act_ct was never meant to be used in the egress path, however some users
are attaching it to egress today [2]. Attempting to reach a middle
ground, we noticed that, while most qdiscs are not handling
TC_ACT_CONSUMED, clsact/ingress qdiscs are. With that in mind, we
address the issue by only allowing act_ct to bind to clsact/ingress
qdiscs and shared blocks. That way it's still possible to attach act_ct to
egress (albeit only with clsact).

[1] https://lore.kernel.org/netdev/674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com/
[2] https://lore.kernel.org/netdev/cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org/

Reported-by: GangMin Kim <km.kim1503@gmail.com>
Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
CC: stable@vger.kernel.org
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260225134349.1287037-1-victor@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adjusted flag bit position and dropped TCA_ACT_FLAGS_AT_INGRESS ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/act_api.h | 1 +
 net/sched/act_ct.c    | 6 ++++++
 net/sched/cls_api.c   | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 5cd184ae91cc6..8172e22c8ee65 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -65,6 +65,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_BIND	(1U << (TCA_ACT_FLAGS_USER_BITS + 1))
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
+#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index d50977ef83c67..171ebf4594793 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1273,6 +1273,12 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 		return -EINVAL;
 	}
 
+	if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Attaching ct to a non ingress/clsact qdisc is unsupported");
+		return -EOPNOTSUPP;
+	}
+
 	err = nla_parse_nested(tb, TCA_CT_MAX, nla, ct_policy, extack);
 	if (err < 0)
 		return err;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a5864ddfb8902..3b12c3534b1b3 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1934,6 +1934,11 @@ static void tfilter_put(struct tcf_proto *tp, void *fh)
 		tp->ops->put(tp, fh);
 }
 
+static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
+{
+	return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRESS));
+}
+
 static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			  struct netlink_ext_ack *extack)
 {
@@ -2128,6 +2133,8 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		flags |= TCA_ACT_FLAGS_REPLACE;
 	if (!rtnl_held)
 		flags |= TCA_ACT_FLAGS_NO_RTNL;
+	if (is_ingress_or_clsact(block, q))
+		flags |= TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
-- 
2.51.0


