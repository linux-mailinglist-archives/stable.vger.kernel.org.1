Return-Path: <stable+bounces-93653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5369CFFB1
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 16:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8BA1F235FB
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395417E010;
	Sat, 16 Nov 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yd5tjWPi"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804F18052;
	Sat, 16 Nov 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772226; cv=none; b=nbJWJac3S7ra3Oahapsrd0zmXKmb/QY+5e97ASbRkMB+v7fNIEv+/cxzge/h+STYfAB+VI5SYTrutErsWzRkWkZGYFV5sxxooVOKR109g8LjAN6+0u01MxgBn1Cuvf6ZFCHAYfBGls5GorUaZw9n+mI9EU+BLyV6UwPXdEk++UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772226; c=relaxed/simple;
	bh=wdABmWvmIPhgFkjip+5WZZhugtbvG99NFjnrsK3+dkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JUEs5gFVX450YjORUFYMZhfrMeKOnEDMiixH5QTuLyGNobWTDPJM3O9TaQu4qNLAdWcP9VKxG3vjjxEIcY3NqlJ95z3QBlcKb8I0AbWPJ2cH3ivZNo7v/mGcXY456dZq8YyO9fHk8JcEqMG0LgXwgVNKzEo2JN/hj9iNv4JPBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yd5tjWPi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGEN8Qx021009;
	Sat, 16 Nov 2024 15:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eb5NEXVzD8nXWbaNzThWpx
	hQktIsdJ6cJpLZpuDHR0o=; b=Yd5tjWPiioyJhhvJd92kojHBwR1fV0F9bwW2NY
	BUO2gVF1kweKcrBA+gjDN5FCGXy2jsukalxqtqulKVEWdUd8rh73odEn40XnZaGV
	vxAfhSL/jsc7y3ojtBohXLXkbJT/5NlyfMq9XwcMk0Q+2zw+gk/a3VuzIGBWCg0M
	7JnVK3z/QrKNvGAY8fzPAFkSEqiLK/GXLcvp8jEm+3hX/nqL+73keUoGq4KZCQOK
	oUh6RbE/fQxh0Fs6Q5xaGv3FS3B2XZoQtChrqHItttwtuvUYXcp6pAxs712px5JP
	bpRlA7tl5Adav5ucNZ/t0Wj8ZqwrF9tS+Z5/LQMggDbZ8d4w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xksqgxxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 15:49:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGFnvs8012427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 15:49:57 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 16 Nov 2024 07:49:56 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Sat, 16 Nov 2024 07:49:23 -0800
Subject: [PATCH v2] Bluetooth: qca: Support downloading board ID specific
 NVM for WCN6855
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAK/OGcC/32NQQ7CIBREr9L8tZgCRdCV9zBNQ75g/0JaQbGm4
 e5iD2Bm9SaZNyskF8klODUrRJcp0RQqiF0DONpwc4yulUG0ouOcS7ZwmYY3hoNRavC0MCVRaem
 9NtpAnc3R1XpTXvrKI6XnFD/bQ+a/9o8sc1ajrG+tFao74vnxIqSAe5zu0JdSvkrBk8+yAAAA
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Steev
 Klimaszewski" <steev@kali.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <zijun_hu@icloud.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Luiz
 Augusto von Dentz" <luiz.von.dentz@intel.com>,
        Bjorn Andersson
	<bjorande@quicinc.com>,
        "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        "Cheng
 Jiang" <quic_chejiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "Jens
 Glathe" <jens.glathe@oldschoolsolutions.biz>,
        <stable@vger.kernel.org>, "Johan Hovold" <johan+linaro@kernel.org>,
        Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vSBH5XbeRvQPomDem-dl8sjvPxZoXU75
X-Proofpoint-ORIG-GUID: vSBH5XbeRvQPomDem-dl8sjvPxZoXU75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160136

For WCN6855, board ID specific NVM needs to be downloaded once board ID
is available, but the default NVM is always downloaded currently, and
the wrong NVM causes poor RF performance which effects user experience.

Fix by downloading board ID specific NVM if board ID is available.

Cc: Bjorn Andersson <bjorande@quicinc.com>
Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
Cc: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: Steev Klimaszewski <steev@kali.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
Cc: stable@vger.kernel.org # 6.4
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Thank you Paul, Jens, Steev, Johan, Luiz for code review, various
verification, comments and suggestions. these comments and suggestions
are very good, and all of them are taken by this v2 patch.

Regarding the variant 'g', sorry for that i can say nothing due to
confidential information (CCI), but fortunately, we don't need to
care about its difference against one without 'g' from BT host
perspective, qca_get_hsp_nvm_name_generic() shows how to map BT chip
to firmware.

I will help to backport it to LTS kernels ASAP once this commit
is mainlined.
---
Changes in v2:
- Correct subject and commit message
- Temporarily add nvm fallback logic to speed up backport.
— Add fix/stable tags as suggested by Luiz and Johan
- Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com
---
 drivers/bluetooth/btqca.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dfbbac92242a..ddfe7e3c9b50 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -717,6 +717,29 @@ static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
 		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
 }
 
+static void qca_get_hsp_nvm_name_generic(struct qca_fw_config *cfg,
+					 struct qca_btsoc_version ver,
+					 u8 rom_ver, u16 bid)
+{
+	const char *variant;
+
+	/* hsp gf chip */
+	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
+		variant = "g";
+	else
+		variant = "";
+
+	if (bid == 0x0)
+		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.bin",
+			 rom_ver, variant);
+	else if (bid & 0xff00)
+		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.b%x",
+			 rom_ver, variant, bid);
+	else
+		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.b%02x",
+			 rom_ver, variant, bid);
+}
+
 static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
 					    const char *stem, u8 rom_ver, u16 bid)
 {
@@ -810,8 +833,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
-	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
+	switch (soc_type) {
+	case QCA_QCA2066:
+	case QCA_WCN6855:
+	case QCA_WCN7850:
 		qca_read_fw_board_id(hdev, &boardid);
+		break;
+	default:
+		break;
+	}
 
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
@@ -848,8 +878,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/msnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN6855:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpnv%02x.bin", rom_ver);
+			qca_get_hsp_nvm_name_generic(&config, ver, rom_ver, boardid);
 			break;
 		case QCA_WCN7850:
 			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);
@@ -861,9 +890,18 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		}
 	}
 
+download_nvm:
 	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
+		if (err == -ENOENT && boardid != 0 &&
+		    soc_type == QCA_WCN6855) {
+			boardid = 0;
+			qca_get_hsp_nvm_name_generic(&config, ver,
+						     rom_ver, boardid);
+			bt_dev_warn(hdev, "QCA fallback to default NVM");
+			goto download_nvm;
+		}
 		return err;
 	}
 

---
base-commit: e88b020190bf5bc3e7ce5bd8003fc39b23cc95fe
change-id: 20241113-x13s_wcn6855_fix-53c573ff7878

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


