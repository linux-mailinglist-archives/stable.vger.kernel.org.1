Return-Path: <stable+bounces-72797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B54F9699D5
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9811C230B6
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853817C9B3;
	Tue,  3 Sep 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aD7fREAX"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFD1A0BFE
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358497; cv=none; b=ewTHpBvG8RAjQ/dOol5JujWhPOkwnQ/7F+LBN42yZ1gEB6G7+ETb2+CYy91mWCjDHFW3WeIP5LKbaw1P+G1Dz4BjPrCkxGf5YcXg+PJyWa3UzuTCtnugni1VYxOAeB9+je0uFhGLyte+lRj+GC4MHz5s+z9UxCWmCizatCZCHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358497; c=relaxed/simple;
	bh=0yWiAQ7ae1woxdSNZkNVH04HMg9OdU+djS7Na5NQ3n8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ACh+CU+Z4AeC/CzRzBKGpSNL8TYhDiSI48xjuVupdJrEipTsvjhOqTH+kDpkfYZWb3DsCeZjnntZ/+qESdPrDwB/noGymPsrI/XXxGvqnNLl7WxM8uDk2a6AzpGskCiDG1RdNuE6Gw0iaCAW7BJumITK5VhMmY4qrthuRpiMdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aD7fREAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE41C4CEC4;
	Tue,  3 Sep 2024 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725358497;
	bh=0yWiAQ7ae1woxdSNZkNVH04HMg9OdU+djS7Na5NQ3n8=;
	h=Subject:To:From:Date:From;
	b=aD7fREAX7PFiYsko4lKltvMTMIUq6C63oOBAtOZ/19lifOOjBJ/o4rzfu5uj4uOrC
	 RQiSIKSCWMRuIRWzG+b8qdMnjfaGwgOP7KDnQ7ZB0oZBtkskIchqVf/CQ5DmsUMxSV
	 um7J7Wohu1CEhOCV7gPs2ILUdVb+gQM+EKc13y40=
Subject: patch "iio: pressure: bmp280: Fix regmap for BMP280 device" added to char-misc-testing
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 11:34:43 +0200
Message-ID: <2024090342-rebuttal-prowess-7697@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: bmp280: Fix regmap for BMP280 device

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From b9065b0250e1705935445ede0a18c1850afe7b75 Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 11 Jul 2024 23:15:49 +0200
Subject: iio: pressure: bmp280: Fix regmap for BMP280 device

Up to now, the BMP280 device is using the regmap of the BME280 which
has registers that exist only in the BME280 device.

Fixes: 14e8015f8569 ("iio: pressure: bmp280: split driver in logical parts")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://patch.msgid.link/20240711211558.106327-2-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/bmp280-core.c   |  2 +-
 drivers/iio/pressure/bmp280-regmap.c | 45 ++++++++++++++++++++++++++--
 drivers/iio/pressure/bmp280.h        |  1 +
 3 files changed, 44 insertions(+), 4 deletions(-)

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
 
-- 
2.46.0



