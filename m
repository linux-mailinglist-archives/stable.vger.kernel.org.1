Return-Path: <stable+bounces-12801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F528373ED
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9216F28CF36
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6744779D;
	Mon, 22 Jan 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/Bix+yY"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8740BEE
	for <Stable@vger.kernel.org>; Mon, 22 Jan 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955894; cv=none; b=Mf03Zz1YgcXfn3vU2UEMGYQ+U+GEeycxmnDnrYFZzoJiXb4LzIzREsH2ViHtBKRE0nkZlit0P9Eqnb4XuorLEAAUcRWzBsYC/O3iEDZMyQ76EW43ovU8hymuTmRoRa5OE52vERcCzhnjS5v23PCRB4za3Q9nhc7Foo63ZlwfWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955894; c=relaxed/simple;
	bh=p3ct9ICZ7vvJt2BJ5vea7wlKDBdPVzNEMuV7Od1f8zc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n8uuwwKqUwM9EjBo0axSb6PBFfTZEuE2RFqGmwG9VR6CnokXpr+RJoicWsBqWYND+/btHGXLHh9z7UopEKfDr70Irc/PWJANeXpicUFpPY46LF4ft8grGcmQ3QXt+vy4ls7y65UkAIQsgDnm66W1gTQsdNxJ5s9iuEJ0D+IBX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/Bix+yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35D5C43390;
	Mon, 22 Jan 2024 20:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705955893;
	bh=p3ct9ICZ7vvJt2BJ5vea7wlKDBdPVzNEMuV7Od1f8zc=;
	h=Subject:To:Cc:From:Date:From;
	b=U/Bix+yYMu1CCnXUecFfi49Arorto/02xWVRkMrGBVDYUG92wVaq3ut7WUo5H3Cf0
	 S1JxR0fyipp7OmgEZ3rLdGJgIgbNEfKsmDq4szpW17qMCb0iKTQcwrgFlrURnGkFVt
	 ZnXN1N+IFfEDiuh024oRwpXNyFhS6Q7VV4dg/H34=
Subject: FAILED: patch "[PATCH] iio: adc: ad7091r: Allow users to configure device events" failed to apply to 6.1-stable tree
To: marcelo.schmitt@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:38:12 -0800
Message-ID: <2024012212-playback-mortality-30d2@gregkh>
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
git cherry-pick -x 020e71c7ffc25dfe29ed9be6c2d39af7bd7f661f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012212-playback-mortality-30d2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

020e71c7ffc2 ("iio: adc: ad7091r: Allow users to configure device events")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 020e71c7ffc25dfe29ed9be6c2d39af7bd7f661f Mon Sep 17 00:00:00 2001
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
Date: Tue, 19 Dec 2023 17:26:01 -0300
Subject: [PATCH] iio: adc: ad7091r: Allow users to configure device events

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

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index d3d287d3b953..6d93da154810 100644
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
index 2f048527b7b7..dae98c95ebb8 100644
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


