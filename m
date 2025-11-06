Return-Path: <stable+bounces-192612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1FAC3B7D2
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 14:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C96C3508234
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938842E3B0D;
	Thu,  6 Nov 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N9106Ybr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFD222599
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436931; cv=none; b=nmWQE+8Gzp6J2BkIO4a5V324WBMV+iDJqcgpH9r8I4JV3jhVLYm/V7ey9We894LHARqy3XeEZ/WVxG6n/wR1sDGTi0v1UH7752/n+C3Z0iLkLEmKzuwJ1Sk4jl2NbPHCx2qjYLypDI0WWMtG9larxe6W09Mai25zdZyPV7n5ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436931; c=relaxed/simple;
	bh=oJ3Y3umJJuTYkVLa7IX8rSNPkpCHjgK3xP+LjKIL0xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QC/3J6ZH/y5dvp9hnRqKl+ICySQetZ3Qvj9dmwZ6SPOVGFhMMnNOuoGOY3AKvuDfpFWn9YcnSvgj9pJRgqdqWTm6OcHbQ7C+iL5ThmiFMLfNWj+NKn4j4p7PCnzipRWsAjhtQvNfCrgmDLIpyXucSmUnX0/uep9pJU8psWyGac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N9106Ybr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66tNCX3157007
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 13:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q68OE4XvQa1
	fhjTTa225mcPU+T82tSrdGoN3KFgnP1E=; b=N9106YbrhiX1WB9sB9/xIwYzXj/
	pofAYvJZBIun9HKYbDJdxM22aZRZbqPg8PvhrA0TeAIvM72KyilPbw/z1PJH8uhx
	03f1gG8EOSWexmMCmgbfYBdqZ2OHBx1apMsVSal9HxPdbQRFUlqoSuw8W21DAL4Q
	mJBN0rkp4ZHaJrYJowlwwx4SCKSBa1fIrnT+xfB1CBYR4VVtjRS2p3Z5GdPC/D5o
	Ujuc/58wuxeUtCmtP+Cm5nPlTBON5km1F0Vy4WKLTUaugNYY0uK2UJzIbAa+BOeG
	yh67flapyPZqqejWZnkSEq+MIvecnq3G1ipIeAOeAYTHk/dYrWIYt/21aXA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pu0h42k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Nov 2025 13:48:48 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6DmjlW009870
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 13:48:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9n7snf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Nov 2025 13:48:45 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6DmjYu009865
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 13:48:45 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A6DmidC009862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 13:48:45 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id DB5712327E; Thu,  6 Nov 2025 21:48:43 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_qca: Convert timeout from jiffies to ms
Date: Thu,  6 Nov 2025 21:48:42 +0800
Message-Id: <20251106134842.1388955-3-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106134842.1388955-1-quic_shuaz@quicinc.com>
References: <20251106134842.1388955-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEwOSBTYWx0ZWRfXzI2z6yUe92x9
 R8YJvIx36cco9LpquoC+It0jpcYSJgR1bQVCBYN6dOPaj/f86IeskVNS7iZujwJ8ss7gHs3uF+2
 K+xVw27Wqnu36EhWh26+puTxh2uWaYVAFcmuUHr9TtsxFKXjiMalMdL1yy9EZwN5SflD0mDb1Cz
 HHIv81kfKHS9EEsvMPU6XgFq6dNiY0gs6fDVgYH2F6o8kab6Pq9yzsPP2YpsVf914ZjGjrze2yk
 C5CMwzTuZfKEyfgQcwyj8gqpq+iVqFtWQoiZV1mHuhPQJ/fWQF/O9jydaeKHmhsdLWUleoRYo2R
 8TRcMk+cu6Mn3nWVBhTpo0mW3ghjtWrHMmDjyyrlNa5Z8k5q/sM75/gRDiqjnK9lhBn57rGgQ33
 Z5x/7Bme4CzQJonk1v87V7VXgO4YoA==
X-Authority-Analysis: v=2.4 cv=bIYb4f+Z c=1 sm=1 tr=0 ts=690ca740 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=eLiQT_JKY73VEPCCN3QA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vqYi-3i3EiXj8IK60C5Nt1kbuYPtNphG
X-Proofpoint-GUID: vqYi-3i3EiXj8IK60C5Nt1kbuYPtNphG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060109

Since the timer uses jiffies as its unit rather than ms, the timeout value
must be converted from ms to jiffies when configuring the timer. Otherwise,
the intended 8s timeout is incorrectly set to approximately 33s.

Cc: stable@vger.kernel.org
Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index fa6be1992..c14b2fa9d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1602,7 +1602,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
-			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
 
 	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 }
-- 
2.34.1


