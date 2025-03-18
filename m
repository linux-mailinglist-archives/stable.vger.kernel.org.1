Return-Path: <stable+bounces-124771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEE0A66EA4
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 09:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383FC1717EA
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC991F09BF;
	Tue, 18 Mar 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oF7scM9S"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF2946F
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287339; cv=none; b=H+syzxNnYfWUbEiNndZwqplMkJOUG8DFDvlubgXXJ0F9YlCM9tBXeBn5bX8yct3aFMhHuZCckWWP/ROg34Juq7JG4URbANCFGcpa4uQqJU/ovIBQsq2uU0Qh7E2FSmCXIiUDe3RCRE0FchiG3wqHev8JfbXd1riOVpFmkksFFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287339; c=relaxed/simple;
	bh=GQ0nvLlVmHYJxzCOUpeiVeGBVZ/dO5D4BlVaM16a8Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H3yARLHIpapVECUpGcG/mUVOnHDpKKgKPjBmquv1NalDb9fAX6Hf4D6VWtbVpdYmdl7tAUlWYWNpgguBBMs8TZ5C2oCvuxAsJKJg0TMOvPFCVwkdOiUkm553MRcUiNrDCWNU3BHUGs0VH5S5lfDmuKHx3PyIOsyx9NYmDhGHmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oF7scM9S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HMhxIg016064
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=piO8tm0d5vROKyYlCUGas4eWWkLgh+4oz07
	Dw0n9ors=; b=oF7scM9SEVVeokJCoMEt9tTU8AHCuVvq4BVt3o/x0x3P0tUM/Hx
	JrWpJmJRvuIENOWo73RYdwnsAvQrhW2gcOUHGKIxB4cqlmA5/440OWfcCFnj7viz
	BVTKWmEwTGNa/oCxVPgkjETqRyvQtormzzv7JRSb6RSqyJoKrM7D+bjzY4YeIjsi
	/TECq5vkwIOJw2m5W/rl2rWcAYeygRhkUgCS5byzPzOLA4r1fMvTWU7T5/7IBfOc
	GLmEHgYswSvUDsTWD0oIj9nlVeMXE9OSochkqtXjHW+qOzB7h/2C598O+tr5r+H7
	tx76CqO/whPhy+gZe7shfluh8BlaWIW1uIQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1tx7ev1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:42:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8g711015265
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:42:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45dkgmdhde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:42:07 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52I8g7rI015256
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:42:07 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-schowdhu-hyd.qualcomm.com [10.213.97.56])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 52I8g7uD015253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 08:42:07 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2365959)
	id A64B5592; Tue, 18 Mar 2025 14:12:06 +0530 (+0530)
From: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To: mojha@quicinc.com
Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>, stable@vger.kernel.org
Subject: [PATCH] remoteproc: Add device awake calls in rproc boot and shutdown path
Date: Tue, 18 Mar 2025 14:12:06 +0530
Message-Id: <20250318084206.2716046-1-quic_schowdhu@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=W/I4VQWk c=1 sm=1 tr=0 ts=67d931e4 cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=d-bqaP4l6ypRa8K_nXgA:9 a=0fcYfjdothPMH0Ll:21
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6aIX1LUNpDCpwITup7HhKlh-Jngy6Ik5
X-Proofpoint-ORIG-GUID: 6aIX1LUNpDCpwITup7HhKlh-Jngy6Ik5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180061

Add device awake calls in case of rproc boot and rproc shutdown path.
Currently, device awake call is only present in the recovery path
of remoteproc. If a user stops and starts rproc by using the sysfs
interface, then on pm suspension the firmware loading fails. Keep the
device awake in such a case just like it is done for the recovery path.

Fixes: a781e5aa59110 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: stable@vger.kernel.org
---
 drivers/remoteproc/remoteproc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c2cf0d277729..5d6c4e694b4c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1917,6 +1917,7 @@ int rproc_boot(struct rproc *rproc)
 		return -EINVAL;
 	}
 
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


