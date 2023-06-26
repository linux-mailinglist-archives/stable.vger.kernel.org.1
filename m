Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3873E820
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjFZSXQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjFZSXC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBBD19AA
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D67E60F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B6C433C8;
        Mon, 26 Jun 2023 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803696;
        bh=E34G79hfY9gKLRtvfSh+ldeJOR/dny+TKpgI0MKgf+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHm6XYm1WKrJva2sHMQdAQtSTVrzdSKT1e8nzvPLq/m279bsY8wYEQ4wO6fNVjfr5
         QevxFJFJwzuL8EhH9RJHGGotXjqnPj786+Z7MdBN2p4UEeiuYxuA57bElNZXkiffb7
         oMWoXnjs/fzD3D5Gqg1CSBjqhyn2qBDzd3/X0sV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiawen Wu <jiawenwu@trustnetic.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 146/199] gpiolib: Fix GPIO chip IRQ initialization restriction
Date:   Mon, 26 Jun 2023 20:10:52 +0200
Message-ID: <20230626180812.024436215@linuxfoundation.org>
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

From: Jiawen Wu <jiawenwu@trustnetic.com>

[ Upstream commit 8c00914e5438e3636f26b4f814b3297ae2a1b9ee ]

In case of gpio-regmap, IRQ chip is added by regmap-irq and associated with
GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag was not
added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to return
-EPROBE_DEFER.

Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members before initialization")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4472214fcd43a..1cfddbb3443d0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1763,6 +1763,14 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
 
+	/*
+	 * Using barrier() here to prevent compiler from reordering
+	 * gc->irq.initialized before adding irqdomain.
+	 */
+	barrier();
+
+	gc->irq.initialized = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
-- 
2.39.2



