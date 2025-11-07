Return-Path: <stable+bounces-192676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D0C3E5C2
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 04:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1039D3A4AF4
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 03:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE12FBDFD;
	Fri,  7 Nov 2025 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kZQzWIAz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236426C391
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486616; cv=none; b=jQ6KwRu9iSQoKkNdRyOS3a/Zkk7lq7pRpMq8EkHAYXz4r2Lr2d8wsqFpH6adhujUDxCNJcNsO+gSyAlfDp+SPwTOaytNFPDBAqR3HNqnp0faQf8tznHk47CzG0Y7BwQbGZzuB0r3V7omQOPMx1nWTYFV5lZBXqzXwwoMziG5w6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486616; c=relaxed/simple;
	bh=8uqtQ7durPRO80bDASrhdcsI7a+DO9vkGrPITvp2mFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=caFqcTiD2AV7lT9P+WtnDY4mew3Nd/UBq75YxqztW/bourMmzWUtUx5JvHFlM4qbODIwLoDuixtiXKZXclI+tJmKED+752335D5aElMbojxKA2hpOe1GnMkpvV202fFxm+h6IaxtKCnTYCaV+kfEJ/EleWwAJ7Gf1c4XUv/uCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kZQzWIAz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6KFkNo3748291
	for <stable@vger.kernel.org>; Fri, 7 Nov 2025 03:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g3GN2Xwyx+E
	I5XBC1SLI+9n8ti44Se/rR8KLRFUW1Bk=; b=kZQzWIAzJrXqWoTR2TVsvPOfmAL
	ayN2dp3EuG03XOZN2GChsA25PmpCnUfcDa6O2e6SN260PiWro8ZTZg8noplA5E9+
	Mv+XvxiZVkBWSl+SXnF6PnV04Uw2DpMLSfcn/oQEyeLUbEpZw3cEFSplQBuhP1QD
	7SkYKp6xbgRjb0btxW361USEsFa/eZIS1ZCqb3Bhi2f0QEUbVyzVy+q/aBJeaLkb
	dA08Muaez73+ZJvh6hcXsVW+QHTWZ4mqlbTFOMODckhzTrLPUtcalTO20RjmduVZ
	a4ro4tKzc8vv0Y4T1JldaKpTXVAuHgYYwhKxSPkzFIsHFpsqGXW4D0kpsbw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8sy6jt17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Nov 2025 03:36:53 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A73apuQ011620
	for <stable@vger.kernel.org>; Fri, 7 Nov 2025 03:36:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9nbyrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Nov 2025 03:36:51 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A73apbq011614
	for <stable@vger.kernel.org>; Fri, 7 Nov 2025 03:36:51 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A73aoK2011612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 03:36:51 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id CC62C2327A; Fri,  7 Nov 2025 11:36:49 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup during SSR
Date: Fri,  7 Nov 2025 11:36:47 +0800
Message-Id: <20251107033648.3705196-2-quic_shuaz@quicinc.com>
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
 a=eIGlGOcC9ytwnVZZLkwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAyNiBTYWx0ZWRfX+3GyWzSrR0u6
 7TI7/ulcNH9gJ5foTsz6/dHUlslJ5NF6WTbbw2dx0VW7U0oV1slNkgJ0kSAcXhJ6q0hFZU9bd4W
 gCcLse/PcyNJHt6i+m7UCoiroQDxcGMuUfe+v+OX1E0ishFp6UnDP8Oc7Rp/jHC4uHVI6swjFQJ
 0nlFkArhXkz61+C6atIpVFNTL2KmqpHhCGIBCpvvTJ48t9toeWKXMcQm2I6qGoitsQzDltWKLAV
 ZjIPo2ZGF3dEbf/7NOEkj6wY0wWS1PEAEoREPVos39hUEBD2DXVIMcW6HuSlscaDKwzj+H0JW+3
 836+TyQq+hJV0XgE92X52e2jJG5s3GcSLk6pfPHXZwX3qH56a8Kcctl6IgtrUYfCw4On/mvZtsE
 jGBpS/QyNizD1axyv26xPQvaVKCqOQ==
X-Proofpoint-ORIG-GUID: RZPPCKhcFdjlqkmCfDJEB1OcGllb-JvY
X-Proofpoint-GUID: RZPPCKhcFdjlqkmCfDJEB1OcGllb-JvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070026

When Bluetooth controller encounters a coredump, it triggers
the Subsystem Restart (SSR) mechanism. The controller first
reports the coredump data, and once the data upload is complete,
it sends a hw_error event. The host relies on this event to
proceed with subsequent recovery actions.

If the host has not finished processing the coredump data
when the hw_error event is received,
it sets a timer to wait until either the data processing is complete
or the timeout expires before handling the event.

The current implementation lacks a wakeup trigger. As a result,
even if the coredump data has already been processed, the host
continues to wait until the timer expires, causing unnecessary
delays in handling the hw_error event.

To fix this issue, adds a `wake_up_bit()` call after the host finishes
processing the coredump data. This ensures that the waiting thread is
promptly notified and can proceed to handle the hw_error event without
waiting for the timeout.

Test case:
- Trigger controller coredump using the command: `hcitool cmd 0x3f 0c 26`.
- Use `btmon` to capture HCI logs.
- Observe the time interval between receiving the hw_error event
and the execution of the power-off sequence in the HCI log.

Cc: stable@vger.kernel.org
Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 888176b0f..fa6be1992 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1103,7 +1103,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				qca->qca_memdump = NULL;
 				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
 				cancel_delayed_work(&qca->ctrl_memdump_timeout);
-				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+				clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 				clear_bit(QCA_IBS_DISABLED, &qca->flags);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
@@ -1181,7 +1181,7 @@ static void qca_controller_memdump(struct work_struct *work)
 			kfree(qca->qca_memdump);
 			qca->qca_memdump = NULL;
 			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
-			clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+			clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 		}
 
 		mutex_unlock(&qca->hci_memdump_lock);
-- 
2.34.1


