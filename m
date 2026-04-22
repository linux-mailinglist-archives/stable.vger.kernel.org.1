Return-Path: <stable+bounces-240275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBZWIcVk6GmpJwIAu9opvQ
	(envelope-from <stable+bounces-240275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:03:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB8442414
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F16303AF0E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382042D321B;
	Wed, 22 Apr 2026 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lm2LrJV5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fedFO3e9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46EB2DB7B9
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837742; cv=none; b=eIDh7JXhsIwtDNJxBkd8wiP0c2VmEgh3oAouljPM2zqk80tDcNd9pvLYoBFEqTrmE6VMT10BWP36CdvvHy3/sUuGGZGDrMlTLocwcYdZnPJaf7jtWr1xyb17w7R0n/BVGFiha9Pt85dz4T5METukZNEee/mQwJitgCyWHpcKjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837742; c=relaxed/simple;
	bh=koMmfDgY6enq9c552pstA8QV5P3AcIvAKR/xucXdwSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXxt8V8jquc2Mj7ima9iI6poSXGnu9t2XbRigWkkBsJ74h0LYuJiD4bcEsQwBMtwidsdxbchaVNCrieJcobC0VNB1OmfTHyIa0JyCUIH157sv5pC5wXytSuwJj4x5L18H4K7cJrtX2P9cMnc8F6zn1iLj5Cjbfxiqzf4uzlnjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lm2LrJV5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fedFO3e9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M4hY1X2965878
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFsNyAPQYJKzJfr5Ys2tu91JQOWqhh8cnTV/8Y7H4qs=; b=Lm2LrJV5sqR28LbT
	sAdcnAuAPN1TnYodA2rrM2FdEIxiZfqKbGAke/Y08uLv3oUbW7jfWRzC3acoQRF2
	Iq7FH5yDZKID7nhmX2MQwiJZWj6GRc/ImNhHIyy/+oS/f7AVRtC32KMUj+l9ErjV
	4BPUZ7MPznhYiwBwLvMJ5y1hqkyCOAPozZOYZLX1e3MnF0TqrsX0t7vYq4z2zAwF
	sdQF6TfaJXh0iwXvzpmiGPZ6MMP+RGi0OM6oDh6cvfG3LQicVgAWgLyfCosBIH8M
	VMyYqq2VeFKT1vRKEykOhcZishHLVTRLcbYAzNyBHrUGKYepGr9d6zQVS9EpRVa/
	rPVEdA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfhvav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8dd61e9d1faso1306098085a.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 23:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776837739; x=1777442539; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFsNyAPQYJKzJfr5Ys2tu91JQOWqhh8cnTV/8Y7H4qs=;
        b=fedFO3e9IYRQ6uoyvtGtbz/JlaIB8g9yUERuMmKFmLbwual1/CQ9OAN3oiMPECZah0
         TUTiITxEWuYWQzXCx6iClO8RpmMyrw1aAPlFPM0BG4wps8xLPmmgyCQU7DeCLRwWvBNB
         R39zqhkfWGlLzHrhzJqCfSQSEX78gWPJW68agQMBQ5AqOxbSkSPyz8pOSsW524Gr0Ko2
         aqGlIVyCdZsUGfUp5HNwZhcW4IphpI5CH1v2SfQ/FxVjAvjyEdU41O1LpWLN6Rca/4XF
         FJRWRso4vuadgu//ft2ORlxNSVy+mly00MMvhtOXoNivsNAbSd01f74AxWIxmqW4H/s4
         lrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837739; x=1777442539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFsNyAPQYJKzJfr5Ys2tu91JQOWqhh8cnTV/8Y7H4qs=;
        b=XDWLyTozVhZuDLIbRPWtvYnUgaGYLjZJFD2elHC5KhCnJewLT9YmEYMe3KlTmk7N6A
         o2tOtOYGZooz9gm/CyiGEghroDP6B8uCoqj1B9mL4c5JQ4oZd5YeZl0zlu1FkpbkhmI0
         hqjunOt3EgNXak7D4tmoPnaCz5qPfJtJaXv2ZR2xk0StGb/OJDob8kHI/WVdm3XPJUoQ
         NeCFMHZQvaSkaZ9NTPM6a4/HtMgAcjH6vGNWfIk1XaMWhaj8X4QYsEPVLU5Yb+wAvuEU
         DSDuK0OzEN3VcvHJ45o7B19ZFSgSumtFfIfiDh7f9UBrqLGwBmCu1rffKPIXCF+vm8k7
         BxGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YgcjtyB+ogVOfHv8uKQQEwSI85hmWKKF8pOUj/Uq116KRFeRtvh5YkwFN+DrqoXheZjYNKmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PBa80hBbOyCYtmDJDxft7qDMYUDU9ftx/MmwZtHoQnfG1DY3
	R00u9/D1b7dg9i+RbzGYPuSyhHlq9RNahFWhjTGyqB6OaNSPhWDdBTcvmDtS0qOcWWMhuPczCsC
	DBL7zfuqq10sSgPD6p2eMgUm5eaxD7xpPadBh1l/fDqjzkNtuCw5D1innhAg=
X-Gm-Gg: AeBDiesliNYp9saUNydVPhDDJawmKMuRcdjYMEq+trMrhqtinGinei0qNh62iz2pAXq
	4y+T7dDqziBe8DnHKSLULb+3e0hviaV/rcPryqJou7vKGpVEvw8Q3VcEiZTsj822eTVRgRpQE5I
	8EgiWO4SkU/jAmnjNNBoVqQNsHSnWIgIIjkIPLpLkGS9g/bIWgZaFI5x3GsRbUHcLK2YUHKt4d5
	YVvLRuCfSCnBoLLbHRv8nIU8vaqcexN/6Zb9yFm21d6OT9I8uXsCodt+bLhy/hha2c98fpALiWM
	Y7G3MjId5gndPDzuGdZNA3w66RHdbyJ6Itf9Hs0+SrYRFiHlJITPQpIzJ1Q7glrdY2hq0TFJ3wD
	LvC6cBKDwMuPr0hm/Opa+/m/74c0tE2kW3lMNGh4nykPRESAwrfC2SHybadSX1BHrHQMNbjpwEB
	Cyrnn2Zr32l7lg6MoZmg==
X-Received: by 2002:a05:620a:e98:b0:8eb:49b5:bdb1 with SMTP id af79cd13be357-8eb49b5bfb0mr1206076785a.18.1776837738555;
        Tue, 21 Apr 2026 23:02:18 -0700 (PDT)
X-Received: by 2002:a05:620a:e98:b0:8eb:49b5:bdb1 with SMTP id af79cd13be357-8eb49b5bfb0mr1206074185a.18.1776837738070;
        Tue, 21 Apr 2026 23:02:18 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef12122800sm237379985a.18.2026.04.21.23.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:02:17 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 14:01:52 +0800
Subject: [PATCH v4 2/5] phy: qcom: edp: Add eDP/DP mode switch support
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-edp_phy-v4-2-c38bef2d027b@oss.qualcomm.com>
References: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
In-Reply-To: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776837726; l=5695;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=koMmfDgY6enq9c552pstA8QV5P3AcIvAKR/xucXdwSU=;
 b=4njF7bVd40+2M5r00zYKejJksd05Hb3dd9BkdXPx3lh83ZcOzqWPg2uzhEvYFLbap3kTFhUIe
 +gVt4TP5w3lDrqStpudtWi3+eSo02lv3JHRZZOIuLlmSfSBthRoobz2
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Y6rIdBeN c=1 sm=1 tr=0 ts=69e8646b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=se8qGc9sdx2UsIF7nuMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1NiBTYWx0ZWRfX6cS8DUsdjawk
 1Uvr2/sJtm8P6PVp2AfKj4BHldZA9TnMKVbel9FWbKet/ndPQCi4LBK9IgZ4BGjEFsjQLmwrFnW
 aJAoN4kPYxOTE5CVZtiZTFMKammsxUgQ6UWOgIfn8D2QhEddX/636q3zGnLfJh9ppEINnVKBVTL
 ty8mXyE4+4dEmqHexS+TeZalYsxAcv+u/1OeQliWXByvdawElqpoEv6QL4ebQaRZGsue0jSaRpQ
 otxGoRknYx2hDK4Mpqnf5+N/dyZttIL3CmvfFVcsEaTCKwE8byc0JA1iZIQs6G8/fB55qCnyuRk
 fBPsK+onHwZKmTsjpAc1Ta0h5MexOmiUNE2DPnGGOhSMiR39TefZL1Yeq6lmP+5DBP/06gMUOh6
 D7Do8qYN1Jmk7Dq+Ye2Of92vHZbkjfHZ8dr02lTak5+g4byIccf3CkxVh9sEghu/zlirQHUFkH6
 El/cUByhm09d8C7AT7g==
X-Proofpoint-GUID: qQzLPYS6-9WBhQjy8SzL5gzYr_yDG3zJ
X-Proofpoint-ORIG-GUID: qQzLPYS6-9WBhQjy8SzL5gzYr_yDG3zJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220056
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240275-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03FB8442414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The eDP PHY supports both eDP/DP modes, each requires a different table.
The current driver doesn't support both modes and use either the eDP or
DP table when enable the platform. Add a separate set of tables for eDP
and DP modes, and select the appropriate table based on the current mode.

Glymur's DP mode table differs from the other platforms, add a dedicated
table for it.

Since both modes are supported, so also fixes the table mismatch for
X1E80100(eDP) and SA8775P(DP).

Cc: stable@vger.kernel.org
Fixes: 3f12bf16213c ("phy: qcom: edp: Add support for eDP PHY on SA8775P")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 46 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 2af3fd63832f..3266026cfe37 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -87,7 +87,8 @@ struct qcom_edp_phy_cfg {
 	bool is_edp;
 	const u8 *aux_cfg;
 	const u8 *vco_div_cfg;
-	const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *dp_swing_pre_emph_cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *edp_swing_pre_emph_cfg;
 	const struct phy_ver_ops *ver_ops;
 };
 
@@ -150,6 +151,20 @@ static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg = {
 	.pre_emphasis_hbr3_hbr2 = &dp_pre_emp_hbr2_hbr3,
 };
 
+static const u8 dp_pre_emp_hbr_rbr_v8[4][4] = {
+	{ 0x00, 0x0e, 0x15, 0x1a },
+	{ 0x00, 0x0e, 0x15, 0xff },
+	{ 0x00, 0x0e, 0xff, 0xff },
+	{ 0x00, 0xff, 0xff, 0xff }
+};
+
+static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg_v8 = {
+	.swing_hbr_rbr = &dp_swing_hbr_rbr,
+	.swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr_v8,
+	.pre_emphasis_hbr3_hbr2 = &dp_pre_emp_hbr2_hbr3,
+};
+
 static const u8 edp_swing_hbr_rbr[4][4] = {
 	{ 0x07, 0x0f, 0x16, 0x1f },
 	{ 0x0d, 0x16, 0x1e, 0xff },
@@ -246,7 +261,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	 * when more information becomes available about why this is
 	 * even needed.
 	 */
-	if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
+	if (edp->cfg->dp_swing_pre_emph_cfg && !edp->is_edp)
 		aux_cfg[8] = 0xb7;
 
 	writel(0xfc, edp->edp + DP_PHY_MODE);
@@ -270,7 +285,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 
 static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
 {
-	const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->cfg->swing_pre_emph_cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
 	u8 ldo_config;
@@ -278,12 +293,14 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	u8 emph;
 	int i;
 
+	if (edp->is_edp)
+		cfg = edp->cfg->edp_swing_pre_emph_cfg;
+	else
+		cfg = edp->cfg->dp_swing_pre_emph_cfg;
+
 	if (!cfg)
 		return 0;
 
-	if (edp->is_edp)
-		cfg = &edp_phy_swing_pre_emph_cfg;
-
 	for (i = 0; i < dp_opts->lanes; i++) {
 		v_level = max(v_level, dp_opts->voltage[i]);
 		p_level = max(p_level, dp_opts->pre[i]);
@@ -543,7 +560,8 @@ static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
 	.is_edp = false,
 	.aux_cfg = edp_phy_aux_cfg_v5,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
@@ -556,7 +574,8 @@ static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
 static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
@@ -564,7 +583,8 @@ static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
 	.is_edp = true,
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
@@ -745,7 +765,8 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v6,
 };
 
@@ -924,7 +945,8 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
 static struct qcom_edp_phy_cfg glymur_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v8,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v8,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v8,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v8,
 };
 
@@ -942,7 +964,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
+	if (edp->cfg->edp_swing_pre_emph_cfg && !edp->is_edp)
 		ldo_config = 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);

-- 
2.43.0


