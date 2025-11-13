Return-Path: <stable+bounces-194660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E884C55CFF
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 06:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0559B3AE9CB
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 05:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D58199949;
	Thu, 13 Nov 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MHADl0F7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4035CBC3
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763011786; cv=none; b=hBTzgSDsM7iuPYGUvyAZ3RWkvXj4zyHM1saTd7XCyjEpcml8pdIFIie7t+5mvVaYCAmzcXu78SGlyHMa4prVDT9KJJlcjiraMNw6Sur5oyLVjGTt0+2yVay6c9AQVh1BAgKj/BZvjlPp2yOgj1pZS5F2xOeqbEvOZlZjLzqTOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763011786; c=relaxed/simple;
	bh=rbAlDdL9MMF25B6EoR34d58v2JHT2KUnHAr3E3DXNZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXX+w8wZjwQEbxpddhjpjX+oRNiVChma1tfrUCCrymb6fLUPPgCHTS1+3dlINKJvzKWApFleTnwNRabDXTeuKWEOUakhH8Gfq1k6qGtHS40ytOl0c+qMiMSOCrL8HXwrsbs2WBzGWTSXogPIOHEfWg4fkBLZCQlN7n0mE0vJ5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MHADl0F7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD1SHRh3120385
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 05:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eZ6OLS9Ndb6
	8+TlAt0dnmMmxvTIl3QWJjkZdmgWlVnk=; b=MHADl0F7pAn2Pa0N6RnIKotX6FT
	By8y0T22d9R+EhAephAS9SmnTF8EgAYkhRFC3ZUf2kYjin3hHofD28TEhvNq/fS0
	8V904UFGdoskqs85ik/GSRVyc3BliD5BOKEtTP/TpEi28wWv0Ll1U8Zw6lHwQRlz
	gk5FyoNUv8tYYLEb0wg2I6rrN0Yre4D41wugsC7Sco3E7FzQfXQ7BvIogm2Ulx0e
	SY3bFaHyd6+u56HgcemWW9j6vMzWr3O/BtYHrqwpnd9ijdNy7vmtuwiCAOdSlerV
	UqfLZf7wCbbB2GccIPXLSZhe+fvhQgTlAKa5e6NjrW4/yOQa75nTIervoDw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad5purkfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 05:29:43 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD5TfCf030550
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 05:29:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxmmy42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 05:29:41 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AD5Ten2030541
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 05:29:40 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AD5TeT2030539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 05:29:40 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id 80FD12287B; Thu, 13 Nov 2025 13:29:39 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: shuai.zhang@oss.qualcomm.com
Cc: cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        jiaymao@qti.qualcomm.com, wei.deng@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: btqca: Add WCN6855 firmware priority selection feature
Date: Thu, 13 Nov 2025 13:29:38 +0800
Message-Id: <20251113052938.1631408-2-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113052938.1631408-1-shuai.zhang@oss.qualcomm.com>
References: <20251113052938.1631408-1-shuai.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69156cc7 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mafMjTZoDSqqSwhiDToA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAzNSBTYWx0ZWRfX8OGAK58skP88
 jt0l/6HFICUAnLAKXitnMexzO5xBYBRfLLyjzdi8DR7lRxoKlGGlCWqZ4mtHUthfyVt7HNWC0rd
 mCr6uLAowGUKa/k+r10tfueXwf9iCEUwp7T2lm+9VJPdOGZ7XmGi9eRnXpjIgv6fyUb3qDKwiWp
 nZlmmyhooynPthhhOXMA5M5kmAvm/fXGhx/0sYz1VLMVtEiIaYzQ7oR195K5zMhwJMwdV3kezG6
 /rvt66TTyFf/nlPzVIv04PSJwDHIdGe+B80bdeuhW6xk8ikiICGb3hkVScYywbf5b/cV8ZKP5tc
 4D8NGpUq2D/eAJ6/JFglzzBzRgkdSCMmq1DzOQEhlXr0+AKpOOCvD/IxyYvKu5y7EfrD3iC4PU4
 YyHCE+fp8b/8Sf5syJi7Fd7QEdgpkg==
X-Proofpoint-GUID: poF68YuZbN7M3ZXckRI1b6b0DO36Tgz5
X-Proofpoint-ORIG-GUID: poF68YuZbN7M3ZXckRI1b6b0DO36Tgz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130035

The prefix "wcn" corresponds to the WCN685x chip, while entries without
the "wcn" prefix correspond to the QCA2066 chip. There are some feature
differences between the two.

However, due to historical reasons, WCN685x chip has been using firmware
without the "wcn" prefix. The mapping between the chip and its
corresponding firmware has now been corrected.

Cc: stable@vger.kernel.org
Fixes: 30209aeff75f ("Bluetooth: qca: Expand firmware-name to load specific rampatch")
Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 7c958d606..8e0004ef7 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/msbtfw%02x.mbn", rom_ver);
 			break;
 		case QCA_WCN6855:
+			/* Due to historical reasons, WCN685x chip has been using firmware
+			 * without the "wcn" prefix. The mapping between the chip and its
+			 * corresponding firmware has now been corrected.
+			 */
 			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpbtfw%02x.tlv", rom_ver);
+				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
 			break;
 		case QCA_WCN7850:
 			snprintf(config.fwname, sizeof(config.fwname),
@@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	}
 
 	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
+
+	if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hpbtfw%02x.tlv", rom_ver);
+		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
+	}
+
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
 		return err;
@@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		case QCA_WCN6855:
 			qca_read_fw_board_id(hdev, &boardid);
 			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
-						  "hpnv", soc_type, ver, rom_ver, boardid);
+						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
 			break;
 		case QCA_WCN7850:
 			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
@@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	}
 
 	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
+
+	if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
+		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+					  "hpnv", soc_type, ver, rom_ver, boardid);
+		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
+	}
+
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
 		return err;
-- 
2.34.1


