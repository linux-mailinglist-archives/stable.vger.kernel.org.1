Return-Path: <stable+bounces-224932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOq8NDkds2mDSAAAu9opvQ
	(envelope-from <stable+bounces-224932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:08:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DFC27884A
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B107A31BC9D7
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203B9401A29;
	Thu, 12 Mar 2026 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/D8nCf1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87582C032C;
	Thu, 12 Mar 2026 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345919; cv=none; b=rh/ORWqcthWTn8wl/T6myAlTvVWDPspQN2r4hOfOSgoJx6Jt5Ty/+IjTg8r0vkMfN9M2s8oeBd9E4+4a6qkzBtyhGeXtiGXvrlUxVYrxR1Ivz8mJyOQrlvrkalg9W67l1RNvYJ0rynef9Rl+MdgHF5nS5dPEWiK4W51NnoCKBHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345919; c=relaxed/simple;
	bh=1W6jvotX7QuGyYzSNhsPeifKeH3BzqFrYTerkQvDzME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVjZmT+s6mDNdpAV2tknoE4DAcAaOTHhuPX2/KftWM9rK85X9QWfBJa+Jf2Mugjj8/hfCNg0E9w6c5xt5XoZrtgBXY16qwhUbu2XYSTcCfG5ZaIfHsbaCOqT+aEm67hL5t/VSje2zoBDAnYFFtm/5/d4WzgrNg56sTwNvvZUavA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/D8nCf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A90C19425;
	Thu, 12 Mar 2026 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773345919;
	bh=1W6jvotX7QuGyYzSNhsPeifKeH3BzqFrYTerkQvDzME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/D8nCf14dfdjqxOacj5qUAoEyUtHMFgz/MapALEMr+fdPf5oXQD+SuYYYOQzWm5L
	 S7BvRP2bL8aGvhdc+i5AsFbDYOzZo/dEO74RAcWKZOghZRWVpG6TNAZuPEUfJyvsg5
	 2kZyetPg/XeLE0eXQmCWugew8xiC00DKS/tB0rTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	GangMin Kim <km.kim1503@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 02/13] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks
Date: Thu, 12 Mar 2026 21:03:43 +0100
Message-ID: <20260312200326.338141533@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312200326.246396673@linuxfoundation.org>
References: <20260312200326.246396673@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-224932-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,mojatatu.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,mojatatu.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67DFC27884A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Nogueira <victor@mojatatu.com>

commit 11cb63b0d1a0685e0831ae3c77223e002ef18189 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/act_api.h |    1 +
 net/sched/act_ct.c    |    6 ++++++
 net/sched/cls_api.c   |    7 +++++++
 3 files changed, 14 insertions(+)

--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -70,6 +70,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
+#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1358,6 +1358,12 @@ static int tcf_ct_init(struct net *net,
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
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2228,6 +2228,11 @@ static bool is_qdisc_ingress(__u32 class
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
@@ -2420,6 +2425,8 @@ replay:
 		flags |= TCA_ACT_FLAGS_NO_RTNL;
 	if (is_qdisc_ingress(parent))
 		flags |= TCA_ACT_FLAGS_AT_INGRESS;
+	if (is_ingress_or_clsact(block, q))
+		flags |= TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {



