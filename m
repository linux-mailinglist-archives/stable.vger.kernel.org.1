Return-Path: <stable+bounces-112385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E2A28C72
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4935D1882468
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EBE13AD22;
	Wed,  5 Feb 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwuqjX35"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C0126C18;
	Wed,  5 Feb 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763396; cv=none; b=BtArDhvLTqwVGOFM7U8ZF6MKJZ+wXXTf2ZAgTOIR7RtA2Xz5SLgow3hdLLUl4sNF34FOCn3HgkJW4AujB4/nwIbIvB97JbCPTdGXG2x+RSAp5SWB30oECKler3Yw93oBn4kFGauA4qH54wtSf8PjvoQTIGmX6pG+j4AAx8XiNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763396; c=relaxed/simple;
	bh=sYAkjZb+djFqN1q8sFx5G+TbrRV7w56wFYpNB9/AdIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spqKLBlUHek/+Qce2Y1sIemJgpGtRoY9W4rDyzB8iCJ6446XY9Ue4fhB5v6XO4yMRKpoJ0JzovPqpUfLt/7LtN0lMNVCYqNHY1ejWeJgrrGOFm5/SR10zAb8ceogN55Ki3yEi4iv6NC3AfiYUv3doqwPx/qB00hPGYBggv5kYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwuqjX35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7E1C4CED1;
	Wed,  5 Feb 2025 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763396;
	bh=sYAkjZb+djFqN1q8sFx5G+TbrRV7w56wFYpNB9/AdIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwuqjX350W0Mt0y6iThOGOyW7msHdoaqgjiUk91SgkKL6eMCtnkJKq0BoylEx/PXd
	 axFCc2cQ57UDgPRdXE748L8Ts2xGYPQoOEtYyQlFQSTAotgWM87wFMtuVBFXbkGRpV
	 UYWcYjunssTo7W5mc+WvKE1VN0YnmBut75WZiQn8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 056/393] net_sched: sch_sfq: handle bigger packets
Date: Wed,  5 Feb 2025 14:39:35 +0100
Message-ID: <20250205134422.440477024@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e4650d7ae4252f67e997a632adfae0dd74d3a99a ]

SFQ has an assumption on dealing with packets smaller than 64KB.

Even before BIG TCP, TCA_STAB can provide arbitrary big values
in qdisc_pkt_len(skb)

It is time to switch (struct sfq_slot)->allot to a 32bit field.

sizeof(struct sfq_slot) is now 64 bytes, giving better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://patch.msgid.link/20241008111603.653140-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_sfq.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index ed362eefeea9a..7d4feae2fae36 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -77,12 +77,6 @@
 #define SFQ_EMPTY_SLOT		0xffff
 #define SFQ_DEFAULT_HASH_DIVISOR 1024
 
-/* We use 16 bits to store allot, and want to handle packets up to 64K
- * Scale allot by 8 (1<<3) so that no overflow occurs.
- */
-#define SFQ_ALLOT_SHIFT		3
-#define SFQ_ALLOT_SIZE(X)	DIV_ROUND_UP(X, 1 << SFQ_ALLOT_SHIFT)
-
 /* This type should contain at least SFQ_MAX_DEPTH + 1 + SFQ_MAX_FLOWS values */
 typedef u16 sfq_index;
 
@@ -104,7 +98,7 @@ struct sfq_slot {
 	sfq_index	next; /* next slot in sfq RR chain */
 	struct sfq_head dep; /* anchor in dep[] chains */
 	unsigned short	hash; /* hash value (index in ht[]) */
-	short		allot; /* credit for this slot */
+	int		allot; /* credit for this slot */
 
 	unsigned int    backlog;
 	struct red_vars vars;
@@ -120,7 +114,6 @@ struct sfq_sched_data {
 	siphash_key_t 	perturbation;
 	u8		cur_depth;	/* depth of longest slot */
 	u8		flags;
-	unsigned short  scaled_quantum; /* SFQ_ALLOT_SIZE(quantum) */
 	struct tcf_proto __rcu *filter_list;
 	struct tcf_block *block;
 	sfq_index	*ht;		/* Hash table ('divisor' slots) */
@@ -456,7 +449,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		 */
 		q->tail = slot;
 		/* We could use a bigger initial quantum for new flows */
-		slot->allot = q->scaled_quantum;
+		slot->allot = q->quantum;
 	}
 	if (++sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
@@ -493,7 +486,7 @@ sfq_dequeue(struct Qdisc *sch)
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
 		q->tail = slot;
-		slot->allot += q->scaled_quantum;
+		slot->allot += q->quantum;
 		goto next_slot;
 	}
 	skb = slot_dequeue_head(slot);
@@ -512,7 +505,7 @@ sfq_dequeue(struct Qdisc *sch)
 		}
 		q->tail->next = next_a;
 	} else {
-		slot->allot -= SFQ_ALLOT_SIZE(qdisc_pkt_len(skb));
+		slot->allot -= qdisc_pkt_len(skb);
 	}
 	return skb;
 }
@@ -595,7 +588,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				q->tail->next = x;
 			}
 			q->tail = slot;
-			slot->allot = q->scaled_quantum;
+			slot->allot = q->quantum;
 		}
 	}
 	sch->q.qlen -= dropped;
@@ -628,7 +621,8 @@ static void sfq_perturbation(struct timer_list *t)
 	rcu_read_unlock();
 }
 
-static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
+static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	struct tc_sfq_qopt *ctl = nla_data(opt);
@@ -646,14 +640,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
 
-	/* slot->allot is a short, make sure quantum is not too big. */
-	if (ctl->quantum) {
-		unsigned int scaled = SFQ_ALLOT_SIZE(ctl->quantum);
-
-		if (scaled <= 0 || scaled > SHRT_MAX)
-			return -EINVAL;
+	if ((int)ctl->quantum < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
+		return -EINVAL;
 	}
-
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -663,10 +653,8 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 			return -ENOMEM;
 	}
 	sch_tree_lock(sch);
-	if (ctl->quantum) {
+	if (ctl->quantum)
 		q->quantum = ctl->quantum;
-		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
-	}
 	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
@@ -762,12 +750,11 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
 	q->divisor = SFQ_DEFAULT_HASH_DIVISOR;
 	q->maxflows = SFQ_DEFAULT_FLOWS;
 	q->quantum = psched_mtu(qdisc_dev(sch));
-	q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
 	q->perturb_period = 0;
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 
 	if (opt) {
-		int err = sfq_change(sch, opt);
+		int err = sfq_change(sch, opt, extack);
 		if (err)
 			return err;
 	}
@@ -878,7 +865,7 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
 
-		xstats.allot = slot->allot << SFQ_ALLOT_SHIFT;
+		xstats.allot = slot->allot;
 		qs.qlen = slot->qlen;
 		qs.backlog = slot->backlog;
 	}
-- 
2.39.5




