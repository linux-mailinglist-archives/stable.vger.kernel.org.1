Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5CF713C19
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjE1TEj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjE1TEj (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:04:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31CA0
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BBD960F7E
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC09C433D2;
        Sun, 28 May 2023 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300676;
        bh=KPyiM2CHLosDi6R0s18BUEs0CQ4PI6+SN8P3rSzNOZ0=;
        h=Subject:To:From:Date:From;
        b=naCCK1eA0gjlYUhlD+Y47gGvYGOIWVJ9FYqNHdTXhvfDaPM3KN2rs8oesrAp6j4h7
         EeFznH0OU/2IGIYTwdnWID1viFBHWeUljULVd6gHh+0StXxFotrvvPuA894tNpXyJ7
         OcWWAwLLsHi7Q+Ffva1z7YMzjKtoMWfdQqzG2H7I=
Subject: patch "iio: adc: mt6370: Fix ibus and ibat scaling value of some specific" added to char-misc-linus
To:     chiaen_wu@richtek.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, amergnat@baylibre.com
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:31 +0100
Message-ID: <2023052831-delouse-rewash-ac28@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: adc: mt6370: Fix ibus and ibat scaling value of some specific

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 00ffdd6fa90298522d45ca0c348b23485584dcdc Mon Sep 17 00:00:00 2001
From: ChiaEn Wu <chiaen_wu@richtek.com>
Date: Mon, 10 Apr 2023 18:34:22 +0800
Subject: iio: adc: mt6370: Fix ibus and ibat scaling value of some specific
 vendor ID chips

The scale value of ibus and ibat on the datasheet is incorrect due to the
customer report after the experimentation with some specific vendor ID
chips.

Fixes: c1404d1b659f ("iio: adc: mt6370: Add MediaTek MT6370 support")
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Link: https://lore.kernel.org/r/1681122862-1994-1-git-send-email-chiaen_wu@richtek.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/mt6370-adc.c | 53 ++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6370-adc.c b/drivers/iio/adc/mt6370-adc.c
index bc62e5a9d50d..0bc112135bca 100644
--- a/drivers/iio/adc/mt6370-adc.c
+++ b/drivers/iio/adc/mt6370-adc.c
@@ -19,6 +19,7 @@
 
 #include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
 
+#define MT6370_REG_DEV_INFO		0x100
 #define MT6370_REG_CHG_CTRL3		0x113
 #define MT6370_REG_CHG_CTRL7		0x117
 #define MT6370_REG_CHG_ADC		0x121
@@ -27,6 +28,7 @@
 #define MT6370_ADC_START_MASK		BIT(0)
 #define MT6370_ADC_IN_SEL_MASK		GENMASK(7, 4)
 #define MT6370_AICR_ICHG_MASK		GENMASK(7, 2)
+#define MT6370_VENID_MASK		GENMASK(7, 4)
 
 #define MT6370_AICR_100_mA		0x0
 #define MT6370_AICR_150_mA		0x1
@@ -47,6 +49,10 @@
 #define ADC_CONV_TIME_MS		35
 #define ADC_CONV_POLLING_TIME_US	1000
 
+#define MT6370_VID_RT5081		0x8
+#define MT6370_VID_RT5081A		0xA
+#define MT6370_VID_MT6370		0xE
+
 struct mt6370_adc_data {
 	struct device *dev;
 	struct regmap *regmap;
@@ -55,6 +61,7 @@ struct mt6370_adc_data {
 	 * from being read at the same time.
 	 */
 	struct mutex adc_lock;
+	unsigned int vid;
 };
 
 static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
@@ -98,6 +105,30 @@ static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
 	return ret;
 }
 
+static int mt6370_adc_get_ibus_scale(struct mt6370_adc_data *priv)
+{
+	switch (priv->vid) {
+	case MT6370_VID_RT5081:
+	case MT6370_VID_RT5081A:
+	case MT6370_VID_MT6370:
+		return 3350;
+	default:
+		return 3875;
+	}
+}
+
+static int mt6370_adc_get_ibat_scale(struct mt6370_adc_data *priv)
+{
+	switch (priv->vid) {
+	case MT6370_VID_RT5081:
+	case MT6370_VID_RT5081A:
+	case MT6370_VID_MT6370:
+		return 2680;
+	default:
+		return 3870;
+	}
+}
+
 static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
 				 int chan, int *val1, int *val2)
 {
@@ -123,7 +154,7 @@ static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
 		case MT6370_AICR_250_mA:
 		case MT6370_AICR_300_mA:
 		case MT6370_AICR_350_mA:
-			*val1 = 3350;
+			*val1 = mt6370_adc_get_ibus_scale(priv);
 			break;
 		default:
 			*val1 = 5000;
@@ -150,7 +181,7 @@ static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
 		case MT6370_ICHG_600_mA:
 		case MT6370_ICHG_700_mA:
 		case MT6370_ICHG_800_mA:
-			*val1 = 2680;
+			*val1 = mt6370_adc_get_ibat_scale(priv);
 			break;
 		default:
 			*val1 = 5000;
@@ -251,6 +282,20 @@ static const struct iio_chan_spec mt6370_adc_channels[] = {
 	MT6370_ADC_CHAN(TEMP_JC, IIO_TEMP, 12, BIT(IIO_CHAN_INFO_OFFSET)),
 };
 
+static int mt6370_get_vendor_info(struct mt6370_adc_data *priv)
+{
+	unsigned int dev_info;
+	int ret;
+
+	ret = regmap_read(priv->regmap, MT6370_REG_DEV_INFO, &dev_info);
+	if (ret)
+		return ret;
+
+	priv->vid = FIELD_GET(MT6370_VENID_MASK, dev_info);
+
+	return 0;
+}
+
 static int mt6370_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -272,6 +317,10 @@ static int mt6370_adc_probe(struct platform_device *pdev)
 	priv->regmap = regmap;
 	mutex_init(&priv->adc_lock);
 
+	ret = mt6370_get_vendor_info(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get vid\n");
+
 	ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, 0);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to reset ADC\n");
-- 
2.40.1


