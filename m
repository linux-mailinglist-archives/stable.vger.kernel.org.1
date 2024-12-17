Return-Path: <stable+bounces-104809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5C9F532F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387401890FB5
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE541F75A6;
	Tue, 17 Dec 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3AfUKJp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FF1EF085;
	Tue, 17 Dec 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456168; cv=none; b=giScrwdk4NfCM/Sk8jRbro+YIw5UMuQZU67z6n1savzBdQFjsikbaIDzkO0WFP9oyXEOgJsQ4XCjeAQvX5kUB6r3T/U8JDgrckIy/YRb4JXv+qWhZcbO5Bt3hF/YmhoPRHExsijmQyulpP7ew1JG/AiIk44s0qRqlrIsnhXFGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456168; c=relaxed/simple;
	bh=xga7InLJOqNVD2WhVBUpbb+k4Ddx+fMufKj7cEnz4fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzsVgw0zrXSGsbMYSKGEVguqK8aROpKkCuq/8jGm2fHPn6ovMR0ZxZ+NIHc3/9H8Gp1ULrFQCOYEwy0JL1yG1AcPz46oT2PGHTNJ7qUpdNAN/uYIeIZKcSsO04BDpSsS0P3YuS7fDb1jCJA/vUpjy5iLy6ym6DE9haI04Xp7QV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3AfUKJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A77C4CEDD;
	Tue, 17 Dec 2024 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456168;
	bh=xga7InLJOqNVD2WhVBUpbb+k4Ddx+fMufKj7cEnz4fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3AfUKJpWlYRF5rCMgWbhzgoCDkZwuYdLSknWdEpjR3FaiZDQ1pB05tnIy7AysBmI
	 CtYWYus136QIaztu3vW7Rbc3vTLCdxiUgSF7BVJND9+kav2EbjQaM2DMCsDlKZLvSW
	 6q9Frv54WsEQBsoFXhiNjPesPqBcMmiF97TBvmDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Ottens <martin.ottens@fau.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 082/109] net/sched: netem: account for backlog updates from child qdisc
Date: Tue, 17 Dec 2024 18:08:06 +0100
Message-ID: <20241217170536.806928432@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Ottens <martin.ottens@fau.de>

[ Upstream commit f8d4bc455047cf3903cd6f85f49978987dbb3027 ]

In general, 'qlen' of any classful qdisc should keep track of the
number of packets that the qdisc itself and all of its children holds.
In case of netem, 'qlen' only accounts for the packets in its internal
tfifo. When netem is used with a child qdisc, the child qdisc can use
'qdisc_tree_reduce_backlog' to inform its parent, netem, about created
or dropped SKBs. This function updates 'qlen' and the backlog statistics
of netem, but netem does not account for changes made by a child qdisc.
'qlen' then indicates the wrong number of packets in the tfifo.
If a child qdisc creates new SKBs during enqueue and informs its parent
about this, netem's 'qlen' value is increased. When netem dequeues the
newly created SKBs from the child, the 'qlen' in netem is not updated.
If 'qlen' reaches the configured sch->limit, the enqueue function stops
working, even though the tfifo is not full.

Reproduce the bug:
Ensure that the sender machine has GSO enabled. Configure netem as root
qdisc and tbf as its child on the outgoing interface of the machine
as follows:
$ tc qdisc add dev <oif> root handle 1: netem delay 100ms limit 100
$ tc qdisc add dev <oif> parent 1:0 tbf rate 50Mbit burst 1542 latency 50ms

Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
client on the machine. Check the qdisc statistics:
$ tc -s qdisc show dev <oif>

Statistics after 10s of iPerf3 TCP test before the fix (note that
netem's backlog > limit, netem stopped accepting packets):
qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
 Sent 2767766 bytes 1848 pkt (dropped 652, overlimits 0 requeues 0)
 backlog 4294528236b 1155p requeues 0
qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
 Sent 2767766 bytes 1848 pkt (dropped 327, overlimits 7601 requeues 0)
 backlog 0b 0p requeues 0

Statistics after the fix:
qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
 Sent 37766372 bytes 24974 pkt (dropped 9, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
 Sent 37766372 bytes 24974 pkt (dropped 327, overlimits 96017 requeues 0)
 backlog 0b 0p requeues 0

tbf segments the GSO SKBs (tbf_segment) and updates the netem's 'qlen'.
The interface fully stops transferring packets and "locks". In this case,
the child qdisc and tfifo are empty, but 'qlen' indicates the tfifo is at
its limit and no more packets are accepted.

This patch adds a counter for the entries in the tfifo. Netem's 'qlen' is
only decreased when a packet is returned by its dequeue function, and not
during enqueuing into the child qdisc. External updates to 'qlen' are thus
accounted for and only the behavior of the backlog statistics changes. As
in other qdiscs, 'qlen' then keeps track of  how many packets are held in
netem and all of its children. As before, sch->limit remains as the
maximum number of packets in the tfifo. The same applies to netem's
backlog statistics.

Fixes: 50612537e9ab ("netem: fix classful handling")
Signed-off-by: Martin Ottens <martin.ottens@fau.de>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20241210131412.1837202-1-martin.ottens@fau.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_netem.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index d36eeb7b0502..152dbbe8fd31 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -78,6 +78,8 @@ struct netem_sched_data {
 	struct sk_buff	*t_head;
 	struct sk_buff	*t_tail;
 
+	u32 t_len;
+
 	/* optional qdisc for classful handling (NULL at netem init) */
 	struct Qdisc	*qdisc;
 
@@ -382,6 +384,7 @@ static void tfifo_reset(struct Qdisc *sch)
 	rtnl_kfree_skbs(q->t_head, q->t_tail);
 	q->t_head = NULL;
 	q->t_tail = NULL;
+	q->t_len = 0;
 }
 
 static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
@@ -411,6 +414,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 		rb_link_node(&nskb->rbnode, parent, p);
 		rb_insert_color(&nskb->rbnode, &q->t_root);
 	}
+	q->t_len++;
 	sch->q.qlen++;
 }
 
@@ -517,7 +521,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			1<<get_random_u32_below(8);
 	}
 
-	if (unlikely(sch->q.qlen >= sch->limit)) {
+	if (unlikely(q->t_len >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
@@ -701,8 +705,8 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 tfifo_dequeue:
 	skb = __qdisc_dequeue_head(&sch->q);
 	if (skb) {
-		qdisc_qstats_backlog_dec(sch, skb);
 deliver:
+		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_bstats_update(sch, skb);
 		return skb;
 	}
@@ -718,8 +722,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 		if (time_to_send <= now && q->slot.slot_next <= now) {
 			netem_erase_head(q, skb);
-			sch->q.qlen--;
-			qdisc_qstats_backlog_dec(sch, skb);
+			q->t_len--;
 			skb->next = NULL;
 			skb->prev = NULL;
 			/* skb->dev shares skb->rbnode area,
@@ -746,16 +749,21 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 					if (net_xmit_drop_count(err))
 						qdisc_qstats_drop(sch);
 					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
+					sch->qstats.backlog -= pkt_len;
+					sch->q.qlen--;
 				}
 				goto tfifo_dequeue;
 			}
+			sch->q.qlen--;
 			goto deliver;
 		}
 
 		if (q->qdisc) {
 			skb = q->qdisc->ops->dequeue(q->qdisc);
-			if (skb)
+			if (skb) {
+				sch->q.qlen--;
 				goto deliver;
+			}
 		}
 
 		qdisc_watchdog_schedule_ns(&q->watchdog,
@@ -765,8 +773,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 	if (q->qdisc) {
 		skb = q->qdisc->ops->dequeue(q->qdisc);
-		if (skb)
+		if (skb) {
+			sch->q.qlen--;
 			goto deliver;
+		}
 	}
 	return NULL;
 }
-- 
2.39.5




