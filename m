Return-Path: <stable+bounces-8649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC081F7E7
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F929B21C29
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB7C6FDA;
	Thu, 28 Dec 2023 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JETruhA5"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AB79D9
	for <Stable@vger.kernel.org>; Thu, 28 Dec 2023 11:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4DFC433CC;
	Thu, 28 Dec 2023 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703763824;
	bh=bE3h4ZN1KTz4uw97u5w3Aoz0WoaRf27f2O7LYNo7jGw=;
	h=Subject:To:Cc:From:Date:From;
	b=JETruhA5yVOJMm4H7DYTd02t8Nmvvnm9F+iuvd/xDvPKpkgLwkSTc6N61adrgaVja
	 kqQF9eL8Jp+xAjv7VEZYMQK8FO3p41AZDKkCjSmxuzKkcvbTBSp3Ql1uDuM2NvSKiD
	 o1kbgKCnqL+LjnYK7mFdnFmf950sgLUYCvF/8gC8=
Subject: FAILED: patch "[PATCH] iio: imu: adis16475: add spi_device_id table" failed to apply to 5.15-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 11:43:41 +0000
Message-ID: <2023122841-winnings-careless-572f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ee4d79055aeea27f1b8c42233cc0c90d0a8b5355
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122841-winnings-careless-572f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ee4d79055aee ("iio: imu: adis16475: add spi_device_id table")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee4d79055aeea27f1b8c42233cc0c90d0a8b5355 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 2 Nov 2023 13:52:58 +0100
Subject: [PATCH] iio: imu: adis16475: add spi_device_id table

This prevents the warning message "SPI driver has no spi_device_id for..."
when registering the driver. More importantly, it makes sure that
module autoloading works as spi relies on spi: modaliases and not of.

While at it, move the of_device_id table to it's natural place.

Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20231102125258.3284830-1-nuno.sa@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index b7cbe1565aee..04153a2725d5 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1406,50 +1406,6 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 	return 0;
 }
 
-static const struct of_device_id adis16475_of_match[] = {
-	{ .compatible = "adi,adis16470",
-		.data = &adis16475_chip_info[ADIS16470] },
-	{ .compatible = "adi,adis16475-1",
-		.data = &adis16475_chip_info[ADIS16475_1] },
-	{ .compatible = "adi,adis16475-2",
-		.data = &adis16475_chip_info[ADIS16475_2] },
-	{ .compatible = "adi,adis16475-3",
-		.data = &adis16475_chip_info[ADIS16475_3] },
-	{ .compatible = "adi,adis16477-1",
-		.data = &adis16475_chip_info[ADIS16477_1] },
-	{ .compatible = "adi,adis16477-2",
-		.data = &adis16475_chip_info[ADIS16477_2] },
-	{ .compatible = "adi,adis16477-3",
-		.data = &adis16475_chip_info[ADIS16477_3] },
-	{ .compatible = "adi,adis16465-1",
-		.data = &adis16475_chip_info[ADIS16465_1] },
-	{ .compatible = "adi,adis16465-2",
-		.data = &adis16475_chip_info[ADIS16465_2] },
-	{ .compatible = "adi,adis16465-3",
-		.data = &adis16475_chip_info[ADIS16465_3] },
-	{ .compatible = "adi,adis16467-1",
-		.data = &adis16475_chip_info[ADIS16467_1] },
-	{ .compatible = "adi,adis16467-2",
-		.data = &adis16475_chip_info[ADIS16467_2] },
-	{ .compatible = "adi,adis16467-3",
-		.data = &adis16475_chip_info[ADIS16467_3] },
-	{ .compatible = "adi,adis16500",
-		.data = &adis16475_chip_info[ADIS16500] },
-	{ .compatible = "adi,adis16505-1",
-		.data = &adis16475_chip_info[ADIS16505_1] },
-	{ .compatible = "adi,adis16505-2",
-		.data = &adis16475_chip_info[ADIS16505_2] },
-	{ .compatible = "adi,adis16505-3",
-		.data = &adis16475_chip_info[ADIS16505_3] },
-	{ .compatible = "adi,adis16507-1",
-		.data = &adis16475_chip_info[ADIS16507_1] },
-	{ .compatible = "adi,adis16507-2",
-		.data = &adis16475_chip_info[ADIS16507_2] },
-	{ .compatible = "adi,adis16507-3",
-		.data = &adis16475_chip_info[ADIS16507_3] },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, adis16475_of_match);
 
 static int adis16475_probe(struct spi_device *spi)
 {
@@ -1463,7 +1419,7 @@ static int adis16475_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->info = device_get_match_data(&spi->dev);
+	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -EINVAL;
 
@@ -1503,12 +1459,83 @@ static int adis16475_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id adis16475_of_match[] = {
+	{ .compatible = "adi,adis16470",
+		.data = &adis16475_chip_info[ADIS16470] },
+	{ .compatible = "adi,adis16475-1",
+		.data = &adis16475_chip_info[ADIS16475_1] },
+	{ .compatible = "adi,adis16475-2",
+		.data = &adis16475_chip_info[ADIS16475_2] },
+	{ .compatible = "adi,adis16475-3",
+		.data = &adis16475_chip_info[ADIS16475_3] },
+	{ .compatible = "adi,adis16477-1",
+		.data = &adis16475_chip_info[ADIS16477_1] },
+	{ .compatible = "adi,adis16477-2",
+		.data = &adis16475_chip_info[ADIS16477_2] },
+	{ .compatible = "adi,adis16477-3",
+		.data = &adis16475_chip_info[ADIS16477_3] },
+	{ .compatible = "adi,adis16465-1",
+		.data = &adis16475_chip_info[ADIS16465_1] },
+	{ .compatible = "adi,adis16465-2",
+		.data = &adis16475_chip_info[ADIS16465_2] },
+	{ .compatible = "adi,adis16465-3",
+		.data = &adis16475_chip_info[ADIS16465_3] },
+	{ .compatible = "adi,adis16467-1",
+		.data = &adis16475_chip_info[ADIS16467_1] },
+	{ .compatible = "adi,adis16467-2",
+		.data = &adis16475_chip_info[ADIS16467_2] },
+	{ .compatible = "adi,adis16467-3",
+		.data = &adis16475_chip_info[ADIS16467_3] },
+	{ .compatible = "adi,adis16500",
+		.data = &adis16475_chip_info[ADIS16500] },
+	{ .compatible = "adi,adis16505-1",
+		.data = &adis16475_chip_info[ADIS16505_1] },
+	{ .compatible = "adi,adis16505-2",
+		.data = &adis16475_chip_info[ADIS16505_2] },
+	{ .compatible = "adi,adis16505-3",
+		.data = &adis16475_chip_info[ADIS16505_3] },
+	{ .compatible = "adi,adis16507-1",
+		.data = &adis16475_chip_info[ADIS16507_1] },
+	{ .compatible = "adi,adis16507-2",
+		.data = &adis16475_chip_info[ADIS16507_2] },
+	{ .compatible = "adi,adis16507-3",
+		.data = &adis16475_chip_info[ADIS16507_3] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adis16475_of_match);
+
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
+
 static struct spi_driver adis16475_driver = {
 	.driver = {
 		.name = "adis16475",
 		.of_match_table = adis16475_of_match,
 	},
 	.probe = adis16475_probe,
+	.id_table = adis16475_ids,
 };
 module_spi_driver(adis16475_driver);
 


