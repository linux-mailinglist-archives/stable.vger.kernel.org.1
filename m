Return-Path: <stable+bounces-192611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C3C3B814
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 14:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 678145081E6
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3F226D1F;
	Thu,  6 Nov 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bnRbC7i8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0EF213E6D
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436930; cv=none; b=F3MqSI5TufQmqtwcAvjbLQfu0ZESdJ2rjhC+pHh7jWgA2tH7qyvg7YvCv9ftiA/fjy1UIhVT0EkQF5N8UIT52MikLMZUgRw5dKVxMkORxz4Ap6lBc1MAKOn+hZdEtQVBQ7zYljn/aAZo9Cycyz20jMTaFKqdeET/ydIf4vl6B98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436930; c=relaxed/simple;
	bh=8uqtQ7durPRO80bDASrhdcsI7a+DO9vkGrPITvp2mFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuhuFVfYjTASwfM0bgmjoxs+7N+uUr5zaaCqpZHxbJ1eUrHZr81xgnKR4XqHdkcaGxHwbbgb57BN4bZdw7tWpHHemFwnQuvZ3eAp8GVAWockekmm8V61a1xu8OPJ4FVC5onU0206ZURKyxcgQ4sF5wJxS868/JdOoPDtMBx6ZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bnRbC7i8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6Bit8m4018561
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 13:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g3GN2Xwyx+E
	I5XBC1SLI+9n8ti44Se/rR8KLRFUW1Bk=; b=bnRbC7i8I2uQg0cMIVEYfE66ewl
	5d5dQ/oeVSLI3aO681KJ9q0yNSe7/9iGY9d9LXOsUeMFGlPEMCFj9McwK80C36GC
	2nzunDvZVoVsjdVx195FFb6X/PUam00jxxLTljIKoiwhXTw0glOlDr4qYfGItzHS
	7DDA2eS4xIsBMtYyr+w3PHhsdVm8qJwlzFIKRjSBL0oW5zfGOg1OPKl0HINmybGm
	G5DnnLqKJL7zvX6VbDL+WoUITkX6yOd+kYIsS9g0P3dVpZ1oQsmm1GaGEr2NOVUM
	Mz7kNzk5Z3LMkU0HdPKsx71LHJtG/UGa88ool3PUwW51o4KZlMSMeZl5DOw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u2ura5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Nov 2025 13:48:47 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6DmjWt019914
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 13:48:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4a5b9n098y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Nov 2025 13:48:45 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6DmjVa019908
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 13:48:45 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5A6Dmiq6019907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 13:48:45 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id D717E22C67; Thu,  6 Nov 2025 21:48:43 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup during SSR
Date: Thu,  6 Nov 2025 21:48:41 +0800
Message-Id: <20251106134842.1388955-2-quic_shuaz@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=Wv4m8Nfv c=1 sm=1 tr=0 ts=690ca740 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=eIGlGOcC9ytwnVZZLkwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEwOSBTYWx0ZWRfX55kEayFMVUse
 ZDT6g/hF+jf6EIfx4Tl8kEOBZOjiyjBgq3OjctrV4q86QVabOMKuJ70f0kQmltrVHvsMoTDfThW
 3V+SRIOeKsMrs6eXm7VmW9qphsCASiANKEsudmynNWDemzhzLaECii62uePjb+hn/KPdZZYig0k
 ylA2lH8a0zrwPg+a2H4GxuKwl2Nt8qRXkVLrNop70AZ7zaxNV/1mPw65Q1mg+Iw9deKATXym/zy
 f8gLR9L8lyjpUfjJ4VGfr7bNnB4zJdhQbyeZjWtHLlFou1DJVS5Ae/+2DV+gE2u+JnI6/i9kKgY
 a95gq+jRJ/BlocptCtZRWNr0Noa+/YS8aNkQjdJ89AqHH5ToKhERW+10jF5QPkFkkHx0LwcdRvm
 dY1RGjaeYFe5DQoKwDlgAp38P98U3w==
X-Proofpoint-GUID: k4BKp3pIAUX3G_O92hdwCWslJXGFG6lx
X-Proofpoint-ORIG-GUID: k4BKp3pIAUX3G_O92hdwCWslJXGFG6lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060109

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


