Return-Path: <stable+bounces-163263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A87B08D4E
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BBC17D4AC
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853E29AB09;
	Thu, 17 Jul 2025 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SwENgFCL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CE5789D
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756386; cv=none; b=rTGKmhFuhxgOJqHIOYL+TcjzIQ6Cv5CZDyN390H6P2KGTduO61cudmprjBPXKVrpVhPSpg9WvOdZiDSQ44u8PpQt7bDMt2hOuS0Ow5/dyNwSnCXJ2/AVmqDaUDzrmwXrGFkknyK4nUhBruQ4wkbHgO2QH5EOT0naNtjEA97GYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756386; c=relaxed/simple;
	bh=FYZTpOIkzE+CIPCY7TWqrvc46ujWWaUfdDUDVnFRG+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF/LBPt8i5fa4UlsYyjQiekzPdd6XpF3dQE2+/DnTKwxb1OcUA4J+UOjHI81PF4jUNeg5eQRVQ2jYB+nisLxgbtb/Aw1B1WQ4bad22Zp3930zBy/Pzb6pO1FMgoUYfUobNiuvntgwHMMl1OlslxVF1QczoS9OAkC18ZWG8MFMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SwENgFCL; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7flXY025394;
	Thu, 17 Jul 2025 12:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=XMw+E
	a7n5yTB/4zLYKV0B8eOoYcQwzhaLc3TR/fDsUg=; b=SwENgFCLiOxcoLEPsDGIH
	b92SfsQ6ZhKnhGiL48SAiVXYgrCOb+rP+Fy4YgedEdSaSte/apZdcNjZ8OomkUDq
	lRUbwpJeH0wUFTXteo4qU/X/qlLS9c7CVFdUS+Y0wpEcT+u2M8i5FP2b4fQf4dB7
	fbHeRvxt3rxDYHMcmLA4MxBG1zXI+J5tjz2lB/35+db6aR9LRTvD99AqXlIV/Dt/
	ybY+2tkJrKuc/9uO0+/DYCqawVjD7fUoF9WfRzXKmC/8IVBOCq/fJ/FkpJvhwhJT
	isakglui8fdV46DIqVYnU59YLg3AUUcOWQnq8efEBPj3Sd/uqqRENElmmIQQFsi3
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx8352x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HB9X7B039601;
	Thu, 17 Jul 2025 12:46:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cpy8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:14 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HCk0o7024687;
	Thu, 17 Jul 2025 12:46:13 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ue5cpxww-7;
	Thu, 17 Jul 2025 12:46:13 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: edumazet@google.com, tavip@google.com,
        Gerrard Tai <gerrard.tai@starlabs.sg>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.4.y 6/6] net_sched: sch_sfq: reject invalid perturb period
Date: Thu, 17 Jul 2025 05:45:56 -0700
Message-ID: <20250717124556.589696-7-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6878f09c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7T3opWC_yx0JHwMEbIIA:9
 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: xQrvHQV0I7oHURbvUX7gPfeB_C5eXCfq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfXxFxCOAEaPXDi lCxxsrqRnmnanqhRuAbh9XxjcysHjaUKzR0WNk6D9MEQR6AGZrU2AoBgFFBr+Fsa1h/7mdzIDQq j8pdSfjYH7c0BnecywVGkQcu9/58PTL6b/LFC2aClgGwHnE6uCLMRmL4YSEzUgnJzM0DqVcjBcv
 4IzpiOqiCSaL5iwn0/fHvePYbOWfgMe/eF0Mry/xW+4wOD9wdFbFn8P7X3l4TN/szGw8/b6WmiP x7KEW3arwmQqe5wSa7DNhZTcRiLcWCVXQe3vhZPO9juZhKaBjs+kfgf5MpniGZh6QdkIN20RC7u 7y/AGE3IuaOp7WrSc1fGI43BNdtk66S+otegdLL+CBryo1lj9jisNbD1sMrp/1pI5cEgn6lt00C
 7qaA7dW3exvujfXsNOHGNz2rjQcrLivLQJd4ESHWE1gnGEr4KfHmcbfwSC5mcVHq5oTLyIwX
X-Proofpoint-GUID: xQrvHQV0I7oHURbvUX7gPfeB_C5eXCfq

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7ca52541c05c832d32b112274f81a985101f9ba8 ]

Gerrard Tai reported that SFQ perturb_period has no range check yet,
and this can be used to trigger a race condition fixed in a separate patch.

We want to make sure ctl->perturb_period * HZ will not overflow
and is positive.

Tested:

tc qd add dev lo root sfq perturb -10   # negative value : error
Error: sch_sfq: invalid perturb period.

tc qd add dev lo root sfq perturb 1000000000 # too big : error
Error: sch_sfq: invalid perturb period.

tc qd add dev lo root sfq perturb 2000000 # acceptable value
tc -s -d qd sh dev lo
qdisc sfq 8005: root refcnt 2 limit 127p quantum 64Kb depth 127 flows 128 divisor 1024 perturb 2000000sec
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250611083501.1810459-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 7ca52541c05c832d32b112274f81a985101f9ba8)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_sfq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 9e8601e64508..eaaa5d0e17a7 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -653,6 +653,14 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
 		return -EINVAL;
 	}
+
+	if (ctl->perturb_period < 0 ||
+	    ctl->perturb_period > INT_MAX / HZ) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+		return -EINVAL;
+	}
+	perturb_period = ctl->perturb_period * HZ;
+
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -669,14 +677,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	headdrop = q->headdrop;
 	maxdepth = q->maxdepth;
 	maxflows = q->maxflows;
-	perturb_period = q->perturb_period;
 	quantum = q->quantum;
 	flags = q->flags;
 
 	/* update and validate configuration */
 	if (ctl->quantum)
 		quantum = ctl->quantum;
-	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-- 
2.47.1


