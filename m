Return-Path: <stable+bounces-152670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C73ADA2D5
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 19:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F317D7A7869
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3E1FE474;
	Sun, 15 Jun 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A4tN4a4M"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE013B5B3
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750009929; cv=none; b=nPzer8DCKgg/GW7Kv46/Q1V7Zp7Sh38qUrXkVbiao5PhQc60p3AQ1HH2zP6IvpH5sNYroB5S558an/9EW5HCsmfBZeqEdItf3vSUURtsMmZKXeqwK0T/2+DEiO638CnnV6Y3wfRhoOZtvkISywz1j1j6fF3ph+q9TRMI+UwJMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750009929; c=relaxed/simple;
	bh=Usb+LdYkIcmrtq9Fh+vHyNuWFNNedFtkDPBM+Gtowtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDyGK+DLzUfEa6TXZjcmLcCMoPkQ/EkXL0vyvP/4TqyfjDbHcyXGWAXHM1wpZtkBZfQii4oqlvaY6lzADt0sVohUx6rpdaeQ8KxMZmkp87BxZXCBxZJSpgmFNsRFydfiPqWUXg+3w2G/nS5ndeTy/PiXIfiP/2tNLqiJqJrrhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A4tN4a4M; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FCYUUL019886;
	Sun, 15 Jun 2025 17:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PbEacalg+uwHAqBtZyskPXohIzT9acU6f+K5lzyo6r0=; b=
	A4tN4a4Miy4akwJzODCdkzKAqACxEAVa/cvu7qGCw3J5Aaj5ALELnhvMv1fFJs7g
	Duf0w6K/W3vbFR5I/0AgaoljjkXc9KJVVZ9MmMZt7a83j9hkTwQksqJvZLCp4NkM
	Qgp2p1nvMA835JxbdbMyhf2YLH9iGiKkT3qFPCYybDw4o61vs7vGhf0LruMxM3XX
	ms8F+D+Z7L5AjCbQCkXAJjLm0BDbg6QCDSr68Bus0Nj9R7FPE+FYN5qTdQOCf9Sy
	WLRWrXsq8EiJsdIPqFjXGnQe8zm+iiLcucWfQrDxhqk2ZOZIhFUoISIKicYaZuDv
	GCPk0bmPlHrkf1flkmmT3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv519yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:52:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FBQhcR031670;
	Sun, 15 Jun 2025 17:52:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6wk23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:52:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FHpugL014138;
	Sun, 15 Jun 2025 17:52:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6wk1m-3;
	Sun, 15 Jun 2025 17:52:00 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 2/5] net_sched: sch_sfq: handle bigger packets
Date: Sun, 15 Jun 2025 10:51:50 -0700
Message-ID: <20250615175153.1610731-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com>
References: <20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506150132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDEzMSBTYWx0ZWRfX7tAxNFaLqZRe hoajq5AIsIYIsQb+otoFb/wl3EW+XrJQ7cPQg/yy5CnOmfLN5nnLvd4Z58qmetKm4aK/Jdk1zJj Um5nxcQP2I4/W3GpOkqQ0at1+05+S4gx4RsYx6Q6kKLLyBNh10CPSuv+7WgKtn2RzbWRUp1gAD5
 p3vyHWEes7d4U53ogQuTLFP0qZjcRX9lNdaml2Isegg7CLTP+hQGzE6g1fcH5BJkWtNHbh/3gy+ pKp2sqeZZX+LmAAiwU4S9Oh/gDsV/Pd9ujB4JDQ7Ffx7J9DIn/7nfMmC0mdR0aGG9Se/YaePFp9 hVQ76fmXxnWuva08OOzkyu+92J0kfjaBbfqoYn7H4SYfbzGMDsTzMXDYh3BZAfdLRc8JKB0l4I4
 GLnOyZ026t0FqczbjQqtrEU7OQgFEGx4YiFgLEgzZ3R0+Ydw065t5ogwWtl3KX5WIfUNXozJ
X-Proofpoint-GUID: B5LqQGqu8iITqTtRN783Q4mBg7qcJRGB
X-Proofpoint-ORIG-GUID: B5LqQGqu8iITqTtRN783Q4mBg7qcJRGB
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=684f0842 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=cUZHy8J3r0YVTestrCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22

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
index 4234ca7ac66a..2fb2dcd0ae2a 100644
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
@@ -625,7 +618,8 @@ static void sfq_perturbation(struct timer_list *t)
 		mod_timer(&q->perturb_timer, jiffies + period);
 }
 
-static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
+static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	struct tc_sfq_qopt *ctl = nla_data(opt);
@@ -643,14 +637,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
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
@@ -660,10 +650,8 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
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
@@ -759,12 +747,11 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -875,7 +862,7 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
 
-		xstats.allot = slot->allot << SFQ_ALLOT_SHIFT;
+		xstats.allot = slot->allot;
 		qs.qlen = slot->qlen;
 		qs.backlog = slot->backlog;
 	}
-- 
2.47.1


