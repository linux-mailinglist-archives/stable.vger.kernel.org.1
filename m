Return-Path: <stable+bounces-16683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832EC840DFC
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D701C236B1
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E3D15B0FB;
	Mon, 29 Jan 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CYT5iA8e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8715705A;
	Mon, 29 Jan 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548201; cv=none; b=l0ObM/Bulal3JFIyz9K0zOnslMp2grNDlGjvJs2bOoLESR27lpOqHHfF+DPNBK7ns2M9SJ2ENqKhjCbQ5/5JjrytTzC6J6ORui42Qxqv0qJ1gzOeP4r1R9lEjlNLGBRBmpDr9O/db0yl7A8kWr4uHOKr+5MBbFHisiZLrB1AziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548201; c=relaxed/simple;
	bh=4VlSiOWzbWXT3z3MIXmU1evnRA2D655gzef95jl8bjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7vv2lLvT0Vd3s65e4OOyi5siLpAuwZaAmV8pHbqf+v+cZSaWw3A8WmuHmpkpke1Mn7G7Ytt6CW1C+KKNJMBAiQ1Xukv3M/NgCET84RVc90RubS1QUJZyho6zqEiaB+C8z4jWioix8Ya/yjfhuOh2jlRf3DWTxmCVMThQnDS/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CYT5iA8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ADEC43390;
	Mon, 29 Jan 2024 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548201;
	bh=4VlSiOWzbWXT3z3MIXmU1evnRA2D655gzef95jl8bjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYT5iA8ebsmJzQFnhpZoGhwJCpC3r4GuG/8WblRpk+DIvKt0hc1b+x5ZnnXthKs8g
	 7HL3wH+mne57KN9exwpQBw8hMtZimiaLWliCPqrr2WVYUsYzUIXMledRwO//CX4ltP
	 LFrmV4VqitYca1/Ouso/5qZ4FA4qDKdtmAFwfNaI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/185] iio: adc: ad7091r: Allow users to configure device events
Date: Mon, 29 Jan 2024 09:03:26 -0800
Message-ID: <20240129165958.801525777@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

[ Upstream commit 020e71c7ffc25dfe29ed9be6c2d39af7bd7f661f ]

AD7091R-5 devices are supported by the ad7091r-5 driver together with
the ad7091r-base driver. Those drivers declared iio events for notifying
user space when ADC readings fall bellow the thresholds of low limit
registers or above the values set in high limit registers.
However, to configure iio events and their thresholds, a set of callback
functions must be implemented and those were not present until now.
The consequence of trying to configure ad7091r-5 events without the
proper callback functions was a null pointer dereference in the kernel
because the pointers to the callback functions were not set.

Implement event configuration callbacks allowing users to read/write
event thresholds and enable/disable event generation.

Since the event spec structs are generic to AD7091R devices, also move
those from the ad7091r-5 driver the base driver so they can be reused
when support for ad7091r-2/-4/-8 be added.

Fixes: ca69300173b6 ("iio: adc: Add support for AD7091R5 ADC")
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Link: https://lore.kernel.org/r/59552d3548dabd56adc3107b7b4869afee2b0c3c.1703013352.git.marcelo.schmitt1@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7091r-base.c | 156 +++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |   6 ++
 drivers/iio/adc/ad7091r5.c     |  28 +-----
 3 files changed, 166 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 8aaa854f816f..3d36bcd26b0c 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -50,6 +51,27 @@ struct ad7091r_state {
 	struct mutex lock; /*lock to prevent concurent reads */
 };
 
+const struct iio_event_spec ad7091r_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+EXPORT_SYMBOL_NS_GPL(ad7091r_events, IIO_AD7091R);
+
 static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
 {
 	int ret, conf;
@@ -169,8 +191,142 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
 	return ret;
 }
 
+static int ad7091r_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+				  &val);
+		if (ret)
+			return ret;
+		return val != AD7091R_HIGH_LIMIT;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+				  &val);
+		if (ret)
+			return ret;
+		return val != AD7091R_LOW_LIMIT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7091r_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, int state)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+
+	if (state) {
+		return regmap_set_bits(st->map, AD7091R_REG_CONF,
+				       AD7091R_REG_CONF_ALERT_EN);
+	} else {
+		/*
+		 * Set thresholds either to 0 or to 2^12 - 1 as appropriate to
+		 * prevent alerts and thus disable event generation.
+		 */
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					    AD7091R_HIGH_LIMIT);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					    AD7091R_LOW_LIMIT);
+		default:
+			return -EINVAL;
+		}
+	}
+}
+
+static int ad7091r_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int *val, int *val2)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_read(st->map,
+					  AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					  val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(st->map,
+					  AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					  val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_HYSTERESIS(chan->channel),
+				  val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7091r_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info, int val, int val2)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					    val);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					    val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_HYSTERESIS:
+		return regmap_write(st->map,
+				    AD7091R_REG_CH_HYSTERESIS(chan->channel),
+				    val);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ad7091r_info = {
 	.read_raw = ad7091r_read_raw,
+	.read_event_config = &ad7091r_read_event_config,
+	.write_event_config = &ad7091r_write_event_config,
+	.read_event_value = &ad7091r_read_event_value,
+	.write_event_value = &ad7091r_write_event_value,
 };
 
 static irqreturn_t ad7091r_event_handler(int irq, void *private)
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 509748aef9b1..7a78976a2f80 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -8,6 +8,10 @@
 #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 
+/* AD7091R_REG_CH_LIMIT */
+#define AD7091R_HIGH_LIMIT		0xFFF
+#define AD7091R_LOW_LIMIT		0x0
+
 struct device;
 struct ad7091r_state;
 
@@ -17,6 +21,8 @@ struct ad7091r_chip_info {
 	unsigned int vref_mV;
 };
 
+extern const struct iio_event_spec ad7091r_events[3];
+
 extern const struct regmap_config ad7091r_regmap_config;
 
 int ad7091r_probe(struct device *dev, const char *name,
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 47f5763023a4..12d475463945 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -12,26 +12,6 @@
 
 #include "ad7091r-base.h"
 
-static const struct iio_event_spec ad7091r5_events[] = {
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
-	},
-};
-
 #define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
 	.type = IIO_VOLTAGE, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
@@ -44,10 +24,10 @@ static const struct iio_event_spec ad7091r5_events[] = {
 	.scan_type.realbits = bits, \
 }
 static const struct iio_chan_spec ad7091r5_channels_irq[] = {
-	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(1, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(2, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(3, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(2, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(3, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
 };
 
 static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
-- 
2.43.0




