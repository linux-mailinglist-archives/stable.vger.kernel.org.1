Return-Path: <stable+bounces-52589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3C90B905
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607AB28936D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C5419AD71;
	Mon, 17 Jun 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ibltqWQg"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E2195967
	for <Stable@vger.kernel.org>; Mon, 17 Jun 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647389; cv=none; b=VTKysCAABfEEJar3CSgnVGdaiy/frSIjzQ98B8pd/Yw0OtNGNxra9Yy785S+5ZAonVOeerON/WEnzTf3YxIEEvaw8cabySw4JaC7NbG2Q084eSz216rP16aocvYrnEMq0iIbqKyZ7h9+irJUGgMoIt3xAtDbOHZFKVcN4lIkLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647389; c=relaxed/simple;
	bh=5cs7CkAiw9i/S05z9inglh9xJGoyDo3fuk5O+IN0ay4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=fBX9AaW5AoTUEDPF8xvahMdvLB9mlY0wIWxgQQ45ClTeh+CYcBEUnfstbatZ3YWBHYxN3CEC6VE9sz7X0WxZaolhiWau4cflKCHa5WXvv6g2I4BI0rAmWeKqwojHrXFog92pChaDvJ98qrIHg47yv2U2a1atrpS33uR/WmjCDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ibltqWQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3889C2BD10;
	Mon, 17 Jun 2024 18:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647389;
	bh=5cs7CkAiw9i/S05z9inglh9xJGoyDo3fuk5O+IN0ay4=;
	h=Subject:To:From:Date:From;
	b=ibltqWQgWw/4XPPLNDQIaHkB9xJUiwwcogX4D0tpCYymrObwF+95xHTvB1y5sZohO
	 6yTuwoKslPq9Rq9BmizVlF2q94N0U2yFuoa6t/ljkMT7Nw9tpM1n8BwvVlFtHiRtv0
	 qbWavYQKSJvWVNiyfgraZbtiCcyIPy1O6whak63Q=
Subject: patch "iio: chemical: bme680: Fix sensor data read operation" added to char-misc-linus
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:02:44 +0200
Message-ID: <2024061743-vision-thigh-d459@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: bme680: Fix sensor data read operation

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 4241665e6ea063a9c1d734de790121a71db763fc Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 6 Jun 2024 23:22:56 +0200
Subject: iio: chemical: bme680: Fix sensor data read operation

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
---
 drivers/iio/chemical/bme680.h      |  2 ++
 drivers/iio/chemical/bme680_core.c | 46 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 4edc5d21cb9f..f959252a4fe6 100644
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
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 5db48f6d646c..500f56834b01 100644
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
@@ -532,6 +533,43 @@ static u8 bme680_oversampling_to_reg(u8 val)
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
@@ -622,6 +660,10 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       &tmp, 3);
 	if (ret < 0) {
@@ -738,6 +780,10 @@ static int bme680_read_gas(struct bme680_data *data,
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
 	if (check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
-- 
2.45.2



