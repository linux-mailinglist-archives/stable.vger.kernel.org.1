Return-Path: <stable+bounces-83798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8299C9A2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EC72884BA
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47E19F114;
	Mon, 14 Oct 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+2D+I2V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A553156F3F
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907444; cv=none; b=Z492D12NMx0f5Udt+EiUUIMr+dN3UnL70VJlFMSj+Uu/XXi0WlEqfEsIglWmoviaOuxkjo/yx7t3KvFjhJmj6zni5L4raeb2YqBVBnQrh4TjKlTjULFIz8NlYUdMwlkkWCn2lYD7FOcEDSQP6WArbQAKHiLo45tj4EBxit32WRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907444; c=relaxed/simple;
	bh=o/3dS5vKtBG82/S8hS1yzuuWKI02PDquJGLZuh8vkrA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ot2hcigAXWhrSJwYl3Vzz7NuTz/eNMM7wxEDRr1ndKmTc1Saw7rs9bqOKwuLGCCtDpyj4bjSxczY11yRNfr6NDxsxQVS9/CjR4rYFyW/S5dCr6ab2Mq7e2TJryv22+gNoc6a1sgi1bVoX0XspXzR16Ms1arm+i33CBCgnVwoT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+2D+I2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D0C4CEC3;
	Mon, 14 Oct 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728907443;
	bh=o/3dS5vKtBG82/S8hS1yzuuWKI02PDquJGLZuh8vkrA=;
	h=Subject:To:Cc:From:Date:From;
	b=m+2D+I2VwXGdafNiLTwsJYXQNRQUsyWDtBp5tgv2cPDa7Rsqlj4Folq+AjHHk2YSu
	 2cZ10wvhn+bKqov4XErTHBS8n3M5ZneRzbbU4WMVwCXsqLEwIhQ6G6l1hR647iSHTN
	 IMVd4Z5umeUhz+Qicy7NqEmLB+pBSgoBbojeTxeI=
Subject: FAILED: patch "[PATCH] net: dsa: lan9303: ensure chip reset and wait for READY" failed to apply to 4.19-stable tree
To: agust@denx.de,alexander.sverdlin@siemens.com,kuba@kernel.org,olteanv@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 14:04:00 +0200
Message-ID: <2024101400-rectal-cattle-3833@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 5c14e51d2d7df49fe0d4e64a12c58d2542f452ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101400-rectal-cattle-3833@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5c14e51d2d7d ("net: dsa: lan9303: ensure chip reset and wait for READY status")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c14e51d2d7df49fe0d4e64a12c58d2542f452ff Mon Sep 17 00:00:00 2001
From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 4 Oct 2024 13:36:54 +0200
Subject: [PATCH] net: dsa: lan9303: ensure chip reset and wait for READY
 status

Accessing device registers seems to be not reliable, the chip
revision is sometimes detected wrongly (0 instead of expected 1).

Ensure that the chip reset is performed via reset GPIO and then
wait for 'Device Ready' status in HW_CFG register before doing
any register initializations.

Cc: stable@vger.kernel.org
Fixes: a1292595e006 ("net: dsa: add new DSA switch driver for the SMSC-LAN9303")
Signed-off-by: Anatolij Gustschin <agust@denx.de>
[alex: reworked using read_poll_timeout()]
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://patch.msgid.link/20241004113655.3436296-1-alexander.sverdlin@siemens.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 268949939636..d246f95d57ec 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
+#include <linux/iopoll.h>
 #include <linux/mutex.h>
 #include <linux/mii.h>
 #include <linux/of.h>
@@ -839,6 +840,8 @@ static void lan9303_handle_reset(struct lan9303 *chip)
 	if (!chip->reset_gpio)
 		return;
 
+	gpiod_set_value_cansleep(chip->reset_gpio, 1);
+
 	if (chip->reset_duration != 0)
 		msleep(chip->reset_duration);
 
@@ -864,8 +867,34 @@ static int lan9303_disable_processing(struct lan9303 *chip)
 static int lan9303_check_device(struct lan9303 *chip)
 {
 	int ret;
+	int err;
 	u32 reg;
 
+	/* In I2C-managed configurations this polling loop will clash with
+	 * switch's reading of EEPROM right after reset and this behaviour is
+	 * not configurable. While lan9303_read() already has quite long retry
+	 * timeout, seems not all cases are being detected as arbitration error.
+	 *
+	 * According to datasheet, EEPROM loader has 30ms timeout (in case of
+	 * missing EEPROM).
+	 *
+	 * Loading of the largest supported EEPROM is expected to take at least
+	 * 5.9s.
+	 */
+	err = read_poll_timeout(lan9303_read, ret,
+				!ret && reg & LAN9303_HW_CFG_READY,
+				20000, 6000000, false,
+				chip->regmap, LAN9303_HW_CFG, &reg);
+	if (ret) {
+		dev_err(chip->dev, "failed to read HW_CFG reg: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+	if (err) {
+		dev_err(chip->dev, "HW_CFG not ready: 0x%08x\n", reg);
+		return err;
+	}
+
 	ret = lan9303_read(chip->regmap, LAN9303_CHIP_REV, &reg);
 	if (ret) {
 		dev_err(chip->dev, "failed to read chip revision register: %d\n",


