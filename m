Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92B9703C1A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbjEOSJb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbjEOSJN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943A515527
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C0163073
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE679C433EF;
        Mon, 15 May 2023 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684174017;
        bh=3BlsnDXcYCnJiZYAu6Ms81QqM4FSNcNiTtEGLRtmxSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiGncT98x8ax3BfUiciYxHnepm89rL43IECkQhcxNQEsfJY5rq6cXvt07eYcEZxWD
         JTNcEK/BjbeIaxqQpBfNiar/RBT6SrDVXH2ZktO2JwY77VkGtprRSAd7BpIQWJ7nUK
         KE2b4oWi3RnZNoXmIfZ53rioztwQWQGYag8bDE00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tian Tao <tiantao6@hisilicon.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 5.4 280/282] drm/exynos: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Mon, 15 May 2023 18:30:58 +0200
Message-Id: <20230515161730.777970735@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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
@@ -1350,10 +1350,9 @@ static int exynos_dsi_register_te_irq(st
 	}
 
 	te_gpio_irq = gpio_to_irq(dsi->te_gpio);
-	irq_set_status_flags(te_gpio_irq, IRQ_NOAUTOEN);
 
 	ret = request_threaded_irq(te_gpio_irq, exynos_dsi_te_irq_handler, NULL,
-					IRQF_TRIGGER_RISING, "TE", dsi);
+				   IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN, "TE", dsi);
 	if (ret) {
 		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
 		gpio_free(dsi->te_gpio);
@@ -1792,9 +1791,9 @@ static int exynos_dsi_probe(struct platf
 		return dsi->irq;
 	}
 
-	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, dsi->irq, NULL,
-					exynos_dsi_irq, IRQF_ONESHOT,
+					exynos_dsi_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					dev_name(dev), dsi);
 	if (ret) {
 		dev_err(dev, "failed to request dsi irq\n");


