Return-Path: <stable+bounces-133168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB6A91E99
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459FA7B0255
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0301ACECB;
	Thu, 17 Apr 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NfsbEApp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF991F949
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897644; cv=none; b=camHivqqTrtLb3bMbJMG0i9g6+gRdsC/R3FfiE47FOvMvIPKul0+yLZX8dzyvl20CP2qvEXIdgcsRQb3PFAyxgXh6fD6vcgE8YgGp/KyzIX94S9uZBNbdfOfJdR9XCVxspKgCnbgGTLYIWYagqTPmGKC4Izz8ITNS8JJtl6s0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897644; c=relaxed/simple;
	bh=NWjZaMcvWTtHDogSa5+LZAu3QOkfifvzD7o8AEN/v/s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PsrUBDU/QU/4/xKiyrUopmTDpVUVzSJk62l6l21eugIob8lcPbFLj3cgKWOLAuB1YfADQvYAnSdxVP8cwRNu+XHYsPLqpcOfs1c2fXNM8E5RfjiW9W8hniJbmmSExgrxqo1RO8FC25eZ/l7LC36+iFeU4wxRmH9ltzXL1oqUUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NfsbEApp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19A0C4CEE4;
	Thu, 17 Apr 2025 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897644;
	bh=NWjZaMcvWTtHDogSa5+LZAu3QOkfifvzD7o8AEN/v/s=;
	h=Subject:To:Cc:From:Date:From;
	b=NfsbEAppoFz433KWuN8lZOS00vYBJNm/myDiIHzuomf70X1LusCmdD6K3oAwhTg0j
	 5p6APbGzLCK2RKs5IQl7AHG+89RMj10yqs1DUuFkqG43wAYNxE07Te0Zi1eSBvdPWv
	 SQQwnX8CK8EFBVorI0ty5LQ4kh1m8sDrG338+Y6U=
Subject: FAILED: patch "[PATCH] thermal/drivers/mediatek/lvts: Disable Stage 3 thermal" failed to apply to 6.6-stable tree
To: nfraprado@collabora.com,angelogioacchino.delregno@collabora.com,daniel.lezcano@linaro.org,yuanhsinte@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:47:21 +0200
Message-ID: <2025041721-net-slider-2204@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c612cbcdf603aefb3358b2e3964dcd5aa3f827a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041721-net-slider-2204@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c612cbcdf603aefb3358b2e3964dcd5aa3f827a0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
Date: Mon, 13 Jan 2025 10:27:13 -0300
Subject: [PATCH] thermal/drivers/mediatek/lvts: Disable Stage 3 thermal
 threshold
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Stage 3 thermal threshold is currently configured during
the controller initialization to 105 Celsius. From the kernel
perspective, this configuration is harmful because:
* The stage 3 interrupt that gets triggered when the threshold is
  crossed is not handled in any way by the IRQ handler, it just gets
  cleared. Besides, the temperature used for stage 3 comes from the
  sensors, and the critical thermal trip points described in the
  Devicetree will already cause a shutdown when crossed (at a lower
  temperature, of 100 Celsius, for all SoCs currently using this
  driver).
* The only effect of crossing the stage 3 threshold that has been
  observed is that it causes the machine to no longer be able to enter
  suspend. Even if that was a result of a momentary glitch in the
  temperature reading of a sensor (as has been observed on the
  MT8192-based Chromebooks).

For those reasons, disable the Stage 3 thermal threshold configuration.

Cc: stable@vger.kernel.org
Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/
Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20250113-mt8192-lvts-filtered-suspend-fix-v2-2-07a25200c7c6@collabora.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index a1a438ebad33..0aaa44b734ca 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,7 +65,7 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x8300318C
+#define LVTS_MONINT_CONF			0x0300318C
 
 #define LVTS_MONINT_OFFSET_SENSOR0		0xC
 #define LVTS_MONINT_OFFSET_SENSOR1		0x180
@@ -91,8 +91,6 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
-#define LVTS_HW_TSHUT_TEMP		105000
-
 #define LVTS_MINIMUM_THRESHOLD		20000
 
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
@@ -145,7 +143,6 @@ struct lvts_ctrl {
 	struct lvts_sensor sensors[LVTS_SENSOR_MAX];
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
-	u32 hw_tshut_raw_temp;
 	u8 valid_sensor_mask;
 	int mode;
 	void __iomem *base;
@@ -837,14 +834,6 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 		 */
 		lvts_ctrl[i].mode = lvts_data->lvts_ctrl[i].mode;
 
-		/*
-		 * The temperature to raw temperature must be done
-		 * after initializing the calibration.
-		 */
-		lvts_ctrl[i].hw_tshut_raw_temp =
-			lvts_temp_to_raw(LVTS_HW_TSHUT_TEMP,
-					 lvts_data->temp_factor);
-
 		lvts_ctrl[i].low_thresh = INT_MIN;
 		lvts_ctrl[i].high_thresh = INT_MIN;
 	}
@@ -919,7 +908,6 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 *         10 : Selected sensor with bits 19-18
 	 *         11 : Reserved
 	 */
-	writel(BIT(16), LVTS_PROTCTL(lvts_ctrl->base));
 
 	/*
 	 * LVTS_PROTTA : Stage 1 temperature threshold
@@ -932,8 +920,8 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 *
 	 * writel(0x0, LVTS_PROTTA(lvts_ctrl->base));
 	 * writel(0x0, LVTS_PROTTB(lvts_ctrl->base));
+	 * writel(0x0, LVTS_PROTTC(lvts_ctrl->base));
 	 */
-	writel(lvts_ctrl->hw_tshut_raw_temp, LVTS_PROTTC(lvts_ctrl->base));
 
 	/*
 	 * LVTS_MONINT : Interrupt configuration register


