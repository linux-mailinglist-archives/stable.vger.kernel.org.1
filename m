Return-Path: <stable+bounces-152662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D3ADA252
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0553B061E
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179327A107;
	Sun, 15 Jun 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JU0HKMg3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B426A1BB
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001083; cv=none; b=iqz0qs3kcZ2BZ1rxX5ZQp1TOxkHRbgDNqnl9uDW4ce8JUG3EdCIhOhKfoxCvAu2+vhfwvjkeK8wOpEnyKDKSQCFCdNnQvKPKXgtElqEXDSFTnMjYG8UR+rF3LL0tOUtB5rJYMauuoIUJ16tyDrYRDc5dDuD1X6yI/D3R8E8ynq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001083; c=relaxed/simple;
	bh=jjYa4BLs2fkNYJP8oOxhWhNDauC2ZCEcl2kCMpbpTU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S77g0FUizUeMP9o3Bhew3z1kXhS7vNYseI8IifWDHogi9MwbRJt1vmXVwjMXeqUmL+Qor7WR2Rg4orYm0pj/liHGhcHEDlzaiAcDOcNBaPPD7pFBF0VZ3/igrMWu40zAuS47sbp36OlQvnLjsC7SYlKSwjg8oMKX9pzueuX9Gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JU0HKMg3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FED66t021089;
	Sun, 15 Jun 2025 15:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=k2yQy
	jFm+HEG3AkJ+oFybZtwDu4YW8IKMgpRCIrqNu0=; b=JU0HKMg3OzzdZxRtJWYLD
	vlVgT2pnpF5cqFw8q7q4YG0Z6FYq29+Azt+NXHJ89GxUnO/EI1buJ7HNRDALvhZ/
	iqDiD1tlxqLiMA9qiHWU8U+gON0n4ROZCTGMR5ylEM5N+K/yA6nTSj+cuaeacvfS
	mYW6h06X0Hg3vL3plWiLsBjsVB1xb65YsGwSPb/qJATTQU7ChUIXqE31ctOp5fWr
	HDdj2hj1DjS8BybPU+juYs5gWttaiaogPkr+TRMuHzI55uX2o9m0W3kqSAFcW5WM
	IChFepCvBBnnkvjaq2I4hrm23m83jHSthKT6I0/3fc4DvRRPY/6cgHU1n1GaV5Gj
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4h7ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:24:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FBGrCj034396;
	Sun, 15 Jun 2025 15:24:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6v52y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:24:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FFOTZw022730;
	Sun, 15 Jun 2025 15:24:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6v51x-5;
	Sun, 15 Jun 2025 15:24:35 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 4/5] net_sched: sch_sfq: use a temporary work area for validating configuration
Date: Sun, 15 Jun 2025 08:24:26 -0700
Message-ID: <20250615152427.1364822-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
References: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506150114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDExNCBTYWx0ZWRfXyEFVLjOPJOuG zXKMbTXwOj/+J4wpWzKq9HZUE4mwki4kUb+CnQxti9Wdd0f7iJHJ00L9IjS53rvuCIPk0S7y8mD CPv2UjJArVJj3QZZrJ0VjUS4YcPCCDtJKoPbo18GAIpVLt6VvLVUfZoRPsWb2bdUCYM5swZNL3R
 1qHKZRrAfirwNW3c7V7YQI4mITAUY82vtD3JjkqT9OgS5bqBZc1wwcLxLMX3zFFLiTl3TgBjaB9 aJmp6v1J2XbsziKDUopRtMHqJQ47m7ojftoXJ2ucc9iI4oEoWLDzO4j84+lD6cxDRiA4G91T1/4 xHycdTKezVIz59mbOQuIxq7rK9nf8YykWWZzbymGV9L2TZ6TXhUZwhy0CafWA+nrcZb7BADPZQm
 ETCJvsR+BbjsdNY+5BeaexZFUIiYh3t2bzR8kSr2+J+RY52BlTmj8Xe1Stw6GuUSQGyKaSQA
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=684ee5b4 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yPCof4ZbAAAA:8 a=CCMG9A82kNbp8Ti1VMMA:9
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: bNlssJxx9PQEmN9l0a8kx7y9adtOzSrJ
X-Proofpoint-ORIG-GUID: bNlssJxx9PQEmN9l0a8kx7y9adtOzSrJ

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
index 505209a932ab..0d916146a5a3 100644
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


