Return-Path: <stable+bounces-152659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E06ADA24F
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FF188AC9F
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 15:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC812116EE;
	Sun, 15 Jun 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f9GB3ivO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDB136672
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001079; cv=none; b=oi69NHB8PzMxiVGhiRretCAsYG5CbEvq+d9hYCs1x1Un/La7+1LODqPkg5thTMIhbXplK/r6o7rLVGeg8A7CCIt+TeNYJLCnLYDZY9WrqHUmVEF8+xo+jk1J6FqJydGGxyEpZvtwyzYPhXa8GFQrTbLJoxIVSpMZ2Vqx/5v7G2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001079; c=relaxed/simple;
	bh=2kJbatZfZpBX9/sSeZWaMCekxeqFhGNWmDzSWD+c/QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiGgEkCXPlMjmL8TqAkugLTnAasBOquv0zHu9R93AE4w3k6ff98/tlWSjDfVzVD4eClKkjgVqGx328zDTFREheqvg+qaN4mjyZUjiZ/Bb3bp6yWyFYj2z6yrf9Z+JkBkpA84/xekQHqpJ+1w2fvEmJpyjpW4HhtIMeDT3ZNRpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f9GB3ivO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FEaP8j021080;
	Sun, 15 Jun 2025 15:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=QK/PV
	T2ovJqDn7HBTw7gc4pnlGlhv0PpSp+8dxoK2+w=; b=f9GB3ivOtwxKqW0lY4w3d
	os3dpNJtyYZycWO2krxz8lYdSVpx3pKoQO3P+kGssDCjTtzlNkivTAXa11N98kyP
	i+Lxgx7z+Sv47SqewHGY4k9MBqbT+AcS4k1XRctG2Eu9iKaOCGsgnGYgwNMrLVbZ
	3dfUXF0X5fgDD4LX53riT5DzKcbMsBCr4U+dLzvj/9+8wkYp4MYrsSIXtKUrIAco
	70OksJVm/U17CALJsSjAQ07UDRXDL+RnmAIG7tTfgyIxxEX4V+FutCx8K8rsXgj/
	4oFglpzIdJ3+n46toEHHoWUhcj2tHjVyTquCWU4wCmhlrJQyRi7F9VUB0ZyCuM95
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd1622-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:24:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FB44Y9035096;
	Sun, 15 Jun 2025 15:24:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6v52c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:24:31 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FFOTZq022730;
	Sun, 15 Jun 2025 15:24:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6v51x-2;
	Sun, 15 Jun 2025 15:24:31 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com, Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 1/5] net_sched: sch_sfq: annotate data-races around q->perturb_period
Date: Sun, 15 Jun 2025 08:24:23 -0700
Message-ID: <20250615152427.1364822-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: XUgw-Jqg_1yMigq7AQpZT5ZM7gZHLFzn
X-Proofpoint-ORIG-GUID: XUgw-Jqg_1yMigq7AQpZT5ZM7gZHLFzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDExNCBTYWx0ZWRfX5Lu3XmtWkfOR eG/ia5YIldtjt7McPirS+u/5DskgamKciidhb/rUEpeNMN7Doi4owOsEMDQRloHWuSdrqahVUF7 Rdr1ddFM+u9OsZ2qtq0grmEFBc6zMWT2Dapo4vUxFfwvG5JcN/SgR6XzXeBzxkw7dHJJ6yu4Ta1
 yA3c8uavRMBdXKOR/ZpZY5Xyb0q5qw+hVFb/idxeFPjnKqeE0Kx1S+2tEprhY+dlLqa/uQd98IZ OPu7iiq43IvPZjr5E2MRPPdWF8E/nAwmr30Ekc44vUyuzqp3cW9lzdHGqdL9RgRagFJrR3xL/5c aZeTZnnFXuBD3vkjDnOdLmnQyK7YLy8MJMEPDqbL9z0yOEmqjH0XAtX8rCk1hr+iwrqpK+FZZ5O
 BOsbHY4AA/cClSvZK7CrBoH33AiFSfuALdX6SnMHa69KrzSi4By9ArMIriV7nvHgOnpMikdS
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=684ee5b0 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=pW8TaxNr5sroxWEVJ5gA:9

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a17ef9e6c2c1cf0fc6cd6ca6a9ce525c67d1da7f ]

sfq_perturbation() reads q->perturb_period locklessly.
Add annotations to fix potential issues.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240430180015.3111398-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit a17ef9e6c2c1cf0fc6cd6ca6a9ce525c67d1da7f)
[Harshit: Backport to 5.15.y, conflicts resolved due to missing commit:
d636fc5dd692 ("net: sched: add rcu annotations around
qdisc->qdisc_sleeping") in 5.15.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_sfq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index f8e569f79f13..d6299eb12a81 100644
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


