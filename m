Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE178769D
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbjHXRSA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbjHXRRj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:17:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E246A1BC7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6905966730
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C397C433C7;
        Thu, 24 Aug 2023 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897454;
        bh=L7apelAQKVga/1cRnPyO6C7MwLuttBoAlpBx/cxcjnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMZJP1dcNTcvgQRocE87CJVmlwI4hwxkwkBvDV0hA5hqVXjp6mC4OoLYFoBwJ99C2
         WBzS+u1wx9EXDuhH520UfDLgoLPaRn2o96MQ3f1ptg2lKaR19mH2/MD3crZjKOwGtC
         6Ruu7qYgiNua4lnb9tLZHSSBs4gHwPcQulvn3aNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fred Eckert <Frede@cmslaser.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 045/135] iio: adc: stx104: Implement and utilize register structures
Date:   Thu, 24 Aug 2023 19:08:37 +0200
Message-ID: <20230824170619.085017447@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Breathitt Gray <william.gray@linaro.org>

[ Upstream commit 6cfd14c54b1f42f29097244c1b6208f8268d7d5b ]

Reduce magic numbers and improve code readability by implementing and
utilizing named register data structures.

Tested-by: Fred Eckert <Frede@cmslaser.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/r/8cb91d5b53e57b066120e42ea07000d6c7ef5543.1657213745.git.william.gray@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 4f9b80aefb9e ("iio: addac: stx104: Fix race condition when converting analog-to-digital")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stx104.c | 74 +++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 7552351bfed9e..48a91a95e597b 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define STX104_OUT_CHAN(chan) {				\
 	.type = IIO_VOLTAGE,				\
@@ -44,14 +45,36 @@ static unsigned int num_stx104;
 module_param_hw_array(base, uint, ioport, &num_stx104, 0);
 MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
+/**
+ * struct stx104_reg - device register structure
+ * @ssr_ad:	Software Strobe Register and ADC Data
+ * @achan:	ADC Channel
+ * @dio:	Digital I/O
+ * @dac:	DAC Channels
+ * @cir_asr:	Clear Interrupts and ADC Status
+ * @acr:	ADC Control
+ * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
+ * @acfg:	ADC Configuration
+ */
+struct stx104_reg {
+	u16 ssr_ad;
+	u8 achan;
+	u8 dio;
+	u16 dac[2];
+	u8 cir_asr;
+	u8 acr;
+	u8 pccr_fsh;
+	u8 acfg;
+};
+
 /**
  * struct stx104_iio - IIO device private data structure
  * @chan_out_states:	channels' output states
- * @base:		base port address of the IIO device
+ * @reg:		I/O address offset for the device registers
  */
 struct stx104_iio {
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	void __iomem *base;
+	struct stx104_reg __iomem *reg;
 };
 
 /**
@@ -64,7 +87,7 @@ struct stx104_iio {
 struct stx104_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
-	void __iomem *base;
+	u8 __iomem *base;
 	unsigned int out_state;
 };
 
@@ -72,6 +95,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
+	struct stx104_reg __iomem *const reg = priv->reg;
 	unsigned int adc_config;
 	int adbu;
 	int gain;
@@ -79,7 +103,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		/* get gain configuration */
-		adc_config = ioread8(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		gain = adc_config & 0x3;
 
 		*val = 1 << gain;
@@ -91,24 +115,26 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 		}
 
 		/* select ADC channel */
-		iowrite8(chan->channel | (chan->channel << 4), priv->base + 2);
+		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
 
-		/* trigger ADC sample capture and wait for completion */
-		iowrite8(0, priv->base);
-		while (ioread8(priv->base + 8) & BIT(7));
+		/* trigger ADC sample capture by writing to the 8-bit
+		 * Software Strobe Register and wait for completion
+		 */
+		iowrite8(0, &reg->ssr_ad);
+		while (ioread8(&reg->cir_asr) & BIT(7));
 
-		*val = ioread16(priv->base);
+		*val = ioread16(&reg->ssr_ad);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-		adc_config = ioread8(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		adbu = !(adc_config & BIT(2));
 
 		*val = -32768 * adbu;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = ioread8(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		adbu = !(adc_config & BIT(2));
 		gain = adc_config & 0x3;
 
@@ -130,16 +156,16 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 		/* Only four gain states (x1, x2, x4, x8) */
 		switch (val) {
 		case 1:
-			iowrite8(0, priv->base + 11);
+			iowrite8(0, &priv->reg->acfg);
 			break;
 		case 2:
-			iowrite8(1, priv->base + 11);
+			iowrite8(1, &priv->reg->acfg);
 			break;
 		case 4:
-			iowrite8(2, priv->base + 11);
+			iowrite8(2, &priv->reg->acfg);
 			break;
 		case 8:
-			iowrite8(3, priv->base + 11);
+			iowrite8(3, &priv->reg->acfg);
 			break;
 		default:
 			return -EINVAL;
@@ -153,7 +179,7 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			priv->chan_out_states[chan->channel] = val;
-			iowrite16(val, priv->base + 4 + 2 * chan->channel);
+			iowrite16(val, &priv->reg->dac[chan->channel]);
 
 			return 0;
 		}
@@ -307,15 +333,15 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	}
 
 	priv = iio_priv(indio_dev);
-	priv->base = devm_ioport_map(dev, base[id], STX104_EXTENT);
-	if (!priv->base)
+	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!priv->reg)
 		return -ENOMEM;
 
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* determine if differential inputs */
-	if (ioread8(priv->base + 8) & BIT(5)) {
+	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
 		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
 		indio_dev->channels = stx104_channels_diff;
 	} else {
@@ -326,14 +352,14 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	indio_dev->name = dev_name(dev);
 
 	/* configure device for software trigger operation */
-	iowrite8(0, priv->base + 9);
+	iowrite8(0, &priv->reg->acr);
 
 	/* initialize gain setting to x1 */
-	iowrite8(0, priv->base + 11);
+	iowrite8(0, &priv->reg->acfg);
 
 	/* initialize DAC output to 0V */
-	iowrite16(0, priv->base + 4);
-	iowrite16(0, priv->base + 6);
+	iowrite16(0, &priv->reg->dac[0]);
+	iowrite16(0, &priv->reg->dac[1]);
 
 	stx104gpio->chip.label = dev_name(dev);
 	stx104gpio->chip.parent = dev;
@@ -348,7 +374,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
 	stx104gpio->chip.set = stx104_gpio_set;
 	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = priv->base + 3;
+	stx104gpio->base = &priv->reg->dio;
 	stx104gpio->out_state = 0x0;
 
 	spin_lock_init(&stx104gpio->lock);
-- 
2.40.1



