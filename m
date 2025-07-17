Return-Path: <stable+bounces-163264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC00B08D4F
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7E64E4906
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9C29E0F0;
	Thu, 17 Jul 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gHlAyh+Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471D63CF
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756387; cv=none; b=UPvfF4H3dhB8JvTIMsYA3USOfE92wF3vc4TptBFcDpvEAceyWNVdfZm7GirKj+9A/xboY2q1HgwtwWlAylI1TD0++F44fr6WbcRH+SFP7huJHtW0bTzYYwZ/gM76ASTNFqYzCtD3YQOYTU9XDyM+nkI2AlC/RwPVRBN+q3mQ3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756387; c=relaxed/simple;
	bh=pH+H+E7v27TRNGg9LwKngmFzYC0rqoD7qcD5Dk5tOhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az7viZ0X4D18AlX4aSSO/DsoSEj1DeSzOUQJt4G0OLNoyZxCfFKl435nVCLGUrUoLug3WVG/B+HWu/y7PxnAGLNvPXEVGSfEZTAxjaD79auwz64qpm16LfmPNbi+A0cA5HIEjudvrZltYL46b0E7zMYeQZgBs0H9RHIKb/Og6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gHlAyh+Q; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7frwW025412;
	Thu, 17 Jul 2025 12:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8K71i
	bCFneWJ0igdv2v2ejeZ677k+U6ap9a6o1/hPb8=; b=gHlAyh+QKVEy5Annf15Pk
	EGb87aIcS1vfkZt+cQQ6Om0UZKVNZ/+u+gqeUIQl/mzQRghoTpckQ7Mg1K2kZrMX
	JHk2EkHoqJvB779q5fmyf3GR3KD/fyX1vVc6ncWUgHWLaOLN7P1ifVrhkJVKxSJE
	d/52IeKVh7552cl4gngFFXBD6w++LStSV7IbOj9yLw7WYOxNRiz/vwabj+0yV5Iq
	rzccpknWOX6rOSww5jmZ+SOUiiH9nFdK+gheI9hwRK9fPO0mdWDNAjbU4+7pt/GX
	ncSjK4hTveUMvSKT5DoGhkaIichqiOruWnqlacWJFn4eWo88Af8R+pNio8GkGATc
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx83526-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HB19FK039597;
	Thu, 17 Jul 2025 12:46:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cpy17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HCk0nv024687;
	Thu, 17 Jul 2025 12:46:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ue5cpxww-2;
	Thu, 17 Jul 2025 12:46:02 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: edumazet@google.com, tavip@google.com, Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.4.y 1/6] net_sched: sch_sfq: annotate data-races around q->perturb_period
Date: Thu, 17 Jul 2025 05:45:51 -0700
Message-ID: <20250717124556.589696-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717124556.589696-1-harshit.m.mogalapalli@oracle.com>
References: <20250717124556.589696-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170112
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6878f09e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=pW8TaxNr5sroxWEVJ5gA:9 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: ZVZ3bAK7dUH8Z0cRzIUiNpdot8HXkzxD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfXwKx7TBXTj2o5 mAs8Nk+0IgAuZUNQWJIlGdmRmQ/CjaBFP7fASaROEBbHBi8tmHevcwSpoQRIdfqCBLJ1Mi2pV1j RedDpYJHHbL0d4+hOMZQKud5LFBfzq1ramzfbqRdyCk10QiTg3TsgTE77+y7n1WkfiRIyv1m+R0
 Zod/WPTihlvLbNcrjPFY0i1ZVV/+GVAqOyuCtYnaSXyO2oXghW6tkRPVdaai4zt+lcDhy8Jq2Xj VVYJXaYiQvZdByf2pEF19X/tUhoX2Zasd88f0GTgnAJBO3O7U33RmSrI/kRIE/sR02tGAwdjCnZ lMexdLxj6txylZWgrLg6rNkg2FjXT5T4mNDRrhmdU6Wv3SKAhUm6VlrFjiiyY1O5E5UlwAycWhI
 bTF70kpwu7Xp4gEX0LPetinUcOJ6ONARlotfvh6lUt6HSDo4PUJNFJZvdHJgjK7Kyl6k5QhW
X-Proofpoint-GUID: ZVZ3bAK7dUH8Z0cRzIUiNpdot8HXkzxD

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a17ef9e6c2c1cf0fc6cd6ca6a9ce525c67d1da7f ]

sfq_perturbation() reads q->perturb_period locklessly.
Add annotations to fix potential issues.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240430180015.3111398-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit a17ef9e6c2c1cf0fc6cd6ca6a9ce525c67d1da7f)
[Harshit: Backport to 5.4.y, conflicts resolved due to missing commit:
d636fc5dd692 ("net: sched: add rcu annotations around
qdisc->qdisc_sleeping")in 5.4.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_sfq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index acda65371028..7ca33cfbd03b 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -611,6 +611,7 @@ static void sfq_perturbation(struct timer_list *t)
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	siphash_key_t nkey;
+	int period;
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	spin_lock(root_lock);
@@ -619,8 +620,12 @@ static void sfq_perturbation(struct timer_list *t)
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
@@ -662,7 +667,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 		q->quantum = ctl->quantum;
 		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
 	}
-	q->perturb_period = ctl->perturb_period * HZ;
+	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
@@ -724,7 +729,7 @@ static void sfq_destroy(struct Qdisc *sch)
 	struct sfq_sched_data *q = qdisc_priv(sch);
 
 	tcf_block_put(q->block);
-	q->perturb_period = 0;
+	WRITE_ONCE(q->perturb_period, 0);
 	del_timer_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
-- 
2.47.1


