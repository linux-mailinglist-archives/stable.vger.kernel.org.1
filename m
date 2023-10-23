Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E435A7D35BD
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjJWLvZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjJWLvX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:51:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A5C100
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:51:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A78C433C9;
        Mon, 23 Oct 2023 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061876;
        bh=uapDjxZoOZ2xT+4NHzetIySZbt0xpnCRHtuT1RNB93I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmM0LFVFK+9dPVC5H90b6mOm3jNmJqB7xCbNbB2EdcLwSWPb8lnT0qa4imG6u6yJ5
         lt+YFOcwcoyUt2pv7IdkA/DKdNmcP14XMf7F0+8Wtf8frN/FJ5FF2WoLItkaRfo7Kl
         27vlEZYTFGQYiyJ8n9nnijkzyxi0Vo5m/IuapCFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 195/202] gpio: vf610: make irq_chip immutable
Date:   Mon, 23 Oct 2023 12:58:22 +0200
Message-ID: <20231023104832.125811974@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit e6ef4f8ede09f4af7cde000717b349b50bc62576 ]

Since recently, the kernel is nagging about mutable irq_chips:

    "not an immutable chip, please consider fixing it!"

Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
helper functions and call the appropriate gpiolib functions.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: 430232619791 ("gpio: vf610: mask the gpio irq in system suspend and support wakeup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-vf610.c | 41 ++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index c2c38f13801f5..a548ac3fbb207 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -29,7 +29,6 @@ struct fsl_gpio_soc_data {
 
 struct vf610_gpio_port {
 	struct gpio_chip gc;
-	struct irq_chip ic;
 	void __iomem *base;
 	void __iomem *gpio_base;
 	const struct fsl_gpio_soc_data *sdata;
@@ -206,20 +205,24 @@ static int vf610_gpio_irq_set_type(struct irq_data *d, u32 type)
 
 static void vf610_gpio_irq_mask(struct irq_data *d)
 {
-	struct vf610_gpio_port *port =
-		gpiochip_get_data(irq_data_get_irq_chip_data(d));
-	void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct vf610_gpio_port *port = gpiochip_get_data(gc);
+	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
+	void __iomem *pcr_base = port->base + PORT_PCR(gpio_num);
 
 	vf610_gpio_writel(0, pcr_base);
+	gpiochip_disable_irq(gc, gpio_num);
 }
 
 static void vf610_gpio_irq_unmask(struct irq_data *d)
 {
-	struct vf610_gpio_port *port =
-		gpiochip_get_data(irq_data_get_irq_chip_data(d));
-	void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct vf610_gpio_port *port = gpiochip_get_data(gc);
+	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
+	void __iomem *pcr_base = port->base + PORT_PCR(gpio_num);
 
-	vf610_gpio_writel(port->irqc[d->hwirq] << PORT_PCR_IRQC_OFFSET,
+	gpiochip_enable_irq(gc, gpio_num);
+	vf610_gpio_writel(port->irqc[gpio_num] << PORT_PCR_IRQC_OFFSET,
 			  pcr_base);
 }
 
@@ -236,6 +239,17 @@ static int vf610_gpio_irq_set_wake(struct irq_data *d, u32 enable)
 	return 0;
 }
 
+static const struct irq_chip vf610_irqchip = {
+	.name = "gpio-vf610",
+	.irq_ack = vf610_gpio_irq_ack,
+	.irq_mask = vf610_gpio_irq_mask,
+	.irq_unmask = vf610_gpio_irq_unmask,
+	.irq_set_type = vf610_gpio_irq_set_type,
+	.irq_set_wake = vf610_gpio_irq_set_wake,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void vf610_gpio_disable_clk(void *data)
 {
 	clk_disable_unprepare(data);
@@ -248,7 +262,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct gpio_chip *gc;
 	struct gpio_irq_chip *girq;
-	struct irq_chip *ic;
 	int i;
 	int ret;
 
@@ -315,14 +328,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	gc->direction_output = vf610_gpio_direction_output;
 	gc->set = vf610_gpio_set;
 
-	ic = &port->ic;
-	ic->name = "gpio-vf610";
-	ic->irq_ack = vf610_gpio_irq_ack;
-	ic->irq_mask = vf610_gpio_irq_mask;
-	ic->irq_unmask = vf610_gpio_irq_unmask;
-	ic->irq_set_type = vf610_gpio_irq_set_type;
-	ic->irq_set_wake = vf610_gpio_irq_set_wake;
-
 	/* Mask all GPIO interrupts */
 	for (i = 0; i < gc->ngpio; i++)
 		vf610_gpio_writel(0, port->base + PORT_PCR(i));
@@ -331,7 +336,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	vf610_gpio_writel(~0, port->base + PORT_ISFR);
 
 	girq = &gc->irq;
-	girq->chip = ic;
+	gpio_irq_chip_set_chip(girq, &vf610_irqchip);
 	girq->parent_handler = vf610_gpio_irq_handler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(&pdev->dev, 1,
-- 
2.42.0



