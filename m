Return-Path: <stable+bounces-192331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0456C2F545
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 06:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835983B892D
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47BC287258;
	Tue,  4 Nov 2025 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D29TcyX2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19052153E7
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232494; cv=none; b=dQcFdDqOZasJDfHnh0Id9y8JTlB3C/dZYs+4QezDrVF7ywEY2ZDjlTosyLj3fOomSZK7sHRABX1xj6/tpUWm5eCl4Ir1zNQfnv3h1uc1xVUX3Al79C7zIjqaLp/yTYlnweCQijEpmA/xKWoH/1w5iXOMvItDz3XdKtMKC3u7gAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232494; c=relaxed/simple;
	bh=iyTNmNXLteKPG9kA4SQVCYbr3HMwDfFSzX+sphJxtUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6djT7i/XTmz7n8Z6L4rvltK6/iMaw5D9/8bs46Cvys+7C9peHeqJk20pAfCp2LDKpS12HIMkSmu35JJ7puEqsFAlyZdZNUBrFyGWLlquJgcxCOB4upaG+zZG1CMl/xiLLoeBgYqRSV78iDTgSzB+zF3H3TyFI+hDqUT6Y3xS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D29TcyX2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A428XFf694392
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 05:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7CFf07+mWoL
	K0gF/1cSa1ilrMTPNu/pEAWrPSEYkBY0=; b=D29TcyX2ot7sD+a+u+9x3QepdVJ
	ltP1fK7/a1VkL3N37pG+GGT73U+VTmyP4fo1a2ndFJ5VriwqkTNg/GuwsMl0D/TS
	zd8VjXjIFlg79ZpzA0ot3EVAiUUKZ1yZ7zCmtnHVonyPK6JSLwX/SKht7fERYRO4
	r2TXr1meDmDKZVAKNqvSXYIINvHdzjdoXyFuX9Z4lKhqrIW8wmurdzPtzBJ2y2cU
	JLE/ENnTWz1E52DYLCYYI7WpV8bNWigP8mD4SDW+KW5ynmVL711a8692Oc5kPHI7
	Bb6LihcAJq/4iQ4HLdedE0d8E62UIz3TyPPc0ePCtymXMjlVRflHeSk8t6A==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a78eqrcyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Nov 2025 05:01:31 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A451SeW025675
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 05:01:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9mphev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Nov 2025 05:01:28 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A451R9G025669
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 05:01:27 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A451RXi025668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 05:01:27 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id D81522393B; Tue,  4 Nov 2025 13:01:26 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3 1/1] Bluetooth: btusb: add default nvm file
Date: Tue,  4 Nov 2025 13:01:24 +0800
Message-Id: <20251104050124.3385507-2-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104050124.3385507-1-quic_shuaz@quicinc.com>
References: <20251104050124.3385507-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAzOCBTYWx0ZWRfXxmlcDTVYB8Gw
 hSlQM7Rx9VdiGL7WK8dNHXJxDNjK661bCTD6WkxzzI/yhBvoMucWgEeZcORPW1Hep+67akYkmHu
 su/Lk9neHBzrPF7TXxgyF46FbKKID7sarMrBTK7V/0a7EbtufTmrnh6/Y6WY+4lAPAJlz5/jajR
 v+rgDB42OtqUJt8Se7WX3G3zgTWcFy9qWZl9NUK3w4iqyjkBW4YutK+yeJUTnHr/9qqd94t0iTU
 8yxVLzHhYJVGSlRSmiRtPEbpJepAslX/Cqqqj/8VQmFVzbyDM5NlGhnHgoz43a+5XEG8it/Br3P
 0ZzHX78COYSFe6jIsUvBxFskdtKUSeYsMU9Vz88WYQL9w9HifAuwN3H5S3acSh/n6bzFmZpiFgv
 nEOmfBpE5KuT0GW1t9MSzDdK4jd+KA==
X-Authority-Analysis: v=2.4 cv=fofRpV4f c=1 sm=1 tr=0 ts=690988ab cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=J2RAPmYWl02GzY4tkNoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zLOJeWtGL2Zc0btqPqdstaqxhY5hrAo9
X-Proofpoint-GUID: zLOJeWtGL2Zc0btqPqdstaqxhY5hrAo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040038

If no NVM file matches the board_id, load the default NVM file.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/btusb.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dcbff7641..18f83131c 100644
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
@@ -3517,14 +3516,14 @@ static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
 
 static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
 				    struct qca_version *ver,
-				    const struct qca_device_info *info)
+				    const struct qca_device_info *info,
+				    u16 board_id)
 {
 	const struct firmware *fw;
 	char fwname[80];
 	int err;
 
-	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);
-
+	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver, board_id);
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err) {
 		bt_dev_err(hdev, "failed to request NVM file: %s (%d)",
@@ -3606,10 +3605,21 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
 
 	if (!(status & QCA_SYSCFG_UPDATED)) {
-		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
-		if (err < 0)
-			return err;
+		u16 board_id = qca_extract_board_id(&ver);
 
+		err = btusb_setup_qca_load_nvm(hdev, &ver, info, board_id);
+		if (err < 0) {
+			if (err == -EINVAL)
+				return err;
+
+			if (err == -ENOENT && board_id != 0) {
+				board_id = 0;
+				err = btusb_setup_qca_load_nvm(hdev, &ver, info, board_id);
+				if (err < 0)
+					return err;
+			}
+			return err;
+		}
 		/* WCN6855 2.1 and later will reset to apply firmware downloaded here, so
 		 * wait ~100ms for reset Done then go ahead, otherwise, it maybe
 		 * cause potential enable failure.
-- 
2.34.1


