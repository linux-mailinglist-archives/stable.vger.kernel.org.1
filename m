Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604C47ECF85
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjKOTtB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjKOTtB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43627B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C058EC433C7;
        Wed, 15 Nov 2023 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077736;
        bh=YKvNEZqEFfwG+8/ilVU01NRijWvku8CFNhauEFd4564=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlICHW9U8HxI2iRv0Wtr4hhbD9UKO7Z8FfqWTXaVPnPNRXC3ehkjvX0FL7SZgz9PS
         AURO7Wk41e3wgd+jhXXkSPtRhUnbcu2gGhP/zVqpmpvgmyBS9eLwaK1PN77xyIL0Ib
         x40faSsiSmlaK9hWSgatSyXjkd3ZLo1dj3i1sD+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 487/603] rtc: brcmstb-waketimer: support level alarm_irq
Date:   Wed, 15 Nov 2023 14:17:12 -0500
Message-ID: <20231115191646.051650254@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit e005a9b35b464be5b2e0194f717e90e7e496785d ]

Some devices (e.g. BCM72112) use an alarm_irq interrupt that is
connected to a level interrupt controller rather than an edge
interrupt controller. In this case, the interrupt cannot be left
enabled by the irq handler while preserving the hardware wake-up
signal on wake capable devices or an interrupt storm will occur.

The alarm_expired flag is introduced to allow the disabling of
the interrupt when an alarm expires and to support balancing the
calls to disable_irq() and enable_irq() in accordance with the
existing design.

Fixes: 24304a87158a ("rtc: brcmstb-waketimer: allow use as non-wake alarm")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20230830224747.1663044-1-opendmb@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 47 ++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 3cdc015692ca6..1a65a4e0dc003 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright © 2014-2017 Broadcom
+ * Copyright © 2014-2023 Broadcom
  */
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
@@ -34,6 +34,7 @@ struct brcmstb_waketmr {
 	u32 rate;
 	unsigned long rtc_alarm;
 	bool alarm_en;
+	bool alarm_expired;
 };
 
 #define BRCMSTB_WKTMR_EVENT		0x00
@@ -64,6 +65,11 @@ static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *timer)
 	writel_relaxed(reg - 1, timer->base + BRCMSTB_WKTMR_ALARM);
 	writel_relaxed(WKTMR_ALARM_EVENT, timer->base + BRCMSTB_WKTMR_EVENT);
 	(void)readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
+	if (timer->alarm_expired) {
+		timer->alarm_expired = false;
+		/* maintain call balance */
+		enable_irq(timer->alarm_irq);
+	}
 }
 
 static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
@@ -105,10 +111,17 @@ static irqreturn_t brcmstb_alarm_irq(int irq, void *data)
 		return IRQ_HANDLED;
 
 	if (timer->alarm_en) {
-		if (!device_may_wakeup(timer->dev))
+		if (device_may_wakeup(timer->dev)) {
+			disable_irq_nosync(irq);
+			timer->alarm_expired = true;
+		} else {
 			writel_relaxed(WKTMR_ALARM_EVENT,
 				       timer->base + BRCMSTB_WKTMR_EVENT);
+		}
 		rtc_update_irq(timer->rtc, 1, RTC_IRQF | RTC_AF);
+	} else {
+		writel_relaxed(WKTMR_ALARM_EVENT,
+			       timer->base + BRCMSTB_WKTMR_EVENT);
 	}
 
 	return IRQ_HANDLED;
@@ -221,8 +234,14 @@ static int brcmstb_waketmr_alarm_enable(struct device *dev,
 		    !brcmstb_waketmr_is_pending(timer))
 			return -EINVAL;
 		timer->alarm_en = true;
-		if (timer->alarm_irq)
+		if (timer->alarm_irq) {
+			if (timer->alarm_expired) {
+				timer->alarm_expired = false;
+				/* maintain call balance */
+				enable_irq(timer->alarm_irq);
+			}
 			enable_irq(timer->alarm_irq);
+		}
 	} else if (!enabled && timer->alarm_en) {
 		if (timer->alarm_irq)
 			disable_irq(timer->alarm_irq);
@@ -352,6 +371,17 @@ static int brcmstb_waketmr_suspend(struct device *dev)
 	return brcmstb_waketmr_prepare_suspend(timer);
 }
 
+static int brcmstb_waketmr_suspend_noirq(struct device *dev)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+
+	/* Catch any alarms occurring prior to noirq */
+	if (timer->alarm_expired && device_may_wakeup(dev))
+		return -EBUSY;
+
+	return 0;
+}
+
 static int brcmstb_waketmr_resume(struct device *dev)
 {
 	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
@@ -368,10 +398,17 @@ static int brcmstb_waketmr_resume(struct device *dev)
 
 	return ret;
 }
+#else
+#define brcmstb_waketmr_suspend		NULL
+#define brcmstb_waketmr_suspend_noirq	NULL
+#define brcmstb_waketmr_resume		NULL
 #endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(brcmstb_waketmr_pm_ops,
-			 brcmstb_waketmr_suspend, brcmstb_waketmr_resume);
+static const struct dev_pm_ops brcmstb_waketmr_pm_ops = {
+	.suspend	= brcmstb_waketmr_suspend,
+	.suspend_noirq	= brcmstb_waketmr_suspend_noirq,
+	.resume		= brcmstb_waketmr_resume,
+};
 
 static const __maybe_unused struct of_device_id brcmstb_waketmr_of_match[] = {
 	{ .compatible = "brcm,brcmstb-waketimer" },
-- 
2.42.0



