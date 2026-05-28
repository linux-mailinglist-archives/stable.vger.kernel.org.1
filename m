Return-Path: <stable+bounces-254880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uALBKb0qGGpafAgAu9opvQ
	(envelope-from <stable+bounces-254880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:45:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B815F1785
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2306D30091FB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D2F3DDDD4;
	Thu, 28 May 2026 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGudMPRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EB3E51F5
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968695; cv=none; b=iuXkiAPmhSupOzcoq96fSeRx7Zv4ujKsP1TBE96KHVoQIw2dRUCYNQ965ffJDRnl0+eFhVro4Fqv0IG4QRSnP8DKupxQDVTva0IzDkX4H/4lnfwzKnO0m/fQUVdqaBq681e8lzHGhBouFrHCRl7wJ1tc/oSiF5JzGTfDrQsi6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968695; c=relaxed/simple;
	bh=S8vqqEXvCsseNVuJxw18A695sSy5p8URLkCE9P4FcL0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sXrx2IPUfi6+ly7oksspowDNny2ZDzqopDNpcBujTcvo9bmmZsfWqYIu5921yIfEWf+Nx9pXO6ERQ0TYNxoEF2meAj+B1OeKRozbxzajvBw+fEeuS0P9rjUfC8Cg5vFAcjzOwSqy3gu+K2W/FC1bCMYR4Rycsfgph5Q95r577q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGudMPRb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F521F000E9;
	Thu, 28 May 2026 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968694;
	bh=L1Q7KXiIy8lMXcd+CXAQ1/srUkHY3Qp98OQipGx16uY=;
	h=Subject:To:Cc:From:Date;
	b=dGudMPRbwoURGuO1riQF2MRs7SlECY6PG4qy2+lIl/StuHpkQEP1VddU90Uda5xst
	 J5XqczPJwUAIMmL3XnxdhXdGKs8IK9+GNEwor9a3tRdaE5qFwmG9ZsUYrK8D+URl/t
	 PAMpvnRAW1Mk+SBEj5+kZQ7ieDzIkRKdBbOwpDTI=
Subject: FAILED: patch "[PATCH] phy: qcom: edp: Unify generic DP/eDP swing and pre-emphasis" failed to apply to 6.12-stable tree
To: yongxing.mou@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:43:53 +0200
Message-ID: <2026052853-nanometer-lavish-2518@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254880-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,linuxfoundation.org:dkim,gregkh:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B2B815F1785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fd672888cccd6b855154efe0ac78e7ce3e8ab088
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052853-nanometer-lavish-2518@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd672888cccd6b855154efe0ac78e7ce3e8ab088 Mon Sep 17 00:00:00 2001
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:35:19 +0800
Subject: [PATCH] phy: qcom: edp: Unify generic DP/eDP swing and pre-emphasis
 tables
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 7372de05a0b8..2af3fd63832f 100644
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
@@ -158,7 +158,7 @@ static const u8 edp_swing_hbr_rbr[4][4] = {
 };
 
 static const u8 edp_pre_emp_hbr_rbr[4][4] = {
-	{ 0x05, 0x12, 0x17, 0x1d },
+	{ 0x05, 0x11, 0x17, 0x1d },
 	{ 0x05, 0x11, 0x18, 0xff },
 	{ 0x06, 0x11, 0xff, 0xff },
 	{ 0x00, 0xff, 0xff, 0xff }
@@ -172,10 +172,10 @@ static const u8 edp_swing_hbr2_hbr3[4][4] = {
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
@@ -193,27 +193,6 @@ static const u8 edp_phy_vco_div_cfg_v4[4] = {
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
@@ -564,7 +543,7 @@ static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
 	.is_edp = false,
 	.aux_cfg = edp_phy_aux_cfg_v5,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
@@ -945,7 +924,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
 static struct qcom_edp_phy_cfg glymur_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v8,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v8,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v8,
 };
 


