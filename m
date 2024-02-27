Return-Path: <stable+bounces-24839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEFC86967B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1871D1F2E4F8
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C732513AA4C;
	Tue, 27 Feb 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXSw59Ba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF978B61;
	Tue, 27 Feb 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043129; cv=none; b=nMOFvMOpieww9xi6dBhcsFsNr8mICXou8LxRoGx0rrPOEYGLYZEpwWb2Jg2ExMweEr/l8I6b4MAAmvQAtiWrEDhSohXsC1S0QHJ3LdwYW/PW6Wq0UbS3RKrFHC2Ux3FjvKvEFp15pFavNvj8ffCAgJ6cTcgvN0W0mDE3JDvDkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043129; c=relaxed/simple;
	bh=t9HGQ4OPz+njZTA84HJB9eKw1D8cdWcy0FFQkpTXNYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvN6lEsHd9gIosd1pOVGUS9Lk7zNm9QGBEzg+XyfEZCTeDuFWPymVLWiO0KpFo2vlIVtsZsxbbkfHwsxpxtrhm2XdPIB2/UIg1IwnauXXmPo0XgeinuQEVmiCjdumBLoD3/VyOgQE6d1813434SSlF3m7e2qY8RjewDVyCI8m64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXSw59Ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AC8C433F1;
	Tue, 27 Feb 2024 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043129;
	bh=t9HGQ4OPz+njZTA84HJB9eKw1D8cdWcy0FFQkpTXNYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXSw59BapcYNOuFuFEQt3epz/PkRQn8ggBQS89ZX3UOrEUzPB6khcUjfAg9yrU1Q8
	 5gc2xJ5PcNe83U9EdIJpUDjQOaR19eUK97Aeq0CTw8gFzdKvpleKXabwN1x6xqfpGd
	 BAYpDyg7vXwbu0keq6hSACt5rnURf9RZCmFMQjkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 217/245] ata: libahci_platform: Convert to using devm bulk clocks API
Date: Tue, 27 Feb 2024 14:26:45 +0100
Message-ID: <20240227131622.255840757@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

[ Upstream commit e28b3abf8020a884bd3b7758ea8915365af8fadf ]

In order to simplify the clock-related code there is a way to convert the
current fixed clocks array into using the common bulk clocks kernel API
with dynamic set of the clock handlers and device-managed clock-resource
tracking. It's a bit tricky due to the complication coming from the
requirement to support the platforms (da850, spear13xx) with the
non-OF-based clock source, but still doable.

Before this modification there are two methods have been used to get the
clocks connected to an AHCI device: clk_get() - to get the very first
clock in the list and of_clk_get() - to get the rest of them. Basically
the platforms with non-OF-based clocks definition could specify only a
single reference clock source. The platforms with OF-hw clocks have been
luckier and could setup up to AHCI_MAX_CLKS clocks. Such semantic can be
retained with using devm_clk_bulk_get_all() to retrieve the clocks defined
via the DT firmware and devm_clk_get_optional() otherwise. In both cases
using the device-managed version of the methods will cause the automatic
resources deallocation on the AHCI device removal event. The only
complicated part in the suggested approach is the explicit allocation and
initialization of the clk_bulk_data structure instance for the non-OF
reference clocks. It's required in order to use the Bulk Clocks API for
the both denoted cases of the clocks definition.

Note aside with the clock-related code reduction and natural
simplification, there are several bonuses the suggested modification
provides. First of all the limitation of having no greater than
AHCI_MAX_CLKS clocks is now removed, since the devm_clk_bulk_get_all()
method will allocate as many reference clocks data descriptors as there
are clocks specified for the device. Secondly the clock names are
auto-detected. So the LLDD (glue) drivers can make sure that the required
clocks are specified just by checking the clock IDs in the clk_bulk_data
array.  Thirdly using the handy Bulk Clocks kernel API improves the
clocks-handling code readability. And the last but not least this
modification implements a true optional clocks support to the
ahci_platform_get_resources() method. Indeed the previous clocks getting
procedure just stopped getting the clocks on any errors (aside from
non-critical -EPROBE_DEFER) in a way so the callee wasn't even informed
about abnormal loop termination. The new implementation lacks of such
problem. The ahci_platform_get_resources() will return an error code if
the corresponding clocks getting method ends execution abnormally.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Stable-dep-of: 26c8404e162b ("ata: ahci_ceva: fix error handling for Xilinx GT PHY support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.h             |  4 +-
 drivers/ata/ahci_da850.c       | 47 ++++++++-----------
 drivers/ata/ahci_dm816.c       |  4 +-
 drivers/ata/libahci_platform.c | 83 ++++++++++++++++------------------
 4 files changed, 61 insertions(+), 77 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 69557e602e2ea..54e79f966444c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -39,7 +39,6 @@
 
 enum {
 	AHCI_MAX_PORTS		= 32,
-	AHCI_MAX_CLKS		= 5,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_MAX_CMDS		= 32,
@@ -343,7 +342,8 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	u32			remapped_nvme;	/* NVMe remapped device count */
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
-	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
+	unsigned int		n_clks;
+	struct clk_bulk_data	*clks;		/* Optional */
 	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 0e82766007128..389268c1ef456 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -163,7 +163,6 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	void __iomem *pwrdn_reg;
 	struct resource *res;
-	struct clk *clk;
 	u32 mpy;
 	int rc;
 
@@ -172,36 +171,28 @@ static int ahci_da850_probe(struct platform_device *pdev)
 		return PTR_ERR(hpriv);
 
 	/*
-	 * Internally ahci_platform_get_resources() calls clk_get(dev, NULL)
-	 * when trying to obtain the functional clock. This SATA controller
-	 * uses two clocks for which we specify two connection ids. If we don't
-	 * have the functional clock at this point - call clk_get() again with
-	 * con_id = "fck".
+	 * Internally ahci_platform_get_resources() calls the bulk clocks
+	 * get method or falls back to using a single clk_get_optional().
+	 * This AHCI SATA controller uses two clocks: functional clock
+	 * with "fck" connection id and external reference clock with
+	 * "refclk" id. If we haven't got all of them re-try the clocks
+	 * getting procedure with the explicitly specified ids.
 	 */
-	if (!hpriv->clks[0]) {
-		clk = clk_get(dev, "fck");
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-
-		hpriv->clks[0] = clk;
-	}
-
-	/*
-	 * The second clock used by ahci-da850 is the external REFCLK. If we
-	 * didn't get it from ahci_platform_get_resources(), let's try to
-	 * specify the con_id in clk_get().
-	 */
-	if (!hpriv->clks[1]) {
-		clk = clk_get(dev, "refclk");
-		if (IS_ERR(clk)) {
-			dev_err(dev, "unable to obtain the reference clock");
-			return -ENODEV;
-		}
-
-		hpriv->clks[1] = clk;
+	if (hpriv->n_clks < 2) {
+		hpriv->clks = devm_kcalloc(dev, 2, sizeof(*hpriv->clks), GFP_KERNEL);
+		if (!hpriv->clks)
+			return -ENOMEM;
+
+		hpriv->clks[0].id = "fck";
+		hpriv->clks[1].id = "refclk";
+		hpriv->n_clks = 2;
+
+		rc = devm_clk_bulk_get(dev, hpriv->n_clks, hpriv->clks);
+		if (rc)
+			return rc;
 	}
 
-	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
+	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1].clk));
 	if (mpy == 0) {
 		dev_err(dev, "invalid REFCLK multiplier value: 0x%x", mpy);
 		return -EINVAL;
diff --git a/drivers/ata/ahci_dm816.c b/drivers/ata/ahci_dm816.c
index 8bec410416714..ec83ba8858060 100644
--- a/drivers/ata/ahci_dm816.c
+++ b/drivers/ata/ahci_dm816.c
@@ -69,12 +69,12 @@ static int ahci_dm816_phy_init(struct ahci_host_priv *hpriv, struct device *dev)
 	 * keep-alive clock and the external reference clock. We need the
 	 * rate of the latter to calculate the correct value of MPY bits.
 	 */
-	if (!hpriv->clks[1]) {
+	if (hpriv->n_clks < 2) {
 		dev_err(dev, "reference clock not supplied\n");
 		return -EINVAL;
 	}
 
-	refclk_rate = clk_get_rate(hpriv->clks[1]);
+	refclk_rate = clk_get_rate(hpriv->clks[1].clk);
 	if ((refclk_rate % 100) != 0) {
 		dev_err(dev, "reference clock rate must be divisible by 100\n");
 		return -EINVAL;
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 64d6da0a53035..6ae1d8b870a2d 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -97,28 +97,14 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
  * ahci_platform_enable_clks - Enable platform clocks
  * @hpriv: host private area to store config values
  *
- * This function enables all the clks found in hpriv->clks, starting at
- * index 0. If any clk fails to enable it disables all the clks already
- * enabled in reverse order, and then returns an error.
+ * This function enables all the clks found for the AHCI device.
  *
  * RETURNS:
  * 0 on success otherwise a negative error code
  */
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv)
 {
-	int c, rc;
-
-	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
-		rc = clk_prepare_enable(hpriv->clks[c]);
-		if (rc)
-			goto disable_unprepare_clk;
-	}
-	return 0;
-
-disable_unprepare_clk:
-	while (--c >= 0)
-		clk_disable_unprepare(hpriv->clks[c]);
-	return rc;
+	return clk_bulk_prepare_enable(hpriv->n_clks, hpriv->clks);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
 
@@ -126,16 +112,13 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
  * ahci_platform_disable_clks - Disable platform clocks
  * @hpriv: host private area to store config values
  *
- * This function disables all the clks found in hpriv->clks, in reverse
- * order of ahci_platform_enable_clks (starting at the end of the array).
+ * This function disables all the clocks enabled before
+ * (bulk-clocks-disable function is supposed to do that in reverse
+ * from the enabling procedure order).
  */
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
 {
-	int c;
-
-	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
-		if (hpriv->clks[c])
-			clk_disable_unprepare(hpriv->clks[c]);
+	clk_bulk_disable_unprepare(hpriv->n_clks, hpriv->clks);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
 
@@ -292,8 +275,6 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 		pm_runtime_disable(dev);
 	}
 
-	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
-		clk_put(hpriv->clks[c]);
 	/*
 	 * The regulators are tied to child node device and not to the
 	 * SATA device itself. So we can't use devm for automatically
@@ -374,8 +355,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
  * 2) regulator for controlling the targets power (optional)
  *    regulator for controlling the AHCI controller (optional)
- * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
- *    or for non devicetree enabled platforms a single clock
+ * 3) all clocks specified in the devicetree node, or a single
+ *    clock for non-OF platforms (optional)
  * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
  * 5) phys (optional)
  *
@@ -385,11 +366,10 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 						   unsigned int flags)
 {
+	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	struct clk *clk;
 	struct device_node *child;
-	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -409,25 +389,38 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		goto err_out;
 	}
 
-	for (i = 0; i < AHCI_MAX_CLKS; i++) {
+	/*
+	 * Bulk clocks getting procedure can fail to find any clock due to
+	 * running on a non-OF platform or due to the clocks being defined in
+	 * bypass of the DT firmware (like da850, spear13xx). In that case we
+	 * fallback to getting a single clock source right from the dev clocks
+	 * list.
+	 */
+	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
+	if (rc < 0)
+		goto err_out;
+
+	if (rc > 0) {
+		/* Got clocks in bulk */
+		hpriv->n_clks = rc;
+	} else {
 		/*
-		 * For now we must use clk_get(dev, NULL) for the first clock,
-		 * because some platforms (da850, spear13xx) are not yet
-		 * converted to use devicetree for clocks.  For new platforms
-		 * this is equivalent to of_clk_get(dev->of_node, 0).
+		 * No clock bulk found: fallback to manually getting
+		 * the optional clock.
 		 */
-		if (i == 0)
-			clk = clk_get(dev, NULL);
-		else
-			clk = of_clk_get(dev->of_node, i);
-
-		if (IS_ERR(clk)) {
-			rc = PTR_ERR(clk);
-			if (rc == -EPROBE_DEFER)
-				goto err_out;
-			break;
+		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
+		if (!hpriv->clks) {
+			rc = -ENOMEM;
+			goto err_out;
+		}
+		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
+		if (IS_ERR(hpriv->clks->clk)) {
+			rc = PTR_ERR(hpriv->clks->clk);
+			goto err_out;
+		} else if (hpriv->clks->clk) {
+			hpriv->clks->id = "ahci";
+			hpriv->n_clks = 1;
 		}
-		hpriv->clks[i] = clk;
 	}
 
 	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
-- 
2.43.0




