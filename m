Return-Path: <stable+bounces-81399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7F993436
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E2B1B21A35
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995B1DCB3D;
	Mon,  7 Oct 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xolETX9L"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1981DBB1D
	for <Stable@vger.kernel.org>; Mon,  7 Oct 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320077; cv=none; b=qz4Pg3zM/cfhT5J/PfYlHYwlyPnn9EAmgNhliaobN/vZOrOlJxsSmR7ahsBmb6TRnDfaNl3KIJzj6S9iujIcmhRVSp0npuIcd3HDgvMVREr8lGZG6OYTBp2K67yha+bz4rGMPv3mK7mH/AtPTJhvSf+M5FUDaprxU5kIkS5wH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320077; c=relaxed/simple;
	bh=NGtDfgAi90TslKSf3R8HHUfCWZHIRePf1psXgoodfAk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MDuURhoJdyUgNhlhZ0IZ+1i38eaAvCwcd0crpCq41G/GvQ+Pn2mo0HVWPbXa7/AHUXfYY56QvKQfFifYA077+M4PNapYxE0EhQ3C7FaaYuEwPJiGvijLdgMESJkIIj7AU+6hzqLV5tx0LpT4UaCtakykuwIGMeoaj/ka8/my5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xolETX9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D2DC4CEC6;
	Mon,  7 Oct 2024 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320077;
	bh=NGtDfgAi90TslKSf3R8HHUfCWZHIRePf1psXgoodfAk=;
	h=Subject:To:Cc:From:Date:From;
	b=xolETX9LHSN4ylYxPQJfjEpwne4rvHim7otcjzDpZmnd+R6Pd96JAsKBgxEQmZlx2
	 Kfzw7GC5V5823aCSaUghE60O/xyt/mhbWHf+HHZwB0YOjz/H0yWmsUciJlsSUZhYqC
	 YLyXsu+1w2GanHm0sHTCS9SKPC3O5yp2O3aDrf+o=
Subject: FAILED: patch "[PATCH] iio: pressure: bmp280: Fix regmap for BMP280 device" failed to apply to 6.1-stable tree
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:54:29 +0200
Message-ID: <2024100729-showbiz-slinging-fa22@gregkh>
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
git cherry-pick -x b9065b0250e1705935445ede0a18c1850afe7b75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100729-showbiz-slinging-fa22@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b9065b0250e1 ("iio: pressure: bmp280: Fix regmap for BMP280 device")
b23be4cd99a6 ("iio: pressure: bmp280: Use BME prefix for BME280 specifics")
439ce8961bdd ("iio: pressure: bmp280: Improve indentation and line wrapping")
33564435c808 ("iio: pressure: bmp280: Allow multiple chips id per family of devices")
a2d43f44628f ("iio: pressure: fix some word spelling errors")
accb9d05df39 ("iio: pressure: bmp280: Add nvmem operations for BMP580")
597dfb2af052 ("iio: pressure: bmp280: Add support for new sensor BMP580")
42cde8808573 ("iio: pressure: Kconfig: Delete misleading I2C reference on bmp280 title")
c25ea00fefa4 ("iio: pressure: bmp280: Add preinit callback")
0b0b772637cd ("iio: pressure: bmp280: Use chip_info pointers for each chip as driver data")
12491d35551d ("iio: pressure: bmp280: convert to i2c's .probe_new()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9065b0250e1705935445ede0a18c1850afe7b75 Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 11 Jul 2024 23:15:49 +0200
Subject: [PATCH] iio: pressure: bmp280: Fix regmap for BMP280 device

Up to now, the BMP280 device is using the regmap of the BME280 which
has registers that exist only in the BME280 device.

Fixes: 14e8015f8569 ("iio: pressure: bmp280: split driver in logical parts")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://patch.msgid.link/20240711211558.106327-2-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 2fc5724196e3..cc8553177977 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1186,7 +1186,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.chip_id = bme280_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
-	.regmap_config = &bmp280_regmap_config,
+	.regmap_config = &bme280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bme280_channels,
 	.num_channels = ARRAY_SIZE(bme280_channels),
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index fa52839474b1..d27d68edd906 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -41,7 +41,7 @@ const struct regmap_config bmp180_regmap_config = {
 };
 EXPORT_SYMBOL_NS(bmp180_regmap_config, IIO_BMP280);
 
-static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
+static bool bme280_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case BMP280_REG_CONFIG:
@@ -54,7 +54,35 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP280_REG_CONFIG:
+	case BMP280_REG_CTRL_MEAS:
+	case BMP280_REG_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP280_REG_TEMP_XLSB:
+	case BMP280_REG_TEMP_LSB:
+	case BMP280_REG_TEMP_MSB:
+	case BMP280_REG_PRESS_XLSB:
+	case BMP280_REG_PRESS_LSB:
+	case BMP280_REG_PRESS_MSB:
+	case BMP280_REG_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool bme280_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case BME280_REG_HUMIDITY_LSB:
@@ -71,7 +99,6 @@ static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
-
 static bool bmp380_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -167,7 +194,7 @@ const struct regmap_config bmp280_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-	.max_register = BME280_REG_HUMIDITY_LSB,
+	.max_register = BMP280_REG_TEMP_XLSB,
 	.cache_type = REGCACHE_RBTREE,
 
 	.writeable_reg = bmp280_is_writeable_reg,
@@ -175,6 +202,18 @@ const struct regmap_config bmp280_regmap_config = {
 };
 EXPORT_SYMBOL_NS(bmp280_regmap_config, IIO_BMP280);
 
+const struct regmap_config bme280_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BME280_REG_HUMIDITY_LSB,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = bme280_is_writeable_reg,
+	.volatile_reg = bme280_is_volatile_reg,
+};
+EXPORT_SYMBOL_NS(bme280_regmap_config, IIO_BMP280);
+
 const struct regmap_config bmp380_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 0933e411ae2c..4b0ebce001df 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -490,6 +490,7 @@ extern const struct bmp280_chip_info bmp580_chip_info;
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
+extern const struct regmap_config bme280_regmap_config;
 extern const struct regmap_config bmp380_regmap_config;
 extern const struct regmap_config bmp580_regmap_config;
 


