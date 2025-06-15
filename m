Return-Path: <stable+bounces-152669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD9ADA2D3
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E95C7A77FD
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49182063F0;
	Sun, 15 Jun 2025 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nM/OFh8s"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EA1B0F1E
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750009924; cv=none; b=uxUVt63L7169nukKzXPEc01H9MSJPEhubQf+eUZajj+QhbLEs/X93R25kUe0UOqDmPYzflzzA3zoxCLwE8ghO6ctm6Z+pMDrRlYYj+QLWbS9GgEVRiZ0wYGNkxFtfj4EcBVe0fusU+f/g/vlj+Tm+r0rum4cx8OAPUiMYHG4FCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750009924; c=relaxed/simple;
	bh=Ws1tbuqfUaW2R+rUtT0JuVpqfyMPe7/Evq1pWlkKgsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpbKb0UyZx+c1p/pFA9j694Ge+G0+gTOXNKuDYEQdWCgsjg77ZZsGeMUmedKXp6UYexHj7DwpnRxFqm/7Cw1tcUu4p4ZTAcmQAaZt6bN+Pval7O38hoKK3FJhljKlByjFWZ9WoJDkRYwEiRGxDkfS62rOuItGqdYfjiUQeLdjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nM/OFh8s; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FFkF8E020451;
	Sun, 15 Jun 2025 17:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=JXBZI
	pWG0H8Lj/ffmLImMgle2hVZpdEQ29O/BdFtXb4=; b=nM/OFh8sI3PP16BeL1IwJ
	TvyoQcjeHpYb0KmGv6UJHJKZIy7sQ1HcrecxEOJxPJKqQ1fK705vtpvd1LyXHjSQ
	K8AKn2n9/m6NjzE5NnOa4Ozuro9WpaQj25V5rDWLgog5BhzThF/yFU4QsxPsaI7J
	HwSHiNbEDffq7mLbGWbtC+EtzpJaLy09PFWn8L3Usy8Hbsg8YUfLkahkDteCbMV3
	H0JdlB/Tvo+7tDnoEHPBeoqiut5Qtg6WNe9OCbvR+bAxd64WnA1uvm9e99NjafOz
	fJSiEipEAGoD40AH+W2kA1KxM9+xBGLFhpo/BNv9zC24joQxl6ELFUoFU9Eqh157
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900es9h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:51:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FHcu5a031748;
	Sun, 15 Jun 2025 17:51:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6wk1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:51:57 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FHpugJ014138;
	Sun, 15 Jun 2025 17:51:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6wk1m-2;
	Sun, 15 Jun 2025 17:51:57 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com, Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 1/5] net_sched: sch_sfq: annotate data-races around q->perturb_period
Date: Sun, 15 Jun 2025 10:51:49 -0700
Message-ID: <20250615175153.1610731-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDEzMSBTYWx0ZWRfX+qMWE7s/J+9Q l78rYGgdJlVR1ETnVuyCF7tbtpm5Dy/Pu1gxmFyunWMVsdP66pmZILWYwv/2AVBK7SkcEvEzvab /iWscsUEodlfRTNHCsjrCujb1uWeONHninwXwjBgMp7gSmLRRFyZz4+fOcBRrTsZb4bwQnetYw8
 qcNrDeuckXjphhlGVawfIpdyB++VFIjG+kQ6vMgngHG1w1w9x1/S3LT/3IoJSxYtqJTHf23P8Gy JX6zCPEnqHGlC+mDVeiPHgd5S7btucWb2lVd0g0e9sAMx0F4szN0IX+XYzadWpxqlFlKg8oDjIX gpMiCZyhN0pxZOdTmlOrMIrcWmNBXqGP1er79416nJRrQjuJwPUVXPihrQ+l6cVgg5y4vTtHIFE
 +ciUsQ0pC+ueIcoUuLyzNksQxY9ivfAqs7BaB/cXr32INJk8kqOQgRP7WHlozYqb84/B/sJZ
X-Proofpoint-ORIG-GUID: s-2Pl3R3mwn7BlvsIzFoQeYRIMrOLbDH
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=684f083e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=pW8TaxNr5sroxWEVJ5gA:9
X-Proofpoint-GUID: s-2Pl3R3mwn7BlvsIzFoQeYRIMrOLbDH

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a17ef9e6c2c1cf0fc6cd6ca6a9ce525c67d1da7f ]

sfq_perturbation() reads q->perturb_period locklessly.
Add annotations to fix potential issues.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240430180015.3111398-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit a17ef9e6c2c1cf0fc6cd6ca6a9ce525c67d1da7f)
[Harshit: Backport to 5.10.y, conflicts resolved due to missing commit:
d636fc5dd692 ("net: sched: add rcu annotations around
qdisc->qdisc_sleeping") in 5.10.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_sfq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 066754a18569..4234ca7ac66a 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -608,6 +608,7 @@ static void sfq_perturbation(struct timer_list *t)
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	siphash_key_t nkey;
+	int period;
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	spin_lock(root_lock);
@@ -616,8 +617,12 @@ static void sfq_perturbation(struct timer_list *t)
 		sfq_rehash(sch);
 	spin_unlock(root_lock);
 
-	if (q->perturb_period)
-		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
+	/* q->perturb_period can change under us from
+	 * sfq_change() and sfq_destroy().
+	 */
+	period = READ_ONCE(q->perturb_period);
+	if (period)
+		mod_timer(&q->perturb_timer, jiffies + period);
 }
 
 static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
@@ -659,7 +664,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 		q->quantum = ctl->quantum;
 		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
 	}
-	q->perturb_period = ctl->perturb_period * HZ;
+	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
@@ -721,7 +726,7 @@ static void sfq_destroy(struct Qdisc *sch)
 	struct sfq_sched_data *q = qdisc_priv(sch);
 
 	tcf_block_put(q->block);
-	q->perturb_period = 0;
+	WRITE_ONCE(q->perturb_period, 0);
 	del_timer_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
-- 
2.47.1


