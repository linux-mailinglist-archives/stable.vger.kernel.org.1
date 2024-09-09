Return-Path: <stable+bounces-73958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87319970EA5
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C001F22419
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D91AD3E4;
	Mon,  9 Sep 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eep4Omrn"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B754279
	for <Stable@vger.kernel.org>; Mon,  9 Sep 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864890; cv=none; b=GqG0l1kCmpgCl5/MGKFdOiwY3mWfhgL1rNbwwVQcw/e9BBirjt/CxYVIUlkkhQCgy+D7GBtwUhDrZLIeS34NIgmZobroDDtqtMIjOPDQds/1MozQqefIGpzJfCmvLBRW+Yw6qj84vEKrvUEarJ8QecatpXB11p7tJETKWRQJZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864890; c=relaxed/simple;
	bh=emjZzRSQ4UMSHRspP2+iHMijMbxyihXvFLimCmwDiB0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fRaQEB77tFM+xON1LNIKEiRs9w5B8pv6aWBNpyo+dk09wMxgrLFKrMMQCC4GZIt78Y9mXXNgL31a7vnO3CJS2QXEpBdfzrADBSuUtTnJ9/4Q/ltvNufZRU5JNzpwqix370rXjctXon7tJTfvnM+e2TnKfxQTg54fJ/nOu0iR/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eep4Omrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4CFC4CEC5;
	Mon,  9 Sep 2024 06:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725864890;
	bh=emjZzRSQ4UMSHRspP2+iHMijMbxyihXvFLimCmwDiB0=;
	h=Subject:To:Cc:From:Date:From;
	b=Eep4OmrnXliHWYijWjb0VBEb7kyJ/m0wGDy4p8lhYO1zziDH8ADlZVe0/6hSx27VX
	 rnZsKIYLD0lPFiJukd2tC6mrIxg/BDJfdtd6JFePODAADIMc5vr7HdulmL4o2RZ//T
	 2ighb8iHNEtVbW8p3NTaqhemPslBU5QJB2/1Fvhs=
Subject: FAILED: patch "[PATCH] iio: adc: ad7606: remove frstdata check for serial mode" failed to apply to 4.19-stable tree
To: gstols@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 08:54:47 +0200
Message-ID: <2024090946-heading-mortality-97cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 90826e08468ba7fb35d8b39645b22d9e80004afe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090946-heading-mortality-97cb@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

90826e08468b ("iio: adc: ad7606: remove frstdata check for serial mode")
7989b4bb23fe ("iio: adc: ad7616: Add support for AD7616 ADC")
6bf229abce75 ("iio: adc: ad7606: Move oversampling options in chip info and rework *_avail attributes")
2985a5d88455 ("staging: iio: adc: ad7606: Move out of staging")
54160ae3b2d3 ("staging: iio: adc: ad7606: Misc style fixes (no functional change)")
cc49bd1652a4 ("staging: iio: adc: ad7606: Add support for threaded irq")
2bbf53e3e506 ("staging: iio: adc: ad7606: Simplify the Kconfing menu")
43f9b204edf0 ("staging: iio: adc: ad7606: Add OF device ID table")
41f71e5e7daf ("staging: iio: adc: ad7606: Use find_closest() macro")
c0683bfd3772 ("staging: iio: adc: ad7606: Use devm functions in probe")
557e585c3fdb ("staging: iio: adc: ad7606: Use wait-for-completion handler")
7c0bc65c8403 ("Merge tag 'iio-for-4.21a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-testing")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90826e08468ba7fb35d8b39645b22d9e80004afe Mon Sep 17 00:00:00 2001
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 2 Jul 2024 12:52:51 +0000
Subject: [PATCH] iio: adc: ad7606: remove frstdata check for serial mode

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

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 3a417595294f..c321c6ef48df 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -49,7 +49,7 @@ static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
-static int ad7606_reset(struct ad7606_state *st)
+int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
 		gpiod_set_value(st->gpio_reset, 1);
@@ -60,6 +60,7 @@ static int ad7606_reset(struct ad7606_state *st)
 
 	return -ENODEV;
 }
+EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
 
 static int ad7606_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
@@ -88,31 +89,6 @@ static int ad7606_read_samples(struct ad7606_state *st)
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
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 0c6a88cc4695..6649e84d25de 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -151,6 +151,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops);
 
+int ad7606_reset(struct ad7606_state *st);
+
 enum ad7606_supported_device_ids {
 	ID_AD7605_4,
 	ID_AD7606_8,
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index d8408052262e..6bc587b20f05 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -7,6 +7,7 @@
 
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/err.h>
@@ -21,8 +22,29 @@ static int ad7606_par16_read_block(struct device *dev,
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
 
@@ -35,8 +57,28 @@ static int ad7606_par8_read_block(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
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
 
-	insb((unsigned long)st->base_address, buf, count * 2);
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


