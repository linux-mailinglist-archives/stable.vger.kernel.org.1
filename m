Return-Path: <stable+bounces-144816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323BEABBE9E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8C116C346
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419BD2777F9;
	Mon, 19 May 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g9Ulhnia"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012EDA55
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660149; cv=none; b=oVWYWrBGiufkaNUzrGhTdR09wSuLocqjxf0NcmY/3Po3J1HGveWJbI/vb6Aq8fIqO7jwSSSRY6ffyYV4C4m63OBThbaCsFRHH6bjbjNdweZ2IWyn13/XKZmVl7s0XU35kCkozOJ3ohdmtIGbQ+cIn2s1Gd5McJqrEcVxy+iItMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660149; c=relaxed/simple;
	bh=G9grg6ljgZXUJSG7v4nYI1BeDPo/n4ZmU2+X7n2TW/g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mzO/CFstqfFbv9VRAu9bYZwXKQekvuGK46CDdheGgyCDhjqeqOguw/lSP0OEJP1ihfNENPbJyk0WktQM4/POQkwLcdyGzb2sXYyz6RBoSwMPjbP8KUYT8F97aR6aF2SPw1uRGeGcR9Y5jlM9PA6gUBDd/HQAdq+/uZOoXlSyVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g9Ulhnia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45FCC4CEE4;
	Mon, 19 May 2025 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660148;
	bh=G9grg6ljgZXUJSG7v4nYI1BeDPo/n4ZmU2+X7n2TW/g=;
	h=Subject:To:Cc:From:Date:From;
	b=g9UlhniatReuLzxw6o879jreNWUlb81PXKYoBt83en+AR8rBsVcnkCj9sxIteNIdA
	 lUB+7FvoU1gKJWd+YdovuaCVnL89e/w83jfl6aTCTncJiFJWLnBBg706MiGpjxeXBX
	 9a8kfXUEWzRhoYPV/valRAFrOZC0EmwL4HDEiCJg=
Subject: FAILED: patch "[PATCH] net: dsa: microchip: let phylink manage PHY EEE configuration" failed to apply to 6.12-stable tree
To: o.rempel@pengutronix.de,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:09:04 +0200
Message-ID: <2025051904-lung-dreaded-8c5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 76ca05e0abe31a4f47a5b5a85041b5a22c03baf8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051904-lung-dreaded-8c5a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76ca05e0abe31a4f47a5b5a85041b5a22c03baf8 Mon Sep 17 00:00:00 2001
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Sun, 4 May 2025 10:14:33 +0200
Subject: [PATCH] net: dsa: microchip: let phylink manage PHY EEE configuration
 on KSZ switches

Phylink expects MAC drivers to provide LPI callbacks to properly manage
Energy Efficient Ethernet (EEE) configuration. On KSZ switches with
integrated PHYs, LPI is internally handled by hardware, while ports
without integrated PHYs have no documented MAC-level LPI support.

Provide dummy mac_disable_tx_lpi() and mac_enable_tx_lpi() callbacks to
satisfy phylink requirements. Also, set default EEE capabilities during
phylink initialization where applicable.

Since phylink can now gracefully handle optional EEE configuration,
remove the need for the MICREL_NO_EEE PHY flag.

This change addresses issues caused by incomplete EEE refactoring
introduced in commit fe0d4fd9285e ("net: phy: Keep track of EEE
configuration"). It is not easily possible to fix all older kernels, but
this patch ensures proper behavior on latest kernels and can be
considered for backporting to stable kernels starting from v6.14.

Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org # v6.14+
Link: https://patch.msgid.link/20250504081434.424489-2-o.rempel@pengutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 89f0796894af..f95a9aac56ee 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -265,16 +265,70 @@ static void ksz_phylink_mac_link_down(struct phylink_config *config,
 				      unsigned int mode,
 				      phy_interface_t interface);
 
+/**
+ * ksz_phylink_mac_disable_tx_lpi() - Callback to signal LPI support (Dummy)
+ * @config: phylink config structure
+ *
+ * This function is a dummy handler. See ksz_phylink_mac_enable_tx_lpi() for
+ * a detailed explanation of EEE/LPI handling in KSZ switches.
+ */
+static void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config)
+{
+}
+
+/**
+ * ksz_phylink_mac_enable_tx_lpi() - Callback to signal LPI support (Dummy)
+ * @config: phylink config structure
+ * @timer: timer value before entering LPI (unused)
+ * @tx_clock_stop: whether to stop the TX clock in LPI mode (unused)
+ *
+ * This function signals to phylink that the driver architecture supports
+ * LPI management, enabling phylink to control EEE advertisement during
+ * negotiation according to IEEE Std 802.3 (Clause 78).
+ *
+ * Hardware Management of EEE/LPI State:
+ * For KSZ switch ports with integrated PHYs (e.g., KSZ9893R ports 1-2),
+ * observation and testing suggest that the actual EEE / Low Power Idle (LPI)
+ * state transitions are managed autonomously by the hardware based on
+ * the auto-negotiation results. (Note: While the datasheet describes EEE
+ * operation based on negotiation, it doesn't explicitly detail the internal
+ * MAC/PHY interaction, so autonomous hardware management of the MAC state
+ * for LPI is inferred from observed behavior).
+ * This hardware control, consistent with the switch's ability to operate
+ * autonomously via strapping, means MAC-level software intervention is not
+ * required or exposed for managing the LPI state once EEE is negotiated.
+ * (Ref: KSZ9893R Data Sheet DS00002420D, primarily Section 4.7.5 explaining
+ * EEE, also Sections 4.1.7 on Auto-Negotiation and 3.2.1 on Configuration
+ * Straps).
+ *
+ * Additionally, ports configured as MAC interfaces (e.g., KSZ9893R port 3)
+ * lack documented MAC-level LPI control.
+ *
+ * Therefore, this callback performs no action and serves primarily to inform
+ * phylink of LPI awareness and to document the inferred hardware behavior.
+ *
+ * Returns: 0 (Always success)
+ */
+static int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+					 u32 timer, bool tx_clock_stop)
+{
+	return 0;
+}
+
 static const struct phylink_mac_ops ksz88x3_phylink_mac_ops = {
 	.mac_config	= ksz88x3_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz8_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
 static const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz8_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
 static const struct ksz_dev_ops ksz88xx_dev_ops = {
@@ -358,6 +412,8 @@ static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
 static const struct ksz_dev_ops ksz9477_dev_ops = {
@@ -401,6 +457,8 @@ static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
 static const struct ksz_dev_ops lan937x_dev_ops = {
@@ -2016,6 +2074,18 @@ static void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	if (dev->dev_ops->get_caps)
 		dev->dev_ops->get_caps(dev, port, config);
+
+	if (ds->ops->support_eee && ds->ops->support_eee(ds, port)) {
+		memcpy(config->lpi_interfaces, config->supported_interfaces,
+		       sizeof(config->lpi_interfaces));
+
+		config->lpi_capabilities = MAC_100FD;
+		if (dev->info->gbit_capable[port])
+			config->lpi_capabilities |= MAC_1000FD;
+
+		/* EEE is fully operational */
+		config->eee_enabled_default = true;
+	}
 }
 
 void ksz_r_mib_stats64(struct ksz_device *dev, int port)
@@ -3008,31 +3078,6 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 		if (!port)
 			return MICREL_KSZ8_P1_ERRATA;
 		break;
-	case KSZ8567_CHIP_ID:
-		/* KSZ8567R Errata DS80000752C Module 4 */
-	case KSZ8765_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8795_CHIP_ID:
-		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
-	case KSZ9477_CHIP_ID:
-		/* KSZ9477S Errata DS80000754A Module 4 */
-	case KSZ9567_CHIP_ID:
-		/* KSZ9567S Errata DS80000756A Module 4 */
-	case KSZ9896_CHIP_ID:
-		/* KSZ9896C Errata DS80000757A Module 3 */
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		/* KSZ9897R Errata DS80000758C Module 4 */
-		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
-		 *   The EEE feature is enabled by default, but it is not fully
-		 *   operational. It must be manually disabled through register
-		 *   controls. If not disabled, the PHY ports can auto-negotiate
-		 *   to enable EEE, and this feature can cause link drops when
-		 *   linked to another device supporting EEE.
-		 *
-		 * The same item appears in the errata for all switches above.
-		 */
-		return MICREL_NO_EEE;
 	}
 
 	return 0;
@@ -3466,6 +3511,20 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ksz_support_eee - Determine Energy Efficient Ethernet (EEE) support for a
+ *                   port
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number to check
+ *
+ * This function also documents devices where EEE was initially advertised but
+ * later withdrawn due to reliability issues, as described in official errata
+ * documents. These devices are explicitly listed to record known limitations,
+ * even if there is no technical necessity for runtime checks.
+ *
+ * Returns: true if the internal PHY on the given port supports fully
+ * operational EEE, false otherwise.
+ */
 static bool ksz_support_eee(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
@@ -3475,15 +3534,35 @@ static bool ksz_support_eee(struct dsa_switch *ds, int port)
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
-	case KSZ8567_CHIP_ID:
-	case KSZ9477_CHIP_ID:
 	case KSZ9563_CHIP_ID:
-	case KSZ9567_CHIP_ID:
 	case KSZ9893_CHIP_ID:
+		return true;
+	case KSZ8567_CHIP_ID:
+		/* KSZ8567R Errata DS80000752C Module 4 */
+	case KSZ8765_CHIP_ID:
+	case KSZ8794_CHIP_ID:
+	case KSZ8795_CHIP_ID:
+		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
+	case KSZ9477_CHIP_ID:
+		/* KSZ9477S Errata DS80000754A Module 4 */
+	case KSZ9567_CHIP_ID:
+		/* KSZ9567S Errata DS80000756A Module 4 */
 	case KSZ9896_CHIP_ID:
+		/* KSZ9896C Errata DS80000757A Module 3 */
 	case KSZ9897_CHIP_ID:
 	case LAN9646_CHIP_ID:
-		return true;
+		/* KSZ9897R Errata DS80000758C Module 4 */
+		/* Energy Efficient Ethernet (EEE) feature select must be
+		 * manually disabled
+		 *   The EEE feature is enabled by default, but it is not fully
+		 *   operational. It must be manually disabled through register
+		 *   controls. If not disabled, the PHY ports can auto-negotiate
+		 *   to enable EEE, and this feature can cause link drops when
+		 *   linked to another device supporting EEE.
+		 *
+		 * The same item appears in the errata for all switches above.
+		 */
+		break;
 	}
 
 	return false;


