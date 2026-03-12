Return-Path: <stable+bounces-224895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMlMJIz1smmLRAAAu9opvQ
	(envelope-from <stable+bounces-224895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:19:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 349832767F4
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7C4A300CA3A
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5610938F640;
	Thu, 12 Mar 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpMUaC3S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC53F8E0A
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335941; cv=none; b=nxotLOWqSZ4JDuv9UJtggU5fWOMbAGkvcjEozdcbi95KMURrH2h02XC8O0XBGAB1kTaZj9YOW9drZqsxcYx4YWw0/xM6D6JU8mY0Zqmr/pkmJOFHiy+FcY+9AsojuOAPXrDAXnto9yPu323bApIutrrWdjnkktq0ZtJtDAPM0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335941; c=relaxed/simple;
	bh=A6cR3a/LScsEz9M4C5FzhbZluICGa05JTzfZNMjKloc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pny8v5YmWZHbCXMLpauqLE32nUEivJAoJ8T8RmkrSuI63eKcCt7w6rmFaDfn4eV3OqRXpG3SdIBPkAZOkN9WrJXySWUcjTx0JFf1poWaB/3Ll2VSv0D72xnmalhLi9p85UBK3dprTsS6b2T0i8XaiLDTSTGQbdJfYJGBqGjAsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpMUaC3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE3BC19424;
	Thu, 12 Mar 2026 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773335941;
	bh=A6cR3a/LScsEz9M4C5FzhbZluICGa05JTzfZNMjKloc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpMUaC3SvTyamJo8biu8gEMX16iBg1J7wOouqp7ks4R/P1TkGMZoN+K4uffFsLy8l
	 EnYB5Beu3VCTY/ljfc3O90StcHo3UZF8pcgOZL45GVli+k851YU2kvwR3rdviMA7Th
	 RlmkS+DhIb9auHSnWJpOot9QOXy398tGQau+BgGSXcHUg1wv6ah7diWFrT95QNKYxu
	 0yPp49CXkgFW3AiahIAc8XDI3JWPyvOGbALzc1ndfKZJ4E/A3NOrp41fhWhwU1UPvZ
	 TINpvbLdv0J1anayIBx1ejzMDlKkTra+AoSi6ze51wxLpsUIl7/fyJgGvBnE68aLNY
	 7dOtIB0URgbtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Victor Nogueira <victor@mojatatu.com>,
	GangMin Kim <km.kim1503@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks
Date: Thu, 12 Mar 2026 13:18:57 -0400
Message-ID: <20260312171857.1797148-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312171857.1797148-1-sashal@kernel.org>
References: <2026031221-tissue-upgrade-f4d3@gregkh>
 <20260312171857.1797148-1-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224895-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,mojatatu.com:email]
X-Rspamd-Queue-Id: 349832767F4
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/act_api.h | 1 +
 net/sched/act_ct.c    | 6 ++++++
 net/sched/cls_api.c   | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index c94ea1a306e0d..8d4fff1f82de3 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -68,6 +68,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
+#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 9594dbc32165f..75a8fba9fa57a 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1440,6 +1440,12 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
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
index 5aef802d17c75..5071c41bc864b 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1998,6 +1998,11 @@ static bool is_qdisc_ingress(__u32 classid)
 	return (TC_H_MIN(classid) == TC_H_MIN(TC_H_MIN_INGRESS));
 }
 
+static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
+{
+	return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRESS));
+}
+
 static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			  struct netlink_ext_ack *extack)
 {
@@ -2191,6 +2196,8 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		flags |= TCA_ACT_FLAGS_NO_RTNL;
 	if (is_qdisc_ingress(parent))
 		flags |= TCA_ACT_FLAGS_AT_INGRESS;
+	if (is_ingress_or_clsact(block, q))
+		flags |= TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
-- 
2.51.0


