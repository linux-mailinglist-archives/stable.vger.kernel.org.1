Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B1176AEE7
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjHAJnH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjHAJmm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A691716
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3766150B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FBDC433C8;
        Tue,  1 Aug 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882821;
        bh=kQ/bIJaR44bwcMYishJ9+cuWM6LjeLo5rihxWKCT3FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hLDivuHyHY2Zuf30vPImN0+pq6f46Yd4KRy0fo2yrYGu8F/6oANfdEKVYqs8qYyD
         FgmsXHMzjTv8wT1d49AMek0hcUDrEnewt/j3EPFBYxQmwPjvwCPQX36pW1VFbUsSQ5
         BL9g5M/U8EG763HXjGYBp4ENWhA03ZWurYJLnH2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 015/239] gpio: mvebu: Make use of devm_pwmchip_add
Date:   Tue,  1 Aug 2023 11:17:59 +0200
Message-ID: <20230801091926.191210297@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 1945063eb59e64d2919cb14d54d081476d9e53bb ]

This allows to get rid of a call to pwmchip_remove() in the error path. There
is no .remove function for this driver, so this change fixes a resource leak
when a gpio-mvebu device is unbound.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mvebu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a68f682aec012..a35958e7adf60 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -874,7 +874,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 
 	spin_lock_init(&mvpwm->lock);
 
-	return pwmchip_add(&mvpwm->chip);
+	return devm_pwmchip_add(dev, &mvpwm->chip);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1243,8 +1243,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!mvchip->domain) {
 		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
 			mvchip->chip.label);
-		err = -ENODEV;
-		goto err_pwm;
+		return -ENODEV;
 	}
 
 	err = irq_alloc_domain_generic_chips(
@@ -1296,9 +1295,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 
 err_domain:
 	irq_domain_remove(mvchip->domain);
-err_pwm:
-	pwmchip_remove(&mvchip->mvpwm->chip);
-
 	return err;
 }
 
-- 
2.39.2



