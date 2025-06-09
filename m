Return-Path: <stable+bounces-152245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047AAD2AB0
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 01:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DC9188F2D2
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 23:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D222F77E;
	Mon,  9 Jun 2025 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SI2TVuX7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0322F77A
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749512948; cv=none; b=XnOYwbl5wxq7SwTWhDQ9dOyxKmzLU1kMbWPGgzIwCLe//qCRupmmsTkiVsSYXJUg8WlvB+zPj1kSHeWNKaRq1aWRD2qsUe3j5ESqiWqx+wMZqeTb5+IMVpSlOsyh0WN0AHBxky5dx14L/xW0sIXaR+ELQUGljU4bRlCvMRokrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749512948; c=relaxed/simple;
	bh=CTGH0YP0bNau1Q/PpchHX6xqrL8uXx8cRZBZc8GQ7yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfRBFw+yC9U8NczMOpX583CT3MrPZoDiLiOSezwqT5AkWKZhh+783iMuVCcZz7826a4BCmrl2zzv5QGI5xnOYG4wri+TwQ4rLGE5z43ZhTqqSlBc/zbCjffFFUYAIIwQGBqwPVaCSD3Fqt5vYjQRjmXNwUEu43tpdQgDP8c+Ac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SI2TVuX7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FZPiS011991;
	Mon, 9 Jun 2025 23:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=QKZj2gneWQEl4TkNQSjsIH/qhRKQh
	g0ZC59hKpeOsSs=; b=SI2TVuX7YTyCyu5Ud5eoGmGbjHUTuzKid2uDudiQ/RAfc
	5erwpt3BZCWmZlXIFLO3eZoVUftoobCLYXYQl7NnnX1aUY7txo2Y4J8CFr9EeR7w
	7CJlcaBdDpE0yW4l2P1c/MbKfgbwG5EPSy0Rj7Ro6S4BRc9WD3CLw+wGbJbyTDSg
	gbKN3e+DfkdQjPMM3PVQT2fNe6iuhUdlv5C2iUkbAlJ9cKMbtyrAGkxawh3IUW5B
	EzYhf15aLRCYHVGnuZ/WYq+8SWaLcbMZ2V6warWgnnKcWjIUhgAB81wr3Y06oLk8
	TGdqJL9/ffFwO1UMp4pMJFGxoxzcWC/TBINlUtJBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbeb537-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 23:49:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559LSASt020342;
	Mon, 9 Jun 2025 23:49:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bve9hhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 23:49:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 559Nn2wc039604;
	Mon, 9 Jun 2025 23:49:02 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 474bve9hgn-1;
	Mon, 09 Jun 2025 23:49:01 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: dan.aloni@vastdata.com, chuck.lever@oracle.com, Anna.Schumaker@Netapp.com
Subject: [PATCH 5.4.y] xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create
Date: Mon,  9 Jun 2025 16:48:32 -0700
Message-ID: <20250609234832.2950719-1-larry.bassel@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_10,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090182
X-Proofpoint-GUID: ugtWGWAB6-y07UQWQNCtbwleOZflKv5_
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=684772f0 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=BQGwlwCTAAAA:8 a=yPCof4ZbAAAA:8 a=JDjsHSkAAAAA:8 a=_56xrKdBjd84HXgoILEA:9
 a=HFqQS4YDwGEJ6BLTKAzC:22 a=dseMxAR1CDlncBZeV_se:22 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: ugtWGWAB6-y07UQWQNCtbwleOZflKv5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE4MiBTYWx0ZWRfX4i/fwDyLQt3X 1Bi+MUYil9KyaOOzQ3+n3ZzUvpO69lxcUVgwH9vomE/czdjqVbfMYjjzwij1LXaWywY9h4hEdTn cD3OpOpf+l23qZ+Ejg3wkVvNPLi9Geax7nWFay45FbUthP89PhCk+SvBFSCoWShoVKFK7joIeEl
 NQA6P322r41vSvstHPwS5yDYcovpPTULBH80ChpLSh8BQMBiiRS+bkq14PExq4lu7MWx3kT4dA4 N2m1AwQCMGKR5Dv1K3vvJ6wPHKdp+GlyM7OyXzAEOhC/KD5WYVrXyohyTk0Eq/NECKQJ8+HmK7G O2QOCCPt9T8c6NpaOBnYMdWoJtwMm5aqWdCVr3rUKZHHGYCpakugQ+Y7fizdoE7YID22kkG3hv/
 zURTsSbkkqmE5b8f1kwh5Y0JpIxwLLBE1iSoPxWoFZvXjj8cMXEZ0seeYQg20GSdv2LFuOqJ

From: Dan Aloni <dan.aloni@vastdata.com>

[ Upstream commit a9c10b5b3b67b3750a10c8b089b2e05f5e176e33 ]

If there are failures then we must not leave the non-NULL pointers with
the error value, otherwise `rpcrdma_ep_destroy` gets confused and tries
free them, resulting in an Oops.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
(cherry picked from commit a9c10b5b3b67b3750a10c8b089b2e05f5e176e33)
[Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 93aa8e0a9de80
xprtrdma: Merge struct rpcrdma_ia into struct rpcrdma_ep]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index cfae1a871578..4fd3f632a2af 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -525,6 +525,7 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 				 IB_POLL_WORKQUEUE);
 	if (IS_ERR(sendcq)) {
 		rc = PTR_ERR(sendcq);
+		sendcq = NULL;
 		goto out1;
 	}
 
@@ -533,6 +534,7 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 				 IB_POLL_WORKQUEUE);
 	if (IS_ERR(recvcq)) {
 		rc = PTR_ERR(recvcq);
+		recvcq = NULL;
 		goto out2;
 	}
 
-- 
2.46.0


