Return-Path: <stable+bounces-24998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB086974F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64E5B2B9D0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8F13EFEC;
	Tue, 27 Feb 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vy3EvyxI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412B78B61;
	Tue, 27 Feb 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043572; cv=none; b=JoktqKRiS5zuff67KHdEf2UQVlclUPUmCFMMHYvnxJMEwmXDSL8avZraHBGFEvgYOw8J+rKwSsXEW0CbFV6m3kJLuEnWgzFtWH8+gw2GuVPVQ2Rufqad1+U7jKE5n642zKRY/OJScYoHGR+BdUPl75u0Sgu7m2DGFqHrol8Vxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043572; c=relaxed/simple;
	bh=MRswAB+/LfQRBIMH4hFEVCF7+ZTD7Hmk1hvqoKvKNV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn0GvCLa8SIocNxLZpFt1d7reLoAX3qgujrLD2LgXncuzjqMkrZ2UvdAFBKyxS9aE6kDQbtpfrlvTUEdCk9aEaVYwrMnIL54HjcjFGv+sixFa+hSCQfiw++zOVLtwnde49A+z+jXdWLJc6U8A19mgAkE6lxc6aeKf0f8rIK+C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vy3EvyxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809E0C433C7;
	Tue, 27 Feb 2024 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043571;
	bh=MRswAB+/LfQRBIMH4hFEVCF7+ZTD7Hmk1hvqoKvKNV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vy3EvyxISM2+kJj5LSMlBaJPoDPqXjYmzv0ihJSp39ZinDjMvfsVLMCVd2kJNiqYw
	 65x/CZXqXmXZCnyA52DnmNNx5wedI/0UibTZvpIuS+hHzH7cv54LfqBMcbiEdAemdz
	 yx/YajuDFZaLN72eDm5okoBhjMJJ1F2BbLM3FxII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 156/195] ata: ahci_ceva: fix error handling for Xilinx GT PHY support
Date: Tue, 27 Feb 2024 14:26:57 +0100
Message-ID: <20240227131615.569281217@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

[ Upstream commit 26c8404e162b43dddcb037ba2d0cb58c0ed60aab ]

Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
error path.

To fix introduce the function ceva_ahci_platform_enable_resources() which
is a customized version of ahci_platform_enable_resources() and inline with
SATA IP programming sequence it does:

- Assert SATA reset
- Program PS GTR phy
- Bring SATA by de-asserting the reset
- Wait for GT lane PLL to be locked

ceva_ahci_platform_enable_resources() is also used in the resume path
as the same SATA programming sequence (as in probe) should be followed.
Also cleanup the mixed usage of ahci_platform_enable_resources() and custom
implementation in the probe function as both are not required.

Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci_ceva.c | 125 +++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 46 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index cb24ecf36fafe..50e07ea60e45c 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -88,7 +88,6 @@ struct ceva_ahci_priv {
 	u32 axicc;
 	bool is_cci_enabled;
 	int flags;
-	struct reset_control *rst;
 };
 
 static unsigned int ceva_ahci_read_id(struct ata_device *dev,
@@ -189,6 +188,60 @@ static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
 };
 
+static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
+{
+	int rc, i;
+
+	rc = ahci_platform_enable_regulators(hpriv);
+	if (rc)
+		return rc;
+
+	rc = ahci_platform_enable_clks(hpriv);
+	if (rc)
+		goto disable_regulator;
+
+	/* Assert the controller reset */
+	rc = ahci_platform_assert_rsts(hpriv);
+	if (rc)
+		goto disable_clks;
+
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_init(hpriv->phys[i]);
+		if (rc)
+			goto disable_rsts;
+	}
+
+	/* De-assert the controller reset */
+	ahci_platform_deassert_rsts(hpriv);
+
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_power_on(hpriv->phys[i]);
+		if (rc) {
+			phy_exit(hpriv->phys[i]);
+			goto disable_phys;
+		}
+	}
+
+	return 0;
+
+disable_rsts:
+	ahci_platform_deassert_rsts(hpriv);
+
+disable_phys:
+	while (--i >= 0) {
+		phy_power_off(hpriv->phys[i]);
+		phy_exit(hpriv->phys[i]);
+	}
+
+disable_clks:
+	ahci_platform_disable_clks(hpriv);
+
+disable_regulator:
+	ahci_platform_disable_regulators(hpriv);
+
+	return rc;
+}
+
 static int ceva_ahci_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -203,47 +256,19 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	cevapriv->ahci_pdev = pdev;
-
-	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
-								  NULL);
-	if (IS_ERR(cevapriv->rst))
-		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
-			      "failed to get reset\n");
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-	if (!cevapriv->rst) {
-		rc = ahci_platform_enable_resources(hpriv);
-		if (rc)
-			return rc;
-	} else {
-		int i;
+	hpriv->rsts = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								NULL);
+	if (IS_ERR(hpriv->rsts))
+		return dev_err_probe(&pdev->dev, PTR_ERR(hpriv->rsts),
+				     "failed to get reset\n");
 
-		rc = ahci_platform_enable_clks(hpriv);
-		if (rc)
-			return rc;
-		/* Assert the controller reset */
-		reset_control_assert(cevapriv->rst);
-
-		for (i = 0; i < hpriv->nports; i++) {
-			rc = phy_init(hpriv->phys[i]);
-			if (rc)
-				return rc;
-		}
-
-		/* De-assert the controller reset */
-		reset_control_deassert(cevapriv->rst);
-
-		for (i = 0; i < hpriv->nports; i++) {
-			rc = phy_power_on(hpriv->phys[i]);
-			if (rc) {
-				phy_exit(hpriv->phys[i]);
-				return rc;
-			}
-		}
-	}
+	rc = ceva_ahci_platform_enable_resources(hpriv);
+	if (rc)
+		return rc;
 
 	if (of_property_read_bool(np, "ceva,broken-gen2"))
 		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
@@ -252,52 +277,60 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
 					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
 					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read OOB timing value for COMWAKE from device-tree*/
 	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
 					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
 					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read phy BURST timing value from device-tree */
 	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
 					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
 					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read phy RETRY interval timing value from device-tree */
 	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
 					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
 		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
 					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
 		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/*
@@ -335,7 +368,7 @@ static int __maybe_unused ceva_ahci_resume(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
-	rc = ahci_platform_enable_resources(hpriv);
+	rc = ceva_ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
 
-- 
2.43.0




