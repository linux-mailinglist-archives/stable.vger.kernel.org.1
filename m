Return-Path: <stable+bounces-124630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7051A64D15
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 12:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26D41892BA4
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19F23643E;
	Mon, 17 Mar 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p4l0vSCv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA419E966;
	Mon, 17 Mar 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211732; cv=none; b=JKaQ7n0PJiuOhMPH4kK7/SnQVDEHFzQcjZnrWqmHF+M0mS8GpkfUzwnm7ZupTAgQzlJXQr9x94YkH0aJ2xNa8YcNnJa+33oCAfckywdSjrNT3TDQ6/LI4DULWtDln3WHgvW+xK6/EAC1by2X6EehRleAuVoAtpm+R7SVA6KLijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211732; c=relaxed/simple;
	bh=aDUIWVNGWKXE5poDnZnwEiUiQ1/dygQU8H1FEa35J8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ENdsrtJi6NwDZaAYUuSFIb7RF+4r7MLq9wAXeWyZ2AC0rB9jCHjJ448zIC+ORf1Pl4eCnzPO2lSpwnift+1XsSszOUpornvgPR2daKCcqBhUKw02m0n9zkm2CdSD1xUjPHPodmQU3b93ur/Bx4agYj0BbwD7PffSGw7oqLR73DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p4l0vSCv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HAJiB3016240;
	Mon, 17 Mar 2025 11:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=69ng99s6TqVcTpaaNvuqbvo1//ZQOTJCMBk
	C/40shkY=; b=p4l0vSCvplpWVmkzukajbNW60vQjVASvKkhFaKwDvAhZUQwKpZF
	M0laSWbtE4Npi2SzfkkYaYe5TwG7t0hXlCUKnaupeEWfHkAPtZp5Pu0Z7dGZr0de
	v+Tl/Rz2CfCXq6SFc11vomLxDmMEL5TwWNPeHRWFsq2LBQCEEmTqEOelwogd+0Rx
	WOVE+UqimcjJv5aOUXIKwFnMS8CqrSm+vE3kRsMmwZUwBa5iIMFYKBpnng98apqX
	yJi9Xwmfc7GAYvZXsMUqt+QKmrt/V1isllehee40eG6nICtuaBXytI19CgcdvoMd
	SqUMrEvnYmZIfpF8N6myZah6JRFmItOnjcA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1tx4gx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:42:06 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HBg29n016196;
	Mon, 17 Mar 2025 11:42:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 45dkdxjj30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:42:02 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52HBg2ig016190;
	Mon, 17 Mar 2025 11:42:02 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-schowdhu-hyd.qualcomm.com [10.213.97.56])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 52HBg2F2016187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:42:02 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2365959)
	id 9C341577; Mon, 17 Mar 2025 17:12:01 +0530 (+0530)
From: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH v3] remoteproc: Add device awake calls in rproc boot and shutdown path
Date: Mon, 17 Mar 2025 17:10:57 +0530
Message-Id: <20250317114057.1725151-1-quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=W/I4VQWk c=1 sm=1 tr=0 ts=67d80a8f cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=d-bqaP4l6ypRa8K_nXgA:9 a=0fcYfjdothPMH0Ll:21
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: S-hec7bQyZn2sirl6qhcqe77n1c8UP5P
X-Proofpoint-ORIG-GUID: S-hec7bQyZn2sirl6qhcqe77n1c8UP5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170086

Add device awake calls in case of rproc boot and rproc shutdown path.
Currently, device awake call is only present in the recovery path
of remoteproc. If a user stops and starts rproc by using the sysfs
interface, then on pm suspension the firmware loading fails. Keep the
device awake in such a case just like it is done for the recovery path.

Fixes: a781e5aa59110 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: stable@vger.kernel.org
---
Changes in v3

*Add the stability mailing list in commit message
 
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c2cf0d277729..908a7b8f6c7e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1916,7 +1916,8 @@ int rproc_boot(struct rproc *rproc)
 		pr_err("invalid rproc handle\n");
 		return -EINVAL;
 	}
-
+	
+	pm_stay_awake(rproc->dev.parent);
 	dev = &rproc->dev;
 
 	ret = mutex_lock_interruptible(&rproc->lock);
@@ -1961,6 +1962,7 @@ int rproc_boot(struct rproc *rproc)
 		atomic_dec(&rproc->power);
 unlock_mutex:
 	mutex_unlock(&rproc->lock);
+	pm_relax(rproc->dev.parent);
 	return ret;
 }
 EXPORT_SYMBOL(rproc_boot);
@@ -1991,6 +1993,7 @@ int rproc_shutdown(struct rproc *rproc)
 	struct device *dev = &rproc->dev;
 	int ret = 0;
 
+	pm_stay_awake(rproc->dev.parent);
 	ret = mutex_lock_interruptible(&rproc->lock);
 	if (ret) {
 		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
@@ -2027,6 +2030,7 @@ int rproc_shutdown(struct rproc *rproc)
 	rproc->table_ptr = NULL;
 out:
 	mutex_unlock(&rproc->lock);
+	pm_relax(rproc->dev.parent);
 	return ret;
 }
 EXPORT_SYMBOL(rproc_shutdown);
-- 
2.34.1


