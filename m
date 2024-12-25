Return-Path: <stable+bounces-106099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE39FC3A0
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 06:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A4F18844BA
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 05:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050F1428E7;
	Wed, 25 Dec 2024 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jBk8oqOP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB505C603;
	Wed, 25 Dec 2024 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735103827; cv=none; b=lBKKekJo1qSrnkMtawVgXMbh84XCObSW7pg7quP73jYWg5UBtE+Xsxpq8prvpa5dWcKq27tIjNywaGntbIoy437X9S9GAqakv0UdFpRIO10sv0JV2oC/5PrHMmqKiO53L4a7gPAJ+PJxkY6VnCRXbb9jH1M4M7tqyY//+gjxmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735103827; c=relaxed/simple;
	bh=gd1wYg1rSEB8fl9V+//TM5/UH/nQutNvNwvPmHU8p54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiT/qX5HLpjCgsFHW0QJ51s4uMbsryJvOSq5KvInThuvVdfAQR0xvbdF6o1RJq/IMi4nQgvPhbkLxHAExMzp9kE4mvy2ilRtHQtWZklibKfZQddwRz+ZDraZWtIkP75Gk8BvZcMLw+dd9SfLAQNTf1YdUBCCPzd+OxaPyLXcAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jBk8oqOP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP3vATU015421;
	Wed, 25 Dec 2024 05:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=b0p0Y
	28dwP5ktlWsukWAeWtYSUxdvj5m7AaVg3wsQUs=; b=jBk8oqOP2dOtqVpfkL+ku
	ir83Jtjmt9HbE9HeMqTq0Ywm8uH/jglyyqGWxLQoERIENP7o0kxOAMU25vNudeWE
	nx0uXIYpDFIf20pn0Nz5mgmeqpob3nRx92j4APn7U8CarmGOTevtgsTOe5dPho61
	Oyrjx5dKyA1VjVwyOQn8lvI/f7eZHqykTGERR4ARj3awQNJJPXc7EPXNY32XkL8E
	1kd0AdZFbyRY4j0xQOUQe5n5eCe+2fTvFxnHDYJVmATKd4wHGWgWLASLlsZ8eikn
	YF5Ayhs9gYF0yyFqMa7daciUt/97AlrZn+GqRNwvr5Wmos2yfPB9JsuuVL8BweLE
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nqd5n14v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP2ASed000862;
	Wed, 25 Dec 2024 05:16:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43pk8ucjrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BP5GPg6035712;
	Wed, 25 Dec 2024 05:16:25 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43pk8ucjr2-2;
	Wed, 25 Dec 2024 05:16:25 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org
Cc: harshvardhan.j.jha@oracle.com, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 5.4.y 5.10.y 1/4] skbuff: introduce skb_expand_head()
Date: Tue, 24 Dec 2024 21:16:21 -0800
Message-ID: <20241225051624.127745-2-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241225051624.127745-1-harshvardhan.j.jha@oracle.com>
References: <20241225051624.127745-1-harshvardhan.j.jha@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-25_01,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412250044
X-Proofpoint-GUID: yKfjyTuKTVi2MpylhsLZfoZJ2d1rCyFB
X-Proofpoint-ORIG-GUID: yKfjyTuKTVi2MpylhsLZfoZJ2d1rCyFB

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit f1260ff15a71b8fc122b2c9abd8a7abffb6e0168 ]

Like skb_realloc_headroom(), new helper increases headroom of specified skb.
Unlike skb_realloc_headroom(), it does not allocate a new skb if possible;
copies skb->sk on new skb when as needed and frees original skb in case
of failures.

This helps to simplify ip[6]_finish_output2() and a few other similar cases.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit f1260ff15a71b8fc122b2c9abd8a7abffb6e0168)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 31ae4b74d4352..3248e4aeec037 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1166,6 +1166,7 @@ static inline struct sk_buff *__pskb_copy(struct sk_buff *skb, int headroom,
 int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail, gfp_t gfp_mask);
 struct sk_buff *skb_realloc_headroom(struct sk_buff *skb,
 				     unsigned int headroom);
+struct sk_buff *skb_expand_head(struct sk_buff *skb, unsigned int headroom);
 struct sk_buff *skb_copy_expand(const struct sk_buff *skb, int newheadroom,
 				int newtailroom, gfp_t priority);
 int __must_check skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b0c2d6f018003..fa3ea287d6ecc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1732,6 +1732,48 @@ struct sk_buff *skb_realloc_headroom(struct sk_buff *skb, unsigned int headroom)
 }
 EXPORT_SYMBOL(skb_realloc_headroom);
 
+/**
+ *	skb_expand_head - reallocate header of &sk_buff
+ *	@skb: buffer to reallocate
+ *	@headroom: needed headroom
+ *
+ *	Unlike skb_realloc_headroom, this one does not allocate a new skb
+ *	if possible; copies skb->sk to new skb as needed
+ *	and frees original skb in case of failures.
+ *
+ *	It expect increased headroom and generates warning otherwise.
+ */
+
+struct sk_buff *skb_expand_head(struct sk_buff *skb, unsigned int headroom)
+{
+	int delta = headroom - skb_headroom(skb);
+
+	if (WARN_ONCE(delta <= 0,
+		      "%s is expecting an increase in the headroom", __func__))
+		return skb;
+
+	/* pskb_expand_head() might crash, if skb is shared */
+	if (skb_shared(skb)) {
+		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+
+		if (likely(nskb)) {
+			if (skb->sk)
+				skb_set_owner_w(nskb, skb->sk);
+			consume_skb(skb);
+		} else {
+			kfree_skb(skb);
+		}
+		skb = nskb;
+	}
+	if (skb &&
+	    pskb_expand_head(skb, SKB_DATA_ALIGN(delta), 0, GFP_ATOMIC)) {
+		kfree_skb(skb);
+		skb = NULL;
+	}
+	return skb;
+}
+EXPORT_SYMBOL(skb_expand_head);
+
 /**
  *	skb_copy_expand	-	copy and expand sk_buff
  *	@skb: buffer to copy
-- 
2.46.0


