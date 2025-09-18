Return-Path: <stable+bounces-173313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6131B35CDF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4D5188BB02
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAB51A256B;
	Tue, 26 Aug 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7udQRnn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955D283FDF;
	Tue, 26 Aug 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207923; cv=none; b=sq0xP4yB16NwSEKIx6/pzpHYCzrGuQCB17LTC7Xx+imvWtEYlNGpnoA2Kl3rN2l9FAQXo7hJW1Sbr3nMqRZyPsmyGv4Wg672hVMJwgf0wWUahW96tXq6UU2UKUQTimwRdmMqnhTIEI9+e6QqGrNEQtP7yul4sGQGthOqy2wmTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207923; c=relaxed/simple;
	bh=YQNs9PxXaLGodv4gcKdNGtJIw+PvXnoJhRZQVIiMe2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaFepov4tQJEWZ+IXqddiiRonRZmVBLjRW98F4Ah7ujqglaBPSUoPozMcCHeWecVgjW27fQ3psWFxF5S9ugKhEz4MlMiFdUS1eQSinUBi8QWkxYBg2eo0g1xC8QSCBoQWBo5vIYyv275DdBH2mvhkKpgi+h6FtLX4z4Vjm6vSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h7udQRnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE8DC4CEF1;
	Tue, 26 Aug 2025 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207923;
	bh=YQNs9PxXaLGodv4gcKdNGtJIw+PvXnoJhRZQVIiMe2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7udQRnnBGc24V2PLwccHUgN+5O1jJrL5CzfwpMGlFyBC3+irMSxdsooAi1nZj7yF
	 YVyh/NqTgVCAkqO++iilUMMq9soAkcj0yU+QRmTJLoSleDmgzfKtOB5pMpZn2QKu+9
	 g5MnQ3LYL3jh+UNHOLZqCRXoM6iH0WvwmMZ3qA6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 369/457] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Date: Tue, 26 Aug 2025 13:10:53 +0200
Message-ID: <20250826110946.420445876@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Liu <will@willsroot.io>

[ Upstream commit 52bf272636bda69587952b35ae97690b8dc89941 ]

This issue applies for the following qdiscs: hhf, fq, fq_codel, and
fq_pie, and occurs in their change handlers when adjusting to the new
limit. The problem is the following in the values passed to the
subsequent qdisc_tree_reduce_backlog call given a tbf parent:

   When the tbf parent runs out of tokens, skbs of these qdiscs will
   be placed in gso_skb. Their peek handlers are qdisc_peek_dequeued,
   which accounts for both qlen and backlog. However, in the case of
   qdisc_dequeue_internal, ONLY qlen is accounted for when pulling
   from gso_skb. This means that these qdiscs are missing a
   qdisc_qstats_backlog_dec when dropping packets to satisfy the
   new limit in their change handlers.

   One can observe this issue with the following (with tc patched to
   support a limit of 0):

   export TARGET=fq
   tc qdisc del dev lo root
   tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms
   tc qdisc replace dev lo handle 3: parent 1:1 $TARGET limit 1000
   echo ''; echo 'add child'; tc -s -d qdisc show dev lo
   ping -I lo -f -c2 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
   echo ''; echo 'after ping'; tc -s -d qdisc show dev lo
   tc qdisc change dev lo handle 3: parent 1:1 $TARGET limit 0
   echo ''; echo 'after limit drop'; tc -s -d qdisc show dev lo
   tc qdisc replace dev lo handle 2: parent 1:1 sfq
   echo ''; echo 'post graft'; tc -s -d qdisc show dev lo

   The second to last show command shows 0 packets but a positive
   number (74) of backlog bytes. The problem becomes clearer in the
   last show command, where qdisc_purge_queue triggers
   qdisc_tree_reduce_backlog with the positive backlog and causes an
   underflow in the tbf parent's backlog (4096 Mb instead of 0).

To fix this issue, the codepath for all clients of qdisc_dequeue_internal
has been simplified: codel, pie, hhf, fq, fq_pie, and fq_codel.
qdisc_dequeue_internal handles the backlog adjustments for all cases that
do not directly use the dequeue handler.

The old fq_codel_change limit adjustment loop accumulated the arguments to
the subsequent qdisc_tree_reduce_backlog call through the cstats field.
However, this is confusing and error prone as fq_codel_dequeue could also
potentially mutate this field (which qdisc_dequeue_internal calls in the
non gso_skb case), so we have unified the code here with other qdiscs.

Fixes: 2d3cbfd6d54a ("net_sched: Flush gso_skb list too during ->change()")
Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
Link: https://patch.msgid.link/20250812235725.45243-1-will@willsroot.io
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sch_generic.h | 11 ++++++++---
 net/sched/sch_codel.c     | 12 +++++++-----
 net/sched/sch_fq.c        | 12 +++++++-----
 net/sched/sch_fq_codel.c  | 12 +++++++-----
 net/sched/sch_fq_pie.c    | 12 +++++++-----
 net/sched/sch_hhf.c       | 12 +++++++-----
 net/sched/sch_pie.c       | 12 +++++++-----
 7 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 638948be4c50..738cd5b13c62 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1038,12 +1038,17 @@ static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool dir
 	skb = __skb_dequeue(&sch->gso_skb);
 	if (skb) {
 		sch->q.qlen--;
+		qdisc_qstats_backlog_dec(sch, skb);
 		return skb;
 	}
-	if (direct)
-		return __qdisc_dequeue_head(&sch->q);
-	else
+	if (direct) {
+		skb = __qdisc_dequeue_head(&sch->q);
+		if (skb)
+			qdisc_qstats_backlog_dec(sch, skb);
+		return skb;
+	} else {
 		return sch->dequeue(sch);
+	}
 }
 
 static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index c93761040c6e..fa0314679e43 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -101,9 +101,9 @@ static const struct nla_policy codel_policy[TCA_CODEL_MAX + 1] = {
 static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
 {
+	unsigned int dropped_pkts = 0, dropped_bytes = 0;
 	struct codel_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_CODEL_MAX + 1];
-	unsigned int qlen, dropped = 0;
 	int err;
 
 	err = nla_parse_nested_deprecated(tb, TCA_CODEL_MAX, opt,
@@ -142,15 +142,17 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(q->params.ecn,
 			   !!nla_get_u32(tb[TCA_CODEL_ECN]));
 
-	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
 		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
-		dropped += qdisc_pkt_len(skb);
-		qdisc_qstats_backlog_dec(sch, skb);
+		if (!skb)
+			break;
+
+		dropped_pkts++;
+		dropped_bytes += qdisc_pkt_len(skb);
 		rtnl_qdisc_drop(skb, sch);
 	}
-	qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
+	qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
 
 	sch_tree_unlock(sch);
 	return 0;
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 902ff5470607..fee922da2f99 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1013,11 +1013,11 @@ static int fq_load_priomap(struct fq_sched_data *q,
 static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		     struct netlink_ext_ack *extack)
 {
+	unsigned int dropped_pkts = 0, dropped_bytes = 0;
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_FQ_MAX + 1];
-	int err, drop_count = 0;
-	unsigned drop_len = 0;
 	u32 fq_log;
+	int err;
 
 	err = nla_parse_nested_deprecated(tb, TCA_FQ_MAX, opt, fq_policy,
 					  NULL);
@@ -1135,16 +1135,18 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		err = fq_resize(sch, fq_log);
 		sch_tree_lock(sch);
 	}
+
 	while (sch->q.qlen > sch->limit) {
 		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		if (!skb)
 			break;
-		drop_len += qdisc_pkt_len(skb);
+
+		dropped_pkts++;
+		dropped_bytes += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
-		drop_count++;
 	}
-	qdisc_tree_reduce_backlog(sch, drop_count, drop_len);
+	qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
 
 	sch_tree_unlock(sch);
 	return err;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 2a0f3a513bfa..a14142392939 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -366,6 +366,7 @@ static const struct nla_policy fq_codel_policy[TCA_FQ_CODEL_MAX + 1] = {
 static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 			   struct netlink_ext_ack *extack)
 {
+	unsigned int dropped_pkts = 0, dropped_bytes = 0;
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_FQ_CODEL_MAX + 1];
 	u32 quantum = 0;
@@ -443,13 +444,14 @@ static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 	       q->memory_usage > q->memory_limit) {
 		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
-		q->cstats.drop_len += qdisc_pkt_len(skb);
+		if (!skb)
+			break;
+
+		dropped_pkts++;
+		dropped_bytes += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
-		q->cstats.drop_count++;
 	}
-	qdisc_tree_reduce_backlog(sch, q->cstats.drop_count, q->cstats.drop_len);
-	q->cstats.drop_count = 0;
-	q->cstats.drop_len = 0;
+	qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
 
 	sch_tree_unlock(sch);
 	return 0;
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index b0e34daf1f75..7b96bc3ff891 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -287,10 +287,9 @@ static struct sk_buff *fq_pie_qdisc_dequeue(struct Qdisc *sch)
 static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 			 struct netlink_ext_ack *extack)
 {
+	unsigned int dropped_pkts = 0, dropped_bytes = 0;
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_FQ_PIE_MAX + 1];
-	unsigned int len_dropped = 0;
-	unsigned int num_dropped = 0;
 	int err;
 
 	err = nla_parse_nested(tb, TCA_FQ_PIE_MAX, opt, fq_pie_policy, extack);
@@ -368,11 +367,14 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 	while (sch->q.qlen > sch->limit) {
 		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
-		len_dropped += qdisc_pkt_len(skb);
-		num_dropped += 1;
+		if (!skb)
+			break;
+
+		dropped_pkts++;
+		dropped_bytes += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
 	}
-	qdisc_tree_reduce_backlog(sch, num_dropped, len_dropped);
+	qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
 
 	sch_tree_unlock(sch);
 	return 0;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 5aa434b46707..2d4855e28a28 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -508,9 +508,9 @@ static const struct nla_policy hhf_policy[TCA_HHF_MAX + 1] = {
 static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 		      struct netlink_ext_ack *extack)
 {
+	unsigned int dropped_pkts = 0, dropped_bytes = 0;
 	struct hhf_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_HHF_MAX + 1];
-	unsigned int qlen, prev_backlog;
 	int err;
 	u64 non_hh_quantum;
 	u32 new_quantum = q->quantum;
@@ -561,15 +561,17 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 			   usecs_to_jiffies(us));
 	}
 
-	qlen = sch->q.qlen;
-	prev_backlog = sch->qstats.backlog;
 	while (sch->q.qlen > sch->limit) {
 		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
+		if (!skb)
+			break;
+
+		dropped_pkts++;
+		dropped_bytes += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
 	}
-	qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen,
-				  prev_backlog - sch->qstats.backlog);
+	qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
 
 	sch_tree_unlock(sch);
 	return 0;
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index ad46ee3ed5a9..0a377313b6a9 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -141,9 +141,9 @@ static const struct nla_policy pie_policy[TCA_PIE_MAX + 1] = {
 static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 		      struct netlink_ext_ack *extack)
 {
+	unsigned int dropped_pkts = 0, dropped_bytes = 0;
 	struct pie_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_PIE_MAX + 1];
-	unsigned int qlen, dropped = 0;
 	int err;
 
 	err = nla_parse_nested_deprecated(tb, TCA_PIE_MAX, opt, pie_policy,
@@ -193,15 +193,17 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 			   nla_get_u32(tb[TCA_PIE_DQ_RATE_ESTIMATOR]));
 
 	/* Drop excess packets if new limit is lower */
-	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
 		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
-		dropped += qdisc_pkt_len(skb);
-		qdisc_qstats_backlog_dec(sch, skb);
+		if (!skb)
+			break;
+
+		dropped_pkts++;
+		dropped_bytes += qdisc_pkt_len(skb);
 		rtnl_qdisc_drop(skb, sch);
 	}
-	qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
+	qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
 
 	sch_tree_unlock(sch);
 	return 0;
-- 
2.50.1




