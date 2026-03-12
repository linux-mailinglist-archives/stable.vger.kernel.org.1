Return-Path: <stable+bounces-224894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILdQD5f1smmLRAAAu9opvQ
	(envelope-from <stable+bounces-224894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:19:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 142662767FB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B61D830288D0
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A787D3F8812;
	Thu, 12 Mar 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD0blfAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A743F23BF
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335941; cv=none; b=lQYBLQkowZFzyNQK1y0+H3KZF37QYADFtwEmroulWH5NsubQVwTP2P1iiBmlNT4dNETHk2r2SYH0BnENCHI46VlUeHAWN81FrHYa/5rvd2H/kbmyntPdF/RDzzed2hroBHidA+J3uP0VPwZ1gfIYtUzBt72UOweNNzItxQuAj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335941; c=relaxed/simple;
	bh=Pl+lTUHgba4xv+BG23OAMj+FnMWojheP3CPohpDfcKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3Go8I6Glz1E8JoZiGWue1CFZx1GQ0OgG+cYTDI7QCQF7v8EXq6NFzDXSxsQoK3nPhpfKYMtndXC9YRvyy0NbQVNepr/++EBlKnhWjjTY9S27XFQLRLSS50HOnjBq4GuTy19oiaxc1r9uwHCsuTsU0KXeg0a6sR7KpUBxHgRAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD0blfAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E68C4CEF7;
	Thu, 12 Mar 2026 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773335940;
	bh=Pl+lTUHgba4xv+BG23OAMj+FnMWojheP3CPohpDfcKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD0blfAP6rFs9ungMOPqsP0+hX0TCn3CyYOjBZ8cF/AC2JIQnzzvYsuj6JDI38yMz
	 AxCn0J4Lbv81o+xpgcaIQfX8QnMU7iKddLmv4pwIeimT4kcHZ+xbp7b0CudNer4e7j
	 31yDgRLx16nDdZa5uA2hQq22QftJRu5K8rbiLeZugMuZMUXfjJNtaf3TrSH6Yl9tsJ
	 J65THyhXQGxC90Dig8yXq927orWpvozi/UiU5tpQSApgBqfkTCiWOavCCEE1jXXNhB
	 kWhOT1phpQ5W0RiZ7waFqyaelmgI/hKXFfNfHoUG/Yb3arLiR4mzwUrgtt9iBXxEJ3
	 q+fjM7MTLswEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amritha Nambiar <amritha.nambiar@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] act_skbedit: skbedit queue mapping for receive queue
Date: Thu, 12 Mar 2026 13:18:56 -0400
Message-ID: <20260312171857.1797148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031221-tissue-upgrade-f4d3@gregkh>
References: <2026031221-tissue-upgrade-f4d3@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224894-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: 142662767FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amritha Nambiar <amritha.nambiar@intel.com>

[ Upstream commit 4a6a676f8c16ec17d2f8d69ce3b5d680277ed0d2 ]

Add support for skbedit queue mapping action on receive
side. This is supported only in hardware, so the skip_sw
flag is enforced. This enables offloading filters for
receive queue selection in the hardware using the
skbedit action. Traffic arrives on the Rx queue requested
in the skbedit action parameter. A new tc action flag
TCA_ACT_FLAGS_AT_INGRESS is introduced to identify the
traffic direction the action queue_mapping is requested
on during filter addition. This is used to disallow
offloading the skbedit queue mapping action on transmit
side.

Example:
$tc filter add dev $IFACE ingress protocol ip flower dst_ip $DST_IP\
 action skbedit queue_mapping $rxq_id skip_sw

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 11cb63b0d1a0 ("net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/act_api.h           |  1 +
 include/net/flow_offload.h      |  2 ++
 include/net/tc_act/tc_skbedit.h | 29 +++++++++++++++++++++++++++++
 net/sched/act_skbedit.c         | 14 ++++++++++++--
 net/sched/cls_api.c             |  7 +++++++
 5 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 61f2ceb3939ee..c94ea1a306e0d 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -67,6 +67,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_BIND	(1U << (TCA_ACT_FLAGS_USER_BITS + 1))
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
+#define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index e343f9f8363e3..7a60bc6d72c92 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -155,6 +155,7 @@ enum flow_action_id {
 	FLOW_ACTION_MARK,
 	FLOW_ACTION_PTYPE,
 	FLOW_ACTION_PRIORITY,
+	FLOW_ACTION_RX_QUEUE_MAPPING,
 	FLOW_ACTION_WAKE,
 	FLOW_ACTION_QUEUE,
 	FLOW_ACTION_SAMPLE,
@@ -247,6 +248,7 @@ struct flow_action_entry {
 		u32			csum_flags;	/* FLOW_ACTION_CSUM */
 		u32			mark;		/* FLOW_ACTION_MARK */
 		u16                     ptype;          /* FLOW_ACTION_PTYPE */
+		u16			rx_queue;	/* FLOW_ACTION_RX_QUEUE_MAPPING */
 		u32			priority;	/* FLOW_ACTION_PRIORITY */
 		struct {				/* FLOW_ACTION_QUEUE */
 			u32		ctx;
diff --git a/include/net/tc_act/tc_skbedit.h b/include/net/tc_act/tc_skbedit.h
index dc1079f28e13e..9649600fb3dcc 100644
--- a/include/net/tc_act/tc_skbedit.h
+++ b/include/net/tc_act/tc_skbedit.h
@@ -95,12 +95,41 @@ static inline u32 tcf_skbedit_priority(const struct tc_action *a)
 	return priority;
 }
 
+static inline u16 tcf_skbedit_rx_queue_mapping(const struct tc_action *a)
+{
+	u16 rx_queue;
+
+	rcu_read_lock();
+	rx_queue = rcu_dereference(to_skbedit(a)->params)->queue_mapping;
+	rcu_read_unlock();
+
+	return rx_queue;
+}
+
 /* Return true iff action is queue_mapping */
 static inline bool is_tcf_skbedit_queue_mapping(const struct tc_action *a)
 {
 	return is_tcf_skbedit_with_flag(a, SKBEDIT_F_QUEUE_MAPPING);
 }
 
+/* Return true if action is on ingress traffic */
+static inline bool is_tcf_skbedit_ingress(u32 flags)
+{
+	return flags & TCA_ACT_FLAGS_AT_INGRESS;
+}
+
+static inline bool is_tcf_skbedit_tx_queue_mapping(const struct tc_action *a)
+{
+	return is_tcf_skbedit_queue_mapping(a) &&
+	       !is_tcf_skbedit_ingress(a->tcfa_flags);
+}
+
+static inline bool is_tcf_skbedit_rx_queue_mapping(const struct tc_action *a)
+{
+	return is_tcf_skbedit_queue_mapping(a) &&
+	       is_tcf_skbedit_ingress(a->tcfa_flags);
+}
+
 /* Return true iff action is inheritdsfield */
 static inline bool is_tcf_skbedit_inheritdsfield(const struct tc_action *a)
 {
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 0fcf40a5d1e31..12050a626487a 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -148,6 +148,11 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (tb[TCA_SKBEDIT_QUEUE_MAPPING] != NULL) {
+		if (is_tcf_skbedit_ingress(act_flags) &&
+		    !(act_flags & TCA_ACT_FLAGS_SKIP_SW)) {
+			NL_SET_ERR_MSG_MOD(extack, "\"queue_mapping\" option on receive side is hardware only, use skip_sw");
+			return -EOPNOTSUPP;
+		}
 		flags |= SKBEDIT_F_QUEUE_MAPPING;
 		queue_mapping = nla_data(tb[TCA_SKBEDIT_QUEUE_MAPPING]);
 	}
@@ -378,9 +383,12 @@ static int tcf_skbedit_offload_act_setup(struct tc_action *act, void *entry_data
 		} else if (is_tcf_skbedit_priority(act)) {
 			entry->id = FLOW_ACTION_PRIORITY;
 			entry->priority = tcf_skbedit_priority(act);
-		} else if (is_tcf_skbedit_queue_mapping(act)) {
-			NL_SET_ERR_MSG_MOD(extack, "Offload not supported when \"queue_mapping\" option is used");
+		} else if (is_tcf_skbedit_tx_queue_mapping(act)) {
+			NL_SET_ERR_MSG_MOD(extack, "Offload not supported when \"queue_mapping\" option is used on transmit side");
 			return -EOPNOTSUPP;
+		} else if (is_tcf_skbedit_rx_queue_mapping(act)) {
+			entry->id = FLOW_ACTION_RX_QUEUE_MAPPING;
+			entry->rx_queue = tcf_skbedit_rx_queue_mapping(act);
 		} else if (is_tcf_skbedit_inheritdsfield(act)) {
 			NL_SET_ERR_MSG_MOD(extack, "Offload not supported when \"inheritdsfield\" option is used");
 			return -EOPNOTSUPP;
@@ -398,6 +406,8 @@ static int tcf_skbedit_offload_act_setup(struct tc_action *act, void *entry_data
 			fl_action->id = FLOW_ACTION_PTYPE;
 		else if (is_tcf_skbedit_priority(act))
 			fl_action->id = FLOW_ACTION_PRIORITY;
+		else if (is_tcf_skbedit_rx_queue_mapping(act))
+			fl_action->id = FLOW_ACTION_RX_QUEUE_MAPPING;
 		else
 			return -EOPNOTSUPP;
 	}
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 89da596be1b86..5aef802d17c75 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1993,6 +1993,11 @@ static void tfilter_put(struct tcf_proto *tp, void *fh)
 		tp->ops->put(tp, fh);
 }
 
+static bool is_qdisc_ingress(__u32 classid)
+{
+	return (TC_H_MIN(classid) == TC_H_MIN(TC_H_MIN_INGRESS));
+}
+
 static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			  struct netlink_ext_ack *extack)
 {
@@ -2184,6 +2189,8 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		flags |= TCA_ACT_FLAGS_REPLACE;
 	if (!rtnl_held)
 		flags |= TCA_ACT_FLAGS_NO_RTNL;
+	if (is_qdisc_ingress(parent))
+		flags |= TCA_ACT_FLAGS_AT_INGRESS;
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
-- 
2.51.0


