Return-Path: <stable+bounces-192343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F8C3044A
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 10:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 877A74EC55D
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A91DED5C;
	Tue,  4 Nov 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mhKVgWde"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24C2116F4
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248341; cv=none; b=aOAjj4yZpoFnLOg/bkaEIiuwYW02i/07AHEa7a0LyuRBiDOsbcY0VKMzxMGtqweZ6zBXLQiGgSWzVbcJLo0YVwUgFlWhU2imFe5bwS5aE9rIw0/Xa9q46/T+vyc7zahh+Q3Uoj4VyFTiIRv8MDrw3YfJ7tF0WO6pV0V+9gzeL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248341; c=relaxed/simple;
	bh=iOdVHPf/377/FhinO7miMt0s/AvZdO5fUpCpLMrBQoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WNEUtdACo5rUklbT8jhhnsMSgmOBUrKQKo//pO8/RvA4Ws8mPduru7qQnyv/i+k/uWbpO479BhZIgvzcWCf3PE013TQUbXhL/TnFR/KJCZYYiOLxvL/L9Zi0uaoubF1eN1Mi+rIVcVQysCHpT31mDbDXWMeU0lSqlPymw8JcOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mhKVgWde; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48giPl1545918
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 09:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0BAfdC7hzP5
	ehVu09EgzZpTPlj4KYvu9DoxbnvIYnpg=; b=mhKVgWdei/aLBIe6rs8DqIMQSSl
	tbaIfmoIF5dfs8bcBhB5QMhDB4+yK5a2LeIhxc0qnID19lPWSy9ojAsjDPWQ5kKF
	qmVkPhFEL/BdpXIHqaCSl+cI6nHQYWHsogWZpMXGTtGsyaLgXlkwinmXM1i1QFuy
	1HfW6i41VTlBFkUAep6GcaQvV5jyRU4gcCTH6ju2Yq/j8JUFtFt3rS2dAOydesdQ
	O5qVDfvOL7YGzV0v24WE4N8mKRWNmjWA5sM958EZaOvywCMjPH7+Tc0KcZRo9ril
	zQFRcfAwtxROGBqLkEIpyIz5spEWBcSGRK5c4uQKm2+lZNMXPkMMp5eReZw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b3c9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Nov 2025 09:25:38 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A49PYjb001286
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 09:25:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9mqux8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Nov 2025 09:25:34 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A49PYGf001278
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 09:25:34 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A49PYb8001265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 09:25:34 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id 66CC222D52; Tue,  4 Nov 2025 17:25:33 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v3 1/1] Bluetooth: btusb: add default nvm file
Date: Tue,  4 Nov 2025 17:25:31 +0800
Message-Id: <20251104092531.2323503-2-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104092531.2323503-1-quic_shuaz@quicinc.com>
References: <20251104092531.2323503-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3NiBTYWx0ZWRfX1XY2x14jnVJL
 p3UWLXhWvxiJUZiudjKoZJYhY722iVgtu2lSWUVHwfQTqup9os9j2asfdFw651Fr1hGDasJWitG
 hhy6PLt0NuwUyZQIzJD/u/P5MahIFqs4lUIPEkdM476wr7vJ4knRYNCEFuY8nETnWK8EWlqhKtW
 JtsejbrY2JJX29EN+tqByPx7xPvboLnUGCei/YhYQk0Nze7NyiWTlECck4z9jPVGXwarELHwqng
 Th2v0fGJuBu+TTCqKSq+r1xD7RygyTvj5BFET0oMXkYKSS2DU6AjCbTlMXTOzGvEbXK8r6wbkln
 96K4VI5/rAJmpUEPsJGm2XN7UJBLqchdEvRdrBHSQcENPR2WYBCa1Q0zRyTC2kDVcdcgT2QmPZn
 FkBlNNTPevVM2G9Wjc90Nki2VflDiw==
X-Proofpoint-GUID: ig6WuF6Wb1QfgbvDbKIszanwH0eCVu0F
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6909c692 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=J2RAPmYWl02GzY4tkNoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ig6WuF6Wb1QfgbvDbKIszanwH0eCVu0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040076

If no NVM file matches the board_id, load the default NVM file.

Cc: stable@vger.kernel.org
Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/btusb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dcbff7641..020dbb0ab 100644
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
@@ -3606,10 +3605,19 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
 
 	if (!(status & QCA_SYSCFG_UPDATED)) {
-		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
-		if (err < 0)
-			return err;
+		u16 board_id = qca_extract_board_id(&ver);
 
+		err = btusb_setup_qca_load_nvm(hdev, &ver, info, board_id);
+		if (err < 0) {
+			// set baord_id to 0,and load default nvm file
+			if (err == -ENOENT && board_id != 0) {
+				err = btusb_setup_qca_load_nvm(hdev, &ver, info, 0);
+				if (err < 0)
+					return err;
+			} else {
+				return err;
+			}
+		}
 		/* WCN6855 2.1 and later will reset to apply firmware downloaded here, so
 		 * wait ~100ms for reset Done then go ahead, otherwise, it maybe
 		 * cause potential enable failure.
-- 
2.34.1


