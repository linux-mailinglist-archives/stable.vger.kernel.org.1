Return-Path: <stable+bounces-75141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B70A9733E0
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81F5B2D2A0
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76731940B3;
	Tue, 10 Sep 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGbNbGS5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E719412C;
	Tue, 10 Sep 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963869; cv=none; b=Mst0pkRA0IHCu/7dccL+qfHG7GnLh4gSpLGuaMy6ZwCEwXrDBE/YSdFtOsBjsBdZfonikRbhGgjkIokXShIyo12ob4BjDB8Lecm/XSu37HNs8URwCvm4qO9oTLNLGtkqSdjpM0fjGkpCm6z0Iyv1szOXM8coaQgMlXg1NMv5Snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963869; c=relaxed/simple;
	bh=0iwi/pGjp5D9g7qXW1t05H0khbxJAepWtHfTS2fivBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GatDxbozdWaAaq/LdoPU9kHKctk0GlQ8c8jGK6VMePRPAEwkjE3kS60+GsCG3GDsjmRahGZfWlKCSGe/T9RScFv4uwcaseffHGN1y0KL3ycB8yUvLUtR0Ma9lWIHeAt4qJQeiL3AOFTB3TDJ9Va/WjklwlaY0IvC7If1MmJTX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NGbNbGS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BA2C4CEC3;
	Tue, 10 Sep 2024 10:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963869;
	bh=0iwi/pGjp5D9g7qXW1t05H0khbxJAepWtHfTS2fivBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGbNbGS5ANy6b2uVGNf9oJ36IN2kjajLhWtfnFn6KmnLw8BuR6lUPRvLhMVQR1+GJ
	 gYVEFrAqeXE7O5S81sf9YNFAyWAju5D6Z3zm11iKRwL3FJqimMfo0eB4e78ACEhfAy
	 e2A1CscwS+HjbGo02L1JWjgLD+tY02u+4V55POp0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Stols <gstols@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 178/214] iio: adc: ad7606: remove frstdata check for serial mode
Date: Tue, 10 Sep 2024 11:33:20 +0200
Message-ID: <20240910092605.974403428@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Stols <gstols@baylibre.com>

commit 90826e08468ba7fb35d8b39645b22d9e80004afe upstream.

The current implementation attempts to recover from an eventual glitch
in the clock by checking frstdata state after reading the first
channel's sample: If frstdata is low, it will reset the chip and
return -EIO.

This will only work in parallel mode, where frstdata pin is set low
after the 2nd sample read starts.

For the serial mode, according to the datasheet, "The FRSTDATA output
returns to a logic low following the 16th SCLK falling edge.", thus
after the Xth pulse, X being the number of bits in a sample, the check
will always be true, and the driver will not work at all in serial
mode if frstdata(optional) is defined in the devicetree as it will
reset the chip, and return -EIO every time read_sample is called.

Hence, this check must be removed for serial mode.

Fixes: b9618c0cacd7 ("staging: IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-1-18d5ea18770e@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7606.c     |   28 +------------------------
 drivers/iio/adc/ad7606.h     |    2 +
 drivers/iio/adc/ad7606_par.c |   48 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 29 deletions(-)

--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -48,7 +48,7 @@ static const unsigned int ad7616_oversam
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
-static int ad7606_reset(struct ad7606_state *st)
+int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
 		gpiod_set_value(st->gpio_reset, 1);
@@ -59,6 +59,7 @@ static int ad7606_reset(struct ad7606_st
 
 	return -ENODEV;
 }
+EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
 
 static int ad7606_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
@@ -87,31 +88,6 @@ static int ad7606_read_samples(struct ad
 {
 	unsigned int num = st->chip_info->num_channels - 1;
 	u16 *data = st->data;
-	int ret;
-
-	/*
-	 * The frstdata signal is set to high while and after reading the sample
-	 * of the first channel and low for all other channels. This can be used
-	 * to check that the incoming data is correctly aligned. During normal
-	 * operation the data should never become unaligned, but some glitch or
-	 * electrostatic discharge might cause an extra read or clock cycle.
-	 * Monitoring the frstdata signal allows to recover from such failure
-	 * situations.
-	 */
-
-	if (st->gpio_frstdata) {
-		ret = st->bops->read_block(st->dev, 1, data);
-		if (ret)
-			return ret;
-
-		if (!gpiod_get_value(st->gpio_frstdata)) {
-			ad7606_reset(st);
-			return -EIO;
-		}
-
-		data++;
-		num--;
-	}
 
 	return st->bops->read_block(st->dev, num, data);
 }
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -153,6 +153,8 @@ int ad7606_probe(struct device *dev, int
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops);
 
+int ad7606_reset(struct ad7606_state *st);
+
 enum ad7606_supported_device_ids {
 	ID_AD7605_4,
 	ID_AD7606_8,
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/err.h>
@@ -20,8 +21,29 @@ static int ad7606_par16_read_block(struc
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	insw((unsigned long)st->base_address, buf, count);
 
+	/*
+	 * On the parallel interface, the frstdata signal is set to high while
+	 * and after reading the sample of the first channel and low for all
+	 * other channels.  This can be used to check that the incoming data is
+	 * correctly aligned.  During normal operation the data should never
+	 * become unaligned, but some glitch or electrostatic discharge might
+	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
+	 * allows to recover from such failure situations.
+	 */
+	int num = count;
+	u16 *_buf = buf;
+
+	if (st->gpio_frstdata) {
+		insw((unsigned long)st->base_address, _buf, 1);
+		if (!gpiod_get_value(st->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+		_buf++;
+		num--;
+	}
+	insw((unsigned long)st->base_address, _buf, num);
 	return 0;
 }
 
@@ -34,8 +56,28 @@ static int ad7606_par8_read_block(struct
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
-
-	insb((unsigned long)st->base_address, buf, count * 2);
+	/*
+	 * On the parallel interface, the frstdata signal is set to high while
+	 * and after reading the sample of the first channel and low for all
+	 * other channels.  This can be used to check that the incoming data is
+	 * correctly aligned.  During normal operation the data should never
+	 * become unaligned, but some glitch or electrostatic discharge might
+	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
+	 * allows to recover from such failure situations.
+	 */
+	int num = count;
+	u16 *_buf = buf;
+
+	if (st->gpio_frstdata) {
+		insb((unsigned long)st->base_address, _buf, 2);
+		if (!gpiod_get_value(st->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+		_buf++;
+		num--;
+	}
+	insb((unsigned long)st->base_address, _buf, num * 2);
 
 	return 0;
 }



