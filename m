Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ED17DAC5B
	for <lists+stable@lfdr.de>; Sun, 29 Oct 2023 13:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJ2MQk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 29 Oct 2023 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2MQj (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 29 Oct 2023 08:16:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819B6BE
        for <Stable@vger.kernel.org>; Sun, 29 Oct 2023 05:16:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF88C433C8;
        Sun, 29 Oct 2023 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698581797;
        bh=1SSYP92B6JkrBi6w4PBeEs48X7udptnQxGjYhwoXPDk=;
        h=Subject:To:Cc:From:Date:From;
        b=o6TTHNRAs2oNOW8D78ThxQPmQcrxq/lIV4gO1ASA6JY9EawU91zVtU+XavVsuUEbt
         mlwiz5AFiohMCpRsk2lgbbMLDq5/eW0cWmmF36hCfADwqVNnYobLe9f/RAtbuS5G0z
         mcuzgBG8jWqTxaptZeftBe7Q51sraj6WKnLrIf0s=
Subject: FAILED: patch "[PATCH] iio: exynos-adc: request second interupt only when" failed to apply to 4.19-stable tree
To:     m.szyprowski@samsung.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 29 Oct 2023 13:16:32 +0100
Message-ID: <2023102932-catatonic-decline-3ee9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 865b080e3229102f160889328ce2e8e97aa65ea0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102932-catatonic-decline-3ee9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 865b080e3229102f160889328ce2e8e97aa65ea0 Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Mon, 9 Oct 2023 12:14:12 +0200
Subject: [PATCH] iio: exynos-adc: request second interupt only when
 touchscreen mode is used

Second interrupt is needed only when touchscreen mode is used, so don't
request it unconditionally. This removes the following annoying warning
during boot:

exynos-adc 14d10000.adc: error -ENXIO: IRQ index 1 not found

Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20231009101412.916922-1-m.szyprowski@samsung.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

