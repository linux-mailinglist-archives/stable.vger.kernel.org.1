Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D347E23E7
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjKFNQB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjKFNQA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:16:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B538F3
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:15:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F5CC433C9;
        Mon,  6 Nov 2023 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276557;
        bh=NasVcBkTjtYpaZof9GvkgU7TcxXUppldfpXuwRstUGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=12rLWO8nZjlRfO7e0VxZy3xuxtU6+PT5T5IHn9/7U8hXIN4Eaf5qjypTkFdNPP8LV
         j+756NjaqmsFiKEXHjPA2M7ifqAtR5c7pwEdo8Dp+GqAu27KViJB3U2vLXJjT3xXuB
         4icP79tLX9WTBX6q0y7baNc3JoRpyo9CqssTp35E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 09/88] can: flexcan: remove the auto stop mode for IMX93
Date:   Mon,  6 Nov 2023 14:03:03 +0100
Message-ID: <20231106130306.125664752@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit 63ead535570f13d0e06fda3f2d020c8f5394e998 ]

IMX93 A0 chip involve the internal q-channel handshake in LPCG and
CCM to automatically handle the Flex-CAN IPG STOP signal. Only after
FLEX-CAN enter stop mode then can support the self-wakeup feature.
But meet issue when do the continue system PM stress test. When config
the CAN as wakeup source, the first time after system suspend, any data
on CAN bus can wakeup the system, this is as expect. But the second time
when system suspend, data on CAN bus can't wakeup the system. If continue
this test, we find in odd time system enter suspend, CAN can wakeup the
system, but in even number system enter suspend, CAN can't wakeup the
system. IC find a bug in the auto stop mode logic, and can't fix it easily.
So for the new imx93 A1, IC drop the auto stop mode and involve the
GPR to support stop mode (used before). IC define a bit in GPR which can
trigger the IPG STOP signal to Flex-CAN, let it go into stop mode.
And NXP claim to drop IMX93 A0, and only support IMX93 A1. So this patch
remove the auto stop mode, and add flag FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR
to imx93.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/all/20230726112458.3524165-2-haibo.chen@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan/flexcan-core.c | 46 ++++++++------------------
 drivers/net/can/flexcan/flexcan.h      |  2 --
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ff0fc18baf133..d8be69f4a0c3f 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -348,7 +348,7 @@ static struct flexcan_devtype_data fsl_imx8mp_devtype_data = {
 static struct flexcan_devtype_data fsl_imx93_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
-		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_AUTO_STOP_MODE |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
 		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
@@ -544,11 +544,6 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR) {
 		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
-	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE) {
-		/* For the auto stop mode, software do nothing, hardware will cover
-		 * all the operation automatically after system go into low power mode.
-		 */
-		return 0;
 	}
 
 	return flexcan_low_power_enter_ack(priv);
@@ -574,12 +569,6 @@ static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 	reg_mcr &= ~FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
 
-	/* For the auto stop mode, hardware will exist stop mode
-	 * automatically after system go out of low power mode.
-	 */
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		return 0;
-
 	return flexcan_low_power_exit_ack(priv);
 }
 
@@ -1994,13 +1983,18 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		ret = flexcan_setup_stop_mode_scfw(pdev);
 	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
 		ret = flexcan_setup_stop_mode_gpr(pdev);
-	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		ret = 0;
 	else
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
 
-	if (ret)
+	/* If ret is -EINVAL, this means SoC claim to support stop mode, but
+	 * dts file lack the stop mode property definition. For this case,
+	 * directly return 0, this will skip the wakeup capable setting and
+	 * will not block the driver probe.
+	 */
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
 		return ret;
 
 	device_set_wakeup_capable(&pdev->dev, true);
@@ -2320,16 +2314,8 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		if (device_may_wakeup(device)) {
+		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, true);
-			/* For auto stop mode, need to keep the clock on before
-			 * system go into low power mode. After system go into
-			 * low power mode, hardware will config the flexcan into
-			 * stop mode, and gate off the clock automatically.
-			 */
-			if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-				return 0;
-		}
 
 		err = pm_runtime_force_suspend(device);
 		if (err)
@@ -2347,15 +2333,9 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		/* For the wakeup in auto stop mode, no need to gate on the
-		 * clock here, hardware will do this automatically.
-		 */
-		if (!(device_may_wakeup(device) &&
-		      priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)) {
-			err = pm_runtime_force_resume(device);
-			if (err)
-				return err;
-		}
+		err = pm_runtime_force_resume(device);
+		if (err)
+			return err;
 
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, false);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 91402977780b2..025c3417031f4 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -68,8 +68,6 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
 /* Device supports RX via FIFO */
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
-/* auto enter stop mode to support wakeup */
-#define FLEXCAN_QUIRK_AUTO_STOP_MODE BIT(17)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.42.0



