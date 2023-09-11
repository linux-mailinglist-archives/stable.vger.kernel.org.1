Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAB79BFE8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbjIKVN6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbjIKOVn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:21:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C55EDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:21:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F73C433C7;
        Mon, 11 Sep 2023 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442098;
        bh=8h1z8IZq5A00Vc4PwfkDGn/x7MuFJ82siDVvjL4poc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCeHVBkQXfW1mjULMX167fy5n3q5vaYy4GD9JRmsJSVc1uVybB6jRYckZzaKPJwAy
         TELPkyzJmtkTpumHqTCzEodW7T60b6nURLXyT2Tp06qiF/K1HLF0XvpHkSZEiczKjy
         uA83cV8Rd4kkhBnlueNc82/IwjIchrcHPJwqpRqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Mack <daniel@zonque.org>,
        stable@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.5 638/739] gpio: zynq: restore zynq_gpio_irq_reqres/zynq_gpio_irq_relres callbacks
Date:   Mon, 11 Sep 2023 15:47:17 +0200
Message-ID: <20230911134708.915141134@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mack <daniel@zonque.org>

commit 180b10bd160b014448366e5bc86e0558f8acb74f upstream.

Commit f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip
warning") ditched the open-coded resource allocation handlers in favor
of the generic ones. These generic handlers don't maintain the PM
runtime anymore, which causes a regression in that level IRQs are no
longer reported.

Restore the original handlers to fix this.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Fixes: f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip warning")
Cc: stable@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-zynq.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 0a7264aabe48..324e942c0650 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -575,6 +575,26 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
+static int zynq_gpio_irq_reqres(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(chip->parent);
+	if (ret < 0)
+		return ret;
+
+	return gpiochip_reqres_irq(chip, d->hwirq);
+}
+
+static void zynq_gpio_irq_relres(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+
+	gpiochip_relres_irq(chip, d->hwirq);
+	pm_runtime_put(chip->parent);
+}
+
 /* irq chip descriptor */
 static const struct irq_chip zynq_gpio_level_irqchip = {
 	.name		= DRIVER_NAME,
@@ -584,9 +604,10 @@ static const struct irq_chip zynq_gpio_level_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources = zynq_gpio_irq_reqres,
+	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
 			  IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static const struct irq_chip zynq_gpio_edge_irqchip = {
@@ -597,8 +618,9 @@ static const struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources = zynq_gpio_irq_reqres,
+	.irq_release_resources = zynq_gpio_irq_relres,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
-- 
2.42.0



