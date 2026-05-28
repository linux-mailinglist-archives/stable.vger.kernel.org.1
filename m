Return-Path: <stable+bounces-255209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MGNJHGeGGpblggAu9opvQ
	(envelope-from <stable+bounces-255209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 137405F790A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE6793011076
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293AA33CE8A;
	Thu, 28 May 2026 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uhbz1uil"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9732BF5D;
	Thu, 28 May 2026 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998268; cv=none; b=M+dLnjgeU/1kzdO4jT5OpFKNW73qPzNh4IC8uTp5PlT4DdY+A5bOtW71OsBjQEoweSqP8Z4VWXxxM6PEC+R5RdtWOvT6Ws3DY/wDT0S+2h9FXazfa6OdTR7dHwNkxRjl+PihMwVecAYG+USdfjTEim/fy2X+9Qrz+hSN5S2kB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998268; c=relaxed/simple;
	bh=mrdtmihHf3EKknnqDsVvO81P6GUHy5PPptH/rjAf7Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drpu56Opjvf/ymHtkWbNIF81WEzUaltu9pZNgqbVL7uSvVnI0lDUB+Pu3B/rqejaEF6IfKhGa57bYgW0FKLtg7Cgbn44WNvb8hejHL/i35aCjUgHBUt/6ylpyKmjZTqSz7eTaqldY9yRqL2rjuvMCm/0sNsxweUlOaH22z3q+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uhbz1uil; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507761F000E9;
	Thu, 28 May 2026 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998266;
	bh=7Xm7CpKGyVpu2eMNtJH1osXdtlszC9q4YOdKRlxr35s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uhbz1uilrHEUoKrQRwCl75jekip2WS1ZVNSnlRqY5UVQmZpewmjJmNTRIAZVcgCFU
	 WO7u/iT2x45AE7GVh/NvzsDudW2ukKxFL2dEg8a4nSK8da8Yk/cbWEK19V7zfa+UCT
	 tmRJNMID47RxvDtRB3xvNb4x89KEbinH/Hk7BY9o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 7.0 112/461] phy: qcom: edp: Unify generic DP/eDP swing and pre-emphasis tables
Date: Thu, 28 May 2026 21:44:01 +0200
Message-ID: <20260528194650.212375273@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255209-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 137405F790A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

commit fd672888cccd6b855154efe0ac78e7ce3e8ab088 upstream.

The current eDP and DP swing/pre-emphasis tables do not match the HPG
requirements for the supported platforms, correct the table accordingly.

The generic tables which can be shared as follows:

DP mode：
	-sa8775p/sc7280/sc8280xp/x1e80100
	-glymur
	-sc8180x
eDP mode(low vdiff):
	-glymur/sa8775p/sc8280xp/x1e80100
	-sc7280
	-sc8180x

The proper tables for SC8180X and SC7280 will be added in a later patch,
since they need separate table.

Cc: stable@vger.kernel.org
Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Link: https://patch.msgid.link/20260427-edp_phy-v5-1-3bb876824475@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c |   41 ++++++++----------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -116,17 +116,17 @@ struct qcom_edp {
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
@@ -158,7 +158,7 @@ static const u8 edp_swing_hbr_rbr[4][4]
 };
 
 static const u8 edp_pre_emp_hbr_rbr[4][4] = {
-	{ 0x05, 0x12, 0x17, 0x1d },
+	{ 0x05, 0x11, 0x17, 0x1d },
 	{ 0x05, 0x11, 0x18, 0xff },
 	{ 0x06, 0x11, 0xff, 0xff },
 	{ 0x00, 0xff, 0xff, 0xff }
@@ -172,10 +172,10 @@ static const u8 edp_swing_hbr2_hbr3[4][4
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
@@ -193,27 +193,6 @@ static const u8 edp_phy_vco_div_cfg_v4[4
 	0x01, 0x01, 0x02, 0x00,
 };
 
-static const u8 edp_pre_emp_hbr_rbr_v5[4][4] = {
-	{ 0x05, 0x11, 0x17, 0x1d },
-	{ 0x05, 0x11, 0x18, 0xff },
-	{ 0x06, 0x11, 0xff, 0xff },
-	{ 0x00, 0xff, 0xff, 0xff }
-};
-
-static const u8 edp_pre_emp_hbr2_hbr3_v5[4][4] = {
-	{ 0x0c, 0x15, 0x19, 0x1e },
-	{ 0x0b, 0x15, 0x19, 0xff },
-	{ 0x0e, 0x14, 0xff, 0xff },
-	{ 0x0d, 0xff, 0xff, 0xff }
-};
-
-static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg_v5 = {
-	.swing_hbr_rbr = &edp_swing_hbr_rbr,
-	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
-	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr_v5,
-	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3_v5,
-};
-
 static const u8 edp_phy_aux_cfg_v5[DP_AUX_CFG_SIZE] = {
 	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03, 0x02, 0x02, 0x00,
 };
@@ -564,7 +543,7 @@ static const struct qcom_edp_phy_cfg sa8
 	.is_edp = false,
 	.aux_cfg = edp_phy_aux_cfg_v5,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
@@ -945,7 +924,7 @@ static const struct phy_ver_ops qcom_edp
 static struct qcom_edp_phy_cfg glymur_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v8,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v8,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v8,
 };
 



