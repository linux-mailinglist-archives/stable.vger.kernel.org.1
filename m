Return-Path: <stable+bounces-191562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4513C180B3
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 03:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C761A25428
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 02:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A432D23A6;
	Wed, 29 Oct 2025 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XsaJVoHg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55324E01D
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704887; cv=none; b=lUE81WTftUNam8lPL+JDGGnP9QVG01uWbGG6RGAPOPHsVmJRwD9vteOMK/86vauAOfb2EoVGG6P2jPXnkq8niYRsch9aznKDow1k57YwJsRslhFhPVYwEizoopzth2jtfBLO+xwtHM27ydithKNKLN3ZTFqya4Ihg8/vAKUtyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704887; c=relaxed/simple;
	bh=BeESw+vKw6cYDcN/A4G65c0j8zVSiMecMyBznJqncsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9G7JAOzUx3wSkeDGskU035A9js5jck2WI07QxZa/iz9NOIG5xOTuFhUtQmzjtYJDLW1T9Uy3zPuRPvEiX6h6bQI2zfAwODq0qwSvydmuzrZarpnlgYErPOFFcyX2lWMoorlGmp6EBEl7MFRs59049AJkLyiW0Yu/I/qKrQl/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XsaJVoHg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlLZ22616741
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 02:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZW+/KCGQS+z
	Y7T27U6tDMtmZERCSPv6YdAILEXmxBD4=; b=XsaJVoHgOGsu7BZ0RHVhNGwcwyI
	6uvpi4o7PxrXGOIVxA8XdVI8k01EvZ4WU9ohMi1gShK0na9ck26yg8AC3waBHRV+
	SZNtGy7YLE5CHwaqkFY4Ze2iBt9Qlt39HQ7qP5arj6MEu6veEmk+VXs/TpllueXr
	G1FrssijPVTxesYLPzk67tqZfeQsNQ2axnyDfGaMu80WVT/ca8E5po7w45ei76dy
	a+PwenXIOXKm5ZmAxmUTOuZVQujSQ5rEeWF3ZKvL6cqy+VEN8VqnKOunzt3SEqVE
	2mT0ikqag6+a9QOggwXQrRyXMCTcdSoJm3+j9BiSpNWhoiUDeEHbXadhgMw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a349y0vtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 02:28:04 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T2S2lC016690
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 02:28:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a0qmm54bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 02:28:02 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59T2S23I016683
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 02:28:02 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 59T2S2Qt016661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 02:28:02 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id 73E5D231FD; Wed, 29 Oct 2025 10:28:01 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: btusb: add default nvm file
Date: Wed, 29 Oct 2025 10:27:58 +0800
Message-Id: <20251029022758.773914-2-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029022758.773914-1-quic_shuaz@quicinc.com>
References: <20251029022758.773914-1-quic_shuaz@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=D8RK6/Rj c=1 sm=1 tr=0 ts=69017bb5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=icOeAstkKu_1uK2K-hUA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: w8J3_lcT8AsKq0srbyG3F-UFJIh-iKiO
X-Proofpoint-ORIG-GUID: w8J3_lcT8AsKq0srbyG3F-UFJIh-iKiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAxOCBTYWx0ZWRfX/3WJnBhQM/iL
 CHuGDfh4f5bQZz5bkvYLVOnRipDKnRcfRcbNbwqESCNZkgXi0kURnOopDjd/xuD2rqlnptoiRHd
 YxmdNmDMbFar2NiHyRBo0YrL2yuiSIDrYD0+hNth6ITcXIApIBmItuyQUCTQnlL9f8Rp9vqAdko
 rFkb55VboL20dzKdppyINTOVrtK/ygf9FxDpYPCRdJIYARdh3hFA/9K175zfWfxCoLhsR6Cri8/
 YDjD92yprnnpiZH04ZE113yoJ/V8VnG91PKNhE+REUEUgtp76Sn6wfuO0kToe5Tgsok3AP7sFej
 kNQd6+TV68FQ2qh8WB75ekHsOrFoOGJTMicWILysmSqsQk67fBIqsd5wSzr0pG8FQUNuCV9mrjb
 5Oki6MQ5Kz8ObqjkL1Q99oY6jUvxTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290018

If no NVM file matches the board_id, load the default NVM file.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/btusb.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dcbff7641..6903606d3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3482,15 +3482,14 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 }
 
 static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
-					const struct qca_version *ver)
+					const struct qca_version *ver,
+					u16 board_id)
 {
 	u32 rom_version = le32_to_cpu(ver->rom_version);
 	const char *variant, *fw_subdir;
 	int len;
-	u16 board_id;
 
 	fw_subdir = qca_get_fw_subdirectory(ver);
-	board_id = qca_extract_board_id(ver);
 
 	switch (le32_to_cpu(ver->ram_version)) {
 	case WCN6855_2_0_RAM_VERSION_GF:
@@ -3522,14 +3521,28 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
 	const struct firmware *fw;
 	char fwname[80];
 	int err;
+	u16 board_id = 0;
 
-	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);
+	board_id = qca_extract_board_id(ver);
 
+retry:
+	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver, board_id);
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err) {
+		if (err == -EINVAL) {
+			bt_dev_err(hdev, "QCOM BT firmware file request failed (%d)", err);
+			return err;
+		}
+
 		bt_dev_err(hdev, "failed to request NVM file: %s (%d)",
 			   fwname, err);
-		return err;
+		if (err == -ENOENT && board_id != 0) {
+			board_id = 0;
+			goto retry;
+		} else {
+			bt_dev_err(hdev, "QCOM BT firmware file request failed (%d)", err);
+			return err;
+		}
 	}
 
 	bt_dev_info(hdev, "using NVM file: %s", fwname);
-- 
2.34.1


