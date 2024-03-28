Return-Path: <stable+bounces-32995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A59688E8F1
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6C91C2EAA7
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9105131BC7;
	Wed, 27 Mar 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QB4ilcxa"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25F131BB1
	for <Stable@vger.kernel.org>; Wed, 27 Mar 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552909; cv=none; b=KQ2OjuSqDnlg6+2NzPSirnVgLhYpmZF5aWIxKcMfvkjpPDY1BaqNE64BvWKkSzqMWrxOfy5wyexUMFnFGzzCd9bWruNfPxaynMpUaQrj36Irk4jQz+z4ENmI3r4iEZhAiijjiBlLAi6P9yP0apuhN/a1nPQxGrpCAQ5HatzZidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552909; c=relaxed/simple;
	bh=jBVbVVgcQUtVHZ4Ixs5dvHxxC5r8tpjj8eqpia+yGKk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aTJzuO+xh3N1Zrsc2Zt+/xJpl8r2DMiFsYseoZng6Bo/ZEpiNGKJik0AcO2SF4phtdtGocDt9KZs2tqR/K/WJxY97j5ru+hjWqv/oF3Ii4JLOZprscMNeqhuEceailFMGUAWRhgylpv9sW5V3K3/kyVl82LsmV8Z+6RM4Gvid0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QB4ilcxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CCDC43394;
	Wed, 27 Mar 2024 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711552909;
	bh=jBVbVVgcQUtVHZ4Ixs5dvHxxC5r8tpjj8eqpia+yGKk=;
	h=Subject:To:Cc:From:Date:From;
	b=QB4ilcxaAvxoVATAc+5esbygQNEv3I7eEQnrzFQ3HQ6Cv/y27hQ2qzrZpvydvqOev
	 +dpbE1I83+IKTfUljg69M/tSG+EcCnU1o6tdjScGc9bcIxsx03XLdo7a6+8bObJW3M
	 kYZxyYUv10CPNbEDX/1KjKo3ohm4Nr41lhE06rRM=
Subject: FAILED: patch "[PATCH] iio: pressure: Fixes BMP38x and BMP390 SPI support" failed to apply to 6.1-stable tree
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@linux.intel.com,ang.iglesiasg@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:21:45 +0100
Message-ID: <2024032745-jiffy-flyaway-dec6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a9dd9ba323114f366eb07f1d9630822f8df6cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032745-jiffy-flyaway-dec6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9dd9ba323114f366eb07f1d9630822f8df6cbb2 Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Mon, 19 Feb 2024 20:13:59 +0100
Subject: [PATCH] iio: pressure: Fixes BMP38x and BMP390 SPI support

According to the datasheet of BMP38x and BMP390 devices, for an SPI
read operation the first byte that is returned needs to be dropped,
and the rest of the bytes are the actual data returned from the
sensor.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Acked-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Link: https://lore.kernel.org/r/20240219191359.18367-1-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index e8a5fed07e88..a444d4b2978b 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -4,6 +4,7 @@
  *
  * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
  */
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/err.h>
@@ -35,6 +36,34 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
 	return spi_write_then_read(spi, reg, reg_size, val, val_size);
 }
 
+static int bmp380_regmap_spi_read(void *context, const void *reg,
+				  size_t reg_size, void *val, size_t val_size)
+{
+	struct spi_device *spi = to_spi_device(context);
+	u8 rx_buf[4];
+	ssize_t status;
+
+	/*
+	 * Maximum number of consecutive bytes read for a temperature or
+	 * pressure measurement is 3.
+	 */
+	if (val_size > 3)
+		return -EINVAL;
+
+	/*
+	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
+	 * the first byte needs to be dropped and the rest are the requested
+	 * data.
+	 */
+	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
+	if (status)
+		return status;
+
+	memcpy(val, rx_buf + 1, val_size);
+
+	return 0;
+}
+
 static struct regmap_bus bmp280_regmap_bus = {
 	.write = bmp280_regmap_spi_write,
 	.read = bmp280_regmap_spi_read,
@@ -42,10 +71,19 @@ static struct regmap_bus bmp280_regmap_bus = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static struct regmap_bus bmp380_regmap_bus = {
+	.write = bmp280_regmap_spi_write,
+	.read = bmp380_regmap_spi_read,
+	.read_flag_mask = BIT(7),
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
 static int bmp280_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	const struct bmp280_chip_info *chip_info;
+	struct regmap_bus *bmp_regmap_bus;
 	struct regmap *regmap;
 	int ret;
 
@@ -58,8 +96,18 @@ static int bmp280_spi_probe(struct spi_device *spi)
 
 	chip_info = spi_get_device_match_data(spi);
 
+	switch (chip_info->chip_id[0]) {
+	case BMP380_CHIP_ID:
+	case BMP390_CHIP_ID:
+		bmp_regmap_bus = &bmp380_regmap_bus;
+		break;
+	default:
+		bmp_regmap_bus = &bmp280_regmap_bus;
+		break;
+	}
+
 	regmap = devm_regmap_init(&spi->dev,
-				  &bmp280_regmap_bus,
+				  bmp_regmap_bus,
 				  &spi->dev,
 				  chip_info->regmap_config);
 	if (IS_ERR(regmap)) {


