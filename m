Return-Path: <stable+bounces-192332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC22CC2F566
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 06:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83C524E3755
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 05:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A89273D7B;
	Tue,  4 Nov 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I8i/GpFf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB01DFF0
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232758; cv=none; b=n1XAGiHahAVTwbo6Q8LywwMDD/4mYcqV3niBf7k4G1OPt9ICQ+lrmE8uVZYb6hk11rsgRvl7ikWV/ZGijvfvSGzlIqGn927zKDhkvH+x95opkzFoQ8ibOvFpeFQLUb5tLAYicDmI21HpyYcm5CsUmIapjIrEzCnk/4TzdTh4Nhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232758; c=relaxed/simple;
	bh=ndR7CX6Iocv9e1CR7DZxWrfTwggDled2CmOSyOYnobw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABaMpV6Hqct70VNk1bHcKqrRSlExtwzoeyUVjoFK4lvzC9QoJ7BoBvwx4fmwEmwEqBSRD0vXdk7j6kmBv/jcssgZCJrM+oIi8LmpgAS/EE6Wm4iFOoz1AsoW0ghivK2B5ctTzdVrjaU+pVHvGVQ0FNUngxX2fJWhbD81dcpw/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I8i/GpFf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43UYDX3744688
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 05:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SM5EweQsM/6
	uKDc4fYZeCgWeqFil1P7quIG4/j2dzCg=; b=I8i/GpFfojo+bl3sDZSbAHoZsdZ
	+joC3dOgA1TjqlV0NC9c45r7nCaDShoDz5iQlXIj8/HXa5bMdwhQxklROMUJu4nM
	Xk/SWWlMbpt9y/bvlQ4K052TCSCk8qX53FskXmhAIWh3d7TUuKsmgVEwHm0gx6bX
	ePLTMsEE4AmrDWKYCXx57TsgfdSWrx/WolBKT4pSKs3kERbPuZJ7XAIgW1xpeaFQ
	mSvXCBBUYhJgkbN6uRpqJGvqJhkkJTq/gDojEX6wvqXCFwLJ0y06KRd87CDIAgf4
	JusyFcrGJzGUwhCiSEE4yoss2F9MaIuNMb0O72LmElY/3JYMKOzuIojzp2A==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70kc9py5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Nov 2025 05:05:55 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A455rJl029548
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 05:05:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9mpj7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Nov 2025 05:05:53 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A455qke029540
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 05:05:52 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A455q9N029538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 05:05:52 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id 0D1BF2393F; Tue,  4 Nov 2025 13:05:52 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: quic_chejiang@quicinc.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, stable@vger.kernel.org
Subject: [PATCH v3 1/1] Bluetooth: btusb: add default nvm file
Date: Tue,  4 Nov 2025 13:05:50 +0800
Message-Id: <20251104050550.3424525-2-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104050550.3424525-1-quic_shuaz@quicinc.com>
References: <20251104050550.3424525-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAzOSBTYWx0ZWRfX0jRZbRh8s80X
 yaF9EmpVg7Vt+/1UXi69DdQbS8ZwHJMESwYRlVqVlcYfZwCrzXbY87McaoYU2EuAqJGR2x64+6W
 tEFH4aqoWcNOBoaTy6Ba4iSg+Eup/cGfCJX+zrlR/+j1PWSex/83cn4PSmj/NnVaep1nvDgpW9K
 XCk6b3q4mLcgHFNHyHNcOfHF6flZ5MFLpYPRITa+JFH5wemEkTvpFLXdqBMBefFrlAqMvh9HybZ
 dLAiQ/UqxFtTiDrhNc8UHiSgg3jiSCsNNpddKTZZsl8F5URImiUXofKDwGKpPrrPjujgKIN/K5a
 DmrxvYjdbgziWWVsK4xs+pHVsq7GNlIrtub7WKi1dnksUQoFhpNzS3atGFwe7KOrZHfmVJXTWCZ
 QbEUVSO1wOw2TiyoLvhqMSDgFel40g==
X-Proofpoint-GUID: A3zQuNajQ_qjHNQWGPcWSFih0p0y3GEx
X-Proofpoint-ORIG-GUID: A3zQuNajQ_qjHNQWGPcWSFih0p0y3GEx
X-Authority-Analysis: v=2.4 cv=TIJIilla c=1 sm=1 tr=0 ts=690989b3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=J2RAPmYWl02GzY4tkNoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040039

If no NVM file matches the board_id, load the default NVM file.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org
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


