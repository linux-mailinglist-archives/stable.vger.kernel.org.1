Return-Path: <stable+bounces-149140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70725ACB0EE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217157AFBB4
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F209223DF6;
	Mon,  2 Jun 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LGYnDMg/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05812C324D;
	Mon,  2 Jun 2025 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873023; cv=none; b=okPCol2wXTrXNXb8C2qqCRRDOMcCSXk4yv9AucIN4FuIG68eiF0UUb6JfeNHJ5RYQbXsI3LWXe3OfyCngADtA72hmTwKVY2XhfoZAZmF0CB+gXpbMRXelx73VC8RL6ZWtuEcc23c3pz6cd3HV352s7xvVy54mJHAIwaKIz305oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873023; c=relaxed/simple;
	bh=nh9xiL6BdOYN02SjuRgCWWcrwZvQiI5rSbxi8wfmxkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POVnKRD4dGgYLbJ1zzcei8qAbuDu9mAWeTeq4g+brR/OmSI9cMqviQet8MiHVMR4PwEGd/smUBK/SPyCAf3fkjPrY2wRvCSkX+4RQ3fu89KuiU4u1SmD8ujAgsXxihJqPhQS20RcXjgl0m/2w4qmA79AGKhJBrnKn1RridAfjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LGYnDMg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3620C4CEEB;
	Mon,  2 Jun 2025 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873023;
	bh=nh9xiL6BdOYN02SjuRgCWWcrwZvQiI5rSbxi8wfmxkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGYnDMg/gqg/PHSFBoJb0Tqd9OuuzIC+IfdrEiVG4k0TYb8okW4lQuSbgJr9Hs+0N
	 c8pczskiB0adTHfhH4XU6IJdm4PC3SojBjs4mTFCRcEARvMT0UoU5khmW3Wtm95ZKV
	 VeXcSnK+IbWqUWqjojKKsgoCOFVJiNio3C2ymaDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/444] i2c: designware: Use temporary variable for struct device
Date: Mon,  2 Jun 2025 15:41:10 +0200
Message-ID: <20250602134341.169072311@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit d2f94dccab8319063dd1fbc1738b4a280c2e4009 ]

Use temporary variable for struct device to make code neater.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 1cfe51ef07ca ("i2c: designware: Fix an error handling path in i2c_dw_pci_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 29 ++++++-------
 drivers/i2c/busses/i2c-designware-platdrv.c | 48 ++++++++++-----------
 2 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 6db6f9d5d4d4e..36c13612b55d4 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -248,6 +248,7 @@ static const struct software_node dgpu_node = {
 static int i2c_dw_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
+	struct device *device = &pdev->dev;
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	int r;
@@ -256,25 +257,22 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	struct i2c_timings *t;
 
 	if (id->driver_data >= ARRAY_SIZE(dw_pci_controllers))
-		return dev_err_probe(&pdev->dev, -EINVAL,
-				     "Invalid driver data %ld\n",
+		return dev_err_probe(device, -EINVAL, "Invalid driver data %ld\n",
 				     id->driver_data);
 
 	controller = &dw_pci_controllers[id->driver_data];
 
 	r = pcim_enable_device(pdev);
 	if (r)
-		return dev_err_probe(&pdev->dev, r,
-				     "Failed to enable I2C PCI device\n");
+		return dev_err_probe(device, r, "Failed to enable I2C PCI device\n");
 
 	pci_set_master(pdev);
 
 	r = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
 	if (r)
-		return dev_err_probe(&pdev->dev, r,
-				     "I/O memory remapping failed\n");
+		return dev_err_probe(device, r, "I/O memory remapping failed\n");
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	dev = devm_kzalloc(device, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
@@ -284,7 +282,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	dev->get_clk_rate_khz = controller->get_clk_rate_khz;
 	dev->base = pcim_iomap_table(pdev)[0];
-	dev->dev = &pdev->dev;
+	dev->dev = device;
 	dev->irq = pci_irq_vector(pdev, 0);
 	dev->flags |= controller->flags;
 
@@ -338,14 +336,14 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU) {
 		dev->slave = i2c_new_ccgx_ucsi(&dev->adapter, dev->irq, &dgpu_node);
 		if (IS_ERR(dev->slave))
-			return dev_err_probe(dev->dev, PTR_ERR(dev->slave),
+			return dev_err_probe(device, PTR_ERR(dev->slave),
 					     "register UCSI failed\n");
 	}
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(device, 1000);
+	pm_runtime_use_autosuspend(device);
+	pm_runtime_put_autosuspend(device);
+	pm_runtime_allow(device);
 
 	return 0;
 }
@@ -353,11 +351,12 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 static void i2c_dw_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
+	struct device *device = &pdev->dev;
 
 	i2c_dw_disable(dev);
 
-	pm_runtime_forbid(&pdev->dev);
-	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_forbid(device);
+	pm_runtime_get_noresume(device);
 
 	i2c_del_adapter(&dev->adapter);
 	devm_free_irq(&pdev->dev, dev->irq, dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 61c506092abdb..f3245a6856309 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -275,6 +275,7 @@ static void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev)
 
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
+	struct device *device = &pdev->dev;
 	struct i2c_adapter *adap;
 	struct dw_i2c_dev *dev;
 	struct i2c_timings *t;
@@ -284,15 +285,15 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), GFP_KERNEL);
+	dev = devm_kzalloc(device, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	dev->flags = (uintptr_t)device_get_match_data(&pdev->dev);
-	if (device_property_present(&pdev->dev, "wx,i2c-snps-model"))
+	dev->flags = (uintptr_t)device_get_match_data(device);
+	if (device_property_present(device, "wx,i2c-snps-model"))
 		dev->flags = MODEL_WANGXUN_SP | ACCESS_POLLING;
 
-	dev->dev = &pdev->dev;
+	dev->dev = device;
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
@@ -300,7 +301,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	dev->rst = devm_reset_control_get_optional_exclusive(device, NULL);
 	if (IS_ERR(dev->rst))
 		return PTR_ERR(dev->rst);
 
@@ -328,13 +329,13 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	i2c_dw_configure(dev);
 
 	/* Optional interface clock */
-	dev->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	dev->pclk = devm_clk_get_optional(device, "pclk");
 	if (IS_ERR(dev->pclk)) {
 		ret = PTR_ERR(dev->pclk);
 		goto exit_reset;
 	}
 
-	dev->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	dev->clk = devm_clk_get_optional(device, NULL);
 	if (IS_ERR(dev->clk)) {
 		ret = PTR_ERR(dev->clk);
 		goto exit_reset;
@@ -363,28 +364,24 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	adap->dev.of_node = pdev->dev.of_node;
 	adap->nr = -1;
 
-	if (dev->flags & ACCESS_NO_IRQ_SUSPEND) {
-		dev_pm_set_driver_flags(&pdev->dev,
-					DPM_FLAG_SMART_PREPARE);
-	} else {
-		dev_pm_set_driver_flags(&pdev->dev,
-					DPM_FLAG_SMART_PREPARE |
-					DPM_FLAG_SMART_SUSPEND);
-	}
+	if (dev->flags & ACCESS_NO_IRQ_SUSPEND)
+		dev_pm_set_driver_flags(device, DPM_FLAG_SMART_PREPARE);
+	else
+		dev_pm_set_driver_flags(device, DPM_FLAG_SMART_PREPARE | DPM_FLAG_SMART_SUSPEND);
 
-	device_enable_async_suspend(&pdev->dev);
+	device_enable_async_suspend(device);
 
 	/* The code below assumes runtime PM to be disabled. */
-	WARN_ON(pm_runtime_enabled(&pdev->dev));
+	WARN_ON(pm_runtime_enabled(device));
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(device, 1000);
+	pm_runtime_use_autosuspend(device);
+	pm_runtime_set_active(device);
 
 	if (dev->shared_with_punit)
-		pm_runtime_get_noresume(&pdev->dev);
+		pm_runtime_get_noresume(device);
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(device);
 
 	ret = i2c_dw_probe(dev);
 	if (ret)
@@ -402,15 +399,16 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 static void dw_i2c_plat_remove(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	struct device *device = &pdev->dev;
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(device);
 
 	i2c_del_adapter(&dev->adapter);
 
 	i2c_dw_disable(dev);
 
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(device);
+	pm_runtime_put_sync(device);
 	dw_i2c_plat_pm_cleanup(dev);
 
 	i2c_dw_remove_lock_support(dev);
-- 
2.39.5




