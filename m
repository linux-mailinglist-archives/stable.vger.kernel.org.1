Return-Path: <stable+bounces-163265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F61B08D50
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2501E188B353
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AB82C15BF;
	Thu, 17 Jul 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebZuy6vU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193163CF
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756389; cv=none; b=eS8LEaAtJpIRfSGSs+6Q1y5QYhtKr8R3OIq6FlBgSvj8GURrcU4uEVbCvqbnv2XSkjpdQV9QcsCvnH7a4nz55wLwNNS/TzZI7PLAuLYbxbaWb1VmtrVv4I1IQIws7gVSVuV1kNzI8R0xp/1gkwgouW/lEOZUw9Ej0TFFrPG0kcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756389; c=relaxed/simple;
	bh=mQYRkrhCy3DfNHkXoIwG3US0MPu9QuF2TAtXrfXgzrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1REby9vWKzlOIS6wJ770p1SzZ8CBuW3JG9LeEd2NsuQz5DSBZP5fizlH0+ufBglq4cmUccVplJhbAPx81n0l1dVYsdCWWT39gGwRUAsuG25wnIl+yIcJ8UggRTUd2sjAvnyubBXKRVPLMM889RPUW5Kq15SYwcGC7jjX+S0szA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebZuy6vU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7frwV025412;
	Thu, 17 Jul 2025 12:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ANHya9LWGZZ0afHtB6PU2mIqUlLY8w3eF4A/8uY0Kno=; b=
	ebZuy6vUuCY/MHdJxunwP/mDkNqUq6lXVLggWnGqpvSxad9v53cxNo6pKkcm6myh
	TwnQo7vpMinSmE972TxON6rsJGiq5+S6qXs8oQqBF52Qtdu9rm1VOFxRKyGuCVjm
	aIpvcAIDZpVj7lWcVP5ht7bon9+XeNSoOYBOKZy2DoUaXW/ul50cacPOb6TuLQAF
	iEATpKNUJkYB2SQQmTYtFcEXr1jNML36kq/hb8VgAnCSRawdXayW+62/tgcJgydV
	bkAvWzP19G9tRFw7h0Z8oQ++K2EX0yv0TCezyvZ7X/T4NuJN4KvHfLsH4EkJ2SXO
	o+3JeSCJv02YSJnFvxhiaA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx8352d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HB58SC039682;
	Thu, 17 Jul 2025 12:46:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cpy2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HCk0nx024687;
	Thu, 17 Jul 2025 12:46:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ue5cpxww-3;
	Thu, 17 Jul 2025 12:46:04 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: edumazet@google.com, tavip@google.com,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.4.y 2/6] net_sched: sch_sfq: handle bigger packets
Date: Thu, 17 Jul 2025 05:45:52 -0700
Message-ID: <20250717124556.589696-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717124556.589696-1-harshit.m.mogalapalli@oracle.com>
References: <20250717124556.589696-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170112
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6878f09d b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=cUZHy8J3r0YVTestrCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: f-aXXpnFNJubQWAoCsxXrNJHS8QqdSwE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfX83HAXLTtIRuS 6OVFtV4Ej161ZQJz935ZWpJqqueMEhs6V6Jim46EatQBYO4J6JCMt4qWgmJyaI9+DXR2/DTSMM0 3Vpeh8lV0IjBCVMLrnOo1t0dXabZoW3nc9gY9pFGPnizYT/TSwUgJfjvOxMex+Tw/gQMJnHg/r5
 aqDPoR7Yu8osq77FQ2yIVI4Vl3WEO5/CSyy6kTtkeLuWYLiFX8qB0RyCUU/qVtsFXcpq5+ZppWa Fk+bOU2+CtOrkS66ivSipRwObtLwimpHmx3VTsrS6Mw/T6E9t0RnAthkB+IqtEkpGtH+yz82Bit OqNvVxBBpYhqKndCg7M4Y0tBknj6pWxXtlEeZzlEYSFV0YuHgcsXloCY86p3VgqDQ2IrLyflpz6
 yB2+2Cyd6e+rtfvlFgQaiefrTeG7cf3BealK8NZDjE2hz6J2exvi1JIuyGn3Xtu6rTCz6xuC
X-Proofpoint-GUID: f-aXXpnFNJubQWAoCsxXrNJHS8QqdSwE

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
(cherry picked from commit e4650d7ae4252f67e997a632adfae0dd74d3a99a)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_sfq.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 7ca33cfbd03b..69e7d01c8518 100644
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
@@ -459,7 +452,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		 */
 		q->tail = slot;
 		/* We could use a bigger initial quantum for new flows */
-		slot->allot = q->scaled_quantum;
+		slot->allot = q->quantum;
 	}
 	if (++sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
@@ -496,7 +489,7 @@ sfq_dequeue(struct Qdisc *sch)
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
 		q->tail = slot;
-		slot->allot += q->scaled_quantum;
+		slot->allot += q->quantum;
 		goto next_slot;
 	}
 	skb = slot_dequeue_head(slot);
@@ -515,7 +508,7 @@ sfq_dequeue(struct Qdisc *sch)
 		}
 		q->tail->next = next_a;
 	} else {
-		slot->allot -= SFQ_ALLOT_SIZE(qdisc_pkt_len(skb));
+		slot->allot -= qdisc_pkt_len(skb);
 	}
 	return skb;
 }
@@ -598,7 +591,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				q->tail->next = x;
 			}
 			q->tail = slot;
-			slot->allot = q->scaled_quantum;
+			slot->allot = q->quantum;
 		}
 	}
 	sch->q.qlen -= dropped;
@@ -628,7 +621,8 @@ static void sfq_perturbation(struct timer_list *t)
 		mod_timer(&q->perturb_timer, jiffies + period);
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
2.47.1


