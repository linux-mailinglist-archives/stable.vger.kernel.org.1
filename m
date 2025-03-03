Return-Path: <stable+bounces-120041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF7A4BA57
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 10:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F22A1891A00
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A8152532;
	Mon,  3 Mar 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L3nS6aHS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58201F03D7;
	Mon,  3 Mar 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992944; cv=none; b=lx7hAGKEiY/WkNi00KgZSBxJJoDEa4XgiLB3xObVHgoRjkT+ojWkAwF/LSfzHPrusKwv18RXUZJF/0tH+wxLAHOXBtPIOmQ4raHIP8pX2i/NqAVo3pbILenEwol2s/GW0rBvEfrdr9SI6yOnQ1bwgnNjo8+dDIkHoCFeeiCmrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992944; c=relaxed/simple;
	bh=ZRrV6YVukHwqMpA7xuFqqMELfGYmOq7MQoJMG5pfdZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tMaZspEGNP1X1gwzYPpJPnT1+np3o1E4/Hv1FzWbNgMvq9CZMofXVeOWjqbQxYXsiuZe4Pa81rZ+2feXZr51WVmmgMwmPFLrECG9cDETZTUudQMk/AhQQfu8NQSRN2/xextTK0kNwfyG3if1w0ORuOnt7t4cco6jYFWzLM+X27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L3nS6aHS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522MmU91029520;
	Mon, 3 Mar 2025 09:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1imeeoL46u9Hm/RGGWve8ZtZEslUgdzzc5Q
	ogPrqr+c=; b=L3nS6aHSaTL3v/MiZBQNDavAS2N8rx5TXjsVIS7nbMYAVjtcx4s
	yiXvFmOLJUMIulLlRvQh0Z+5ypxdEMOEFf/8l/6v9oJmXpG/rUWN+qgar/DdsbZn
	i/dgczwB9Ijj+gsdcmq1A7zL0DrzZf6b1JRZ4PaJRVEbvGpIJHSZUfF1b08SQOrj
	My72yn2xRww/nJwpYjNEc8cY65YXMhgQKKyDJLM4hAEtaFT3nq/GMEEeU/aROfR2
	raXk5zXz33RR3ejps9jtHhPzKjQ3I8nYrUxrUD3FyS/kPOQwydiXiXY/A9/663SW
	wwYOpexv16NQ4VkNw19+HkG22JzxaltE6ag==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tm5mc71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 09:08:58 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52391opR010699;
	Mon, 3 Mar 2025 09:08:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 453uakvnwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 09:08:54 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52395vJk014646;
	Mon, 3 Mar 2025 09:08:54 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-schowdhu-hyd.qualcomm.com [10.213.97.56])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 52398seY017511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 09:08:54 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2365959)
	id C9EC759C; Mon,  3 Mar 2025 14:38:53 +0530 (+0530)
From: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable <stable@vger.kernel.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH v1] remoteproc: Add device awake calls in rproc boot and shutdown path
Date: Mon,  3 Mar 2025 14:38:52 +0530
Message-Id: <20250303090852.301720-1-quic_schowdhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6FUX2QfO2D3oIp_7k9lYsn5K-DoOLYHJ
X-Proofpoint-GUID: 6FUX2QfO2D3oIp_7k9lYsn5K-DoOLYHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030069

Add device awake calls in case of rproc boot and rproc shutdown path.
Currently, device awake call is only present in the recovery path
of remoteproc. If a user stops and starts rproc by using the sysfs
interface, then on pm suspension the firmware loading fails. Keep the
device awake in such a case just like it is done for the recovery path.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
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


