Return-Path: <stable+bounces-6415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FAF80E67C
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0171F2201A
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA221376;
	Tue, 12 Dec 2023 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1sBnHcny"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A068D1B271
	for <Stable@vger.kernel.org>; Tue, 12 Dec 2023 08:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF766C433C7;
	Tue, 12 Dec 2023 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702370633;
	bh=HF01zpQ0i/ry8/mY3yPjAxOkWBRc0yT/Xa6RVWzC0XI=;
	h=Subject:To:From:Date:From;
	b=1sBnHcny0nXT3HWMetzU1cKwJZtV0cteFVidj+FmX5vYl0Lz7f16soQF+DqkuJt95
	 PDS0lLDGNJCSHnsheAJ8uqB4Sxf/4jlmsLIniWTt7SDOfcMx83ggGk+Nf6+ef/Ro/F
	 s1KyJQdnsIgGuXaExal2V3V+7cXDFRlfKgAHSWFQ=
Subject: patch "iio: imu: adis16475: add spi_device_id table" added to char-misc-linus
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:43:42 +0100
Message-ID: <2023121242-igloo-clone-b309@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: adis16475: add spi_device_id table

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From ee4d79055aeea27f1b8c42233cc0c90d0a8b5355 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 2 Nov 2023 13:52:58 +0100
Subject: iio: imu: adis16475: add spi_device_id table

This prevents the warning message "SPI driver has no spi_device_id for..."
when registering the driver. More importantly, it makes sure that
module autoloading works as spi relies on spi: modaliases and not of.

While at it, move the of_device_id table to it's natural place.

Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20231102125258.3284830-1-nuno.sa@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/adis16475.c | 129 ++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index b7cbe1565aee..04153a2725d5 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1406,6 +1406,59 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 	return 0;
 }
 
+
+static int adis16475_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adis16475 *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -EINVAL;
+
+	ret = adis_init(&st->adis, indio_dev, spi, &st->info->adis_data);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->info = &adis16475_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = __adis_initial_startup(&st->adis);
+	if (ret)
+		return ret;
+
+	ret = adis16475_config_irq_pin(st);
+	if (ret)
+		return ret;
+
+	ret = adis16475_config_sync_mode(st);
+	if (ret)
+		return ret;
+
+	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
+						 adis16475_trigger_handler);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	adis16475_debugfs_init(indio_dev);
+
+	return 0;
+}
+
 static const struct of_device_id adis16475_of_match[] = {
 	{ .compatible = "adi,adis16470",
 		.data = &adis16475_chip_info[ADIS16470] },
@@ -1451,57 +1504,30 @@ static const struct of_device_id adis16475_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, adis16475_of_match);
 
-static int adis16475_probe(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev;
-	struct adis16475 *st;
-	int ret;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	st = iio_priv(indio_dev);
-
-	st->info = device_get_match_data(&spi->dev);
-	if (!st->info)
-		return -EINVAL;
-
-	ret = adis_init(&st->adis, indio_dev, spi, &st->info->adis_data);
-	if (ret)
-		return ret;
-
-	indio_dev->name = st->info->name;
-	indio_dev->channels = st->info->channels;
-	indio_dev->num_channels = st->info->num_channels;
-	indio_dev->info = &adis16475_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = __adis_initial_startup(&st->adis);
-	if (ret)
-		return ret;
-
-	ret = adis16475_config_irq_pin(st);
-	if (ret)
-		return ret;
-
-	ret = adis16475_config_sync_mode(st);
-	if (ret)
-		return ret;
-
-	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
-						 adis16475_trigger_handler);
-	if (ret)
-		return ret;
-
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	adis16475_debugfs_init(indio_dev);
-
-	return 0;
-}
+static const struct spi_device_id adis16475_ids[] = {
+	{ "adis16470", (kernel_ulong_t)&adis16475_chip_info[ADIS16470] },
+	{ "adis16475-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_1] },
+	{ "adis16475-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_2] },
+	{ "adis16475-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_3] },
+	{ "adis16477-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_1] },
+	{ "adis16477-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_2] },
+	{ "adis16477-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_3] },
+	{ "adis16465-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_1] },
+	{ "adis16465-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_2] },
+	{ "adis16465-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_3] },
+	{ "adis16467-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_1] },
+	{ "adis16467-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_2] },
+	{ "adis16467-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_3] },
+	{ "adis16500", (kernel_ulong_t)&adis16475_chip_info[ADIS16500] },
+	{ "adis16505-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_1] },
+	{ "adis16505-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_2] },
+	{ "adis16505-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_3] },
+	{ "adis16507-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_1] },
+	{ "adis16507-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_2] },
+	{ "adis16507-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_3] },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adis16475_ids);
 
 static struct spi_driver adis16475_driver = {
 	.driver = {
@@ -1509,6 +1535,7 @@ static struct spi_driver adis16475_driver = {
 		.of_match_table = adis16475_of_match,
 	},
 	.probe = adis16475_probe,
+	.id_table = adis16475_ids,
 };
 module_spi_driver(adis16475_driver);
 
-- 
2.43.0



