Return-Path: <stable+bounces-96846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636549E2192
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28591283EE1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67A1F75BD;
	Tue,  3 Dec 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7ooLxNA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73A1F75A8;
	Tue,  3 Dec 2024 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238763; cv=none; b=M1aRQ6NS0U4kn5emi9ade29i7/PWJbe12YKkD7EJJ7DfHTOrTWnF1b2oxvxxfSbY61EASsLxk0ibz5rvFt+8bYij6xVTrNYH1IuxQNa/CYO+hF37rSj0CX8Z+VT0d7Lp/oN3KJpEIHeg1z9ZqQXVXosYMr5mGx6Tvvgyvh3dkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238763; c=relaxed/simple;
	bh=lpksFKOjvn2kPdDhVO8Fgx2h2UhMWK3Lu7MqpdNvh2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQHvgetttbntzaIKhCPZF8MqaPhLo59zLnKNxB3gsLaCVLZs7+TMvPUFUGEDKz/dhzm8dNeWx7X3jP/wlS2eWPvCLfX9dqTG3HXfnCLV5EyVoM+k0jjo0ZNB4K1X/2qzVeCfzrBXz/okeLyh8g4iHcYZsRm9C6nnQHQwdckmZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7ooLxNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F065C4CEDD;
	Tue,  3 Dec 2024 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238762;
	bh=lpksFKOjvn2kPdDhVO8Fgx2h2UhMWK3Lu7MqpdNvh2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w7ooLxNAHJio6j6JeieRbE0t9JbNpTGzXB2iCUOvVB7p+6PFhohsvWOunrUWQKEx9
	 aCLnKvXGjHROBW7Z2lC+f/xqQGHYhqKhLqmvh0DRB+4/sH6Be8ziE3ZbZswX0AcEg6
	 Wv+cjahjJJhdQ93oAnT0u1Gm4BSmDwSzsxkri4SI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Ning <zhangn1985@outlook.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 390/817] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
Date: Tue,  3 Dec 2024 15:39:22 +0100
Message-ID: <20241203144011.094430947@linuxfoundation.org>
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

[ Upstream commit 0350d783ab888cb1cb48ced36cc28b372723f1a4 ]

While design wise the idea of converting the driver to use
the hierarchy of the IRQ chips is correct, the implementation
has (inherited) flaws. This was unveiled when platform_get_irq()
had started WARN() on IRQ 0 that is supposed to be a Linux
IRQ number (also known as vIRQ).

Rework the driver to respect IRQ domain when creating each MFD
device separately, as the domain is not the same for all of them.

Fixes: 57129044f504 ("mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips")
Tested-by: Zhang Ning <zhangn1985@outlook.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20241005193029.1929139-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 54 +++++++++++++++++-------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index f4d50e35b8489..f588e0f1fd0ad 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -231,21 +231,11 @@ static const struct resource tmu_resources[] = {
 };
 
 static struct mfd_cell bxt_wc_dev[] = {
-	{
-		.name = "bxt_wcove_gpadc",
-		.num_resources = ARRAY_SIZE(adc_resources),
-		.resources = adc_resources,
-	},
 	{
 		.name = "bxt_wcove_thermal",
 		.num_resources = ARRAY_SIZE(thermal_resources),
 		.resources = thermal_resources,
 	},
-	{
-		.name = "bxt_wcove_bcu",
-		.num_resources = ARRAY_SIZE(bcu_resources),
-		.resources = bcu_resources,
-	},
 	{
 		.name = "bxt_wcove_gpio",
 		.num_resources = ARRAY_SIZE(gpio_resources),
@@ -264,6 +254,22 @@ static const struct mfd_cell bxt_wc_tmu_dev[] = {
 	},
 };
 
+static const struct mfd_cell bxt_wc_bcu_dev[] = {
+	{
+		.name = "bxt_wcove_bcu",
+		.num_resources = ARRAY_SIZE(bcu_resources),
+		.resources = bcu_resources,
+	},
+};
+
+static const struct mfd_cell bxt_wc_adc_dev[] = {
+	{
+		.name = "bxt_wcove_gpadc",
+		.num_resources = ARRAY_SIZE(adc_resources),
+		.resources = adc_resources,
+	},
+};
+
 static struct mfd_cell bxt_wc_chgr_dev[] = {
 	{
 		.name = "bxt_wcove_usbc",
@@ -509,23 +515,23 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWRBTN IRQ chip\n");
 
-	/* Add chained IRQ handler for BCU IRQs */
-	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
-					 BXTWC_BCU_LVL1_IRQ,
-					 IRQF_ONESHOT,
-					 &bxtwc_regmap_irq_chip_bcu,
-					 &pmic->irq_chip_data_bcu);
+	ret = bxtwc_add_chained_devices(pmic, bxt_wc_bcu_dev, ARRAY_SIZE(bxt_wc_bcu_dev),
+					pmic->irq_chip_data,
+					BXTWC_BCU_LVL1_IRQ,
+					IRQF_ONESHOT,
+					&bxtwc_regmap_irq_chip_bcu,
+					&pmic->irq_chip_data_bcu);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add BUC IRQ chip\n");
+		return ret;
 
-	/* Add chained IRQ handler for ADC IRQs */
-	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
-					 BXTWC_ADC_LVL1_IRQ,
-					 IRQF_ONESHOT,
-					 &bxtwc_regmap_irq_chip_adc,
-					 &pmic->irq_chip_data_adc);
+	ret = bxtwc_add_chained_devices(pmic, bxt_wc_adc_dev, ARRAY_SIZE(bxt_wc_adc_dev),
+					pmic->irq_chip_data,
+					BXTWC_ADC_LVL1_IRQ,
+					IRQF_ONESHOT,
+					&bxtwc_regmap_irq_chip_adc,
+					&pmic->irq_chip_data_adc);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add ADC IRQ chip\n");
+		return ret;
 
 	ret = bxtwc_add_chained_devices(pmic, bxt_wc_chgr_dev, ARRAY_SIZE(bxt_wc_chgr_dev),
 					pmic->irq_chip_data,
-- 
2.43.0




