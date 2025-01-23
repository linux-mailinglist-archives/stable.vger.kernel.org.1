Return-Path: <stable+bounces-110296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B505A1A7C2
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F37A1654FE
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0102116F2;
	Thu, 23 Jan 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hiwQ3kaG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06C1C5D4D
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649315; cv=none; b=QI55C2zhJ8Cedb3/HMNAKr0DqcuSjji4Z/aFbHFDEvWjXCASsd3mx/BzAEPpwCB4MS4+eqAnaHIwQxUok1FZAWWOVbAueXNMz4JkFMZ4rVCccdvHj5FhUt631iNldLjxksDVUMEAEAF+KEqa4D/9fBoRJHMEBV5A+cQJX9aOiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649315; c=relaxed/simple;
	bh=aRDXetIWQOvz9IeTeZVbHW/7Hzi1A0v9Qy1wyCPcAUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bmfbslMb6cI4rwM7bVU9z3hTQC2rx3s+txMGMhL9s/+L6jGMqwgNCZXqespYfRrcRqRfQAMgoj0l/PBoldXGG79LTtSfIh9kR3wT1Ra8/vVyM0HQF3D5qgyXBhHGXqbewIE/GJmKZdJFKlqpDfL4JRnjb1tt9R9I6ogJbwFUFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hiwQ3kaG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NApd2v014158
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 16:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wx5TJavWPaNz9mnX/E2Tah
	0I89uGKiGEDdnmz0vsjqI=; b=hiwQ3kaGoOqHd6RA1uDEoWUO/7Em3iEIoeLgso
	RF06Y6RWVyOgB5MmbZ37+8BGPhOdoX6K2j5dhiT6VI0b9xf7u+TwmvOW1u5pOI+Y
	qyQ3ZlvdMmwhBMw+l6WuTumN0w5RIrmOZDBFG6E9yJXfh4HEhzTAoE7dvU9F/+tz
	M3/JPsR5OBxO6TxVJxAGpFsdrOs1op/6PyhxauOa5FfOG/UNszsoAivgX+3p4T/O
	d+dsLvq3SaPb+TqItKsY0Q4qgUQYaFMYSd/exv7u+b/rcZEFvU9vKW+16J5iBbrB
	4YxvE2yUmVgjn2DVl0Vxbk6hyEhqAtXNPOFurDcl/7yqZJ/g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bmcvgs1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 16:21:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2efc3292021so3304669a91.1
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 08:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737649311; x=1738254111;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wx5TJavWPaNz9mnX/E2Tah0I89uGKiGEDdnmz0vsjqI=;
        b=BtmpBdeirvhs7mfya/vVwq0AwGA0skXdXZpbXBNau9QqRw9JldY0MVFIfmUxjYG239
         AC5XmnoH8aMmnJbMz931oO8VErEOzu1RanNFw7ZoUPKxHy84kJeCU576AB5oapl1D8zo
         /n9jnTGbBaLwOtBfW0iRhNAQAsL0+S+yZnRzHCBlfJE1AGl55f6thYyjIh1Bpno2duPA
         RuL+XErCf8/FjxD1rsr2cCqipzWtF9sB2jx9pSIIzvvhJq4NpSZWoVjLFbu/j29rSnrG
         V6PHK2p+jKPyf+7AXOGH/yaMAp/cArbLJDvPk1rVJC1w4hknA4KX3YpndlpPi1y38FVf
         dA7w==
X-Forwarded-Encrypted: i=1; AJvYcCUxi5BFeE0BiFwv6CuWEJdnCfZfGtdqTaSAXo/IJR1Hc9cdKjCt2821niPZO9BG3qm1FRCbgNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy714yrdce+HYirDMOSQ7F/+feKBSoTOOCAjaWf12tT4SH44MNn
	vDbgATwUPjln30fFHBkyEXyJjaNnXeYxQxqzZ6LmwEbv/eJwIocrqBjiyPu7LLYNT8sn9IXwOE+
	xK/V8QBaKmIQ/EuuN1o59hc9HPHUVJxevZJiwB4ETLLcPNswqmQEaufw=
X-Gm-Gg: ASbGncsjxHvnlnxy+5SL00rh5fHk8tQ7k7BNnvL5G5iZd/Y2oC5cRF1Dh33fb32niuM
	XZDliSHki28i02hjHGenk9VvNCg2bSLudRyUokQN6U8W+WUlOrdCpn4+lAoalVVQS3egGkYEyra
	+qWb8EcCPNbwlTj0IIkECx5M1J5l8LoWYQYmYlCXJ5DPr5GkUeRicLBtbb8x2GkboTnQ9M1gpVV
	kGaTFwsIgDc1tV3RafiJ6BDxgc3g90rkxhK1hD7IVknl/TK3pGrnAzxa8z7Fct9WQXG8ZvrXSUm
	AUc5lxRAEZK1+XfjVhAJ3eRcFRVvIAwnh8MrKNGlss7Mva4qzKhqecXDrQGABSFpokDIvKLD/rS
	Fc+jOOamgzMEyLm6hTzw=
X-Received: by 2002:a17:90b:2709:b0:2f4:434d:c7ed with SMTP id 98e67ed59e1d1-2f782cbdfe2mr42308901a91.16.1737649310758;
        Thu, 23 Jan 2025 08:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8Pwb4wE8+gwUhLvHjzhTe1kkVPWCXTcP85tfaQItdsYDRJbcwDWGfSqivQhSCp1/ilKpw1g==
X-Received: by 2002:a17:90b:2709:b0:2f4:434d:c7ed with SMTP id 98e67ed59e1d1-2f782cbdfe2mr42308851a91.16.1737649310342;
        Thu, 23 Jan 2025 08:21:50 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a7e04dsm4534085a91.12.2025.01.23.08.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 08:21:49 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 21:51:38 +0530
Subject: [PATCH for-current] wifi: ath12k: fix handling of 6 GHz rules
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-fix_6ghz_rules_handling-v1-1-d734bfa58ff4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJFskmcC/x2MWwqEMAwAryL5ttBWXJa9yiLFR1IDUiVVEcW7G
 /wcmJkLMgpjhl9xgeDOmeek4MoC+rFNEQ0PyuCtr63zlSE+wieOZ5BtwhzUGSZO0RB9a3JIXWU
 70HoRVPU9/4FmMf0mgmmF5r4fU3jnz3YAAAA=
X-Change-ID: 20250123-fix_6ghz_rules_handling-ff85f1efb30b
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: dc_SJeTiTRFKvdzlbHnah6M1P-Mfn95N
X-Proofpoint-GUID: dc_SJeTiTRFKvdzlbHnah6M1P-Mfn95N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230121

In the US country code, to avoid including 6 GHz rules in the 5 GHz rules
list, the number of 5 GHz rules is set to a default constant value of 4
(REG_US_5G_NUM_REG_RULES). However, if there are more than 4 valid 5 GHz
rules, the current logic will bypass the legitimate 6 GHz rules.

For example, if there are 5 valid 5 GHz rules and 1 valid 6 GHz rule, the
current logic will only consider 4 of the 5 GHz rules, treating the last
valid rule as a 6 GHz rule. Consequently, the actual 6 GHz rule is never
processed, leading to the eventual disabling of 6 GHz channels.

To fix this issue, instead of hardcoding the value to 4, use a helper
function to determine the number of 6 GHz rules present in the 5 GHz rules
list and ignore only those rules.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Cc: stable@vger.kernel.org
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 61 ++++++++++++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/wmi.h |  1 -
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a7625a3d1a3a9b1bbcf90cee30d3c707de03c439..296238c7ee0fd95045a3e0859d730e3bd73ec906 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4852,6 +4852,22 @@ static struct ath12k_reg_rule
 	return reg_rule_ptr;
 }
 
+static u8 ath12k_wmi_ignore_num_extra_rules(struct ath12k_wmi_reg_rule_ext_params *rule,
+					    u32 num_reg_rules)
+{
+	u8 num_invalid_5ghz_rules = 0;
+	u32 count, start_freq;
+
+	for (count = 0; count < num_reg_rules; count++) {
+		start_freq = le32_get_bits(rule[count].freq_info, REG_RULE_START_FREQ);
+
+		if (start_freq >= ATH12K_MIN_6G_FREQ)
+			num_invalid_5ghz_rules++;
+	}
+
+	return num_invalid_5ghz_rules;
+}
+
 static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						   struct sk_buff *skb,
 						   struct ath12k_reg_info *reg_info)
@@ -4862,6 +4878,7 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	u32 num_2g_reg_rules, num_5g_reg_rules;
 	u32 num_6g_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
 	u32 num_6g_reg_rules_cl[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u8 num_invalid_5ghz_ext_rules;
 	u32 total_reg_rules = 0;
 	int ret, i, j;
 
@@ -4955,20 +4972,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 
 	memcpy(reg_info->alpha2, &ev->alpha2, REG_ALPHA2_LEN);
 
-	/* FIXME: Currently FW includes 6G reg rule also in 5G rule
-	 * list for country US.
-	 * Having same 6G reg rule in 5G and 6G rules list causes
-	 * intersect check to be true, and same rules will be shown
-	 * multiple times in iw cmd. So added hack below to avoid
-	 * parsing 6G rule from 5G reg rule list, and this can be
-	 * removed later, after FW updates to remove 6G reg rule
-	 * from 5G rules list.
-	 */
-	if (memcmp(reg_info->alpha2, "US", 2) == 0) {
-		reg_info->num_5g_reg_rules = REG_US_5G_NUM_REG_RULES;
-		num_5g_reg_rules = reg_info->num_5g_reg_rules;
-	}
-
 	reg_info->dfs_region = le32_to_cpu(ev->dfs_region);
 	reg_info->phybitmap = le32_to_cpu(ev->phybitmap);
 	reg_info->num_phy = le32_to_cpu(ev->num_phy);
@@ -5071,8 +5074,29 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 		}
 	}
 
+	ext_wmi_reg_rule += num_2g_reg_rules;
+
+	/* Firmware might include 6 GHz reg rule in 5 GHz rule list
+	 * for few countries along with separate 6 GHz rule.
+	 * Having same 6 GHz reg rule in 5 GHz and 6 GHz rules list
+	 * causes intersect check to be true, and same rules will be
+	 * shown multiple times in iw cmd.
+	 * Hence, avoid parsing 6 GHz rule from 5 GHz reg rule list
+	 */
+	num_invalid_5ghz_ext_rules = ath12k_wmi_ignore_num_extra_rules(ext_wmi_reg_rule,
+								       num_5g_reg_rules);
+
+	if (num_invalid_5ghz_ext_rules) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "CC: %s 5 GHz reg rules number %d from fw, %d number of invalid 5 GHz rules",
+			   reg_info->alpha2, reg_info->num_5g_reg_rules,
+			   num_invalid_5ghz_ext_rules);
+
+		num_5g_reg_rules = num_5g_reg_rules - num_invalid_5ghz_ext_rules;
+		reg_info->num_5g_reg_rules = num_5g_reg_rules;
+	}
+
 	if (num_5g_reg_rules) {
-		ext_wmi_reg_rule += num_2g_reg_rules;
 		reg_info->reg_rules_5g_ptr =
 			create_ext_reg_rules_from_wmi(num_5g_reg_rules,
 						      ext_wmi_reg_rule);
@@ -5084,7 +5108,12 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 		}
 	}
 
-	ext_wmi_reg_rule += num_5g_reg_rules;
+	/* We have adjusted the number of 5 GHz reg rules above. But still those
+	 * many rules needs to be adjusted in ext_wmi_reg_rule.
+	 *
+	 * NOTE: num_invalid_5ghz_ext_rules will be 0 for rest other cases.
+	 */
+	ext_wmi_reg_rule += (num_5g_reg_rules + num_invalid_5ghz_ext_rules);
 
 	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
 		reg_info->reg_rules_6g_ap_ptr[i] =
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 38aed18b99f4239e40d369181549b4bc78faa862..81248253a36872f6fd93db772b5394f3ef9d3bf9 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4093,7 +4093,6 @@ struct ath12k_wmi_eht_rate_set_params {
 #define MAX_REG_RULES 10
 #define REG_ALPHA2_LEN 2
 #define MAX_6G_REG_RULES 5
-#define REG_US_5G_NUM_REG_RULES 4
 
 enum wmi_start_event_param {
 	WMI_VDEV_START_RESP_EVENT = 0,

---
base-commit: c4e4e37afc8b8d178b0f00f607c30b3b81253597
change-id: 20250123-fix_6ghz_rules_handling-ff85f1efb30b


