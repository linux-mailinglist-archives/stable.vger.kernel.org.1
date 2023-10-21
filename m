Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA0B7D1DEF
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjJUPgt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjJUPgs (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sat, 21 Oct 2023 11:36:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E215B114
        for <Stable@vger.kernel.org>; Sat, 21 Oct 2023 08:36:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296B2C433C8;
        Sat, 21 Oct 2023 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697902603;
        bh=+rH3s7o30AwSdVnE9zGFlzMN3TXoTYx93j6Wl1Hl74g=;
        h=Subject:To:From:Date:From;
        b=ijOmiaVJCpJ02qY5o8bF40ySHBLNKgHQpfaGE2GDg5EgJGsL486wUmMmjVprmHv40
         7MZgNObuTVavdSoV13tuoGaZBADy3qxHRf+b1XC8h4Ju9W4w/pI52Ka4SXQ+UcRhjs
         JOeftxSFth553Gk7CCJJgCHaa1DceYmJ1boVCeBU=
Subject: patch "iio: exynos-adc: request second interupt only when touchscreen mode" added to char-misc-linus
To:     m.szyprowski@samsung.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 17:36:34 +0200
Message-ID: <2023102134-victory-distant-412c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: exynos-adc: request second interupt only when touchscreen mode

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 865b080e3229102f160889328ce2e8e97aa65ea0 Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Mon, 9 Oct 2023 12:14:12 +0200
Subject: iio: exynos-adc: request second interupt only when touchscreen mode
 is used

Second interrupt is needed only when touchscreen mode is used, so don't
request it unconditionally. This removes the following annoying warning
during boot:

exynos-adc 14d10000.adc: error -ENXIO: IRQ index 1 not found

Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20231009101412.916922-1-m.szyprowski@samsung.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/exynos_adc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index cff1ba57fb16..43c8af41b4a9 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -826,16 +826,26 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* leave out any TS related code if unreachable */
+	if (IS_REACHABLE(CONFIG_INPUT)) {
+		has_ts = of_property_read_bool(pdev->dev.of_node,
+					       "has-touchscreen") || pdata;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
 
-	irq = platform_get_irq(pdev, 1);
-	if (irq == -EPROBE_DEFER)
-		return irq;
+	if (has_ts) {
+		irq = platform_get_irq(pdev, 1);
+		if (irq == -EPROBE_DEFER)
+			return irq;
 
-	info->tsirq = irq;
+		info->tsirq = irq;
+	} else {
+		info->tsirq = -1;
+	}
 
 	info->dev = &pdev->dev;
 
@@ -900,12 +910,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	/* leave out any TS related code if unreachable */
-	if (IS_REACHABLE(CONFIG_INPUT)) {
-		has_ts = of_property_read_bool(pdev->dev.of_node,
-					       "has-touchscreen") || pdata;
-	}
-
 	if (pdata)
 		info->delay = pdata->delay;
 	else
-- 
2.42.0


