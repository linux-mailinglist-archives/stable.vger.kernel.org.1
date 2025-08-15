Return-Path: <stable+bounces-169736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E9B282F4
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E76BAC48CA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B73D1A256B;
	Fri, 15 Aug 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rWye/Jc4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9352AD13
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271852; cv=none; b=oTrPJhqvEcX7q3DiPXCNAHLUnb8WJTukN4qsj0A8NE6MI4oCgXLiOz99fxfynQc0xWhZhZEejmY4VK1SeacjcjVezcIVFu52nglCMjaCM4r7JjGRukcGP4QRzsYh284Y2zOmGlbK2aOKYplzsKJ1eG7nkN6v9DDoFW5fARfc0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271852; c=relaxed/simple;
	bh=ybqmsReBfCALu/mumTCb8/pJ+3nb+xDhhy5xIG3OQJI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vd9qt4TkzUlszHm2TbtpqNzWj/nNTAEBfEHjRoah2LAR7v97m/Kl90Od8uurUnN8jXZL4EDuJr67ghpP3B5paq6kKpX4wsXiRRs5h76jgFHcg6wOhUVpKFKTDJSNlLBaySvclglM1HuETWvytfPxgQu0Uodx1jOuWXTNVxPgcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rWye/Jc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD55AC4CEEB;
	Fri, 15 Aug 2025 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755271852;
	bh=ybqmsReBfCALu/mumTCb8/pJ+3nb+xDhhy5xIG3OQJI=;
	h=Subject:To:Cc:From:Date:From;
	b=rWye/Jc45zHee1IODPVS0dp1Sw7R+/N4hMWmvgf87PBKcOgzppp/p5Uu6tzOBJ9xK
	 SDrAbsK0eXec4QVHMgXvMrYQa8Db3nmXC7VkNEbEQrfguyKHwOoST3Wlcq8+VGb+Y5
	 ZJgnNQUNO1gEHw6jWgp8guNZ7R59UraIxk/ra490=
Subject: FAILED: patch "[PATCH] leds: flash: leds-qcom-flash: Fix registry access after" failed to apply to 6.6-stable tree
To: krzysztof.kozlowski@linaro.org,fenglin.wu@oss.qualcomm.com,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 17:30:44 +0200
Message-ID: <2025081544-skillet-cofounder-e278@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fab15f57360b1e6620a1d0d6b0fbee896e6c1f07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081544-skillet-cofounder-e278@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fab15f57360b1e6620a1d0d6b0fbee896e6c1f07 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 29 May 2025 08:33:36 +0200
Subject: [PATCH] leds: flash: leds-qcom-flash: Fix registry access after
 re-bind

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

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index b4c19be51c4d..89cf5120f5d5 100644
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
@@ -854,11 +854,17 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
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
@@ -880,6 +886,7 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to allocate regmap field, rc=%d\n", rc);
 		return rc;
 	}
+	devm_kfree(dev, regs); /* devm_regmap_field_bulk_alloc() makes copies */
 
 	platform_set_drvdata(pdev, flash_data);
 	mutex_init(&flash_data->lock);


