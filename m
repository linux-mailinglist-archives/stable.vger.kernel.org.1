Return-Path: <stable+bounces-155163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC8CAE1F65
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643FE1BC226D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E82DCC13;
	Fri, 20 Jun 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ak0N1LwV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D342DCC0B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434400; cv=none; b=ogGFEHDrpI3yOwERSkx3xPWXd5EJrlcgpl10FByLg7JrdkP06ea40VrYwa3dLdta6Yea3ouXQXfW3IqRRVgH1QhcUSkXcNo80TxO/QmG1dseRZSYccymGRrJBre/ib2+HewdfWZZD1l8Ce7gPmiXd4DYlCfUYJ3YjnlmgNJdSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434400; c=relaxed/simple;
	bh=JErxWvIW14nD2UNEYSDAXeSz9/XWCsZBQRmrL4BRBzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FcEfj3zB7peMrCIY9DdKteQcuu3pSueS0cJ3OkCWUigOzL6WrFvGnSXy4UFkcnhXbErqpmCqdaquxEsaMeL/gISzjlOZhV0Ql5hO7Y91qXWbYp2x2p31YBTrA899owbTWHPZxvr8RO+QYolyaQYjOVAUEQLHvJSQ57jqBU+dmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ak0N1LwV; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c7c30d8986so575783485a.2
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434397; x=1751039197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDutLDuVAjFZdbDYcrNS/xQ9KT91dlDWNQchC0hT9xc=;
        b=Ak0N1LwVulETdsQ7j7inrfT4BU2U3z8lvTdGWUzEQOvxSruaW5k5qexiBLpNzysnRc
         YBvjTAinqobc0c7EGC7TA56fzJLPmlFggTwMV9osueGR6qmSF7g3wV60V2tiJGfaSiXc
         7Jd+AywCvezTcwNr0ABBPZr89tx8u84DD93k8aw88fNxUJjH5QVByhuSLwBnU8qB+nNh
         qFy/FoHUrUm1KB2+Posc6awp+stCPtIIQvAbGOlV1VHOETUW8TKlPAAPYx36TGBQ0K8g
         A1YnNAmTkmc3ghkE9oYXoj60IFshps1L+tOAa/BU84MFKcznux9LEdZ8NEDfXjnZCNcx
         BlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434397; x=1751039197;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tDutLDuVAjFZdbDYcrNS/xQ9KT91dlDWNQchC0hT9xc=;
        b=mlI3kW6p5bSDh9fOZFf4zOGvWEAhbP2czwLuXs/pdAMlUYhUuYrOJiVRPXlVglg6so
         tAKg9UGcpm+DH7S147fJPTAKSZ2Y58KiUj98228G4YA1FN7/c7XLqcKFeLC4tFe598/B
         os/El1Q0UL5FNtZ2flf2I9LNmRG0TVMyH5UIiZdg1cBvM/YLyRisEZhrF9Txa9fmFr9G
         ftbFplrZcT8wijULHp5NFhJ7bLgRChlnlJ0IvW6JeWP1rivX50H5Jsq9Tvfk3gFLjzo/
         P4qAbV/u2D0199ZV65U5AgZLuaqZta8hQc4MWQj4Kv2GlXysIjJd5pDam/xjd+xDbP08
         zpPg==
X-Gm-Message-State: AOJu0YxJ6aI/rMRkTwgUdB8l0xUKj1WX4biYLIRedFVjVwzTKgOz+wcg
	VW3y0vb9AXb0RumEd0jJoQu1bvfwuYgZ+3e3muNefE4dEflGuejMPbzLHFP9f28I7VyF3M4BkID
	rL8fe++avYYgxK8k03kvmNdGdHb4aKXJLRxNyce/MzGekSy8L9Jn0OBa9jclk2GglIM0xb3iU7E
	HLwYbMYmhvrYvpJef5MaSQw0hgetU3kiZl0JnATmf0rLN6iWE=
X-Google-Smtp-Source: AGHT+IH1a6AHoNlJei4bd86Y0A6xVYn0sHVH8/akdxeQmdG+lCUtGjbSDkFbvmizEAr5n4M23VV3gG7ltvbWjA==
X-Received: from qknqz8.prod.google.com ([2002:a05:620a:8c08:b0:7d3:f198:f718])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:63c3:b0:7d3:e87b:dfc0 with SMTP id af79cd13be357-7d3f995f8femr511921685a.53.1750434396908;
 Fri, 20 Jun 2025 08:46:36 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:46:18 +0000
In-Reply-To: <20250620154623.331294-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062025-unengaged-regroup-c3c7@gregkh> <20250620154623.331294-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620154623.331294-2-edumazet@google.com>
Subject: [PATCH 5.15.y 2/7] net_sched: sch_sfq: handle bigger packets
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

commit e4650d7ae4252f67e997a632adfae0dd74d3a99a upstream.

SFQ has an assumption on dealing with packets smaller than 64KB.

Even before BIG TCP, TCA_STAB can provide arbitrary big values
in qdisc_pkt_len(skb)

It is time to switch (struct sfq_slot)->allot to a 32bit field.

sizeof(struct sfq_slot) is now 64 bytes, giving better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Link: https://patch.msgid.link/20241008111603.653140-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/sched/sch_sfq.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index d6299eb12a8164bcaa0594d3ac2829531bfac588..714bdc2c5a682a9767ce5e8a404=
aa7b4889604a6 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -77,12 +77,6 @@
 #define SFQ_EMPTY_SLOT		0xffff
 #define SFQ_DEFAULT_HASH_DIVISOR 1024
=20
-/* We use 16 bits to store allot, and want to handle packets up to 64K
- * Scale allot by 8 (1<<3) so that no overflow occurs.
- */
-#define SFQ_ALLOT_SHIFT		3
-#define SFQ_ALLOT_SIZE(X)	DIV_ROUND_UP(X, 1 << SFQ_ALLOT_SHIFT)
-
 /* This type should contain at least SFQ_MAX_DEPTH + 1 + SFQ_MAX_FLOWS val=
ues */
 typedef u16 sfq_index;
=20
@@ -104,7 +98,7 @@ struct sfq_slot {
 	sfq_index	next; /* next slot in sfq RR chain */
 	struct sfq_head dep; /* anchor in dep[] chains */
 	unsigned short	hash; /* hash value (index in ht[]) */
-	short		allot; /* credit for this slot */
+	int		allot; /* credit for this slot */
=20
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
@@ -456,7 +449,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, str=
uct sk_buff **to_free)
 		 */
 		q->tail =3D slot;
 		/* We could use a bigger initial quantum for new flows */
-		slot->allot =3D q->scaled_quantum;
+		slot->allot =3D q->quantum;
 	}
 	if (++sch->q.qlen <=3D q->limit)
 		return NET_XMIT_SUCCESS;
@@ -493,7 +486,7 @@ sfq_dequeue(struct Qdisc *sch)
 	slot =3D &q->slots[a];
 	if (slot->allot <=3D 0) {
 		q->tail =3D slot;
-		slot->allot +=3D q->scaled_quantum;
+		slot->allot +=3D q->quantum;
 		goto next_slot;
 	}
 	skb =3D slot_dequeue_head(slot);
@@ -512,7 +505,7 @@ sfq_dequeue(struct Qdisc *sch)
 		}
 		q->tail->next =3D next_a;
 	} else {
-		slot->allot -=3D SFQ_ALLOT_SIZE(qdisc_pkt_len(skb));
+		slot->allot -=3D qdisc_pkt_len(skb);
 	}
 	return skb;
 }
@@ -595,7 +588,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				q->tail->next =3D x;
 			}
 			q->tail =3D slot;
-			slot->allot =3D q->scaled_quantum;
+			slot->allot =3D q->quantum;
 		}
 	}
 	sch->q.qlen -=3D dropped;
@@ -625,7 +618,8 @@ static void sfq_perturbation(struct timer_list *t)
 		mod_timer(&q->perturb_timer, jiffies + period);
 }
=20
-static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
+static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
 {
 	struct sfq_sched_data *q =3D qdisc_priv(sch);
 	struct tc_sfq_qopt *ctl =3D nla_data(opt);
@@ -643,14 +637,10 @@ static int sfq_change(struct Qdisc *sch, struct nlatt=
r *opt)
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
=20
-	/* slot->allot is a short, make sure quantum is not too big. */
-	if (ctl->quantum) {
-		unsigned int scaled =3D SFQ_ALLOT_SIZE(ctl->quantum);
-
-		if (scaled <=3D 0 || scaled > SHRT_MAX)
-			return -EINVAL;
+	if ((int)ctl->quantum < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
+		return -EINVAL;
 	}
-
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -660,10 +650,8 @@ static int sfq_change(struct Qdisc *sch, struct nlattr=
 *opt)
 			return -ENOMEM;
 	}
 	sch_tree_lock(sch);
-	if (ctl->quantum) {
+	if (ctl->quantum)
 		q->quantum =3D ctl->quantum;
-		q->scaled_quantum =3D SFQ_ALLOT_SIZE(q->quantum);
-	}
 	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows =3D min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
@@ -759,12 +747,11 @@ static int sfq_init(struct Qdisc *sch, struct nlattr =
*opt,
 	q->divisor =3D SFQ_DEFAULT_HASH_DIVISOR;
 	q->maxflows =3D SFQ_DEFAULT_FLOWS;
 	q->quantum =3D psched_mtu(qdisc_dev(sch));
-	q->scaled_quantum =3D SFQ_ALLOT_SIZE(q->quantum);
 	q->perturb_period =3D 0;
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
=20
 	if (opt) {
-		int err =3D sfq_change(sch, opt);
+		int err =3D sfq_change(sch, opt, extack);
 		if (err)
 			return err;
 	}
@@ -875,7 +862,7 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsi=
gned long cl,
 	if (idx !=3D SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot =3D &q->slots[idx];
=20
-		xstats.allot =3D slot->allot << SFQ_ALLOT_SHIFT;
+		xstats.allot =3D slot->allot;
 		qs.qlen =3D slot->qlen;
 		qs.backlog =3D slot->backlog;
 	}
--=20
2.50.0.rc2.701.gf1e915cc24-goog


