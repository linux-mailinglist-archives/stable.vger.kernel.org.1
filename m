Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACDC703AC2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbjEORzU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244991AbjEORyy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7C183DF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D2DF62F9D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B62C433EF;
        Mon, 15 May 2023 17:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173168;
        bh=0e1hVz1OfnBNAurXHdnbrowvGPbmelbq7rWmCHDdTWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuNCk5q2vf3H4Z3BS5WPD6V2BF/RNiZt2x3+yBTwkjaO121Xksg19OqdME/sO+Qjf
         zgn+kDY1kO+WQlap2QLwHpWQQ0V7MfSdVEU3QwmGvqFHjIH1rk13PUTw4L5z8DYO3t
         G7OMESg1VCi7626gi6wjxGu3Rfi2olIg8veJIUzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tian Tao <tiantao6@hisilicon.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 5.10 379/381] drm/exynos: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Mon, 15 May 2023 18:30:30 +0200
Message-Id: <20230515161754.079396066@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

commit a4e5eed2c6a689ef2b6ad8d7ae86665c69039379 upstream.

After this patch cbe16f35bee68 genirq: Add IRQF_NO_AUTOEN for
request_irq/nmi() is merged. request_irq() after setting
IRQ_NOAUTOEN as below

irq_set_status_flags(irq, IRQ_NOAUTOEN);
request_irq(dev, irq...);
can be replaced by request_irq() with IRQF_NO_AUTOEN flag.

v2:
Fix the problem of using wrong flags

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c |    4 ++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c       |    7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -775,8 +775,8 @@ static int decon_conf_irq(struct decon_c
 			return irq;
 		}
 	}
-	irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(ctx->dev, irq, handler, flags, "drm_decon", ctx);
+	ret = devm_request_irq(ctx->dev, irq, handler,
+			       flags | IRQF_NO_AUTOEN, "drm_decon", ctx);
 	if (ret < 0) {
 		dev_err(ctx->dev, "IRQ %s request failed\n", name);
 		return ret;
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1353,10 +1353,9 @@ static int exynos_dsi_register_te_irq(st
 	}
 
 	te_gpio_irq = gpio_to_irq(dsi->te_gpio);
-	irq_set_status_flags(te_gpio_irq, IRQ_NOAUTOEN);
 
 	ret = request_threaded_irq(te_gpio_irq, exynos_dsi_te_irq_handler, NULL,
-					IRQF_TRIGGER_RISING, "TE", dsi);
+				   IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN, "TE", dsi);
 	if (ret) {
 		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
 		gpio_free(dsi->te_gpio);
@@ -1802,9 +1801,9 @@ static int exynos_dsi_probe(struct platf
 	if (dsi->irq < 0)
 		return dsi->irq;
 
-	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, dsi->irq, NULL,
-					exynos_dsi_irq, IRQF_ONESHOT,
+					exynos_dsi_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					dev_name(dev), dsi);
 	if (ret) {
 		dev_err(dev, "failed to request dsi irq\n");


