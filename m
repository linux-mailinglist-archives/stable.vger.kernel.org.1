Return-Path: <stable+bounces-57885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8D925E97
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81FB292D95
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2A818306D;
	Wed,  3 Jul 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jiTDhxOj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE2174EFA;
	Wed,  3 Jul 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006226; cv=none; b=OLn2gi9bjQQiZ9brzMMxETpxpXlaIWXV4VCFDbPXeZv9w7oMeOOHmTqZaVBhr4+4GKgDrfFpL9qoGncI77On8nLQzePRfjZU/oAOQOs8GfHRZkT+eS43QU0gj4smPEJ86YY0UYStkysTIKXS1EI4Ntqe1c8tPCqN9XQRljRw8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006226; c=relaxed/simple;
	bh=zb4sreSkoCD+pIpCH7Q5UkUmCKhxIC7YfRGX65hh+LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MihAiE3aRXOLhDxsGWzOzCeDZtKp2lg5oFHjl86wX2L9cDKx2T1wEQ8LLsrEQpT/FpNZUnRTsBf9OjWbGmHnHKwMnxuAkwH5E+SGBjVeeDaXiJ0QTQPe1Up+uIHDPPXC2lg38Uyyoxfyglnbe+o1QikZPcV3KGewYicB2pJwI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jiTDhxOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64FBC2BD10;
	Wed,  3 Jul 2024 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720006226;
	bh=zb4sreSkoCD+pIpCH7Q5UkUmCKhxIC7YfRGX65hh+LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiTDhxOjDJ+YRlGQA3HRJ7p2nSfkjdIE3l1w4MwYKIBoNLQR2Su1sPC8sNNfaFhf3
	 OC0LRb6FAHQ4ScDphJNV4o66/7kp0tqRh4CrIEuIkvtoc9nVMLPc9BWDT/m/CtGVlP
	 tXDe7Ls27IxoIyklfO1qYWRythAi4qfqQ0tKOZao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 315/356] iio: chemical: bme680: Fix sensor data read operation
Date: Wed,  3 Jul 2024 12:40:51 +0200
Message-ID: <20240703102925.032063791@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

From: Vasileios Amoiridis <vassilisamir@gmail.com>

commit 4241665e6ea063a9c1d734de790121a71db763fc upstream.

A read operation is happening as follows:

a) Set sensor to forced mode
b) Sensor measures values and update data registers and sleeps again
c) Read data registers

In the current implementation the read operation happens immediately
after the sensor is set to forced mode so the sensor does not have
the time to update properly the registers. This leads to the following
2 problems:

1) The first ever value which is read by the register is always wrong
2) Every read operation, puts the register into forced mode and reads
the data that were calculated in the previous conversion.

This behaviour was tested in 2 ways:

1) The internal meas_status_0 register was read before and after every
read operation in order to verify that the data were ready even before
the register was set to forced mode and also to check that after the
forced mode was set the new data were not yet ready.

2) Physically changing the temperature and measuring the temperature

This commit adds the waiting time in between the set of the forced mode
and the read of the data. The function is taken from the Bosch BME68x
Sensor API [1].

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490

Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240606212313.207550-5-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/chemical/bme680.h      |    2 +
 drivers/iio/chemical/bme680_core.c |   46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -54,7 +54,9 @@
 #define   BME680_NB_CONV_MASK			GENMASK(3, 0)
 
 #define BME680_REG_MEAS_STAT_0			0x1D
+#define   BME680_NEW_DATA_BIT			BIT(7)
 #define   BME680_GAS_MEAS_BIT			BIT(6)
+#define   BME680_MEAS_BIT			BIT(5)
 
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -10,6 +10,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/log2.h>
@@ -532,6 +533,43 @@ static u8 bme680_oversampling_to_reg(u8
 	return ilog2(val) + 1;
 }
 
+/*
+ * Taken from Bosch BME680 API:
+ * https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
+ */
+static int bme680_wait_for_eoc(struct bme680_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int check;
+	int ret;
+	/*
+	 * (Sum of oversampling ratios * time per oversampling) +
+	 * TPH measurement + gas measurement + wait transition from forced mode
+	 * + heater duration
+	 */
+	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
+			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   (477 * 5) + 1000 + (data->heater_dur * 1000);
+
+	usleep_range(wait_eoc_us, wait_eoc_us + 100);
+
+	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
+	if (ret) {
+		dev_err(dev, "failed to read measurement status register.\n");
+		return ret;
+	}
+	if (check & BME680_MEAS_BIT) {
+		dev_err(dev, "Device measurement cycle incomplete.\n");
+		return -EBUSY;
+	}
+	if (!(check & BME680_NEW_DATA_BIT)) {
+		dev_err(dev, "No new data available from the device.\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
 static int bme680_chip_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -622,6 +660,10 @@ static int bme680_read_temp(struct bme68
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       &tmp, 3);
 	if (ret < 0) {
@@ -738,6 +780,10 @@ static int bme680_read_gas(struct bme680
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
 	if (check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");



