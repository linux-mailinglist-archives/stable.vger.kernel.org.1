Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85AF73EA49
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjFZSp2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjFZSp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DADFA
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF5360F56
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8000EC433C8;
        Mon, 26 Jun 2023 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805125;
        bh=LLCvYwMHEXWm5SuHxbVaJMRG/uwMYoTI9uLtZG+eGPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2t7Qjtn6ymT8osSLcXufq64uk6CRkbV8OENxOartpReplY+5LiJkWvepqy7Rvw15
         cBJU7/eqnaFSJo5z9wvEcA+y3d267JTsTHftqG3gfH3L78dlmr8BcH7zsBtWYgBk9H
         0GoWOQTPQNzvYv2EjQqNuXa5dFea3POmbEbZs6Go=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 58/81] gpio: Allow per-parent interrupt data
Date:   Mon, 26 Jun 2023 20:12:40 +0200
Message-ID: <20230626180746.832452734@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit cfe6807d82e97e81c3209dca9448f091e1448a57 ]

The core gpiolib code is able to deal with multiple interrupt parents
for a single gpio irqchip. It however only allows a single piece
of data to be conveyed to all flow handlers (either the gpio_chip
or some other, driver-specific data).

This means that drivers have to go through some interesting dance
to find the correct context, something that isn't great in interrupt
context (see aebdc8abc9db86e2bd33070fc2f961012fff74b4 for a prime
example).

Instead, offer an optional way for a pinctrl/gpio driver to provide
an array of pointers which gets used to provide the correct context
to the flow handler.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20211026175815.52703-2-joey.gouly@arm.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: 8c00914e5438 ("gpiolib: Fix GPIO chip IRQ initialization restriction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c      |  9 +++++++--
 include/linux/gpio/driver.h | 19 +++++++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3e01a3ac652d1..7ac86037a4191 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1595,9 +1595,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 	}
 
 	if (gc->irq.parent_handler) {
-		void *data = gc->irq.parent_handler_data ?: gc;
-
 		for (i = 0; i < gc->irq.num_parents; i++) {
+			void *data;
+
+			if (gc->irq.per_parent_data)
+				data = gc->irq.parent_handler_data_array[i];
+			else
+				data = gc->irq.parent_handler_data ?: gc;
+
 			/*
 			 * The parent IRQ chip is already using the chip_data
 			 * for this IRQ chip, so our callbacks simply use the
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 0552a9859a01e..64c93a36a3a92 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -168,11 +168,18 @@ struct gpio_irq_chip {
 
 	/**
 	 * @parent_handler_data:
+	 * @parent_handler_data_array:
 	 *
 	 * Data associated, and passed to, the handler for the parent
-	 * interrupt.
+	 * interrupt. Can either be a single pointer if @per_parent_data
+	 * is false, or an array of @num_parents pointers otherwise.  If
+	 * @per_parent_data is true, @parent_handler_data_array cannot be
+	 * NULL.
 	 */
-	void *parent_handler_data;
+	union {
+		void *parent_handler_data;
+		void **parent_handler_data_array;
+	};
 
 	/**
 	 * @num_parents:
@@ -203,6 +210,14 @@ struct gpio_irq_chip {
 	 */
 	bool threaded;
 
+	/**
+	 * @per_parent_data:
+	 *
+	 * True if parent_handler_data_array describes a @num_parents
+	 * sized array to be used as parent data.
+	 */
+	bool per_parent_data;
+
 	/**
 	 * @init_hw: optional routine to initialize hardware before
 	 * an IRQ chip will be added. This is quite useful when
-- 
2.39.2



