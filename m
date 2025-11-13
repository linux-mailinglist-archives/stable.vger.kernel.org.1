Return-Path: <stable+bounces-194658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D50C55BA8
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 05:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D54E2548
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 04:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA83016F3;
	Thu, 13 Nov 2025 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cd7qPT3R"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852352940B
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009779; cv=none; b=F9VOpWHBG9tc5NujmssIlgiUdeCVan07CZBfpUnkx0f4I6rHQs/ta31ksxM7FR6zVBbruS2a8m6qQ0MGoPQBK3kykdNcb1hVQjxya1qM2X7xoSY8IVd2NrwSZsjapT5ZcgPbKIla962LrbTuk2ycJ4CREpW8V5TkwhDLwvA6+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009779; c=relaxed/simple;
	bh=rbAlDdL9MMF25B6EoR34d58v2JHT2KUnHAr3E3DXNZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skovIAvowMdxPB/W8ZbYce2REP0540CMocWdoXnEtioqhsBUVhiTCcTcLlWGg/foSPkLYYfT+8LH/4nfoXB2F34y70DgF8+i/DlGu67/7p/5LilPK5nM7XwH0hQHfPrg6q5FSzD1SKQJckaJd8wj9IRNZ0JMCi6+zv6z8kLc708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cd7qPT3R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11Zo22918950
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 04:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eZ6OLS9Ndb6
	8+TlAt0dnmMmxvTIl3QWJjkZdmgWlVnk=; b=Cd7qPT3RJ5R04mnHoJkhVGMCiAx
	Cr+Lr9hGap027E0qHGIkPw5nEZStfcONHU3ks+IkScbKDa17QMKBn3KLvd41kKNT
	T2KSl/YCJ8GQXqNToB1Zu2Bb21XzIvqgJDtDTe1mTjwMdOQoIsDpP5ME5293ktV3
	tld3H9iUZExIaUT8RukZGV82uzGqsguRkJyPSUbFkInw4TWmBCKnlvbEn+Fk+xn9
	ku2Pbx3mqCknrdd94qSreSg+oV0fowhG4AmZRN693rDND9+L8xsfLxaJoDcqTAb/
	XZOwqpFDQAZaEzru6FYFsisfkFPP+A6rmELIHJBoHMBppcBXdyI1PUKXAmQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqdgkd8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 04:56:16 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD4p3Je024121
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 04:51:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxmms7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 04:51:03 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AD4p3Tf024115
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 04:51:03 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AD4p3DS024112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 04:51:03 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id 797B823297; Thu, 13 Nov 2025 12:51:02 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: shuai.zhang@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: btqca: Add WCN6855 firmware priority selection feature
Date: Thu, 13 Nov 2025 12:51:01 +0800
Message-Id: <20251113045101.4166670-2-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113045101.4166670-1-shuai.zhang@oss.qualcomm.com>
References: <20251113045101.4166670-1-shuai.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=691564f0 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mafMjTZoDSqqSwhiDToA:9
X-Proofpoint-GUID: ZLcVsOU9Vy60vbLlXr2p_jcht6BKEhFv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAzMCBTYWx0ZWRfX4u09hCC3vMI5
 y8R0xy92yCMCe4hUJdTp1mzooLDBIlxRLGRnSTgZfKFbj5v0+TBsGTmy2keeJPgGhNNfXPmHiel
 NMQoGo6JRagacGwRoVAsuflikuxYv0oa7pIsqFotBXIBBGRO4MDMr3wzc90LGtivf1EbPYCcegX
 ipwkc6h+aaR5Cgq2UeH44cK2ScL61ViO6oSV/ij2m8Phbv97NVnU1GJlUC0meki9ApQHS16v1L0
 dV0KHWVKUxQmTGgZ4YC09uZV1QLEiiiKVKS1HsUAjYwyVuzb5qsn7JfkzCS+IECXyxAzyGP41Nl
 uu2WorNoQhsar3ZJdU/XrQenhUnwncWdZVMrWx9BJj98QAcHwco9RBepvDEiIy9H5A5MoF7lZ1P
 MbZ7YyUjuQ4Xh0/iiEZ3P778/l8eMg==
X-Proofpoint-ORIG-GUID: ZLcVsOU9Vy60vbLlXr2p_jcht6BKEhFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130030

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


