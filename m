Return-Path: <stable+bounces-192617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6279C3B9D8
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61781350B50
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A523816A;
	Thu,  6 Nov 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ihgSY8QO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956AF286408
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438427; cv=none; b=YVE2EkieGu6SsbKJP58ZmdX2cFxr6L71hDypkglub5R3uNp6s+lwHaPTzvL9zRfzmcXXEPubXwho5K+mhIUI73d0KPW4L3GtE7kSDq2LW1UnXYXDTH+cuxbuRjoJWJ80I380M7SOWPXV3Kh2xg4dOQVL+SUGsQOWgizuxIFfI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438427; c=relaxed/simple;
	bh=X9R/ZQWOdt8n09fws3g4SuFInCqIiRcFmDI36CbBtDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fhhxcPpGYWA7vCkECHbseOWqY1KVkeCgsiYt9dnXiSE6Wt/Au33TPavT+dI2BgYtxtdDbPa0DkUMVRyblSs34cOoS7pUFoqZ+BjPbSn7RNsvMdzjzKE6ZbjGplR10kCCKXpD9OcEwKwaxuolhkf/aAvHOXU0ksFhh3TcZwfDEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ihgSY8QO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68je6Z3383378
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 14:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yyShU7oxIVS1HxxAHS2zHkZ/mDoKpVXSN8H
	N4DeKOtc=; b=ihgSY8QO037d4UV7b9MH0tsuUKErb2k4CGbBlyuYwJoEehlXNs5
	IUxEO9WTxNRsBh5PFATyo0zTJ4zJIOR89i3jUZidaPu7qbGlLPRrEMByHQjnErU1
	eQeGSSn/VQEBPcmf8lceeBcxrJzyynlEveLeXjBz5dZ/jOaugbEo090cEV+KwIRf
	9C7VbgAI/9LUQGzTIDSOOkWzpYsb5FRzAovUydmFu/FV5ZfCAoqgZv9nUpqXYqKB
	/qVkm6SVt+4ktF0VHi25bM4HbbJwIrAf6Qd07vERMr/FdWFCPf5KBnYaqUzj8oPb
	EfuLnla8QWBE1UGjEnRl9CZv/I4wnWVETIg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8reurv35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Nov 2025 14:13:44 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EDfxF003145
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 14:13:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9n7wne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Nov 2025 14:13:41 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6EDfjf003139
	for <stable@vger.kernel.org>; Thu, 6 Nov 2025 14:13:41 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A6EDfuu003138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 14:13:41 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id 282F422BEC; Thu,  6 Nov 2025 22:13:40 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btusb: add new custom firmwares
Date: Thu,  6 Nov 2025 22:13:39 +0800
Message-Id: <20251106141339.1422537-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDExMiBTYWx0ZWRfX+lF1yerSeZPj
 MlsstSFTgcA3wNHMfK7sUKrqNr1LFm7Kts89gkVsD92mrxBpNXCAJugcMka9GUTNkwD78/XAwZX
 H53GXnjFUg5e1My6CoOacnLNwrZm7gH7WQ1H0u2k9dr112/l9HejZEOe3lj0Zv8t8VtONZSXlVH
 Mrtyj6/Agq1wpw90Zr8IHXY02xkwrBmZfI4iiT5zvWV6AGiIiM6JxJ6f8lW53mE5b8txEgiqxdt
 cAeJvXtVDAOtHaS2iPDeYTmKruLF0WeJalQniaZl2BPAdNOOc4SH7A+IESDLFbJBhCQP+n+Mxjd
 xu864s5sBXFGyxo7e/+M+q0CXdQgOjm8t9V6GZ2USKwDXBLmj22xVJHGvL8ZKPpy8+UojPiRVe0
 5K7gSXQ2GyRQM6k2cJNuUxMxn0PYMg==
X-Proofpoint-ORIG-GUID: szrXAlhlRr8d9Gnfq5h3hu1AoAAOZS9w
X-Authority-Analysis: v=2.4 cv=RrDI7SmK c=1 sm=1 tr=0 ts=690cad18 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=FwBvamPKdgLavwmduaUA:9 a=zZCYzV9kfG8A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: szrXAlhlRr8d9Gnfq5h3hu1AoAAOZS9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060112

There are custom-made firmwares based on board ID for a given QCA BT
chip sometimes, and they are different with existing firmwares and put
in a separate subdirectory to avoid conflict, for example:
QCA2066, as a variant of WCN6855, has firmwares under 'qca/QCA2066/'
of linux-firmware repository.

Cc: stable@vger.kernel.org
Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dcbff7641..7175e9b2d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3273,6 +3273,7 @@ static const struct qca_device_info qca_devices_table[] = {
 
 static const struct qca_custom_firmware qca_custom_btfws[] = {
 	{ 0x00130201, 0x030A, "QCA2066" },
+	{ 0x00130201, 0x030B, "QCA2066" },
 	{ },
 };
 
-- 
2.34.1


