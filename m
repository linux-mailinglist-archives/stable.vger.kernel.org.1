Return-Path: <stable+bounces-192675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38826C3E5BF
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 04:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16A504EB9D4
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 03:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3E42FB602;
	Fri,  7 Nov 2025 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YwUj9FEq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00453227599
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486616; cv=none; b=ApyCZHnZzTtpSb7+zQAF0y/MCg6Dfz5MioBSFc4+ZVrNw0wUx/k8bD3nGNk3MbPNVZaAx1gWgzjJBY1tde0EYe1OOcPFXsbSRD8A+slVN/kxH2tSr7ZIHiDyGLvx4ALZ0iG5VO+xaA53A5BCcnrnOCpUmmzdFqCoq7PFS15mRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486616; c=relaxed/simple;
	bh=TY6AfTS9IE25kyf1VzFS8t6tVnHe0Sw2zjiBp2xWaG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvhD/gjWNgAVMoUgg2qmOW3itdJ8aM7iq6qrNOMhhN4NOPn0sp+YakjpR7g5vsByEO6i9ry3seoJ4KMkmamVgcWIWTfaRWLJqc0z0E4qgQGWMPJrHjk5sLT2qDE+17MC81Dc1LEAfqraMyBRkFb6NjPFL9/+Qtq0HRUzIQLsjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YwUj9FEq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6KEgl33749048
	for <stable@vger.kernel.org>; Fri, 7 Nov 2025 03:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CG/kbwf3jm9
	5G/VIBAhWTxS8SVIJcY0oCufgRxYh/C0=; b=YwUj9FEq5tLyFIcScT99+OtrG0F
	nOHzk8ybjcus7kw9snFq3eUAIXPYo6P8jfkfVzfRJMztr9v3wSM3VKvBfZx0qHnW
	qL/kWpchHQUe77Y3Iph3mQkTLXVATmHvYXF3wX7gY1scUlRI4n7AAIhJQehHv4Bn
	yXERvY/hyVRKgLu3IfBUXqX9d6nb6zwksvrl6y/Lt2/KxhyGMXJCqGOEV4AkVUce
	PHBy8znYhKJz8qO1+rY5b0JLeO2CTW9wLZrvhnkRCeaj97jvg9KgoO4SGLCmoJ8x
	49Ov8eD7os1GZ78ok/j/8/ehxlh7hZ2/JM/+8K+f+2uFtgnMeAfj7c0Wx4Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8sy6jt18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Nov 2025 03:36:53 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A73apmT027484
	for <stable@vger.kernel.org>; Fri, 7 Nov 2025 03:36:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4a5b9n4neq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Nov 2025 03:36:51 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A73apLQ027479
	for <stable@vger.kernel.org>; Fri, 7 Nov 2025 03:36:51 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5A73aocY027478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 03:36:51 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id D0CD32327E; Fri,  7 Nov 2025 11:36:49 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: hci_qca: Convert timeout from jiffies to ms
Date: Fri,  7 Nov 2025 11:36:48 +0800
Message-Id: <20251107033648.3705196-3-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107033648.3705196-1-quic_shuaz@quicinc.com>
References: <20251107033648.3705196-1-quic_shuaz@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=AYu83nXG c=1 sm=1 tr=0 ts=690d6955 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=70vrXUCaxUCbDeWopUYA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAyNiBTYWx0ZWRfX3RakphvWjgT+
 sZs6XN3mhp+f5eG26WpmeYHq9CfW7zOVgzBTu4hEMULUmMuAi+bVwvC9q5Ht+VJXaE6M9VoxEih
 qNpqkPL47F8kBwO9MKzkyzIXAtLqSGnLYXl34qeo1FihCQTzqgVuzwGXSVM0Rb9JvZVCbWTHGxv
 YCQVNGlkiCK0ATQ35Ly5rXn1cAWjmbGGdimrpT1pIWqyG3bU/v/vFYL0zfqT50M7aseFMd3FyJy
 hQY2WROocVgVJPoLKnAMdzW8XRvNkjVvXHUQyXhM7KvTtNNZTlZKt2uq7bmve2NEOY7j77tbo8h
 zf+JG7g6tSJpouwFzeZD29qPyPO1ctm9RuAGFMjaUvJQQzIO5f0AcM+PbGNbSd6Zki4yNanXvR8
 L+cxZtKrqjtssHk+yD99cF4mpWo/CQ==
X-Proofpoint-ORIG-GUID: y7UOZW_MlGEcJFHTvyM1qH64aF8dPKKe
X-Proofpoint-GUID: y7UOZW_MlGEcJFHTvyM1qH64aF8dPKKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070026

Since the timer uses jiffies as its unit rather than ms, the timeout value
must be converted from ms to jiffies when configuring the timer. Otherwise,
the intended 8s timeout is incorrectly set to approximately 33s.

Cc: stable@vger.kernel.org
Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
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


