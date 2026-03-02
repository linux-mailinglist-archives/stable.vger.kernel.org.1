Return-Path: <stable+bounces-222542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFHrGFhKpWn17wUAu9opvQ
	(envelope-from <stable+bounces-222542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 09:29:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6C71D4A28
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92C02302A7D1
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342143803F2;
	Mon,  2 Mar 2026 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bn8U4CpA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MQKPeH6I"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08E383C96
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440127; cv=none; b=Vbt3F5x9bIFa2w8ujBr2jY3YCKC4jQyWe9O8s6j/EN+ZA7lpRAuLjrd9dtlwdOUD7ciwqL+VsEKZc4l+QgvFlN6LQE/PAQfoKkgu5rdev7gC6xf1iRdHf/dfRpdd3CNMAUPX0S5doEbH2QZvguiIwqv/mug1o1uBBcMHhc6z5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440127; c=relaxed/simple;
	bh=S2JW9nvnfu7j+y2B4VJo/pc6I2SO9Kjz/ltXVbvDAiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lq5MZq1N46RqVul8bKb9TodNVh3srRPnU+3r/GXh9A7tLfzaTlrDyBKqXJA/hK3SKy3X8GgBYVIKdhVtVPR3dowQ/Uu2FIKf6IloocjIxFMKwTZptNzaB2SL6YKAx8xLcBfJ+/kka6/0FNvngstHKi+LI8B1ueYHweCloVeldfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bn8U4CpA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MQKPeH6I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226hCvO2504662
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 08:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B0E1UnYD6bQBqbuh4BJdzy0LpnAFFNel4eYuVziDnac=; b=bn8U4CpAt2u90Cpw
	cyozV/ZciS/oKEH8bo6EC/QTTv1XoDBT1TE3cnT7qH4F3JK7EecR8XWcVdezNCk0
	Bmw+AxKUxt5fh49TSmhqvVuMpRYQzQl23K1jgLfum1+XvwRJooEWirBMX3s5Vrdl
	HCmiETlhOfbICs9zRi2894CkTd9C869PSzswym85JrjMwAv8qj7gW2tljwlBa1gU
	mTkJEyFNRz6LGIau7nrHooMTTT/7crX7anL8W1Rep0c1Grm6oFdaWI+eR6UIArDJ
	lmwGNmx7ds0qa0ai8IJW9jAnnY6dSTvil/t79mVpwKYhiAmFXWi2EHrEvG6/ROMq
	bYB6EA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5herb48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 08:28:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5075d3ee219so260440441cf.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 00:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772440122; x=1773044922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0E1UnYD6bQBqbuh4BJdzy0LpnAFFNel4eYuVziDnac=;
        b=MQKPeH6IiosGCX8tUaGzFh51i4Z3So3neklLhgwlKWA5J3O55bGzup6I6twO87HpYT
         VZQxRkDjwZ7up4fe9OJ9/M1BCQjAZl84RURKmzSYuXF9XSv5Kudw+3CGjNmrvZpA8v+e
         B2/5h8kzCzDJi7pJUWG8XzbBgKMLRovTKkNhwu1LwObmwQad//0hQ779GpZ/iL8hTqVP
         dfGIXbhy1+V5rdBx5snb0/SCZyIzMX4xxovjMpVGz7Xt9Sp8zl4DTiLeCPz+4G4JXiXr
         40aGYzsMCsA9cdUvayOj8Xwr1heT2LPEl875vWoL90QRXqZI6CSa3SXc63dbAzANBYFZ
         mQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772440122; x=1773044922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B0E1UnYD6bQBqbuh4BJdzy0LpnAFFNel4eYuVziDnac=;
        b=mpJIeL53lB+asSeJ4DB+bb9avbFSx+f4H54/12E4LUM8wc6bJRRxF6Y6DWDZjVJftU
         3eTNo5FgIYGphjK+hnQJvmIFB5DXkl3+UEOy4l9exkcyhmXuQrhqC2yHG0JkhBsZDFBP
         MwHgpP26XXRjj7utVlzRip7WGbCKNO85PZQncVp7sgz0DwIn7nc/pp2ULNLWDg3950f8
         em1fF4/uPFuDp/QdvVKKiZFaD+8DRf1H6iSGaY/CZyumXBtBOFuJji5sX0nfA2Ht9KgU
         jYC/icC5z2yo/7xpWjb81ePEN6mnRQ+pg80Awgh8jaf4qXotMFAVVoFj+fF3FhZRlQMR
         R1Og==
X-Forwarded-Encrypted: i=1; AJvYcCXIrT7GZx23cZuOFgCACEDlTZTLWwMNi9VBjDMNzB3UOhjddC9LQlVRi5MJLxh7wMU+TQeDEh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9GXtYAB+yLgG8OVzRsRfIS2vyU9fAg2rnl/uKl0J61Xadf54
	Exuqf2U7Dj2L+5jtOXimIu7ZxMM8Yhg2LB4qh2Y4bW0eIN0zJQrjOeRxGYt+zXuESq2tQ8VDabU
	hFQ0fzRhUIBik4X906VrKlM1W75ompGAL+evZtV42jDY3sat+s3tvG4DBSv4=
X-Gm-Gg: ATEYQzyT+O840jBCrTsjt6eigm16GMG4h7KmBzTenhYl6g9FV71hFkynmAEP31bq8ve
	uV14wh2F7W2r3DaKVQaJ/zFtFtnYfAGAneYUp0lmq6aYXp1HI1t6aQZ8I9EDapB146reqQfD5FT
	huLC7kucD9yDPZX9c9gNGqxhjNiVPWbaYuJFbH+hxhCzJ23gj442fpj8rYp3IqMgzcUCEiHUJ0P
	wADZOy9dS/rjAKoASP5UIzTY/W3rGyov8iEvg0j303hU5fqoBuuhqD5X9p2/ZKtf6YvKYZYV95L
	Nd0eO2WjL8AVWFVfwgAUQmHotji9UTG3t8qYbYRBtYpDhnqgQoQ/bG23Zm1DZo5pIAAeHd9i0dH
	pjGExBN1Ryf72L+eXd8qY68FgKQ7rZggSvykwyZrmn0pALo6yF3C6NsWKNXq0j9I0ZJdkWc2ONi
	pOxSsYPJk=
X-Received: by 2002:a05:622a:190f:b0:501:145f:dbf4 with SMTP id d75a77b69052e-5075297d4f6mr155949251cf.64.1772440122452;
        Mon, 02 Mar 2026 00:28:42 -0800 (PST)
X-Received: by 2002:a05:622a:190f:b0:501:145f:dbf4 with SMTP id d75a77b69052e-5075297d4f6mr155949111cf.64.1772440122039;
        Mon, 02 Mar 2026 00:28:42 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7193227sm101354696d6.21.2026.03.02.00.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:28:41 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:28:29 +0800
Subject: [PATCH v3 1/2] phy: qcom: edp: Add eDP/DP mode switch support
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-edp_phy-v3-1-ca8888d793b0@oss.qualcomm.com>
References: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
In-Reply-To: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772440115; l=8385;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=S2JW9nvnfu7j+y2B4VJo/pc6I2SO9Kjz/ltXVbvDAiw=;
 b=hYtAsZvh3OqA5KmQ2R8844BZr7OXifBB8PP0UO0YgAJ4iEtKbbA3tILbKuvfyDRmRvqrV6Stx
 iAUwJx1HZXYCOzzW53sLuMYf8CGbCIkOLP77CYF4FMAKf2nfcBdnkAp
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a54a3b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fAMMRUVWeN1gI5VMqOgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Ch2eBVvTjEIzzzmOBo9P_oRgeEqX4GhX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3MyBTYWx0ZWRfX6BQxBrx2EBWM
 yDhOw0q3kgW1kQAnwy4Esiy57kAGsph6GNWSbfLe00J6tcg+XzWdJTQdSeVkxSlIzZz7tqA5hyZ
 aOkkfGufgzGdoCrqsgEqsAi8pvDQzZ1E6EP83h+rdQZOafM1TPHK60inRd3kReRhwJhbzRzO17b
 zkJhOzubINqDArj124/FUIxT+JA23gMYzLDn+unyMeMezdhp6uFXS8iSomNcYGX3PFarjLHXJ1e
 pSMSze6K110LHgxwb43INDHPuvAqfxeHJZ5UVzMXBWo4RJAQJCg7jgHtH9+LoEDrrNiiRB45qUG
 pwwAOETJHaTwRESv+r0YrsVqHjVRos/QRWLRtbGGAuJ2G9Fkw4l7DkCfH40hqzkDJWssrcxreeK
 QToWS0n7rwTRps/G2gdSW6cjtQi1K7MImMLY2VHHlbPIs/Ogwvub+j8yh/kqX6E3ic+MYJqsW8h
 vHHF5OVLp2otbkod6GQ==
X-Proofpoint-ORIG-GUID: Ch2eBVvTjEIzzzmOBo9P_oRgeEqX4GhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
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
	TAGGED_FROM(0.00)[bounces-222542-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CD6C71D4A28
X-Rspamd-Action: no action

The eDP PHY supports both eDP&DP modes, each requires a different table.
The current driver doesn't fully support every combo PHY mode and use
either the eDP or DP table when enable the platform. In addition, some
platforms mismatch between the mode and the table where DP mode uses
the eDP table or eDP mode use the DP table.

Clean up and correct the tables for currently supported platforms based on
the HPG specification.

Here lists the tables can be reused across current platforms.
DP mode：
	-sa8775p/sc7280/sc8280xp/x1e80100
	-glymur
eDP mode(low vdiff):
	-glymur/sa8775p/sc8280xp/x1e80100
	-sc7280

Cc: stable@vger.kernel.org
Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 90 ++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 7372de05a0b8..36998326bae6 100644
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
 
@@ -116,17 +117,17 @@ struct qcom_edp {
 };
 
 static const u8 dp_swing_hbr_rbr[4][4] = {
-	{ 0x08, 0x0f, 0x16, 0x1f },
+	{ 0x07, 0x0f, 0x16, 0x1f },
 	{ 0x11, 0x1e, 0x1f, 0xff },
 	{ 0x16, 0x1f, 0xff, 0xff },
 	{ 0x1f, 0xff, 0xff, 0xff }
 };
 
 static const u8 dp_pre_emp_hbr_rbr[4][4] = {
-	{ 0x00, 0x0d, 0x14, 0x1a },
+	{ 0x00, 0x0e, 0x15, 0x1a },
 	{ 0x00, 0x0e, 0x15, 0xff },
 	{ 0x00, 0x0e, 0xff, 0xff },
-	{ 0x03, 0xff, 0xff, 0xff }
+	{ 0x04, 0xff, 0xff, 0xff }
 };
 
 static const u8 dp_swing_hbr2_hbr3[4][4] = {
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
@@ -158,7 +173,7 @@ static const u8 edp_swing_hbr_rbr[4][4] = {
 };
 
 static const u8 edp_pre_emp_hbr_rbr[4][4] = {
-	{ 0x05, 0x12, 0x17, 0x1d },
+	{ 0x05, 0x11, 0x17, 0x1d },
 	{ 0x05, 0x11, 0x18, 0xff },
 	{ 0x06, 0x11, 0xff, 0xff },
 	{ 0x00, 0xff, 0xff, 0xff }
@@ -172,10 +187,10 @@ static const u8 edp_swing_hbr2_hbr3[4][4] = {
 };
 
 static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
-	{ 0x08, 0x11, 0x17, 0x1b },
-	{ 0x00, 0x0c, 0x13, 0xff },
-	{ 0x05, 0x10, 0xff, 0xff },
-	{ 0x00, 0xff, 0xff, 0xff }
+	{ 0x0c, 0x15, 0x19, 0x1e },
+	{ 0x0b, 0x15, 0x19, 0xff },
+	{ 0x0e, 0x14, 0xff, 0xff },
+	{ 0x0d, 0xff, 0xff, 0xff }
 };
 
 static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
@@ -193,25 +208,25 @@ static const u8 edp_phy_vco_div_cfg_v4[4] = {
 	0x01, 0x01, 0x02, 0x00,
 };
 
-static const u8 edp_pre_emp_hbr_rbr_v5[4][4] = {
-	{ 0x05, 0x11, 0x17, 0x1d },
-	{ 0x05, 0x11, 0x18, 0xff },
-	{ 0x06, 0x11, 0xff, 0xff },
-	{ 0x00, 0xff, 0xff, 0xff }
+static const u8 edp_swing_hbr2_hbr3_v3[4][4] = {
+	{ 0x06, 0x11, 0x16, 0x1b },
+	{ 0x0b, 0x19, 0x1f, 0xff },
+	{ 0x18, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff }
 };
 
-static const u8 edp_pre_emp_hbr2_hbr3_v5[4][4] = {
+static const u8 edp_pre_emp_hbr2_hbr3_v3[4][4] = {
 	{ 0x0c, 0x15, 0x19, 0x1e },
-	{ 0x0b, 0x15, 0x19, 0xff },
-	{ 0x0e, 0x14, 0xff, 0xff },
+	{ 0x09, 0x14, 0x19, 0xff },
+	{ 0x0f, 0x14, 0xff, 0xff },
 	{ 0x0d, 0xff, 0xff, 0xff }
 };
 
-static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg_v5 = {
+static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg_v3 = {
 	.swing_hbr_rbr = &edp_swing_hbr_rbr,
-	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
-	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr_v5,
-	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3_v5,
+	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3_v3,
+	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr,
+	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3_v3,
 };
 
 static const u8 edp_phy_aux_cfg_v5[DP_AUX_CFG_SIZE] = {
@@ -262,12 +277,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	/*
-	 * TODO: Re-work the conditions around setting the cfg8 value
-	 * when more information becomes available about why this is
-	 * even needed.
-	 */
-	if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
+	if (!edp->is_edp)
 		aux_cfg[8] = 0xb7;
 
 	writel(0xfc, edp->edp + DP_PHY_MODE);
@@ -291,7 +301,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 
 static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
 {
-	const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->cfg->swing_pre_emph_cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
 	u8 ldo_config;
@@ -299,11 +309,10 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	u8 emph;
 	int i;
 
-	if (!cfg)
-		return 0;
-
 	if (edp->is_edp)
-		cfg = &edp_phy_swing_pre_emph_cfg;
+		cfg = edp->cfg->edp_swing_pre_emph_cfg;
+	else
+		cfg = edp->cfg->dp_swing_pre_emph_cfg;
 
 	for (i = 0; i < dp_opts->lanes; i++) {
 		v_level = max(v_level, dp_opts->voltage[i]);
@@ -564,20 +573,24 @@ static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
 	.is_edp = false,
 	.aux_cfg = edp_phy_aux_cfg_v5,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
 static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v3,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
 static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
@@ -585,7 +598,8 @@ static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
 	.is_edp = true,
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
@@ -766,7 +780,8 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v6,
 };
 
@@ -945,7 +960,8 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
 static struct qcom_edp_phy_cfg glymur_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v8,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v8,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v8,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v8,
 };
 

-- 
2.43.0


