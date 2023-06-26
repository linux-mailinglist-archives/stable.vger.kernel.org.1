Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99773E82C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjFZSXm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjFZSXW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9BA171F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AE160F76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210EFC433C0;
        Mon, 26 Jun 2023 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803708;
        bh=L0Ggq2lNCEivK3SWsW+C/LiJpC98UjhY2u6R+4ivwQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wWoSX9Rd7NRQlDG5k/MsdzWXyNJ3Dp/mVUoArRwQ9YBf969oJLopF6/wsGEwZq6Ky
         1XNiu6Zehfllc34Ru0GJF3s3c+yei4G4QauquvdVm8JtWjOzvF8JzjYTDaur3diunH
         0BxSH4qOQPIv8dOrFfA7vkZ0pQeFzN6utKN+IfJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiawen Wu <jiawenwu@trustnetic.com>,
        Michael Walle <mwalle@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 149/199] gpiolib: Fix irq_domain resource tracking for gpiochip_irqchip_add_domain()
Date:   Mon, 26 Jun 2023 20:10:55 +0200
Message-ID: <20230626180812.173981939@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Michael Walle <mwalle@kernel.org>

[ Upstream commit ff7a1790fbf92f1bdd0966d3f0da3ea808ede876 ]

Up until commit 6a45b0e2589f ("gpiolib: Introduce
gpiochip_irqchip_add_domain()") all irq_domains were allocated
by gpiolib itself and thus gpiolib also takes care of freeing it.

With gpiochip_irqchip_add_domain() a user of gpiolib can associate an
irq_domain with the gpio_chip. This irq_domain is not managed by
gpiolib and therefore must not be freed by gpiolib.

Fixes: 6a45b0e2589f ("gpiolib: Introduce gpiochip_irqchip_add_domain()")
Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c      | 3 ++-
 include/linux/gpio/driver.h | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1cfddbb3443d0..ce8f71e06eb62 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1716,7 +1716,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 	}
 
 	/* Remove all IRQ mappings and delete the domain */
-	if (gc->irq.domain) {
+	if (!gc->irq.domain_is_allocated_externally && gc->irq.domain) {
 		unsigned int irq;
 
 		for (offset = 0; offset < gc->ngpio; offset++) {
@@ -1762,6 +1762,7 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
+	gc->irq.domain_is_allocated_externally = true;
 
 	/*
 	 * Using barrier() here to prevent compiler from reordering
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index ccd8a512d8546..b769ff6b00fdd 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -244,6 +244,14 @@ struct gpio_irq_chip {
 	 */
 	bool initialized;
 
+	/**
+	 * @domain_is_allocated_externally:
+	 *
+	 * True it the irq_domain was allocated outside of gpiolib, in which
+	 * case gpiolib won't free the irq_domain itself.
+	 */
+	bool domain_is_allocated_externally;
+
 	/**
 	 * @init_hw: optional routine to initialize hardware before
 	 * an IRQ chip will be added. This is quite useful when
-- 
2.39.2



