Return-Path: <stable+bounces-152672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C25AADA2D7
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED907A783A
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77D2063F0;
	Sun, 15 Jun 2025 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsgcAoNd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123861B4257
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750009931; cv=none; b=usdChcXnLe0lg8YaEABkjroij880vBURrxwRfBXCEvhAI28Xrg9rQdZQ6Zl354Lr0CoxfREmKcDCCfJ3egVbMRanQ7Wcpfa5vC5Ml9KKQf9Fh/0v9z5CLiberYZfy3Dza4DMqFkTSyGPwNmi6NOXqcLCMgVyRXjOTG7C/lyEJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750009931; c=relaxed/simple;
	bh=+XIuV5U/mYQlha6LMWqC+5x5TPW3nv8FhNhdv6euXjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxsuyAI1AoR2dramcUTw1kod0lethS5oDP/0bGvbQH8IuzMgLidUqe9SQ+djRLRvtz8EaarWj5HRxaOGIbuqLt2lBtwZbaVlh1fW7q4rzn6sUJw/Xzbvuqwt5yngmOHT/D50scF8K04bfof9pqVC35nYsXcLQmS9o9SPw0D99vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XsgcAoNd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FFcrjt024142;
	Sun, 15 Jun 2025 17:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9okXR
	RS4EQfUhDe3KaGVbO7atObvh5HE6Gy3hdH5V+E=; b=XsgcAoNd5r9uiIvtXIDcW
	UN/cBpDNdQgGNagqKrUjY1lqzjCfNUMxhzNeH3JCWh0+DDMFxCHBZpR/dmSIkhsm
	gIwI0vhw44i/F8UxXrGJi5YHXPdJoZVTo8xfCZWq072iY0zflJJTbm2S+j/gxn6f
	FDGSeENmUfZ5Fd+QtHloHhQQk0WSWtuMqrQnt8WpEnMM4y9CDyykkYD2bdfIKJ4v
	9G2ez0/evycxCUYu0nheVKOD7v56buMPr8jyMJcn9jlo599kiuHPbrzOV4R3mD2w
	C8cJaXfflUNKt42zwhYQ/19d6cFc0AvV9NP54b7debWW3Lb001C81noOWFMFt+oW
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r0fcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:52:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FBY19X031638;
	Sun, 15 Jun 2025 17:52:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6wk2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:52:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FHpugP014138;
	Sun, 15 Jun 2025 17:52:03 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6wk1m-5;
	Sun, 15 Jun 2025 17:52:03 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 4/5] net_sched: sch_sfq: use a temporary work area for validating configuration
Date: Sun, 15 Jun 2025 10:51:52 -0700
Message-ID: <20250615175153.1610731-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com>
References: <20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506150132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDEzMiBTYWx0ZWRfX+L4s1C4urYzw wIYPsg8+UpecT1ZPmIXD67lH00aJeZ9V+9IJmMruhVBWHbN1klvhx9GqU233KkosUdheF9rVZV5 yIdgBAT+AJfY4QE4ABgjY3LLIH+XPNcmb1Nj6SzM1SWdjFRdV81e7NhJP3E3s/h6++lfVaFEDvO
 EW/cuCtxEaH7fKdMfgSG0zygUG8t/uDxSQK4nWQNhEVl6lhb7Lu5ctT5CJ5Zo879s8U2PuHwUiP +4INJz8G/I6ME6ZDY43t8TejzClxZmCWbM5+dsy9CptLVW9l+h/r6QiQi7+9FYNIFitXBUDnkQH HxF0FapCuZl7mLDQALPFxZ1Tcq/aJl62/hBgcfTY4M60FfzUp1w/STzCJLkVpVVZ91LEAx8+Fhz
 Ts4n6Zq+NfpdiOPH4BvukMomRO+/OqF+EZktwQ3lJ+533pbK0hzTvAftU9dUZhir2+v+9r5K
X-Proofpoint-GUID: haIhlQUc8VHfHxGZku0bekdkw5rnjXNt
X-Proofpoint-ORIG-GUID: haIhlQUc8VHfHxGZku0bekdkw5rnjXNt
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=684f0845 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yPCof4ZbAAAA:8 a=CCMG9A82kNbp8Ti1VMMA:9
 a=y1Q9-5lHfBjTkpIzbSAN:22

From: Octavian Purdila <tavip@google.com>

[ Upstream commit 8c0cea59d40cf6dd13c2950437631dd614fbade6 ]

Many configuration parameters have influence on others (e.g. divisor
-> flows -> limit, depth -> limit) and so it is difficult to correctly
do all of the validation before applying the configuration. And if a
validation error is detected late it is difficult to roll back a
partially applied configuration.

To avoid these issues use a temporary work area to update and validate
the configuration and only then apply the configuration to the
internal state.

Signed-off-by: Octavian Purdila <tavip@google.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 8c0cea59d40cf6dd13c2950437631dd614fbade6)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_sfq.c | 56 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 16dd1d802e64..9a8c9138702a 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -628,6 +628,15 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	unsigned int maxflows;
+	unsigned int quantum;
+	unsigned int divisor;
+	int perturb_period;
+	u8 headdrop;
+	u8 maxdepth;
+	int limit;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -653,36 +662,59 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
 		return -EINVAL;
 	}
+
 	sch_tree_lock(sch);
+
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	perturb_period = q->perturb_period;
+	quantum = q->quantum;
+	flags = q->flags;
+
+	/* update and validate configuration */
 	if (ctl->quantum)
-		q->quantum = ctl->quantum;
-	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
+		quantum = ctl->quantum;
+	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		divisor = ctl->divisor;
+		maxflows = min_t(u32, maxflows, divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
 		if (p) {
-			swap(q->red_parms, p);
-			red_set_parms(q->red_parms,
+			red_set_parms(p,
 				      ctl_v1->qth_min, ctl_v1->qth_max,
 				      ctl_v1->Wlog,
 				      ctl_v1->Plog, ctl_v1->Scell_log,
 				      NULL,
 				      ctl_v1->max_P);
 		}
-		q->flags = ctl_v1->flags;
-		q->headdrop = ctl_v1->headdrop;
+		flags = ctl_v1->flags;
+		headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
+		maxflows = min_t(u32, maxflows, limit);
 	}
 
+	/* commit configuration */
+	q->limit = limit;
+	q->divisor = divisor;
+	q->headdrop = headdrop;
+	q->maxdepth = maxdepth;
+	q->maxflows = maxflows;
+	WRITE_ONCE(q->perturb_period, perturb_period);
+	q->quantum = quantum;
+	q->flags = flags;
+	if (p)
+		swap(q->red_parms, p);
+
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
 		dropped += sfq_drop(sch, &to_free);
-- 
2.47.1


