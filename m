Return-Path: <stable+bounces-222543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG92BmpKpWn17wUAu9opvQ
	(envelope-from <stable+bounces-222543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 09:29:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F951D4A46
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 09:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C99F230143D1
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC99389445;
	Mon,  2 Mar 2026 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nY8xVwok";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bk+Gf4f2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123E379EFB
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440130; cv=none; b=ZHphMdIQfeHDmxTwAfP2RtbwU0F+oL0ABIS8fXtTRf8ogitHXGQhv71eGJYW7l3XGoDhwn2G+MztVZ+ZakFdMivUbb+eCyNaSU0Drx8TTijaHxo7riJ1ZnFf63EJyb0IRWRGEjeHSJFxNOLM2DhekyBWVl/rOZ5COVdYEnhRVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440130; c=relaxed/simple;
	bh=YJCpyIz4TCdjOpjGbf6o1zRPWSQ0oQEylCxPU7OtSbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HDw8uMvzixTSV3X49QN1XpSzfof4jR1jqsfdos/16PoOka0Rm3GzdoQrRKAwal/8qF83i0EM/G5wzM7+TlrONMM5iGmjDGCX04Ok2hxBnASuqWUUo8u2LQ3G6/I6S2kyx+l/QoqPTZ2qY++4CYyDguvXBI33TgNey7JLW+0h2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nY8xVwok; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bk+Gf4f2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62285oLG1968412
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 08:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SVcr8YN9sDAsKPDI36WQuczMepAZxihuQgrHo3tNpeY=; b=nY8xVwokoWVWVJBY
	ACEWjydMpBrOmilVLIcK9myydbvPa4kGduP59v5OmerxTcKCEDeRam1y0QsDw2tS
	yymirrB6ow+X1jmewOt5n9pNkfidd3EWm2LsLf1C1tIzVsUx8orL+6AfCc/edHdy
	ABmwL+y0Cj+YjpvPK1/NONrOj03sRVi1FUNa/puMMcw1sC7SjD1Y5Jtu527DydQc
	Ciqy9KOl8ibt9X8V2PrDT8Awv7cGgEY0M7hD3GpUZnFA/DAy+eWms2AYsrpQPe0P
	GU4NabBMJmPsItkym5m20vd//WKLS03rRjQlKewmJp8kaieaSb9At/fzI/Ma2rpk
	dbVh3w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckshkvpej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 08:28:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89a0013d87bso45133766d6.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 00:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772440126; x=1773044926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVcr8YN9sDAsKPDI36WQuczMepAZxihuQgrHo3tNpeY=;
        b=Bk+Gf4f2+A8AGwUnQ2tihfoFIRPMHD18WmuZO9/jVigsEadT+9ovF1Ih3Z9jA4+CcM
         /4wJ093RNd2wVexGyGikWPyWh52y5tqS9VGLR2KuNZzwjJZtfr1VRs7PoDfJSrhOEVOo
         nxjAYfACKt3hnhA2DYggyDWzPc99+oK3kn1ezKYoLVa2KuoQ//yh/ZgznWZ5RjrlO+j1
         8zPDWeZOduxZtu66wVU9Y3bbQAcRbwniVndyyYoWFNDKi8jiRMPZ6wtHX7MitFSU/aD0
         IljEeNjUXTVzR0UzBf9OMEBl6LP3PmIgqFdy1LAYP+d61S7hlUZHwSULPZOC+IfU729i
         xDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772440126; x=1773044926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVcr8YN9sDAsKPDI36WQuczMepAZxihuQgrHo3tNpeY=;
        b=mJfrbj0+JCAwScHLqWjrh6Lr6QOMse2lUpWaNB9kMXR3HsGcNkJ9RQ3bn8evqCr/1K
         pBXheljNMJqrq449awE5v6cBLV1JgoKpLc5ezJRM2eG4aGQToRi0KUpmOIxyVvEgVr/C
         /iRoFcgamTagyXCLGBuNuOn7JHYAgBNIplFmK3kWIQ2EmFi5I1fc2SyYY8kSQfdShuW9
         6s+MkWizEyCv40s99QNo9tRwSUBhNuS2iQuAdQEbZ3LKNuFJsusgt5+zKVAztL2XoiYq
         PppxkP0xO5SCyJ2SPTWGbKFIym78wGziEqs9JW6UsevmGeOSuoBezynzlzFp/peysvme
         a9Og==
X-Forwarded-Encrypted: i=1; AJvYcCUE1U2KijOjLFj1TZCe28OPnq6x5SmeZ//rOKu9+q2upqAvZfz7mnY8scmY7M7KT8+PrlZo/Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbZ+61JUsxjtozVxH6lXiXp+tFSqrEtlNrSojSFs4zyo52iY+
	gZnlWi3kOmnKXYbpAVzjWDujR2Bqv1I0SnSwDjY1f4H5bNFej2lysNpamotndJ9dTELVbQCEaR8
	zEs3joOT3o6A+xCeHqijB+KBL72xHk8Vl7wN3q0sXMaFDLB4e+bdfw/7v0+M=
X-Gm-Gg: ATEYQzw/N69yq+GAaZO7imaXMimecLeR4+7wnhT4VXXWnTSVL4pmkpc5kqXAvA6oCBu
	iyMpwzJIqGhTPYtAXhosHaM5wY4010XR3MkPZCCZU+3M34lG67eNCqoBWPLecv8BPObM1nUOqCz
	d8xlAnItvAvCGuZ3o4a7A2XY7ogtSYTuH8mCAF7LIEdi4WEQm1VA8R5jTzzsMf08JbOTf0VX380
	a54WnQPrk9/jYNb7D+qXe4AKDedSi76tGj/9TAMe27Yt4lbDRZYJ6+voKrjukrFMD4KKyJT9A97
	2qscmsJbfFF16QHhWpjPSVPbOzn2yVr4SfG+N+PmBt4/jhbv/zqj9tpFZibQWCHUzrOjQoxoDEV
	pvGDcUUJpwNEHIYr+BthBlIR2fUW+rjiT81WuTj5WBg296OIc4BubyNY1BJsKbMvqev3q8d5UZc
	Ni94hrKJI=
X-Received: by 2002:a05:6214:21c6:b0:895:1cbb:5d5b with SMTP id 6a1803df08f44-899d1e2b9a7mr180329506d6.32.1772440125892;
        Mon, 02 Mar 2026 00:28:45 -0800 (PST)
X-Received: by 2002:a05:6214:21c6:b0:895:1cbb:5d5b with SMTP id 6a1803df08f44-899d1e2b9a7mr180329206d6.32.1772440125393;
        Mon, 02 Mar 2026 00:28:45 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7193227sm101354696d6.21.2026.03.02.00.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:28:45 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:28:30 +0800
Subject: [PATCH v3 2/2] phy: qcom: edp: Add per-version LDO configuration
 callback
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-edp_phy-v3-2-ca8888d793b0@oss.qualcomm.com>
References: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
In-Reply-To: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772440115; l=6465;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=YJCpyIz4TCdjOpjGbf6o1zRPWSQ0oQEylCxPU7OtSbI=;
 b=pYYdYfq9k3t8lnU9A0S1GsHhUarTFiInP9vUOaGsDymYlwJ7FwIzBHThhSN3+DncRIhbY68hM
 u/5VUPpRNq6C5aET+ZGZYefJReEGZwaJa5sJ694Sq61HZ4sylB3aINv
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3MyBTYWx0ZWRfXwY90Zpv1fH/d
 ZxIpiKiZrhW0rALPrQpudObWrgAIKHmlhotOFVCElp29Dj3cy9TTZuzgP+pchfi9j6OLa7zd6xp
 fHlKk2y9PVHDwNYhl0fbjnaZGCjOcve8qh2zP7yDbdGo5YCsy2/2rS0UJuLAeFulRjpeVmZ2pEp
 vKKju/Wf4EGdORN4V+9uNVEmgzbxUMHAkwgulSDugojsTafdkCyxiGalFq0l+72NuoEE9Lu/xVv
 gaWjuZoT3q5p8OXB3oo++dEHKyHoHgcS3xufZjTQ/RLcfBLD/NMN0HfTAWQM2mR/QYWMim0DXRS
 gSZuL9aNrB+YrYFioqiCl28KyuPPBNc75yMlKfIR43FeInt9JWCbzqqI7g3lRzzTTiyXExguJCd
 b0jsxqCnfXzyssFuHK0mt1BKXM21wt9BuE6upvByYbieI8YuHdrTmh3aAw0rWn6coGrAQz7v1UC
 y1BKabK6/xwGEfwXErg==
X-Proofpoint-ORIG-GUID: BMAscepgpiJdHeMWXyTwptVv8AnFCskG
X-Authority-Analysis: v=2.4 cv=EvbfbCcA c=1 sm=1 tr=0 ts=69a54a3e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Wstf64DO4dhji1mrokQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: BMAscepgpiJdHeMWXyTwptVv8AnFCskG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222543-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A7F951D4A46
X-Rspamd-Action: no action

For eDP low Vdiff, the LDO setting depends on the PHY version, instead of
being a simple 0x0 or 0x01. Introduce the com_ldo_config callback to
correct LDO setting accroding to the HPG.

Since SC7280 uses different LDO settings than SA8775P/SC8280XP, introduce
qcom_edp_phy_ops_v3 to keep the LDO setting correct.

Cc: stable@vger.kernel.org
Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 86 ++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 36998326bae6..d29e548fce9d 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -81,6 +81,7 @@ struct phy_ver_ops {
 	int (*com_clk_fwd_cfg)(const struct qcom_edp *edp);
 	int (*com_configure_pll)(const struct qcom_edp *edp);
 	int (*com_configure_ssc)(const struct qcom_edp *edp);
+	int (*com_ldo_config)(const struct qcom_edp *edp);
 };
 
 struct qcom_edp_phy_cfg {
@@ -304,7 +305,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	const struct qcom_edp_swing_pre_emph_cfg *cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
-	u8 ldo_config;
+	int ret;
 	u8 swing;
 	u8 emph;
 	int i;
@@ -330,13 +331,13 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (swing == 0xff || emph == 0xff)
 		return -EINVAL;
 
-	ldo_config = edp->is_edp ? 0x0 : 0x1;
+	ret = edp->cfg->ver_ops->com_ldo_config(edp);
+	if (ret)
+		return ret;
 
-	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
 	writel(emph, edp->tx0 + TXn_TX_EMP_POST1_LVL);
 
-	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx1 + TXn_TX_DRV_LVL);
 	writel(emph, edp->tx1 + TXn_TX_EMP_POST1_LVL);
 
@@ -560,6 +561,52 @@ static int qcom_edp_com_configure_pll_v4(const struct qcom_edp *edp)
 	return 0;
 }
 
+static int qcom_edp_ldo_config_v3(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 ldo_config;
+
+	if (!edp->is_edp)
+		ldo_config = 0x0;
+	else if (dp_opts->link_rate <= 2700)
+		ldo_config = 0x81;
+	else
+		ldo_config = 0x41;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFIG);
+
+	return 0;
+}
+
+static int qcom_edp_ldo_config_v4(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 ldo_config;
+
+	if (!edp->is_edp)
+		ldo_config = 0x0;
+	else if (dp_opts->link_rate <= 2700)
+		ldo_config = 0xc1;
+	else
+		ldo_config = 0x81;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFIG);
+
+	return 0;
+}
+
+static const struct phy_ver_ops qcom_edp_phy_ops_v3 = {
+	.com_power_on		= qcom_edp_phy_power_on_v4,
+	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v4,
+	.com_bias_en_clkbuflr	= qcom_edp_com_bias_en_clkbuflr_v4,
+	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
+	.com_configure_pll	= qcom_edp_com_configure_pll_v4,
+	.com_configure_ssc	= qcom_edp_com_configure_ssc_v4,
+	.com_ldo_config		= qcom_edp_ldo_config_v3,
+};
+
 static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
 	.com_power_on		= qcom_edp_phy_power_on_v4,
 	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v4,
@@ -567,6 +614,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v4,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v4,
+	.com_ldo_config		= qcom_edp_ldo_config_v4,
 };
 
 static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
@@ -583,7 +631,7 @@ static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v3,
-	.ver_ops = &qcom_edp_phy_ops_v4,
+	.ver_ops = &qcom_edp_phy_ops_v3,
 };
 
 static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
@@ -768,6 +816,24 @@ static int qcom_edp_com_configure_pll_v6(const struct qcom_edp *edp)
 	return 0;
 }
 
+static int qcom_edp_ldo_config_v6(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 ldo_config;
+
+	if (!edp->is_edp)
+		ldo_config = 0x0;
+	else if (dp_opts->link_rate <= 2700)
+		ldo_config = 0x51;
+	else
+		ldo_config = 0x91;
+
+	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
+	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFIG);
+
+	return 0;
+}
+
 static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 	.com_power_on		= qcom_edp_phy_power_on_v6,
 	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v6,
@@ -775,6 +841,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v6,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v6,
+	.com_ldo_config		= qcom_edp_ldo_config_v6,
 };
 
 static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
@@ -955,6 +1022,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v8,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v8,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v8,
+	.com_ldo_config		= qcom_edp_ldo_config_v6,
 };
 
 static struct qcom_edp_phy_cfg glymur_phy_cfg = {
@@ -970,7 +1038,6 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	unsigned long pixel_freq;
-	u8 ldo_config = 0x0;
 	int ret;
 	u32 val;
 	u8 cfg1;
@@ -979,11 +1046,10 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
-		ldo_config = 0x1;
+	ret = edp->cfg->ver_ops->com_ldo_config(edp);
+	if (ret)
+		return ret;
 
-	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
-	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
 	writel(0x00, edp->tx0 + TXn_LANE_MODE_1);
 	writel(0x00, edp->tx1 + TXn_LANE_MODE_1);
 

-- 
2.43.0


