Return-Path: <stable+bounces-75924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E61E975EBD
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 04:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED752857C1
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21872D7BF;
	Thu, 12 Sep 2024 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eXLg49R0"
X-Original-To: stable@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855986F2E8
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726106796; cv=none; b=XidRoT1aHb1U4Fs1APMGoKd/fNhENBZ6Q1uE8RdiG++akgeXNLsqFqVeq+G/WU4uXnJlTxXowFlszJeeKCTZDBlQoXvWwInlF1qR3Tv7217zHKpaqAw9He0jkMEWpqT6YxgQ35GKGujgtDlirYvrSlN83O95wj1yZ1ABH/be1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726106796; c=relaxed/simple;
	bh=tnvJDL0q5jquNsAoBMps6b1EOUDV4hNFnBkRKte1f4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODT20L6ZxRIZuFcwilg3j9v2Gtpvne86FGFDirnbGWo1ZlPQmA/hzqekuh6WQo0Kfv1pUk7oV6OXrrGYuL8zSnq6DqvSTtKqDbxeG2hVfI5huyKkIoqBEY/aeIuckTliThNewVNMGhMiKzcjWvOSdrJKbYdOMCHD+AK2ftvs01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eXLg49R0; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726106690;
	bh=gYbVFH+rCM+4nC18Y72cVvKjNu9fqOwI4V0+E7IyHCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eXLg49R0/efG4h9qw0mCrLxGcPcaSSaQPs1JgdMB5hKuc8mCkQcmpSw0g785F2nVX
	 NhubZ7CpsnT8KikNewfi6/41ZQt2+58hbD00NbNzdlVoHBXOJZrgpkqtxPHTy1RUIk
	 7aN8Kt8/OvpVF9PH75iGDRnHx38Zyr254J+qPmIc=
X-QQ-mid: bizesmtpsz5t1726106686to6fpag
X-QQ-Originating-IP: n3p6iYATItHQUOqvdOoYzSQw3B/cB25prCwZnW7YRGc=
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:04:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6909598485399783029
From: He Lugang <helugang@uniontech.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	He Lugang <helugang@uniontech.com>
Subject: [PATCH 6.6.y RESEND 1/2] iio: adc: ad7124: Switch from of specific to fwnode based property handling
Date: Thu, 12 Sep 2024 10:04:38 +0800
Message-ID: <4BA7DEEC50CAC7F3+20240912020439.127704-1-helugang@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024090914-province-underdone-1eea@gregkh>
References: <2024090914-province-underdone-1eea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit a6eaf02b82744b424b9b2c74847282deb2c6f77b upstream

Using the generic firmware data access functions from property.h
provides a number of advantages:
 1) Works with different firmware types.
 2) Doesn't provide a 'bad' example for new IIO drivers.
 3) Lets us use the new _scoped() loops with automatic reference count
    cleanup for fwnode_handle

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240218172731.1023367-4-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: He Lugang <helugang@uniontech.com>
---
 drivers/iio/adc/ad7124.c | 55 +++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b9b206fcd748..e7b1d517d3de 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -14,7 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -807,22 +808,19 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
-static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
-					  struct device_node *np)
+static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
+				       struct device *dev)
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
 	struct ad7124_channel_config *cfg;
 	struct ad7124_channel *channels;
-	struct device_node *child;
 	struct iio_chan_spec *chan;
 	unsigned int ain[2], channel = 0, tmp;
 	int ret;
 
-	st->num_channels = of_get_available_child_count(np);
-	if (!st->num_channels) {
-		dev_err(indio_dev->dev.parent, "no channel children\n");
-		return -ENODEV;
-	}
+	st->num_channels = device_get_child_node_count(dev);
+	if (!st->num_channels)
+		return dev_err_probe(dev, -ENODEV, "no channel children\n");
 
 	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
 			    sizeof(*chan), GFP_KERNEL);
@@ -838,39 +836,38 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	indio_dev->num_channels = st->num_channels;
 	st->channels = channels;
 
-	for_each_available_child_of_node(np, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		cfg = &st->channels[channel].cfg;
 
-		ret = of_property_read_u32(child, "reg", &channel);
+		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
-			goto err;
+			return ret;
 
-		if (channel >= indio_dev->num_channels) {
-			dev_err(indio_dev->dev.parent,
+		if (channel >= indio_dev->num_channels)
+			return dev_err_probe(dev, -EINVAL,
 				"Channel index >= number of channels\n");
-			ret = -EINVAL;
-			goto err;
-		}
 
-		ret = of_property_read_u32_array(child, "diff-channels",
-						 ain, 2);
+		ret = fwnode_property_read_u32_array(child, "diff-channels",
+						     ain, 2);
 		if (ret)
-			goto err;
+			return ret;
 
 		st->channels[channel].nr = channel;
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 
-		cfg->bipolar = of_property_read_bool(child, "bipolar");
+		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
 
-		ret = of_property_read_u32(child, "adi,reference-select", &tmp);
+		ret = fwnode_property_read_u32(child, "adi,reference-select", &tmp);
 		if (ret)
 			cfg->refsel = AD7124_INT_REF;
 		else
 			cfg->refsel = tmp;
 
-		cfg->buf_positive = of_property_read_bool(child, "adi,buffered-positive");
-		cfg->buf_negative = of_property_read_bool(child, "adi,buffered-negative");
+		cfg->buf_positive =
+			fwnode_property_read_bool(child, "adi,buffered-positive");
+		cfg->buf_negative =
+			fwnode_property_read_bool(child, "adi,buffered-negative");
 
 		chan[channel] = ad7124_channel_template;
 		chan[channel].address = channel;
@@ -880,10 +877,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	}
 
 	return 0;
-err:
-	of_node_put(child);
-
-	return ret;
 }
 
 static int ad7124_setup(struct ad7124_state *st)
@@ -943,9 +936,7 @@ static int ad7124_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int i, ret;
 
-	info = of_device_get_match_data(&spi->dev);
-	if (!info)
-		info = (void *)spi_get_device_id(spi)->driver_data;
+	info = spi_get_device_match_data(spi);
 	if (!info)
 		return -ENODEV;
 
@@ -965,7 +956,7 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	ret = ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
+	ret = ad7124_parse_channel_config(indio_dev, &spi->dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.45.2


