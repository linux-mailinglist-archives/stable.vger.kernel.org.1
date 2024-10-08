Return-Path: <stable+bounces-82996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0759A994FD8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7551F23C00
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAF1E04AA;
	Tue,  8 Oct 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JsfownxE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F51E0481;
	Tue,  8 Oct 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394131; cv=none; b=rDBYzSn5iMcOH//KDR8bnnqEBZhvKk3p74aVHBxFp+UtWws1pWOVF2PRRs4D4sHrTDpGHN8u1LaOgFG9CEiTwzptryi3LFjnfDGS3KRgs/0JzFbrCJoDxVBod4Y3kUYf3G+b77kZ6iW0YHVs2zEy9TWGYSD4dbFgp/qNpFKVf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394131; c=relaxed/simple;
	bh=Mz05V0SJ0L6alT5oV3IQwqMxGxjwanErTQJmJ+zWXWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm5wIDoUszaPYVpfCW2oRcR0v2+Dcqp3G8v7vWdpGU36ebdxncUSKbnmqhpTYwFjhPHGjCZOm4pnmQMTrptsFdl4onkklLgLxFASBexALMMakRMcrzONhrrUloGB9601TsK2GQVVY1xWynSQCqOMLek0BrQlrqY2sDQN11ZkW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JsfownxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC93C4CEC7;
	Tue,  8 Oct 2024 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394131;
	bh=Mz05V0SJ0L6alT5oV3IQwqMxGxjwanErTQJmJ+zWXWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JsfownxEP96bBfWtjfeFD9JKRzUVTdWXJev6hS51hHDsYoWWu1yFpelErwxRPDk0L
	 ULIidgtugCu4YyNhxunA5mvc0m7iAAAZhw7YkuRTJ75BhWHIoRvdQuDwQS4RRAQPHk
	 kb2uRPIrV2+0VnYvBAYvsi9tIQj4wod3VlOZTOfk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 355/386] iio: pressure: bmp280: Use BME prefix for BME280 specifics
Date: Tue,  8 Oct 2024 14:10:00 +0200
Message-ID: <20241008115643.354194663@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasileios Amoiridis <vassilisamir@gmail.com>

[ Upstream commit b23be4cd99a6f1f46963b87952632268174e62c1 ]

Change the rest of the defines and function names that are
used specifically by the BME280 humidity sensor to BME280
as it is done for the rest of the BMP{0,1,3,5}80 sensors.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240429190046.24252-3-vassilisamir@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: b9065b0250e1 ("iio: pressure: bmp280: Fix regmap for BMP280 device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/bmp280-core.c   | 37 +++++++++++------------
 drivers/iio/pressure/bmp280-regmap.c |  8 ++---
 drivers/iio/pressure/bmp280.h        | 45 +++++++++++++++-------------
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index dac2a4e237929..8f70fd72f132a 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -234,14 +234,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 	 * Humidity data is only available on BME280.
 	 */
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H1 comp value\n");
 		return ret;
 	}
 	calib->H1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
 			       &data->le16, sizeof(data->le16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H2 comp value\n");
@@ -249,14 +249,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 	}
 	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H3 comp value\n");
 		return ret;
 	}
 	calib->H3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
 			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H4 comp value\n");
@@ -265,15 +265,15 @@ static int bme280_read_calib(struct bmp280_data *data)
 	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
 				  (be16_to_cpu(data->be16) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
 			       &data->le16, sizeof(data->le16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
+	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H6 comp value\n");
 		return ret;
@@ -289,7 +289,7 @@ static int bme280_read_calib(struct bmp280_data *data)
  *
  * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
  */
-static u32 bmp280_compensate_humidity(struct bmp280_data *data,
+static u32 bme280_compensate_humidity(struct bmp280_data *data,
 				      s32 adc_humidity)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
@@ -429,7 +429,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 	return IIO_VAL_FRACTIONAL;
 }
 
-static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_humidity;
 	s32 adc_humidity;
@@ -440,7 +440,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
 			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read humidity\n");
@@ -453,7 +453,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 		dev_err(data->dev, "reading humidity skipped\n");
 		return -EIO;
 	}
-	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
+	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
 
 	*val = comp_humidity * 1000 / 1024;
 
@@ -537,7 +537,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
+static int bme280_write_oversampling_ratio_humid(struct bmp280_data *data,
 						 int val)
 {
 	const int *avail = data->chip_info->oversampling_humid_avail;
@@ -681,7 +681,7 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = bmp280_write_oversampling_ratio_humid(data, val);
+			ret = bme280_write_oversampling_ratio_humid(data, val);
 			break;
 		case IIO_PRESSURE:
 			ret = bmp280_write_oversampling_ratio_press(data, val);
@@ -831,16 +831,15 @@ EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = FIELD_PREP(BMP280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
+	u8 osrs = FIELD_PREP(BME280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
 	int ret;
 
 	/*
 	 * Oversampling of humidity must be set before oversampling of
 	 * temperature/pressure is set to become effective.
 	 */
-	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
-				  BMP280_OSRS_HUMIDITY_MASK, osrs);
-
+	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
+				 BME280_OSRS_HUMIDITY_MASK, osrs);
 	if (ret < 0)
 		return ret;
 
@@ -868,12 +867,12 @@ const struct bmp280_chip_info bme280_chip_info = {
 
 	.oversampling_humid_avail = bmp280_oversampling_avail,
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
-	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
+	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
-	.read_humid = bmp280_read_humid,
+	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
 };
 EXPORT_SYMBOL_NS(bme280_chip_info, IIO_BMP280);
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index 3ee56720428c5..fa52839474b18 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -45,7 +45,7 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case BMP280_REG_CONFIG:
-	case BMP280_REG_CTRL_HUMIDITY:
+	case BME280_REG_CTRL_HUMIDITY:
 	case BMP280_REG_CTRL_MEAS:
 	case BMP280_REG_RESET:
 		return true;
@@ -57,8 +57,8 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case BMP280_REG_HUMIDITY_LSB:
-	case BMP280_REG_HUMIDITY_MSB:
+	case BME280_REG_HUMIDITY_LSB:
+	case BME280_REG_HUMIDITY_MSB:
 	case BMP280_REG_TEMP_XLSB:
 	case BMP280_REG_TEMP_LSB:
 	case BMP280_REG_TEMP_MSB:
@@ -167,7 +167,7 @@ const struct regmap_config bmp280_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-	.max_register = BMP280_REG_HUMIDITY_LSB,
+	.max_register = BME280_REG_HUMIDITY_LSB,
 	.cache_type = REGCACHE_RBTREE,
 
 	.writeable_reg = bmp280_is_writeable_reg,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a44ea33221635..1a6903a917add 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -192,8 +192,6 @@
 #define BMP380_PRESS_SKIPPED		0x800000
 
 /* BMP280 specific registers */
-#define BMP280_REG_HUMIDITY_LSB		0xFE
-#define BMP280_REG_HUMIDITY_MSB		0xFD
 #define BMP280_REG_TEMP_XLSB		0xFC
 #define BMP280_REG_TEMP_LSB		0xFB
 #define BMP280_REG_TEMP_MSB		0xFA
@@ -207,15 +205,6 @@
 #define BMP280_REG_CONFIG		0xF5
 #define BMP280_REG_CTRL_MEAS		0xF4
 #define BMP280_REG_STATUS		0xF3
-#define BMP280_REG_CTRL_HUMIDITY	0xF2
-
-/* Due to non linear mapping, and data sizes we can't do a bulk read */
-#define BMP280_REG_COMP_H1		0xA1
-#define BMP280_REG_COMP_H2		0xE1
-#define BMP280_REG_COMP_H3		0xE3
-#define BMP280_REG_COMP_H4		0xE4
-#define BMP280_REG_COMP_H5		0xE5
-#define BMP280_REG_COMP_H6		0xE7
 
 #define BMP280_REG_COMP_TEMP_START	0x88
 #define BMP280_COMP_TEMP_REG_COUNT	6
@@ -223,8 +212,6 @@
 #define BMP280_REG_COMP_PRESS_START	0x8E
 #define BMP280_COMP_PRESS_REG_COUNT	18
 
-#define BMP280_COMP_H5_MASK		GENMASK(15, 4)
-
 #define BMP280_CONTIGUOUS_CALIB_REGS	(BMP280_COMP_TEMP_REG_COUNT + \
 					 BMP280_COMP_PRESS_REG_COUNT)
 
@@ -235,14 +222,6 @@
 #define BMP280_FILTER_8X		3
 #define BMP280_FILTER_16X		4
 
-#define BMP280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
-#define BMP280_OSRS_HUMIDITY_SKIP	0
-#define BMP280_OSRS_HUMIDITY_1X		1
-#define BMP280_OSRS_HUMIDITY_2X		2
-#define BMP280_OSRS_HUMIDITY_4X		3
-#define BMP280_OSRS_HUMIDITY_8X		4
-#define BMP280_OSRS_HUMIDITY_16X	5
-
 #define BMP280_OSRS_TEMP_MASK		GENMASK(7, 5)
 #define BMP280_OSRS_TEMP_SKIP		0
 #define BMP280_OSRS_TEMP_1X		1
@@ -264,6 +243,30 @@
 #define BMP280_MODE_FORCED		1
 #define BMP280_MODE_NORMAL		3
 
+/* BME280 specific registers */
+#define BME280_REG_HUMIDITY_LSB		0xFE
+#define BME280_REG_HUMIDITY_MSB		0xFD
+
+#define BME280_REG_CTRL_HUMIDITY	0xF2
+
+/* Due to non linear mapping, and data sizes we can't do a bulk read */
+#define BME280_REG_COMP_H1		0xA1
+#define BME280_REG_COMP_H2		0xE1
+#define BME280_REG_COMP_H3		0xE3
+#define BME280_REG_COMP_H4		0xE4
+#define BME280_REG_COMP_H5		0xE5
+#define BME280_REG_COMP_H6		0xE7
+
+#define BME280_COMP_H5_MASK		GENMASK(15, 4)
+
+#define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
+#define BME280_OSRS_HUMIDITY_SKIP	0
+#define BME280_OSRS_HUMIDITY_1X		1
+#define BME280_OSRS_HUMIDITY_2X		2
+#define BME280_OSRS_HUMIDITY_4X		3
+#define BME280_OSRS_HUMIDITY_8X		4
+#define BME280_OSRS_HUMIDITY_16X	5
+
 /* BMP180 specific registers */
 #define BMP180_REG_OUT_XLSB		0xF8
 #define BMP180_REG_OUT_LSB		0xF7
-- 
2.43.0




