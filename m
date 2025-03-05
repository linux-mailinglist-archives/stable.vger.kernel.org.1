Return-Path: <stable+bounces-120419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DCCA4FD17
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 12:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5243C3A6FBA
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0FC22E3F3;
	Wed,  5 Mar 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RXXLBvSn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB92AD2D
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172630; cv=none; b=pMWNDxCMmO9F9CIWJC2enx1mPDuvD+oFD6L0meC2z/umf5ANwAWevpvqCLqrXzAHI/MaegNu+8l/V47q/+ZlEEUSeNxqRELMLRmegX2VQ/tzXA+T8kH8amZuuuIkznvnzM37U0kwWvVselNfFAHIxR7VLgq+wgml+YEyFZvDQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172630; c=relaxed/simple;
	bh=bggFJF3ulwRjZNVIxJZxjc80ekuhnWLejll0RlJy5HM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oCQxfZ60gaOnMZs1hu4WX2z15Y0nV5MyvE/oA32xqxQa9jYshI/UI/M4tNahWRCrpKu0oRMIJDGuAAduNARrOTkAnzjJnZxDbjyA7aYbvL/+AvvJOcUdYBeuH/ArMCxKDHQ/rLcng/ERjMhSsNEGhR4H8jNFumThtjfrmWwN8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RXXLBvSn; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741172629; x=1772708629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i/UDfLthC0tgtFuspoSxU7A6jRjvwgMKFP8a2W+G2jQ=;
  b=RXXLBvSntPd3NoogWJoOyPMtbsw8Mnrwb9JHHuzRGRwWvyjkPKj7Spep
   dFolaf29j12khbcMlM0nnzirKo/cDbo3PGoEx3oYfleonKTugsd8tFMlw
   xD+ZmVH7elA9e/1geCpQ6RGQcU08f0er87fI/2Y2KmEyMxWghHLQEnxy4
   U=;
X-IronPort-AV: E=Sophos;i="6.14,222,1736812800"; 
   d="scan'208";a="383399529"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:03:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:57318]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.36:2525] with esmtp (Farcaster)
 id 1afbc34a-875b-45ed-aad6-85b9fb6edf20; Wed, 5 Mar 2025 11:03:45 +0000 (UTC)
X-Farcaster-Flow-ID: 1afbc34a-875b-45ed-aad6-85b9fb6edf20
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 11:03:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 11:03:45 +0000
Received: from email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 11:03:45 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com (Postfix) with ESMTP id D288EA189E;
	Wed,  5 Mar 2025 11:03:44 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 67BA420DAD; Wed,  5 Mar 2025 11:03:44 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, <syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com>,
	Dave Taht <dave.taht@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "Hagar
 Hemdan" <hagarhem@amazon.com>
Subject: [PATCH 5.15] sched: sch_cake: add bounds checks to host bulk flow fairness counts
Date: Wed, 5 Mar 2025 11:03:30 +0000
Message-ID: <20250305110334.31305-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 737d4d91d35b5f7fa5bb442651472277318b0bfd ]

Even though we fixed a logic error in the commit cited below, syzbot
still managed to trigger an underflow of the per-host bulk flow
counters, leading to an out of bounds memory access.

To avoid any such logic errors causing out of bounds memory accesses,
this commit factors out all accesses to the per-host bulk flow counters
to a series of helpers that perform bounds-checking before any
increments and decrements. This also has the benefit of improving
readability by moving the conditional checks for the flow mode into
these helpers, instead of having them spread out throughout the
code (which was the cause of the original logic error).

As part of this change, the flow quantum calculation is consolidated
into a helper function, which means that the dithering applied to the
ost load scaling is now applied both in the DRR rotation and when a
sparse flow's quantum is first initiated. The only user-visible effect
of this is that the maximum packet size that can be sent while a flow
stays sparse will now vary with +/- one byte in some cases. This should
not make a noticeable difference in practice, and thus it's not worth
complicating the code to preserve the old behaviour.

Fixes: 546ea84d07e3 ("sched: sch_cake: fix bulk flow accounting logic for host fairness")
Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Dave Taht <dave.taht@gmail.com>
Link: https://patch.msgid.link/20250107120105.70685-1-toke@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Hagar: needed contextual fixes due to missing commit 7e3cf0843fe5]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 net/sched/sch_cake.c | 140 +++++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 65 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 8d9c0b98a747..d9535129f4e9 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -643,6 +643,63 @@ static bool cake_ddst(int flow_mode)
 	return (flow_mode & CAKE_FLOW_DUAL_DST) == CAKE_FLOW_DUAL_DST;
 }
 
+static void cake_dec_srchost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_dsrc(flow_mode) &&
+		   q->hosts[flow->srchost].srchost_bulk_flow_count))
+		q->hosts[flow->srchost].srchost_bulk_flow_count--;
+}
+
+static void cake_inc_srchost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_dsrc(flow_mode) &&
+		   q->hosts[flow->srchost].srchost_bulk_flow_count < CAKE_QUEUES))
+		q->hosts[flow->srchost].srchost_bulk_flow_count++;
+}
+
+static void cake_dec_dsthost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_ddst(flow_mode) &&
+		   q->hosts[flow->dsthost].dsthost_bulk_flow_count))
+		q->hosts[flow->dsthost].dsthost_bulk_flow_count--;
+}
+
+static void cake_inc_dsthost_bulk_flow_count(struct cake_tin_data *q,
+					     struct cake_flow *flow,
+					     int flow_mode)
+{
+	if (likely(cake_ddst(flow_mode) &&
+		   q->hosts[flow->dsthost].dsthost_bulk_flow_count < CAKE_QUEUES))
+		q->hosts[flow->dsthost].dsthost_bulk_flow_count++;
+}
+
+static u16 cake_get_flow_quantum(struct cake_tin_data *q,
+				 struct cake_flow *flow,
+				 int flow_mode)
+{
+	u16 host_load = 1;
+
+	if (cake_dsrc(flow_mode))
+		host_load = max(host_load,
+				q->hosts[flow->srchost].srchost_bulk_flow_count);
+
+	if (cake_ddst(flow_mode))
+		host_load = max(host_load,
+				q->hosts[flow->dsthost].dsthost_bulk_flow_count);
+
+	/* The shifted prandom_u32() is a way to apply dithering to avoid
+	 * accumulating roundoff errors
+	 */
+	return (q->flow_quantum * quantum_div[host_load] +
+		(prandom_u32() >> 16)) >> 16;
+}
+
 static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		     int flow_mode, u16 flow_override, u16 host_override)
 {
@@ -789,10 +846,8 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		allocate_dst = cake_ddst(flow_mode);
 
 		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
-			if (allocate_src)
-				q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
-			if (allocate_dst)
-				q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
+			cake_dec_srchost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
+			cake_dec_dsthost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
 		}
 found:
 		/* reserve queue for future packets in same flow */
@@ -817,9 +872,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 			q->hosts[outer_hash + k].srchost_tag = srchost_hash;
 found_src:
 			srchost_idx = outer_hash + k;
-			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
-				q->hosts[srchost_idx].srchost_bulk_flow_count++;
 			q->flows[reduced_hash].srchost = srchost_idx;
+
+			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
+				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
 		}
 
 		if (allocate_dst) {
@@ -840,9 +896,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 			q->hosts[outer_hash + k].dsthost_tag = dsthost_hash;
 found_dst:
 			dsthost_idx = outer_hash + k;
-			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
-				q->hosts[dsthost_idx].dsthost_bulk_flow_count++;
 			q->flows[reduced_hash].dsthost = dsthost_idx;
+
+			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
+				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
 		}
 	}
 
@@ -1855,10 +1912,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	/* flowchain */
 	if (!flow->set || flow->set == CAKE_SET_DECAYING) {
-		struct cake_host *srchost = &b->hosts[flow->srchost];
-		struct cake_host *dsthost = &b->hosts[flow->dsthost];
-		u16 host_load = 1;
-
 		if (!flow->set) {
 			list_add_tail(&flow->flowchain, &b->new_flows);
 		} else {
@@ -1868,18 +1921,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		flow->set = CAKE_SET_SPARSE;
 		b->sparse_flow_count++;
 
-		if (cake_dsrc(q->flow_mode))
-			host_load = max(host_load, srchost->srchost_bulk_flow_count);
-
-		if (cake_ddst(q->flow_mode))
-			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
-
-		flow->deficit = (b->flow_quantum *
-				 quantum_div[host_load]) >> 16;
+		flow->deficit = cake_get_flow_quantum(b, flow, q->flow_mode);
 	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
-		struct cake_host *srchost = &b->hosts[flow->srchost];
-		struct cake_host *dsthost = &b->hosts[flow->dsthost];
-
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
 		 */
@@ -1887,12 +1930,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		b->sparse_flow_count--;
 		b->bulk_flow_count++;
 
-		if (cake_dsrc(q->flow_mode))
-			srchost->srchost_bulk_flow_count++;
-
-		if (cake_ddst(q->flow_mode))
-			dsthost->dsthost_bulk_flow_count++;
-
+		cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
+		cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 	}
 
 	if (q->buffer_used > q->buffer_max_used)
@@ -1949,13 +1988,11 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[q->cur_tin];
-	struct cake_host *srchost, *dsthost;
 	ktime_t now = ktime_get();
 	struct cake_flow *flow;
 	struct list_head *head;
 	bool first_flow = true;
 	struct sk_buff *skb;
-	u16 host_load;
 	u64 delay;
 	u32 len;
 
@@ -2055,11 +2092,6 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	q->cur_flow = flow - b->flows;
 	first_flow = false;
 
-	/* triple isolation (modified DRR++) */
-	srchost = &b->hosts[flow->srchost];
-	dsthost = &b->hosts[flow->dsthost];
-	host_load = 1;
-
 	/* flow isolation (DRR++) */
 	if (flow->deficit <= 0) {
 		/* Keep all flows with deficits out of the sparse and decaying
@@ -2071,11 +2103,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				b->sparse_flow_count--;
 				b->bulk_flow_count++;
 
-				if (cake_dsrc(q->flow_mode))
-					srchost->srchost_bulk_flow_count++;
-
-				if (cake_ddst(q->flow_mode))
-					dsthost->dsthost_bulk_flow_count++;
+				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
+				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 
 				flow->set = CAKE_SET_BULK;
 			} else {
@@ -2087,19 +2116,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			}
 		}
 
-		if (cake_dsrc(q->flow_mode))
-			host_load = max(host_load, srchost->srchost_bulk_flow_count);
-
-		if (cake_ddst(q->flow_mode))
-			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
-
-		WARN_ON(host_load > CAKE_QUEUES);
-
-		/* The shifted prandom_u32() is a way to apply dithering to
-		 * avoid accumulating roundoff errors
-		 */
-		flow->deficit += (b->flow_quantum * quantum_div[host_load] +
-				  (prandom_u32() >> 16)) >> 16;
+		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
 		list_move_tail(&flow->flowchain, &b->old_flows);
 
 		goto retry;
@@ -2123,11 +2140,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					if (cake_dsrc(q->flow_mode))
-						srchost->srchost_bulk_flow_count--;
-
-					if (cake_ddst(q->flow_mode))
-						dsthost->dsthost_bulk_flow_count--;
+					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 
 					b->decaying_flow_count++;
 				} else if (flow->set == CAKE_SET_SPARSE ||
@@ -2145,12 +2159,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				else if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					if (cake_dsrc(q->flow_mode))
-						srchost->srchost_bulk_flow_count--;
-
-					if (cake_ddst(q->flow_mode))
-						dsthost->dsthost_bulk_flow_count--;
-
+					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
 				} else
 					b->decaying_flow_count--;
 
-- 
2.47.1


