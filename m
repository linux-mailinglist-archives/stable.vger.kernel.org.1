Return-Path: <stable+bounces-96845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0A9E2191
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01F72808FC
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2311F75B6;
	Tue,  3 Dec 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nIvvzkFL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD11E3DF9;
	Tue,  3 Dec 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238760; cv=none; b=kGx4z/C2456RUAg3ahZkHWym35aahq0wHSnyiwnDEjQ4phKTx1nfgh7vTlGP6/JQMo8p38jqHHKv36uX7hA7Eo6XFSHLnNDhA5gHcoiMh7roRXpmWsEz5o7iKG5yvshJJVdZp+y4e00ZhMS2tyP4dgXAehOBxocxhw2qZslj2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238760; c=relaxed/simple;
	bh=tayHtd2ir/qHURy8R7H67WESE0IujatjGD09lveWIP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVzW0pMpFBTZbpMgow3Q0/j0dVj2Z5UDL42MhjoDh/jR4m7Mq/FdmUFqkTUbmnb/Ust1+q7wbSnX/VsdtCVZKFnfXiFYFl++06sZkNqMftpQSz/iHbyoK3irAS9UoTAmxzunj9b1+0+eATiQi/0rN/JIVHKBZ84IdI4gv/NkHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nIvvzkFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54247C4CECF;
	Tue,  3 Dec 2024 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238759;
	bh=tayHtd2ir/qHURy8R7H67WESE0IujatjGD09lveWIP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIvvzkFLvxdFh4fts3p92Ar9VGxXPK0SDBpnKuVVvQ8o6tc+ongJFLpux7OIptB1F
	 raLrdCeY3apeDvtI2ek0bUfz/SvTTle5y9KasPDPVl/iLLIwTeLNKHGxVb+ENTP2UZ
	 l4nqsZRncWna2ZK3p4r8ejJMvddhrYgeKqIEncWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Ning <zhangn1985@outlook.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 389/817] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
Date: Tue,  3 Dec 2024 15:39:21 +0100
Message-ID: <20241203144011.055951615@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 9b79d59e6b2b515eb9a22bc469ef7b8f0904fc73 ]

While design wise the idea of converting the driver to use
the hierarchy of the IRQ chips is correct, the implementation
has (inherited) flaws. This was unveiled when platform_get_irq()
had started WARN() on IRQ 0 that is supposed to be a Linux
IRQ number (also known as vIRQ).

Rework the driver to respect IRQ domain when creating each MFD
device separately, as the domain is not the same for all of them.

Fixes: 957ae5098185 ("platform/x86: Add Whiskey Cove PMIC TMU support")
Fixes: 57129044f504 ("mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips")
Reported-by: Zhang Ning <zhangn1985@outlook.com>
Closes: https://lore.kernel.org/r/TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com
Tested-by: Zhang Ning <zhangn1985@outlook.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20241005193029.1929139-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c     | 31 ++++++++++++++------------
 drivers/platform/x86/intel/bxtwc_tmu.c | 22 +++++-------------
 2 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 5c35ccfc534ad..f4d50e35b8489 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -246,12 +246,6 @@ static struct mfd_cell bxt_wc_dev[] = {
 		.num_resources = ARRAY_SIZE(bcu_resources),
 		.resources = bcu_resources,
 	},
-	{
-		.name = "bxt_wcove_tmu",
-		.num_resources = ARRAY_SIZE(tmu_resources),
-		.resources = tmu_resources,
-	},
-
 	{
 		.name = "bxt_wcove_gpio",
 		.num_resources = ARRAY_SIZE(gpio_resources),
@@ -262,6 +256,14 @@ static struct mfd_cell bxt_wc_dev[] = {
 	},
 };
 
+static const struct mfd_cell bxt_wc_tmu_dev[] = {
+	{
+		.name = "bxt_wcove_tmu",
+		.num_resources = ARRAY_SIZE(tmu_resources),
+		.resources = tmu_resources,
+	},
+};
+
 static struct mfd_cell bxt_wc_chgr_dev[] = {
 	{
 		.name = "bxt_wcove_usbc",
@@ -490,6 +492,15 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add IRQ chip\n");
 
+	ret = bxtwc_add_chained_devices(pmic, bxt_wc_tmu_dev, ARRAY_SIZE(bxt_wc_tmu_dev),
+					pmic->irq_chip_data,
+					BXTWC_TMU_LVL1_IRQ,
+					IRQF_ONESHOT,
+					&bxtwc_regmap_irq_chip_tmu,
+					&pmic->irq_chip_data_tmu);
+	if (ret)
+		return ret;
+
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
 					 BXTWC_PWRBTN_LVL1_IRQ,
 					 IRQF_ONESHOT,
@@ -498,14 +509,6 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWRBTN IRQ chip\n");
 
-	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
-					 BXTWC_TMU_LVL1_IRQ,
-					 IRQF_ONESHOT,
-					 &bxtwc_regmap_irq_chip_tmu,
-					 &pmic->irq_chip_data_tmu);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add TMU IRQ chip\n");
-
 	/* Add chained IRQ handler for BCU IRQs */
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
 					 BXTWC_BCU_LVL1_IRQ,
diff --git a/drivers/platform/x86/intel/bxtwc_tmu.c b/drivers/platform/x86/intel/bxtwc_tmu.c
index d0e2a3c293b0b..9ac801b929b93 100644
--- a/drivers/platform/x86/intel/bxtwc_tmu.c
+++ b/drivers/platform/x86/intel/bxtwc_tmu.c
@@ -48,9 +48,8 @@ static irqreturn_t bxt_wcove_tmu_irq_handler(int irq, void *data)
 static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
-	struct regmap_irq_chip_data *regmap_irq_chip;
 	struct wcove_tmu *wctmu;
-	int ret, virq, irq;
+	int ret;
 
 	wctmu = devm_kzalloc(&pdev->dev, sizeof(*wctmu), GFP_KERNEL);
 	if (!wctmu)
@@ -59,27 +58,18 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 	wctmu->dev = &pdev->dev;
 	wctmu->regmap = pmic->regmap;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	wctmu->irq = platform_get_irq(pdev, 0);
+	if (wctmu->irq < 0)
+		return wctmu->irq;
 
-	regmap_irq_chip = pmic->irq_chip_data_tmu;
-	virq = regmap_irq_get_virq(regmap_irq_chip, irq);
-	if (virq < 0) {
-		dev_err(&pdev->dev,
-			"failed to get virtual interrupt=%d\n", irq);
-		return virq;
-	}
-
-	ret = devm_request_threaded_irq(&pdev->dev, virq,
+	ret = devm_request_threaded_irq(&pdev->dev, wctmu->irq,
 					NULL, bxt_wcove_tmu_irq_handler,
 					IRQF_ONESHOT, "bxt_wcove_tmu", wctmu);
 	if (ret) {
 		dev_err(&pdev->dev, "request irq failed: %d,virq: %d\n",
-							ret, virq);
+			ret, wctmu->irq);
 		return ret;
 	}
-	wctmu->irq = virq;
 
 	/* Unmask TMU second level Wake & System alarm */
 	regmap_update_bits(wctmu->regmap, BXTWC_MTMUIRQ_REG,
-- 
2.43.0




