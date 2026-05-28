Return-Path: <stable+bounces-254877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TSCfCP0rGGoHfQgAu9opvQ
	(envelope-from <stable+bounces-254877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:50:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 764975F18CD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB993178098
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E53E5A20;
	Thu, 28 May 2026 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtZrhlS1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3093BBA07
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968669; cv=none; b=azhI0SfAZIiGFYxoRX/5tU8jaykoDLubg/d7+HuqV3PH3v6V0337NuZBRgaL9sta6pyAe5NCI5aTReXFUzOvOPQYYvKCSdh/JPNXnausOE9RcqZlmSdocEjuyPjCKJGk/8uItAkadRvycR64xNQxVfAbMpQ68mprxXRJNaeLPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968669; c=relaxed/simple;
	bh=k0c9kJNvfbmIEeeFGx/IxbUMydyINAF3HRttnkgyi8g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KzdfyVsaQKlZSsk47dqxw3pWz4NP23h53/O9TxGdYGFeXKKb1G8RNtQloWCqsQjpLbvu9LCx79LzvOJfmBhqCiCVwlb4z/asVbnJjdo02rcTswGYc7zaJtW3svHFM3Mvn+i1TvtinCbJpyInuAEQVFeSnbCIjiSU2ZyuvHXerS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtZrhlS1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEB71F000E9;
	Thu, 28 May 2026 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968667;
	bh=jJHYC1U2+kaXT1yUuGlNsaB1SE5ac9URILXf+h2QgnA=;
	h=Subject:To:Cc:From:Date;
	b=gtZrhlS1I+FIB2xDpWrsChlLgk7roFCgG7ozfpwIrkS10xTdkQzc2RgNpHmF6rsjr
	 FGmPpEc6wKl9wT3K1MtYHDXKrVOa9+9T8/znYluvvENn/muPnJ3z8OQdOOuSCsCszk
	 gPzdPLjhHYKjIULLSFYRaDlcDYF295/+zNASawBg=
Subject: FAILED: patch "[PATCH] phy: tegra: xusb: Fix per-pad high-speed termination" failed to apply to 5.10-stable tree
To: waynec@nvidia.com,jonathanh@nvidia.com,vkoul@kernel.org,weichengc@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:43:24 +0200
Message-ID: <2026052824-womankind-colonize-b053@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254877-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email,msgid.link:url,nvidia.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 764975F18CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x da110228b54f2e2143d97ea7151e0dc22e539d67
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052824-womankind-colonize-b053@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da110228b54f2e2143d97ea7151e0dc22e539d67 Mon Sep 17 00:00:00 2001
From: Wayne Chang <waynec@nvidia.com>
Date: Mon, 4 May 2026 11:33:05 +0800
Subject: [PATCH] phy: tegra: xusb: Fix per-pad high-speed termination
 calibration

The existing code reads a single hs_term_range_adj value from bit field
[10:7] of FUSE_SKU_CALIB_0 and applies it to all USB2 pads uniformly.
However, on SoCs that support per-pad termination, each pad has its own
hs_term_range_adj field: pad 0 in FUSE_SKU_CALIB_0[10:7], and pads 1-3
in FUSE_USB_CALIB_EXT_0 at bit offsets [8:5], [12:9], and [16:13]
respectively.

Fix the calibration by reading per-pad values from the appropriate fuse
registers. For SoCs that do not support per-pad termination, replicate
pad 0's value to all pads to maintain existing behavior.

Add a has_per_pad_term flag to the SoC data to indicate whether per-pad
termination values are available in FUSE_USB_CALIB_EXT_0.

Fixes: 1ef535c6ba8e ("phy: tegra: xusb: Add Tegra194 support")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260504033305.2283145-1-weichengc@nvidia.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 1ddf11265974..60156aea2707 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -20,8 +20,8 @@
 /* FUSE USB_CALIB registers */
 #define HS_CURR_LEVEL_PADX_SHIFT(x)	((x) ? (11 + (x - 1) * 6) : 0)
 #define HS_CURR_LEVEL_PAD_MASK		0x3f
-#define HS_TERM_RANGE_ADJ_SHIFT		7
-#define HS_TERM_RANGE_ADJ_MASK		0xf
+#define HS_TERM_RANGE_ADJ_PADX_SHIFT(x)	((x) ? (5 + (x - 1) * 4) : 7)
+#define HS_TERM_RANGE_ADJ_PAD_MASK	0xf
 #define HS_SQUELCH_SHIFT		29
 #define HS_SQUELCH_MASK			0x7
 
@@ -253,7 +253,7 @@
 struct tegra_xusb_fuse_calibration {
 	u32 *hs_curr_level;
 	u32 hs_squelch;
-	u32 hs_term_range_adj;
+	u32 *hs_term_range_adj;
 	u32 rpd_ctrl;
 };
 
@@ -930,7 +930,7 @@ static int tegra186_utmi_phy_power_on(struct phy *phy)
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 	value &= ~TERM_RANGE_ADJ(~0);
-	value |= TERM_RANGE_ADJ(priv->calib.hs_term_range_adj);
+	value |= TERM_RANGE_ADJ(priv->calib.hs_term_range_adj[index]);
 	value &= ~RPD_CTRL(~0);
 	value |= RPD_CTRL(priv->calib.rpd_ctrl);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
@@ -1464,17 +1464,23 @@ static const char * const tegra186_usb3_functions[] = {
 static int
 tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 {
+	const struct tegra_xusb_padctl_soc *soc = padctl->base.soc;
 	struct device *dev = padctl->base.dev;
 	unsigned int i, count;
 	u32 value, *level;
+	u32 *hs_term_range_adj;
 	int err;
 
-	count = padctl->base.soc->ports.usb2.count;
+	count = soc->ports.usb2.count;
 
 	level = devm_kcalloc(dev, count, sizeof(u32), GFP_KERNEL);
 	if (!level)
 		return -ENOMEM;
 
+	hs_term_range_adj = devm_kcalloc(dev, count, sizeof(u32), GFP_KERNEL);
+	if (!hs_term_range_adj)
+		return -ENOMEM;
+
 	err = tegra_fuse_readl(TEGRA_FUSE_SKU_CALIB_0, &value);
 	if (err)
 		return dev_err_probe(dev, err,
@@ -1490,8 +1496,8 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 
 	padctl->calib.hs_squelch = (value >> HS_SQUELCH_SHIFT) &
 					HS_SQUELCH_MASK;
-	padctl->calib.hs_term_range_adj = (value >> HS_TERM_RANGE_ADJ_SHIFT) &
-						HS_TERM_RANGE_ADJ_MASK;
+	hs_term_range_adj[0] = (value >> HS_TERM_RANGE_ADJ_PADX_SHIFT(0)) &
+				HS_TERM_RANGE_ADJ_PAD_MASK;
 
 	err = tegra_fuse_readl(TEGRA_FUSE_USB_CALIB_EXT_0, &value);
 	if (err) {
@@ -1503,6 +1509,17 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 
 	padctl->calib.rpd_ctrl = (value >> RPD_CTRL_SHIFT) & RPD_CTRL_MASK;
 
+	for (i = 1; i < count; i++) {
+		if (soc->has_per_pad_term)
+			hs_term_range_adj[i] =
+				(value >> HS_TERM_RANGE_ADJ_PADX_SHIFT(i)) &
+				HS_TERM_RANGE_ADJ_PAD_MASK;
+		else
+			hs_term_range_adj[i] = hs_term_range_adj[0];
+	}
+
+	padctl->calib.hs_term_range_adj = hs_term_range_adj;
+
 	return 0;
 }
 
@@ -1708,6 +1725,7 @@ const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc = {
 	.num_supplies = ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
 	.supports_gen2 = true,
 	.poll_trk_completed = true,
+	.has_per_pad_term = true,
 };
 EXPORT_SYMBOL_GPL(tegra194_xusb_padctl_soc);
 
@@ -1732,6 +1750,7 @@ const struct tegra_xusb_padctl_soc tegra234_xusb_padctl_soc = {
 	.trk_hw_mode = false,
 	.trk_update_on_idle = true,
 	.supports_lp_cfg_en = true,
+	.has_per_pad_term = true,
 };
 EXPORT_SYMBOL_GPL(tegra234_xusb_padctl_soc);
 #endif
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index cd277d0ed9e1..77609e54de66 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -435,6 +435,7 @@ struct tegra_xusb_padctl_soc {
 	bool trk_hw_mode;
 	bool trk_update_on_idle;
 	bool supports_lp_cfg_en;
+	bool has_per_pad_term;
 };
 
 struct tegra_xusb_padctl {


