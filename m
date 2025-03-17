Return-Path: <stable+bounces-124596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B97AA63FE6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FCF16EA1D
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F32207E0A;
	Mon, 17 Mar 2025 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NZJWYii0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666107E0E4
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190082; cv=none; b=lJKwDSCWaUbdyqZDyJdJKFczP1d3NrgR0mNgEfjA6ka8NsHRcvE8ulZQGOPAwZ4XXaCTNlETKNgCejzkj3jVZQvTtE9NupalBZHa7aDxT4JwYWYauCiTRYHiz4zkEq1KygSitb32s8DFh8QWqgY6jx4JyHOoszXE+pwtNPF9Ykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190082; c=relaxed/simple;
	bh=KeyXlPwoWxz3k/bhcDgKsTvt2UYON6eqUAu0ozm40RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B59Ji62DhkcrJpZYVywgurRBYTmhD3w3CceAQsOm9J0MOJke3EfNSxx6XErqajzFGA1eAbmzka9P1ZDrJUk8E8VFI81BagC2lsxyvEGwxpDjeb+pxJyiDUCNZrz50SdK9jHsyTJgP8uAh8nY6rje0h519LgqdlbLx/sk2oYpa8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NZJWYii0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GHelPB022963
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=u7c4zzIqHSp
	U99BAxGJBfhGwbHsNTMqduCbpBYC0Wsk=; b=NZJWYii0FfuJTMdJI2eU06787jB
	/8TW0TSma1RWJ90kSeaDsyNb9fQiSPSvylb5DQXLArorfAEGQuH4OFOARhUNWdWS
	EOx+0B4kW3ESsPvQAIN1ryKhht4tdcYDd8FW9TWOiroI7Vn/fq3IeREjp7aE9Ab8
	I7MT3N4LqCVndtjvHDclLSFitadHV5JWNXkgPIZVlmQzhmq+XqUOL1EH12MKYYND
	jrgZOgOkD5uLRCqDHMgJidPLZTqXUfz4O+M56emGEaKrFiyVy9+7ZXh4Z+YNm0iP
	8ggp29BZMyZ3zKi1bUY46i8kWq8jN7jXKe4fJKAgRRezowxpEI5OvIU2YwA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1s3ug4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:41:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H5fFa6014943
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:41:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45dkgm3pfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:41:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52H5fFqS014938
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:41:15 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-schowdhu-hyd.qualcomm.com [10.213.97.56])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 52H5fESh014924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 05:41:15 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2365959)
	id D799A3AF; Mon, 17 Mar 2025 11:11:13 +0530 (+0530)
From: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To: quic_schowdhu@quicinc.com
Cc: stable@vger.kernel.org
Subject: [v2] remoteproc: Add device awake calls in rproc boot and shutdown path
Date: Mon, 17 Mar 2025 11:11:10 +0530
Message-Id: <20250317054110.1339365-2-quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317054110.1339365-1-quic_schowdhu@quicinc.com>
References: <20250317054110.1339365-1-quic_schowdhu@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=WbQMa1hX c=1 sm=1 tr=0 ts=67d7b5ff cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=d-bqaP4l6ypRa8K_nXgA:9 a=2gHAyr3T5vsSQB0k:21
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5LJuuBGIiVc-O5dN_50p1rtjVXfM3Flm
X-Proofpoint-ORIG-GUID: 5LJuuBGIiVc-O5dN_50p1rtjVXfM3Flm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_01,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170039

Add device awake calls in case of rproc boot and rproc shutdown path.
Currently, device awake call is only present in the recovery path
of remoteproc. If a user stops and starts rproc by using the sysfs
interface, then on pm suspension the firmware loading fails. Keep the
device awake in such a case just like it is done for the recovery path.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: stable@vger.kernel.org
---
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


