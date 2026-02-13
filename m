Return-Path: <stable+bounces-216031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFeVMnTTjmnJFAEAu9opvQ
	(envelope-from <stable+bounces-216031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:32:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D23133944
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 423103013CB4
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA82B27057D;
	Fri, 13 Feb 2026 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVLB5vHx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2Yn+5Ll"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C192F3C10
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967915; cv=none; b=kbEZn8CXiucD5gkD/qdXcAMgg32HLwV5S7BOtw1sfJJ88K7P8Kp7Y+Xl7sqU+1kUQ2xam+IC3yz7bf4t9X1g9ogD2DqaivMwgy5lhXCdg2MVpCGkvKpwX70hJuOQN7h23gTviY6boO/AGiY0kk2mPt/xNrqZAFJNOIn2tx/kBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967915; c=relaxed/simple;
	bh=MMBXeitiZuY878Tcd7dZwXtn6YzjgtXAK6zo5LiGnbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzHpjwieRsGYbxEfou0lGNfEPhNBxIvSouXvFSIgOX18j6qZ3lEpNfT12pGsRwmv59IG0MZHHjVz3/TgAF+Pu6VEe2dMY0XpQXrX2EdjmEqmQNRPkvdmDPbMu9XjC7lMK9lrZkbk9sIFIZfu7Qa6HyfHLv37oC6p03QgmOHJxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVLB5vHx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O2Yn+5Ll; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D20tPi2691792
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XeRLOEGF763fWVcc6AlQsZ4UUThF/GMTjGHcT0L0/c0=; b=YVLB5vHxhW9WZ096
	U446gyAfYof9GZJ5X+DsjDkfUFrGbTeWU3yXqlaw4N+qCUoYhf3KnYwhrOl8U5bF
	pUAC6P36o4v8lk28n4sjsvkWAtcl2NmhwIrCDktifsmmvPjAbHEmZQpCx/xItgqB
	JeTFt6hfN2TCptNFjkAE/P/WuFf5XdBXB89WPwU9/9Axsi4ORhXxCDXGqs05AA14
	zKuwx0ojKxLCSQy8skbgCS2CsgWha/d0OYXGlh/GDB0ggh+7t6Mm/MnQkp9UDcgE
	rrTxdVO1MBTUjfSuhbTW7XnskEDKpMSkDnlaDsspvwc9uLs55tx9ygYhYnrO4DmU
	VM4N0Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9mb12b7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:31:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70d16d5a9so211957885a.3
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 23:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770967912; x=1771572712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeRLOEGF763fWVcc6AlQsZ4UUThF/GMTjGHcT0L0/c0=;
        b=O2Yn+5Ll6hfapVFWW5OFfZ+n9HpWsb8Ro4l6HN0hU9OeBaWqCM/P/tzjjG2hMpZfrP
         uj4F7kermGYbk69kxVSm7S77Tqxw1+bxpUZ7cOb36a+LNSyEwKniozTjGCEJKTShGiPf
         BffSzU+CD8FvN9olvvn4qYFXjDkdMKg/bv7xa097wwrl882MQeQZBncBfu0/vNom+cPQ
         ZTIuaGnf4ZcRLyT6n067ZJWxID0OR7Mh8vmNsTBocSnB5e8JlTeQRSGXH0/1CGEBXYLz
         GTg7DHdmW9gwQeSlgpzLM5Fjzxgum+mJyOb70A/x4k0vyd0hmJHgJGpsTR/0OkyT5MfJ
         9M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770967912; x=1771572712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XeRLOEGF763fWVcc6AlQsZ4UUThF/GMTjGHcT0L0/c0=;
        b=KuNy8Wr077190SrpBY4bTmy9JfrDgHz2kL0jh1cLC4yQkNUS73R4cCzosxycdiQlma
         DL3p9+VtFtXSyi84HF+6oSq13LlYIwkRi1XuY1gl1TNzKuqKXFjcwGuGLjFwheyvps4T
         0nEq5OqTFqp1pHA2h3M/+igcVYNWsmDJk+jj2Q+Y27ZOc0GPwcHfET2b08lu+fgGB+wc
         1bUGFjgfnqgo10s19VPioWVEelqDv+gdeNLSWfGvSsY5svD99UmNxgL0csjMqbIc5i8w
         yd7dHF9o1QXs0DnEMf/yJJjYJZ3gOzkpBdN1CKz9Idj0UDJtf4UK4F6246Y18aABwzVK
         JymQ==
X-Forwarded-Encrypted: i=1; AJvYcCULmXoYzFyv1U16G4D9vmZo/uSWPA+N54frCOYVIAyJshgD+ZJcw3Ex6uQP2daupCQ6dZUyPxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhEjppCmpVFxmeR9cMMUr6nrgGF3qEWqa2zz+N5+vxl7cvwfT
	iANhG3sN17M9WXkjM1NT7rJGHm7Puqolj1f8ofxW2onMZbwBCy2NibDdd942v96KsEKWS+v0shY
	Ec8XklKNkwW06f6d8yD+xKIipJ0Y1SqAuxViAW/pdhbZv2BqG7WKTwf7qerA=
X-Gm-Gg: AZuq6aKwcQueAnl6qdDIges0yYRcFwsnh85XfHtJUcByMFB6xsm4GOz0O3KBb8GgZCE
	9utTPmJZyGL8tZ+Szdy5P0bXowDHD2Bglfd3oD9MFJiGPBvq5lOK20jDCBHKTgj5lK5Nui61cVZ
	Y1NZb9NBNKdNbOXpa5IxDZ/OvaHGSVVLNyRpBVIGtNHMeoCwcsUC8fZMHoMUUAH15ZzMqMbp7Am
	iP/sm9MwtQ3g9aRp2vbDdnMo/wWcS3B0OEchNH5Hmq1nJP8aTc1Mkf9HAuddOz7st1xPlWpSubF
	RuF7mTcQq/ImgFKXNe4mwCbVbjORp2/FUE/A9N9Mq9tqlTegbCIHfjLWJtRc8DcDfJnaXRO8GH1
	SLJtQxMmBjV269CAf/9JAgSDoKAuaGAaJvo4AYLiLyiK9JGWvlljkfoenHsQAfBL0M26JmfULYt
	VGI5qCjtQ=
X-Received: by 2002:a05:620a:4809:b0:8c7:1b3c:8e8 with SMTP id af79cd13be357-8cb423c1ecamr101122885a.40.1770967912305;
        Thu, 12 Feb 2026 23:31:52 -0800 (PST)
X-Received: by 2002:a05:620a:4809:b0:8c7:1b3c:8e8 with SMTP id af79cd13be357-8cb423c1ecamr101121885a.40.1770967911743;
        Thu, 12 Feb 2026 23:31:51 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0bda6fsm541156485a.9.2026.02.12.23.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:31:51 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 13 Feb 2026 15:31:42 +0800
Subject: [PATCH v2 1/2] phy: qcom: edp: Add eDP/DP mode switch support
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260213-edp_phy-v2-1-43c40976435e@oss.qualcomm.com>
References: <20260213-edp_phy-v2-0-43c40976435e@oss.qualcomm.com>
In-Reply-To: <20260213-edp_phy-v2-0-43c40976435e@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770967906; l=8385;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=MMBXeitiZuY878Tcd7dZwXtn6YzjgtXAK6zo5LiGnbg=;
 b=qbTjOlraNg+3CjGW1D9kjHriy/TcD7Anng0ItMYgX6qqV0xIbxb5F3a2e6GNUYzm0SCuunh5p
 2dLRHweALrtBjiKlr3EOrE2pU0+suCf7t8lvH8vk9aVzxNyNIezgtN3
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA1NyBTYWx0ZWRfX/Wv1q38Nad2r
 iH9J18u++Ac8c4IdQb3ki6cfSC0KbAoPnMdltykvTinfXv4yNZ4X5YjHnXTTm2EV6KFxuWbRLdt
 eL3olFDFaKiq9uUTVdLNs3YsNn+KLcwqjD2ghps8XY5iKx/urO7kD7u3QR2g/T08IrUB4GalV/J
 k5vxj4hOvQZej8I2yHpV6+3wh3A9GfBhk3B+uWKAHANPEszfYXHyLTkLZX40kwKP223JEvjTkUk
 54mH6STIA4yH3YbtMCTu5/kZiqv9AOZ20OFynykLPEpZ+njDw6mxKAo37XKDHF6oc3i+aJk2r2G
 XcnsWss/suMMYqUeKEDVTZlWXQ8WihnxYJRaby2rOhO+/i4SsX3hdf/nD4hCoNXZefTuf8cRYbW
 Yw1ptTVgl3x/LsCm5mOzLBr/NuFMuIiVfGj3QLpMrsB0iKk1YihUdAchNcBMs9hTd7kI9knObeA
 nW0d4WM4g7kE7N/tjHQ==
X-Proofpoint-ORIG-GUID: tKnfoLAgCq5XR6s40QzIDYzmOC8alIST
X-Authority-Analysis: v=2.4 cv=asC/yCZV c=1 sm=1 tr=0 ts=698ed368 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fAMMRUVWeN1gI5VMqOgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: tKnfoLAgCq5XR6s40QzIDYzmOC8alIST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-216031-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 36D23133944
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
index 13feab99feec..ff14de41cb1c 100644
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
 
@@ -765,7 +779,8 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v6,
 };
 
@@ -944,7 +959,8 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
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


