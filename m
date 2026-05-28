Return-Path: <stable+bounces-254888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E+MB0UsGGqwfAgAu9opvQ
	(envelope-from <stable+bounces-254888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:51:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A4D5F1936
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B95C317B739
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30443E315F;
	Thu, 28 May 2026 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZPnOZsHo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF003E1691
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968738; cv=none; b=arkzuuNvq/kvH2m3ny5yFABZOMgj2MadDScjVuXwRqvexAhsahu+GNzIyzZ8Tz1I/CJdecqaxwZWMShU2vXi+L6OaZhxG6eu4fMlpM7YX8mVzgu3vJvxV+EcV+TPIJdpcukuKXTGX1jFl7toY/PTVVDgR4Bhl/ooxDLCOVqh6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968738; c=relaxed/simple;
	bh=KMPJQ4J/TdtTg23qW1iiHGcBAGoPx6UhQBpEA1kvtmg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dV6YVv+VfbldhdNm/CfSOEZ1eWyb0j3hO3NKXopHFsbcxLCift/MideW185+ryBLrVgUaNXNiSUOaDfpxEP38JCp5kD6labLIZiylESvJNnjwBIjZ/O6Tydqjs+OspPBxoD7H/824IHwntVOAXquAKxlY+26XK5vSNKUx+Shyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZPnOZsHo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0C91F000E9;
	Thu, 28 May 2026 11:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968736;
	bh=FNAFPpSlSNJier6ubIguR/1EYeKhDPNaekcNsBXFgis=;
	h=Subject:To:Cc:From:Date;
	b=ZPnOZsHojmCtRx/5Jj3dpgJJ41R7btPVdL+AlkdoXntPDGLG6Vf1Yvts3+X4qe+f8
	 YUwxQKtIgIoz5GDHZ1Io3UwYR0LC1jok5u25LEoE9boMoF7XD7EFVw7OHTXX5xxT3t
	 yiavkb78yNUm9dBivYiRv3cJjqyxEdYyD5eFqWVA=
Subject: FAILED: patch "[PATCH] phy: qcom: edp: Add PHY-specific LDO config for eDP low vdiff" failed to apply to 6.6-stable tree
To: yongxing.mou@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:44:36 +0200
Message-ID: <2026052836-clone-mockup-afba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254888-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email,msgid.link:url,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 78A4D5F1936
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 519a228ee40d1be3453d1da339b4577c3785e333
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052836-clone-mockup-afba@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 519a228ee40d1be3453d1da339b4577c3785e333 Mon Sep 17 00:00:00 2001
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:35:23 +0800
Subject: [PATCH] phy: qcom: edp: Add PHY-specific LDO config for eDP low vdiff

For eDP low vdiff, the LDO setting depends on the PHY version rather
than being a simple 0x0 or 0x1 value. Introduce a PHY callback to program
the correct LDO setting according to the HPG.

Since SC7280/SC8180X uses different LDO settings from SA8775P/SC8280XP,
introduce qcom_edp_phy_ops_v3 to keep the LDO setting correct.

Cc: stable@vger.kernel.org
Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # SC8280XP X13s
Link: https://patch.msgid.link/20260427-edp_phy-v5-5-3bb876824475@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 3a848f18a8d6..a3c893f72908 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -81,6 +81,7 @@ struct phy_ver_ops {
 	int (*com_clk_fwd_cfg)(const struct qcom_edp *edp);
 	int (*com_configure_pll)(const struct qcom_edp *edp);
 	int (*com_configure_ssc)(const struct qcom_edp *edp);
+	int (*com_ldo_config)(const struct qcom_edp *edp);
 };
 
 struct qcom_edp_phy_cfg {
@@ -352,7 +353,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	const struct qcom_edp_swing_pre_emph_cfg *cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
-	u8 ldo_config;
+	int ret;
 	u8 swing;
 	u8 emph;
 	int i;
@@ -378,13 +379,13 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
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
 
@@ -608,6 +609,52 @@ static int qcom_edp_com_configure_pll_v4(const struct qcom_edp *edp)
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
@@ -615,6 +662,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v4,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v4,
+	.com_ldo_config		= qcom_edp_ldo_config_v4,
 };
 
 static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
@@ -631,7 +679,7 @@ static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v3,
-	.ver_ops = &qcom_edp_phy_ops_v4,
+	.ver_ops = &qcom_edp_phy_ops_v3,
 };
 
 static const struct qcom_edp_phy_cfg sc8180x_dp_phy_cfg = {
@@ -639,7 +687,7 @@ static const struct qcom_edp_phy_cfg sc8180x_dp_phy_cfg = {
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
 	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v2,
 	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v2,
-	.ver_ops = &qcom_edp_phy_ops_v4,
+	.ver_ops = &qcom_edp_phy_ops_v3,
 };
 
 static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
@@ -824,6 +872,24 @@ static int qcom_edp_com_configure_pll_v6(const struct qcom_edp *edp)
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
@@ -831,6 +897,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v4,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v6,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v6,
+	.com_ldo_config		= qcom_edp_ldo_config_v6,
 };
 
 static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
@@ -1011,6 +1078,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
 	.com_clk_fwd_cfg	= qcom_edp_com_clk_fwd_cfg_v8,
 	.com_configure_pll	= qcom_edp_com_configure_pll_v8,
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v8,
+	.com_ldo_config		= qcom_edp_ldo_config_v6,
 };
 
 static struct qcom_edp_phy_cfg glymur_phy_cfg = {
@@ -1026,7 +1094,6 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	unsigned long pixel_freq;
-	u8 ldo_config = 0x0;
 	int ret;
 	u32 val;
 	u8 cfg1;
@@ -1035,11 +1102,10 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	if (edp->cfg->edp_swing_pre_emph_cfg && !edp->is_edp)
-		ldo_config = 0x1;
+	ret = edp->cfg->ver_ops->com_ldo_config(edp);
+	if (ret)
+		return ret;
 
-	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
-	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
 	writel(0x00, edp->tx0 + TXn_LANE_MODE_1);
 	writel(0x00, edp->tx1 + TXn_LANE_MODE_1);
 


