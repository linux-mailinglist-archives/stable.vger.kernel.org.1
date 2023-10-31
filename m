Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368BC7DD428
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjJaRH1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjJaRHH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:07:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3801FF5
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:06:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83012C433C7;
        Tue, 31 Oct 2023 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771960;
        bh=CyFqALFA/ufUDJ4ewZbZpEwvK1ZNyXrPoxdwlZcvci0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zc7SF6/5olo8bR52YYoj+TqMtEEm+6FJsNzZyBPacXMuuGcItetL054rkjIaSRoAn
         xoqPFrF+BT16wDnu4guDFj1+d6QDkHdX5OH3XHSnc+O3hBojnf0scNzCgFYs05a7ph
         1qbNI8Gy6L7+VoP2y38i++YkNpIbWDI8ofgwO1Ks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 61/86] iio: exynos-adc: request second interupt only when touchscreen mode is used
Date:   Tue, 31 Oct 2023 18:01:26 +0100
Message-ID: <20231031165920.474570450@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 865b080e3229102f160889328ce2e8e97aa65ea0 upstream.

Second interrupt is needed only when touchscreen mode is used, so don't
request it unconditionally. This removes the following annoying warning
during boot:

exynos-adc 14d10000.adc: error -ENXIO: IRQ index 1 not found

Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20231009101412.916922-1-m.szyprowski@samsung.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/exynos_adc.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -826,16 +826,26 @@ static int exynos_adc_probe(struct platf
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
-
-	info->tsirq = irq;
+	if (has_ts) {
+		irq = platform_get_irq(pdev, 1);
+		if (irq == -EPROBE_DEFER)
+			return irq;
+
+		info->tsirq = irq;
+	} else {
+		info->tsirq = -1;
+	}
 
 	info->dev = &pdev->dev;
 
@@ -900,12 +910,6 @@ static int exynos_adc_probe(struct platf
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


