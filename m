Return-Path: <stable+bounces-14414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F408380D5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90821C273B1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA8134744;
	Tue, 23 Jan 2024 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rWjN6E4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011913473B;
	Tue, 23 Jan 2024 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971916; cv=none; b=SyKSn2C8jgSpbqBVkKbAdKy6bbmnhsnJ6Z8sViQiix8YD/EusLV7/bCL5D7cG8a8ICSr+kl1WTWqPnN95riGWeiEtV4xGoCFTXt/LH+0ZUtr7humFNXtRsaaG/z6BbC6IgzdvRC3cCWi7qlAR14HGTNWDjPuh3dZD7sKx6Hicu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971916; c=relaxed/simple;
	bh=ea56c1MGAZ6xSJx7bBC5c59b4w7uwnKMY5TMLOW8aUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZrRtAZwSDxieNxSfj0HUi1BmuQURU2VJvfJhl/9ltOjveWnEmVJQBoQhkawN3IxznNi/dAvzQBl7xOdLunkmekCc3Q5gXVj8BKLGz1+LuSmCNji0FhmQ3gFcRGD1oUOIS1NZl6A/kz2eQx1Xcv34Fqb0P7qlzGKevnCoOWMeaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rWjN6E4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AB0C433C7;
	Tue, 23 Jan 2024 01:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971916;
	bh=ea56c1MGAZ6xSJx7bBC5c59b4w7uwnKMY5TMLOW8aUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWjN6E4wGBENr8E27yPMOaRjLtM16OIuF1uN0LNXJaSpd4n8/AKA88Q43C8GQs3b6
	 92yXaA9rTbfoJBa8vU6ilgxcaWRE+bSM0wuePE/PtDOuskhICWOg9be9OZaWWoXI2m
	 1FC6QcJHXTS+V/jTSLHGtR2xZAx25xKoMsm87V78=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 350/417] iio: adc: ad9467: fix reset gpio handling
Date: Mon, 22 Jan 2024 15:58:38 -0800
Message-ID: <20240122235803.915747036@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit 76f028539cf360f750efd8cde560edda298e4c6b ]

The reset gpio was being handled with inverted polarity. This means that
as far as gpiolib is concerned we were actually leaving the pin asserted
(in theory, this would mean reset). However, inverting the polarity in
devicetree made things work. Fix it by doing it the proper way and how
gpiolib expects it to be done.

While at it, moved the handling to it's own function and dropped
'reset_gpio' from the 'struct ad9467_state' as we only need it during
probe. On top of that, refactored things so that we now request the gpio
asserted (i.e in reset) and then de-assert it. Also note that we now use
gpiod_set_value_cansleep() instead of gpiod_direction_output() as we
already request the pin as output.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20231207-iio-backend-prep-v2-1-a4a33bc4d70e@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad9467.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 7534572f7475..3e8d1e8fda07 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -121,7 +121,6 @@ struct ad9467_state {
 	unsigned int			output_mode;
 
 	struct gpio_desc		*pwrdown_gpio;
-	struct gpio_desc		*reset_gpio;
 };
 
 static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
@@ -378,6 +377,21 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 	return ad9467_outputmode_set(st->spi, st->output_mode);
 }
 
+static int ad9467_reset(struct device *dev)
+{
+	struct gpio_desc *gpio;
+
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(gpio))
+		return PTR_ERR_OR_ZERO(gpio);
+
+	fsleep(1);
+	gpiod_set_value_cansleep(gpio, 0);
+	fsleep(10 * USEC_PER_MSEC);
+
+	return 0;
+}
+
 static int ad9467_probe(struct spi_device *spi)
 {
 	const struct ad9467_chip_info *info;
@@ -406,18 +420,9 @@ static int ad9467_probe(struct spi_device *spi)
 	if (IS_ERR(st->pwrdown_gpio))
 		return PTR_ERR(st->pwrdown_gpio);
 
-	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
-						 GPIOD_OUT_LOW);
-	if (IS_ERR(st->reset_gpio))
-		return PTR_ERR(st->reset_gpio);
-
-	if (st->reset_gpio) {
-		udelay(1);
-		ret = gpiod_direction_output(st->reset_gpio, 1);
-		if (ret)
-			return ret;
-		mdelay(10);
-	}
+	ret = ad9467_reset(&spi->dev);
+	if (ret)
+		return ret;
 
 	conv->chip_info = &info->axi_adc_info;
 
-- 
2.43.0




