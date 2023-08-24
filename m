Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE2787264
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbjHXOxd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbjHXOxR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745961BF5
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DF766EBE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171B1C433C8;
        Thu, 24 Aug 2023 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888788;
        bh=E4yOEWST6NCx+mI1OFDQ8PfwouKKfNuZJSqmO1OhBUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bX4xNgOW2jF2vpQ43UKIBQlxgFC07XidGGtGnJSVJRyErCW2rPsJXi8ZR1KHx57RM
         z6jgI/xPnfLdaU+AIJzOPPGYsoQzVPg+QUrm45ZO51SRt9pUTYplRezwV6FlWQduM+
         ddLSb8ylTHhBDtPf4eRgQt4Aa8sIfT1GmUtEr1IQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Laight <David.Laight@ACULAB.COM>,
        William Breathitt Gray <william.gray@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 041/139] iio: adc: stx104: Utilize iomap interface
Date:   Thu, 24 Aug 2023 16:49:24 +0200
Message-ID: <20230824145025.405934236@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: William Breathitt Gray <william.gray@linaro.org>

[ Upstream commit 73b8390cc27e096ab157be261ccc4eaaa6db87af ]

This driver doesn't need to access I/O ports directly via inb()/outb()
and friends. This patch abstracts such access by calling ioport_map()
to enable the use of more typical ioread8()/iowrite8() I/O memory
accessor calls.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/64673797df382c52fc32fce24348b25a0b05e73a.1652201921.git.william.gray@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 4f9b80aefb9e ("iio: addac: stx104: Fix race condition when converting analog-to-digital")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stx104.c | 56 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 55bd2dc514e93..7552351bfed9e 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -51,7 +51,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
  */
 struct stx104_iio {
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	unsigned int base;
+	void __iomem *base;
 };
 
 /**
@@ -64,7 +64,7 @@ struct stx104_iio {
 struct stx104_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
-	unsigned int base;
+	void __iomem *base;
 	unsigned int out_state;
 };
 
@@ -79,7 +79,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		/* get gain configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(priv->base + 11);
 		gain = adc_config & 0x3;
 
 		*val = 1 << gain;
@@ -91,24 +91,24 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 		}
 
 		/* select ADC channel */
-		outb(chan->channel | (chan->channel << 4), priv->base + 2);
+		iowrite8(chan->channel | (chan->channel << 4), priv->base + 2);
 
 		/* trigger ADC sample capture and wait for completion */
-		outb(0, priv->base);
-		while (inb(priv->base + 8) & BIT(7));
+		iowrite8(0, priv->base);
+		while (ioread8(priv->base + 8) & BIT(7));
 
-		*val = inw(priv->base);
+		*val = ioread16(priv->base);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(priv->base + 11);
 		adbu = !(adc_config & BIT(2));
 
 		*val = -32768 * adbu;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(priv->base + 11);
 		adbu = !(adc_config & BIT(2));
 		gain = adc_config & 0x3;
 
@@ -130,16 +130,16 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 		/* Only four gain states (x1, x2, x4, x8) */
 		switch (val) {
 		case 1:
-			outb(0, priv->base + 11);
+			iowrite8(0, priv->base + 11);
 			break;
 		case 2:
-			outb(1, priv->base + 11);
+			iowrite8(1, priv->base + 11);
 			break;
 		case 4:
-			outb(2, priv->base + 11);
+			iowrite8(2, priv->base + 11);
 			break;
 		case 8:
-			outb(3, priv->base + 11);
+			iowrite8(3, priv->base + 11);
 			break;
 		default:
 			return -EINVAL;
@@ -153,7 +153,7 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			priv->chan_out_states[chan->channel] = val;
-			outw(val, priv->base + 4 + 2 * chan->channel);
+			iowrite16(val, priv->base + 4 + 2 * chan->channel);
 
 			return 0;
 		}
@@ -222,7 +222,7 @@ static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	if (offset >= 4)
 		return -EINVAL;
 
-	return !!(inb(stx104gpio->base) & BIT(offset));
+	return !!(ioread8(stx104gpio->base) & BIT(offset));
 }
 
 static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -230,7 +230,7 @@ static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
 
-	*bits = inb(stx104gpio->base);
+	*bits = ioread8(stx104gpio->base);
 
 	return 0;
 }
@@ -252,7 +252,7 @@ static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		stx104gpio->out_state &= ~mask;
 
-	outb(stx104gpio->out_state, stx104gpio->base);
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
 
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
@@ -279,7 +279,7 @@ static void stx104_gpio_set_multiple(struct gpio_chip *chip,
 
 	stx104gpio->out_state &= ~*mask;
 	stx104gpio->out_state |= *mask & *bits;
-	outb(stx104gpio->out_state, stx104gpio->base);
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
 
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
@@ -306,11 +306,16 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	priv = iio_priv(indio_dev);
+	priv->base = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!priv->base)
+		return -ENOMEM;
+
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* determine if differential inputs */
-	if (inb(base[id] + 8) & BIT(5)) {
+	if (ioread8(priv->base + 8) & BIT(5)) {
 		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
 		indio_dev->channels = stx104_channels_diff;
 	} else {
@@ -320,18 +325,15 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	indio_dev->name = dev_name(dev);
 
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
-
 	/* configure device for software trigger operation */
-	outb(0, base[id] + 9);
+	iowrite8(0, priv->base + 9);
 
 	/* initialize gain setting to x1 */
-	outb(0, base[id] + 11);
+	iowrite8(0, priv->base + 11);
 
 	/* initialize DAC output to 0V */
-	outw(0, base[id] + 4);
-	outw(0, base[id] + 6);
+	iowrite16(0, priv->base + 4);
+	iowrite16(0, priv->base + 6);
 
 	stx104gpio->chip.label = dev_name(dev);
 	stx104gpio->chip.parent = dev;
@@ -346,7 +348,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
 	stx104gpio->chip.set = stx104_gpio_set;
 	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = base[id] + 3;
+	stx104gpio->base = priv->base + 3;
 	stx104gpio->out_state = 0x0;
 
 	spin_lock_init(&stx104gpio->lock);
-- 
2.40.1



