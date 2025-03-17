Return-Path: <stable+bounces-124598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71527A641BE
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6193A9AD8
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C4219A89;
	Mon, 17 Mar 2025 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BOvRmAGl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855921931B;
	Mon, 17 Mar 2025 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193516; cv=none; b=Wcdi3uR32kU6JFsjvc/90WgxwQ44W4VdHIndaesg8crF8xutw8JAoSmxLGz8l1gaAIhlSS3NS7ziBZ0vPlHMqqn447R5Oufy9zwYYnAX/xkEoleIleyBfB0UjNwWpbPhlVG+ba1JtdUTRyRtFiag2pLFeSoyvDUmhiak7okX/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193516; c=relaxed/simple;
	bh=GFj6C8q0f6OPbUJDFawXqckYdO6JbvwUV2Lkl0t7nzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nHCZuSeCUX3PsjaRJH5AM/1wCVjJxumI056a8Z2qlZljdggQD/Jti9lFLFQrEu6wVJC1ZAZdYcXOc9Ji/Eg1n5U49YtQFegKBrx45tKjtNcz7vMbfjH80CxF+CvR7m7tPvE/RFiNzMING0cxXSet4d3+QT469VZUSwdvrnhaNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BOvRmAGl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H0TolU022723;
	Mon, 17 Mar 2025 06:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xSx9aM3ysh6H8MCCKhgJbOrf+ZSu6CKyBHE
	awG1GrOc=; b=BOvRmAGl1QsN6uCThn4S7qCvoo7RsyHkpiuD4xoLMdEDNTIa1id
	6xOQXB8ZNMn/5kV6UqAW/tN1iEbQYYYpfzZaB2yG+ZBJIDU/mb6ZDdbR8Iv50JnA
	iuckxZm4pVTB09eQSEfRaQOigbQAyGG2iC0YnalF6858mBA5piMw7Q0YqjfHa8l/
	NU90S+out3Dei4cOuomksyoUtyBoYAzx/nBLsf/Ba629AEy9bocB6VZH7QGOuCJ9
	jqScd+2gtq+o9GGWhqmW52Me52n/ogREsXU5vZLBiNhh/FaEJE1EpZWbqLgN3ZTP
	f6zZRU7elxHCbWQYmJbzPo0baRljQ8gcjlg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1r13p0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:38:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H6cSCf032449;
	Mon, 17 Mar 2025 06:38:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 45dkdxgt6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:38:28 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52H6cRIM032442;
	Mon, 17 Mar 2025 06:38:27 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-schowdhu-hyd.qualcomm.com [10.213.97.56])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 52H6cRPm032440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:38:27 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2365959)
	id 0BEAE58E; Mon, 17 Mar 2025 12:08:27 +0530 (+0530)
From: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH v2] remoteproc: Add device awake calls in rproc boot and shutdown path
Date: Mon, 17 Mar 2025 12:08:03 +0530
Message-Id: <20250317063803.1361829-1-quic_schowdhu@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=LuaSymdc c=1 sm=1 tr=0 ts=67d7c367 cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=d-bqaP4l6ypRa8K_nXgA:9 a=0fcYfjdothPMH0Ll:21
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hUK-ZR8P138hXcbemujpwfFIkRVap7ru
X-Proofpoint-ORIG-GUID: hUK-ZR8P138hXcbemujpwfFIkRVap7ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170047

Add device awake calls in case of rproc boot and rproc shutdown path.
Currently, device awake call is only present in the recovery path
of remoteproc. If a user stops and starts rproc by using the sysfs
interface, then on pm suspension the firmware loading fails. Keep the
device awake in such a case just like it is done for the recovery path.

Fixes: a781e5aa59110 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
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


