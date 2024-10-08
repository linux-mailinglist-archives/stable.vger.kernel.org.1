Return-Path: <stable+bounces-82076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E75994AED
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868FC2827F0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031F1DE4CB;
	Tue,  8 Oct 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YU1abvRd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE991DC759;
	Tue,  8 Oct 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391083; cv=none; b=iuPp5KRN982086Eqx3E0Dto0zdzu6GkD+PrnIcM5UVxxUDNiBFvaPx3BKF6GlbQgucH7bx3RQdI0+1hXC3HC6TkAvwGvYnvnS4ffBIaNwRgKJJTujd3qsYjfYfBRzkc/nsHNrBhrl6N+hG8cuyNG5/lPkUIEC83vdDMjcZzPtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391083; c=relaxed/simple;
	bh=lxr2uzr5Z+FVDgoHnveiZJAFxzxw5GvrIN/arYcJjRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rqu7ntOWmeNDnNk4rRMaAeCUpOgBn60bZerPvBpGQUau3hiqxaMU4KNAoRcJna8oCVZMxfmojf0s9HvoKfFkAy8HbbUswlIMulAJ7MoHF64YuE9k3bY9S+uu7zwYw9mlRxISN2qhcPpQEb5neoJ4tV0dshT+0Uuq351nv15Zrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YU1abvRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD79BC4CEC7;
	Tue,  8 Oct 2024 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391083;
	bh=lxr2uzr5Z+FVDgoHnveiZJAFxzxw5GvrIN/arYcJjRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YU1abvRd2sKEKpWSqLfZEDnak4/v70kE76iPC7t3j5pzeAvIGEBVoUoTetqoDXjER
	 wf7t8eP3XEGIBHBNHMrzfMfs2M0Y606+F+BdlLiZp97nOOGtwl4R0ROPFBpJhRbX7c
	 2t+r+9XLwgHhsO8n2JXc/i92Ehx4J37RBaQ+hdHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 465/482] iio: pressure: bmp280: Improve indentation and line wrapping
Date: Tue,  8 Oct 2024 14:08:48 +0200
Message-ID: <20241008115706.812195412@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasileios Amoiridis <vassilisamir@gmail.com>

[ Upstream commit 439ce8961bdd2e925c1f6adc82ce9fe3931e2c08 ]

Fix indentations that are not following the standards, remove
extra white lines and add missing white lines.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240429190046.24252-2-vassilisamir@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: b9065b0250e1 ("iio: pressure: bmp280: Fix regmap for BMP280 device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/bmp280-core.c | 108 ++++++++++++++++-------------
 drivers/iio/pressure/bmp280-spi.c  |   4 +-
 2 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 221fa2c552ae2..82c177e0ff933 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -52,7 +52,6 @@
  */
 enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
 
-
 enum bmp380_odr {
 	BMP380_ODR_200HZ,
 	BMP380_ODR_100HZ,
@@ -181,18 +180,19 @@ static int bmp280_read_calib(struct bmp280_data *data)
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	int ret;
 
-
 	/* Read temperature and pressure calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
-			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
+			       data->bmp280_cal_buf,
+			       sizeof(data->bmp280_cal_buf));
 	if (ret < 0) {
 		dev_err(data->dev,
-			"failed to read temperature and pressure calibration parameters\n");
+			"failed to read calibration parameters\n");
 		return ret;
 	}
 
-	/* Toss the temperature and pressure calibration data into the entropy pool */
-	add_device_randomness(data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
+	/* Toss calibration data into the entropy pool */
+	add_device_randomness(data->bmp280_cal_buf,
+			      sizeof(data->bmp280_cal_buf));
 
 	/* Parse temperature calibration values. */
 	calib->T1 = le16_to_cpu(data->bmp280_cal_buf[T1]);
@@ -223,7 +223,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 	/* Load shared calibration params with bmp280 first */
 	ret = bmp280_read_calib(data);
 	if  (ret < 0) {
-		dev_err(dev, "failed to read common bmp280 calibration parameters\n");
+		dev_err(dev, "failed to read calibration parameters\n");
 		return ret;
 	}
 
@@ -283,6 +283,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	return 0;
 }
+
 /*
  * Returns humidity in percent, resolution is 0.01 percent. Output value of
  * "47445" represents 47445/1024 = 46.333 %RH.
@@ -305,7 +306,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 	var = clamp_val(var, 0, 419430400);
 
 	return var >> 12;
-};
+}
 
 /*
  * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
@@ -538,7 +539,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 }
 
 static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
-					       int val)
+						 int val)
 {
 	const int *avail = data->chip_info->oversampling_humid_avail;
 	const int n = data->chip_info->num_oversampling_humid_avail;
@@ -563,7 +564,7 @@ static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
 }
 
 static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
-					       int val)
+						int val)
 {
 	const int *avail = data->chip_info->oversampling_temp_avail;
 	const int n = data->chip_info->num_oversampling_temp_avail;
@@ -588,7 +589,7 @@ static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
 }
 
 static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
-					       int val)
+						 int val)
 {
 	const int *avail = data->chip_info->oversampling_press_avail;
 	const int n = data->chip_info->num_oversampling_press_avail;
@@ -772,13 +773,12 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
-				 BMP280_OSRS_TEMP_MASK |
-				 BMP280_OSRS_PRESS_MASK |
-				 BMP280_MODE_MASK,
-				 osrs | BMP280_MODE_NORMAL);
+				BMP280_OSRS_TEMP_MASK |
+				BMP280_OSRS_PRESS_MASK |
+				BMP280_MODE_MASK,
+				osrs | BMP280_MODE_NORMAL);
 	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to write ctrl_meas register\n");
+		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
 	}
 
@@ -786,8 +786,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				 BMP280_FILTER_MASK,
 				 BMP280_FILTER_4X);
 	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to write config register\n");
+		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
 
@@ -926,8 +925,8 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
 }
 
 /*
- * Returns temperature in Celsius degrees, resolution is 0.01º C. Output value of
- * "5123" equals 51.2º C. t_fine carries fine temperature as global value.
+ * Returns temperature in Celsius degrees, resolution is 0.01º C. Output value
+ * of "5123" equals 51.2º C. t_fine carries fine temperature as global value.
  *
  * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
  * https://github.com/BoschSensortec/BMP3-Sensor-API.
@@ -1069,7 +1068,8 @@ static int bmp380_read_calib(struct bmp280_data *data)
 
 	/* Read temperature and pressure calibration data */
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START,
-			       data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf));
+			       data->bmp380_cal_buf,
+			       sizeof(data->bmp380_cal_buf));
 	if (ret) {
 		dev_err(data->dev,
 			"failed to read temperature calibration parameters\n");
@@ -1077,7 +1077,8 @@ static int bmp380_read_calib(struct bmp280_data *data)
 	}
 
 	/* Toss the temperature calibration data into the entropy pool */
-	add_device_randomness(data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf));
+	add_device_randomness(data->bmp380_cal_buf,
+			      sizeof(data->bmp380_cal_buf));
 
 	/* Parse calibration values */
 	calib->T1 = get_unaligned_le16(&data->bmp380_cal_buf[BMP380_T1]);
@@ -1159,7 +1160,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 	/* Configure output data rate */
 	ret = regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
-				       BMP380_ODRS_MASK, data->sampling_freq, &aux);
+				       BMP380_ODRS_MASK, data->sampling_freq,
+				       &aux);
 	if (ret) {
 		dev_err(data->dev, "failed to write ODR selection register\n");
 		return ret;
@@ -1178,12 +1180,13 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 	if (change) {
 		/*
-		 * The configurations errors are detected on the fly during a measurement
-		 * cycle. If the sampling frequency is too low, it's faster to reset
-		 * the measurement loop than wait until the next measurement is due.
+		 * The configurations errors are detected on the fly during a
+		 * measurement cycle. If the sampling frequency is too low, it's
+		 * faster to reset the measurement loop than wait until the next
+		 * measurement is due.
 		 *
-		 * Resets sensor measurement loop toggling between sleep and normal
-		 * operating modes.
+		 * Resets sensor measurement loop toggling between sleep and
+		 * normal operating modes.
 		 */
 		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
 					BMP380_MODE_MASK,
@@ -1201,22 +1204,21 @@ static int bmp380_chip_config(struct bmp280_data *data)
 			return ret;
 		}
 		/*
-		 * Waits for measurement before checking configuration error flag.
-		 * Selected longest measure time indicated in section 3.9.1
-		 * in the datasheet.
+		 * Waits for measurement before checking configuration error
+		 * flag. Selected longest measure time indicated in
+		 * section 3.9.1 in the datasheet.
 		 */
 		msleep(80);
 
 		/* Check config error flag */
 		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
 		if (ret) {
-			dev_err(data->dev,
-				"failed to read error register\n");
+			dev_err(data->dev, "failed to read error register\n");
 			return ret;
 		}
 		if (tmp & BMP380_ERR_CONF_MASK) {
 			dev_warn(data->dev,
-				"sensor flagged configuration as incompatible\n");
+				 "sensor flagged configuration as incompatible\n");
 			return -EINVAL;
 		}
 	}
@@ -1317,9 +1319,11 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 	}
 
 	/* Start NVM operation sequence */
-	ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_OP_SEQ_0);
+	ret = regmap_write(data->regmap, BMP580_REG_CMD,
+			   BMP580_CMD_NVM_OP_SEQ_0);
 	if (ret) {
-		dev_err(data->dev, "failed to send nvm operation's first sequence\n");
+		dev_err(data->dev,
+			"failed to send nvm operation's first sequence\n");
 		return ret;
 	}
 	if (is_write) {
@@ -1327,7 +1331,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		ret = regmap_write(data->regmap, BMP580_REG_CMD,
 				   BMP580_CMD_NVM_WRITE_SEQ_1);
 		if (ret) {
-			dev_err(data->dev, "failed to send nvm write sequence\n");
+			dev_err(data->dev,
+				"failed to send nvm write sequence\n");
 			return ret;
 		}
 		/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
@@ -1338,7 +1343,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		ret = regmap_write(data->regmap, BMP580_REG_CMD,
 				   BMP580_CMD_NVM_READ_SEQ_1);
 		if (ret) {
-			dev_err(data->dev, "failed to send nvm read sequence\n");
+			dev_err(data->dev,
+				"failed to send nvm read sequence\n");
 			return ret;
 		}
 		/* Datasheet says on 4.8.1.1 it takes approximately 200us */
@@ -1501,8 +1507,8 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 		if (ret)
 			goto exit;
 
-		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
-				       sizeof(data->le16));
+		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB,
+				       &data->le16, sizeof(data->le16));
 		if (ret) {
 			dev_err(data->dev, "error reading nvm data regs\n");
 			goto exit;
@@ -1546,7 +1552,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 	while (bytes >= sizeof(*buf)) {
 		addr = bmp580_nvmem_addrs[offset / sizeof(*buf)];
 
-		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM_PROG_EN |
+		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
+				   BMP580_NVM_PROG_EN |
 				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
 		if (ret) {
 			dev_err(data->dev, "error writing nvm address\n");
@@ -1554,8 +1561,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 		}
 		data->le16 = cpu_to_le16(*buf++);
 
-		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
-					sizeof(data->le16));
+		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB,
+					&data->le16, sizeof(data->le16));
 		if (ret) {
 			dev_err(data->dev, "error writing LSB NVM data regs\n");
 			goto exit;
@@ -1662,7 +1669,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 		  BMP580_OSR_PRESS_EN;
 
 	ret = regmap_update_bits_check(data->regmap, BMP580_REG_OSR_CONFIG,
-				       BMP580_OSR_TEMP_MASK | BMP580_OSR_PRESS_MASK |
+				       BMP580_OSR_TEMP_MASK |
+				       BMP580_OSR_PRESS_MASK |
 				       BMP580_OSR_PRESS_EN,
 				       reg_val, &aux);
 	if (ret) {
@@ -1713,7 +1721,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 		 */
 		ret = regmap_read(data->regmap, BMP580_REG_EFF_OSR, &tmp);
 		if (ret) {
-			dev_err(data->dev, "error reading effective OSR register\n");
+			dev_err(data->dev,
+				"error reading effective OSR register\n");
 			return ret;
 		}
 		if (!(tmp & BMP580_EFF_OSR_VALID_ODR)) {
@@ -1848,7 +1857,8 @@ static int bmp180_read_calib(struct bmp280_data *data)
 	}
 
 	/* Toss the calibration data into the entropy pool */
-	add_device_randomness(data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
+	add_device_randomness(data->bmp180_cal_buf,
+			      sizeof(data->bmp180_cal_buf));
 
 	calib->AC1 = be16_to_cpu(data->bmp180_cal_buf[AC1]);
 	calib->AC2 = be16_to_cpu(data->bmp180_cal_buf[AC2]);
@@ -1963,8 +1973,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_press;
 	s32 adc_press;
@@ -2241,6 +2250,7 @@ static int bmp280_runtime_resume(struct device *dev)
 	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
 	if (ret)
 		return ret;
+
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 	return data->chip_info->chip_config(data);
 }
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 4e19ea0b4d398..62b4e58104cf9 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -13,7 +13,7 @@
 #include "bmp280.h"
 
 static int bmp280_regmap_spi_write(void *context, const void *data,
-                                   size_t count)
+				   size_t count)
 {
 	struct spi_device *spi = to_spi_device(context);
 	u8 buf[2];
@@ -29,7 +29,7 @@ static int bmp280_regmap_spi_write(void *context, const void *data,
 }
 
 static int bmp280_regmap_spi_read(void *context, const void *reg,
-                                  size_t reg_size, void *val, size_t val_size)
+				  size_t reg_size, void *val, size_t val_size)
 {
 	struct spi_device *spi = to_spi_device(context);
 
-- 
2.43.0




