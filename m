Return-Path: <stable+bounces-210346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BB2D3A912
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 13:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F46A3005308
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF235B15F;
	Mon, 19 Jan 2026 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2KqMNYs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aVsKsmy4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2B33CE8A
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826258; cv=none; b=pC8IqPk9pDWRjFpQ9btF8Jr7cf5OACRlXAAUU2gr5z3aRC7n6vUWW6BDiehcPJa6s7UfYR0Id4E80I0rjg0sukSVcI0eL29fR3l28l+2dzDp51LabLMwR7q6gcgjp4PIcUSsEgS0o1PZmF94u9mHY9odlFH5XWAyUZH2UvGo0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826258; c=relaxed/simple;
	bh=NZRyf1dFwiNbqdkWNPc6DEipJCrOLZWSeo1BDrPkkl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=acWdijWGnlL+wEhNfZFgFcuAGgeRMtokkzvhWHXYMYyEry+aWgFaX5ik0QgWzOrLQ+hME/+ChE62V4HJocPPktlKySXpayB2NHZJ3F1VpcfwkWB5VOzu83AQyxPEdQCpUk2XtlxcgtMRsRZhjNr2Xr+scqIs0vmI0zE5AyxThcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2KqMNYs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aVsKsmy4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J90m531904964
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 12:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8WVBmlebpTLAZoV1cZHD41
	7RyW/bIktDE2JF6nvOrdE=; b=F2KqMNYsUuDCAOq9KxMptzTFKnmdpV+LzneO7f
	/w8EB6YSu7VocmDITh/bnh2WhSbYTvk3LK8H1zO45DdcRwgPD0qwQumUUVXDaEWk
	20GtlCwBOMj7v//N9vmW57zck+yxky1O+8pNex6pxeHYw/ODd8oNBudOa2oPEXNv
	KWK3gldCFZqWshiB1/S6YTUHKeNyw4awQQWb7IiInZAHUBI6IDOWL+jwywPWYSpk
	xWIanih7UVgJJgJJtyo7kcpm5AlFC49Qlob8nFWbLPcEfOmAu6QRfhuO6rRJA1m2
	ZpJzJnBjjn4YJi/YsX847oKs8chxarPIBeQLTO2PydjnMW0g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmu8wb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 12:37:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50145222233so117415011cf.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 04:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768826255; x=1769431055; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WVBmlebpTLAZoV1cZHD417RyW/bIktDE2JF6nvOrdE=;
        b=aVsKsmy4VUTZ1rAqwi7k+vAuRXsN5nrrUSbBnVjPKCFgEHXfjioV9gOBkxRE7PCyju
         J+f5kNCD43arOAdF/rPuYD1PC34cN8au/q9Qi1tq1kpprrEhLuIsdDEcldY+pVNCVpIl
         G2GrRRF+N8Ugu+Jn1OTi5jh5ZXyZ5RzmI534R5X/lsBCHba1Pst+e/ANBu3E8Rb5JMH/
         jsk+OWHlVtnhS5nvuRTBRDJLSzboQHr27uwGlCrduS8RFcPZMDiKwOGmTlxZC3u4J7R6
         QmSTdhMYI0hYFJ4rB75zfm5U3CeZBECQRAClDOBHwnVmQGPlASx1uRf3m2Tb9+22dmmI
         RzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768826255; x=1769431055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WVBmlebpTLAZoV1cZHD417RyW/bIktDE2JF6nvOrdE=;
        b=gErO+KQmtyl8LbNAAdDTpMKFu8mf4+dn4nLsX6/oI5VCWe3gSE/4WPlaXgpdNqQigi
         GwQ0ADJDRg8+4OF870rEy5Tny+sqsA9wkkqFY1QTeGODPdhgXlPW0pKmixfGgjXoe5D/
         NcCvqkt3O1f8X89U3vjQMaeicLy+F6JI8f6+7zAFLTri757dnGaVnqCVmvSWZPxaU7Yf
         iwFZzdlONI6qJsf3Hji1CcKkSggBemVr34U5Bg+aM4OxIPmHb/3X1m0KNmysFD3TBwil
         V1/0bg5VBqXGMwXOUkQaQa677ENHosrS4/d6m1I3+rrqk9uDYM8ZxAZT9WkHiM10iuU1
         Gbfg==
X-Forwarded-Encrypted: i=1; AJvYcCWWcwhrBF+P16L3IA/6YWxF3Ebyc2tzgmCXKvgMM05AKytg0diSDcXYP5Jw7lpzrExrNPO53B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9ZIRRdvnsPj30jYq0BTEUHWt5jwyVqJW3ddD6eeASZMKBbH5
	0DQN5CTlnks9Yi7gKXwvSpl167+tV+1p2lgTsWfxfLCXXkD8V2fJC/uQMdM0PQG8biZ8cre3027
	7ySm8//0/+EELeC98wei3cjEWQVumNh3H0dsYfVgkSOj1v2Nk35yMKaiR/pkmoqej0Uc=
X-Gm-Gg: AY/fxX48ap++2rUP1SW8ir7Csrab2C6LC51hsn+CBLU2fafnPmECHDHkM1n0mXoUDTZ
	veVidU1aoYkdmW+682h6bDYud71nxiNp24pR2Lgj/58BB2djNZkwGiROm3RH27stRtmA5XjPNZF
	ulIe3d+kIOUTl3VI1vEWJ0KhRskr6w59r4DC2D6Wfc60vXOJYybT2BHIfarOkK436sUUaTWPlQp
	AEs6ARG7vpq1g1ErXAVJX6AuBnQU+n/mzVRgoLQ97d7XWGIxklvnoBP6ABAWk2kXwQZgqpIyrOB
	yRm38CgyY1PZG6egYw7xHV8WFw8rOVIQU0PUpUiAIWBUR6hxRjNqfplTHSKU6qC+fQ5EpsYQD7Q
	cQ10IbBWRo112fmh4CNpetDbiK3IfQ+R4gJ7ep45ZNVUlJuPAJ6lY3JdZkIHdBRu3vyLY5EQ=
X-Received: by 2002:ac8:5a93:0:b0:501:4c41:989f with SMTP id d75a77b69052e-502a1f89b69mr142296111cf.69.1768826255026;
        Mon, 19 Jan 2026 04:37:35 -0800 (PST)
X-Received: by 2002:ac8:5a93:0:b0:501:4c41:989f with SMTP id d75a77b69052e-502a1f89b69mr142295821cf.69.1768826254457;
        Mon, 19 Jan 2026 04:37:34 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f228d7sm74133531cf.35.2026.01.19.04.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:37:34 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 20:37:20 +0800
Subject: [PATCH v2] drm/msm/dp: Correct LeMans/Monaco DP phy Swing/Emphasis
 setting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH8lbmkC/22Oyw6CMBBFf4XM2pqW0kJd+R/GmD4GaRSKLRKN4
 d+tsHVzk3MzOXM/kDB6THAoPhBx9smHIUO5K8B2ergi8S4zlLSUlFFFbvf+4saxe5PGcK1ELWh
 bN5Dvx4itf62u03njiI9nVk5bCUYnJDb0vZ8ORWsrVMxKrizVreJOcsudMJYiVkIw4Vx2Vxp+r
 s6nKcT3OnNmq+zPopkRRrQ0UhvkTenwGFLaP576/nu6zwHnZVm+K/Rlg/UAAAA=
X-Change-ID: 20260109-klm_dpphy-8b3a95750f78
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768826251; l=2874;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=NZRyf1dFwiNbqdkWNPc6DEipJCrOLZWSeo1BDrPkkl0=;
 b=VAtzYSp7SCDmdm9jCDEYIBq4YMGH1LldcK/8dxc87qzqVUHUx/BCVnrSBMKBYZzYwI3Tg+LCp
 2Qm8Kk1W6kZBb8r1h2zt/jSZx9HPm4GlH64kk3FP1f1ZVmttn3HgHgr
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEwNCBTYWx0ZWRfXxzPbVcBpUToZ
 Qv/M+qhPY7VJUsicX9by8D34cY8GuxolpLDmXVPpiwQTCuqUR8s05eB5qT51biACMAfF2nF2R2U
 cTFzwV2oGNR1EEovywlFfVN2GEeL7s/y0HaLkfzoM0A3Gp73X3e1Gbhptye+5/R6YsBlMn7c/Id
 qm2kXpb5ZH0X0/Xum5C6zgS0YQKA0y2unPRt8hG+WanGXxVEVNKvhdXg4ixFJ2kqIiUs6HnLld9
 MJDsN0hm2ZpwcJG/VfV6Xb5SPmDLZuoiByxB2ujswxYw1EGTTs/crtRLC9DDxsv5dZ1V/FZSGzr
 XBtcVjzk9LVKwl5XzwSSRNT7OF/4XVsVunXlDnOxW0MS/Y2p7GHcpGeu02kDGwIYW9d+IbMsD+B
 AfnedlqtcSjiF9rjoJLag/7l5aNHAVjoR5Big8dRvEnoUxWnDGjcsnz4bo9Hy1O5Fmr7Nwwoea1
 9F/uTWyIrhcMaSIvhXA==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696e2590 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4O7gz8BUHgUS6mrrnVAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: wOYLxzNzA0nTnkPDaf23BeVpBIURDiFz
X-Proofpoint-GUID: wOYLxzNzA0nTnkPDaf23BeVpBIURDiFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190104

Currently, the LeMans/Monaco devices and their derivative platforms
operate in DP mode rather than eDP mode. Per the PHY HPG, the Swing and
Emphasis settings need to be corrected to the proper values.

This will help achieve successful link training on some dongles.

Cc: stable@vger.kernel.org
Fixes: 3f12bf16213c ("phy: qcom: edp: Add support for eDP PHY on SA8775P")
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v2:
- Separate the LDO change out.[Konrad][Dmitry]
- Modify the commit message.[Dmitry]
- Link to v1: https://lore.kernel.org/r/20260109-klm_dpphy-v1-1-a6b6abe382de@oss.qualcomm.com
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 13feab99feec..ae98f0a3cf3a 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -122,6 +122,13 @@ static const u8 dp_swing_hbr_rbr[4][4] = {
 	{ 0x1f, 0xff, 0xff, 0xff }
 };
 
+static const u8 dp_swing_hbr_rbr_v1[4][4] = {
+	{ 0x07, 0x0f, 0x16, 0x1f },
+	{ 0x11, 0x1e, 0x1f, 0xff },
+	{ 0x16, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff }
+};
+
 static const u8 dp_pre_emp_hbr_rbr[4][4] = {
 	{ 0x00, 0x0d, 0x14, 0x1a },
 	{ 0x00, 0x0e, 0x15, 0xff },
@@ -129,6 +136,13 @@ static const u8 dp_pre_emp_hbr_rbr[4][4] = {
 	{ 0x03, 0xff, 0xff, 0xff }
 };
 
+static const u8 dp_pre_emp_hbr_rbr_v1[4][4] = {
+	{ 0x00, 0x0e, 0x15, 0x1a },
+	{ 0x00, 0x0e, 0x15, 0xff },
+	{ 0x00, 0x0e, 0xff, 0xff },
+	{ 0x04, 0xff, 0xff, 0xff }
+};
+
 static const u8 dp_swing_hbr2_hbr3[4][4] = {
 	{ 0x02, 0x12, 0x16, 0x1a },
 	{ 0x09, 0x19, 0x1f, 0xff },
@@ -150,6 +164,13 @@ static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg = {
 	.pre_emphasis_hbr3_hbr2 = &dp_pre_emp_hbr2_hbr3,
 };
 
+static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg_v1 = {
+	.swing_hbr_rbr = &dp_swing_hbr_rbr_v1,
+	.swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr_v1,
+	.pre_emphasis_hbr3_hbr2 = &dp_pre_emp_hbr2_hbr3,
+};
+
 static const u8 edp_swing_hbr_rbr[4][4] = {
 	{ 0x07, 0x0f, 0x16, 0x1f },
 	{ 0x0d, 0x16, 0x1e, 0xff },
@@ -564,7 +585,7 @@ static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
 	.is_edp = false,
 	.aux_cfg = edp_phy_aux_cfg_v5,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v1,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 

---
base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
change-id: 20260109-klm_dpphy-8b3a95750f78

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


