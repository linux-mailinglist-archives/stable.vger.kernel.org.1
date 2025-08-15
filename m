Return-Path: <stable+bounces-169815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D04B28673
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 21:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44101B64EE2
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550B230BD5;
	Fri, 15 Aug 2025 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FojzSoBR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C20221282
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286299; cv=none; b=UpNs/rvyaptjncnziBO5E1DnOCmSQZsaOc1mdRcGVDwvIpkR43xCVdlKna5EWBq8FuAq9U1qz3ZB8qyxXwBZ2n8DfD7CHCIe8A8eaNUSihwBXqUBoL7HRjvswSbbJ2NLW9zm8uYaqclKnuLn5GzYwR3TqETCbyV5OqEVx7KPTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286299; c=relaxed/simple;
	bh=6faC/Djwe5ymEQ05CVs6fz8MxlP5RNNVhLgQXWWmeUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZnzL30+rw0fyQ4ATN8b9EwNx3N3FglXhH2cTbr8TmDeY15xJNeTh6dmCNZHEQls3E6KV/NnVCYDzZ/39haWaraPv+NJrNpMnp6bRN8hbclgesbgXSrWY7yVwYLbwa69mxj2JkQAyQBLseUQReu5JVJTwSRT7FjYwZmBVRnrprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FojzSoBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885ADC4CEF1;
	Fri, 15 Aug 2025 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755286296;
	bh=6faC/Djwe5ymEQ05CVs6fz8MxlP5RNNVhLgQXWWmeUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FojzSoBR8A4QVmzPOF7MqWpAf3cEXDV7/XreWjT5ZKvbQNRLnviEX1PeaBNC9LXaK
	 3kh+8lqA7l6BXPXUx+L/5xEW02hEvtUIWZF4yJmj3PMLzAaAzFMCB2rnKjJcKNHfHB
	 Grlw0lka07E0iUc7nza0yQ/tpnDB5mUpe88CRarrm4rHBXkMA1DoeQQT0AVseN1euy
	 a1+E6mcqCTxD0S95Io1GrvjcsQloMFSgZppE2ogEcxfx62egM+DBfG6t6UjZYt8HbK
	 sXypnebs26PcVZqwPHWdpyYwIWl/Q7X4BJRo4xyk6uQKYg3DRkhHjGRVHBqrTBi7pn
	 KhV28qPdB4tig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] leds: flash: leds-qcom-flash: Fix registry access after re-bind
Date: Fri, 15 Aug 2025 15:31:27 -0400
Message-ID: <20250815193127.192775-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815193127.192775-1-sashal@kernel.org>
References: <2025081544-skillet-cofounder-e278@gregkh>
 <20250815193127.192775-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit fab15f57360b1e6620a1d0d6b0fbee896e6c1f07 ]

Driver in probe() updates each of 'reg_field' with 'reg_base':

	for (i = 0; i < REG_MAX_COUNT; i++)
		regs[i].reg += reg_base;

'reg_field' array (under variable 'regs' above) is statically allocated,
thus each re-bind would add another 'reg_base' leading to bogus
register addresses.  Constify the local 'reg_field' array and duplicate
it in probe to solve this.

Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250529063335.8785-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/flash/leds-qcom-flash.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index 7df4e8426528..a619dbe01524 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -117,7 +117,7 @@ enum {
 	REG_MAX_COUNT,
 };
 
-static struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
+static const struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
 	REG_FIELD(0x08, 0, 7),			/* status1	*/
 	REG_FIELD(0x09, 0, 7),                  /* status2	*/
 	REG_FIELD(0x0a, 0, 7),                  /* status3	*/
@@ -132,7 +132,7 @@ static struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
 	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */
 };
 
-static struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
+static const struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
 	REG_FIELD(0x06, 0, 7),			/* status1	*/
 	REG_FIELD(0x07, 0, 6),			/* status2	*/
 	REG_FIELD(0x09, 0, 7),			/* status3	*/
@@ -855,11 +855,17 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 	if (val == FLASH_SUBTYPE_3CH_PM8150_VAL || val == FLASH_SUBTYPE_3CH_PMI8998_VAL) {
 		flash_data->hw_type = QCOM_MVFLASH_3CH;
 		flash_data->max_channels = 3;
-		regs = mvflash_3ch_regs;
+		regs = devm_kmemdup(dev, mvflash_3ch_regs, sizeof(mvflash_3ch_regs),
+				    GFP_KERNEL);
+		if (!regs)
+			return -ENOMEM;
 	} else if (val == FLASH_SUBTYPE_4CH_VAL) {
 		flash_data->hw_type = QCOM_MVFLASH_4CH;
 		flash_data->max_channels = 4;
-		regs = mvflash_4ch_regs;
+		regs = devm_kmemdup(dev, mvflash_4ch_regs, sizeof(mvflash_4ch_regs),
+				    GFP_KERNEL);
+		if (!regs)
+			return -ENOMEM;
 
 		rc = regmap_read(regmap, reg_base + FLASH_REVISION_REG, &val);
 		if (rc < 0) {
@@ -881,6 +887,7 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to allocate regmap field, rc=%d\n", rc);
 		return rc;
 	}
+	devm_kfree(dev, regs); /* devm_regmap_field_bulk_alloc() makes copies */
 
 	platform_set_drvdata(pdev, flash_data);
 	mutex_init(&flash_data->lock);
-- 
2.50.1


