Return-Path: <stable+bounces-129603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74289A800A2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF679446573
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F1926869D;
	Tue,  8 Apr 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FMfYthIK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854B266EFE;
	Tue,  8 Apr 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111483; cv=none; b=qtb61ysuVmHVC6aIQ0H4ZRH9B5t+qFlJPfEQAWAgj+g5JIrOF04oQNBfKbrrq8c/k7Eyr4u6fP9zSw+jbpHXjhDJ+3oGUROyTxtxgZChPJ8cqjUyaw7mYh4lj0avhQdwVshL0Pa1JGKFRr1Ko/BtMUjtHw50t7fLvDXpNQ42eYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111483; c=relaxed/simple;
	bh=j5JnFdkUtQtpmb03kXEsI5qC01ZLvbESbuXfJz6XJ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQt+zc5HZh5RDlLhuO4WPgE8PQqblI3NqAzn/kTwDHnbDBS2TnIBzMMtm0roPPecyb4W7tYHjdYYSkMKgNnAKlJPWjgQ7XemBBRhl5MXlpdU+RYLpcntiVi5XFWjZP1sSBkq3zMCTcVVrAVhlWuhYMog2XzRhfesjdm2UgU6B88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FMfYthIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8589AC4CEE5;
	Tue,  8 Apr 2025 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111482;
	bh=j5JnFdkUtQtpmb03kXEsI5qC01ZLvbESbuXfJz6XJ7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMfYthIKwGzMMd5kz0M7RWlQPEzcfFz/KvAR1lPdYQpmE6PooyxmdpSZL2ukVMEll
	 nl0DyWQ9e6lbui/yUXIX0+sAn6EkyoBuSoHpMVLpNkL/0Bh2ymRNQJCHOsHxpnFFgz
	 dDKx1uQxh2lH3G9rRIS0ygOpQcF79caG/tz6n4BQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 447/731] iio: light: veml6030: extend regmap to support regfields
Date: Tue,  8 Apr 2025 12:45:44 +0200
Message-ID: <20250408104924.673749666@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 9c7eb1ab2eec47ad9eaf6e11ce14d3d6fd54e677 ]

Add support for regfields as well to simplify register operations,
taking into account the different fields for the veml6030/veml7700 and
veml6035.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20250119-veml6030-scale-v2-1-6bfc4062a371@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 22eaca4283b2 ("iio: light: veml6030: fix scale to conform to ABI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/veml6030.c | 95 ++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 9b71825eea9be..8e4eb8b0c1927 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -59,18 +59,31 @@
 #define VEML6035_INT_CHAN     BIT(3)
 #define VEML6035_CHAN_EN      BIT(2)
 
+/* Regfields */
+#define VEML6030_GAIN_RF      REG_FIELD(VEML6030_REG_ALS_CONF, 11, 12)
+#define VEML6030_IT_RF        REG_FIELD(VEML6030_REG_ALS_CONF, 6, 9)
+
+#define VEML6035_GAIN_RF      REG_FIELD(VEML6030_REG_ALS_CONF, 10, 12)
+
 enum veml6030_scan {
 	VEML6030_SCAN_ALS,
 	VEML6030_SCAN_WH,
 	VEML6030_SCAN_TIMESTAMP,
 };
 
+struct veml6030_rf {
+	struct regmap_field *it;
+	struct regmap_field *gain;
+};
+
 struct veml603x_chip {
 	const char *name;
 	const int(*scale_vals)[][2];
 	const int num_scale_vals;
 	const struct iio_chan_spec *channels;
 	const int num_channels;
+	const struct reg_field gain_rf;
+	const struct reg_field it_rf;
 	int (*hw_init)(struct iio_dev *indio_dev, struct device *dev);
 	int (*set_info)(struct iio_dev *indio_dev);
 	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
@@ -91,6 +104,7 @@ struct veml603x_chip {
 struct veml6030_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
+	struct veml6030_rf rf;
 	int cur_resolution;
 	int cur_gain;
 	int cur_integration_time;
@@ -330,17 +344,17 @@ static const struct regmap_config veml6030_regmap_config = {
 static int veml6030_get_intgrn_tm(struct iio_dev *indio_dev,
 						int *val, int *val2)
 {
-	int ret, reg;
+	int it_idx, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.it, &it_idx);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch ((reg >> 6) & 0xF) {
+	switch (it_idx) {
 	case 0:
 		*val2 = 100000;
 		break;
@@ -405,8 +419,7 @@ static int veml6030_set_intgrn_tm(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-					VEML6030_ALS_IT, new_int_time);
+	ret = regmap_field_write(data->rf.it, new_int_time);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't update als integration time %d\n", ret);
@@ -510,23 +523,22 @@ static int veml6030_set_als_gain(struct iio_dev *indio_dev,
 	struct veml6030_data *data = iio_priv(indio_dev);
 
 	if (val == 0 && val2 == 125000) {
-		new_gain = 0x1000; /* 0x02 << 11 */
+		new_gain = 0x01;
 		gain_idx = 3;
 	} else if (val == 0 && val2 == 250000) {
-		new_gain = 0x1800;
+		new_gain = 0x11;
 		gain_idx = 2;
 	} else if (val == 1 && val2 == 0) {
 		new_gain = 0x00;
 		gain_idx = 1;
 	} else if (val == 2 && val2 == 0) {
-		new_gain = 0x800;
+		new_gain = 0x01;
 		gain_idx = 0;
 	} else {
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-					VEML6030_ALS_GAIN, new_gain);
+	ret = regmap_field_write(data->rf.gain, new_gain);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't set als gain %d\n", ret);
@@ -544,30 +556,31 @@ static int veml6035_set_als_gain(struct iio_dev *indio_dev, int val, int val2)
 	struct veml6030_data *data = iio_priv(indio_dev);
 
 	if (val == 0 && val2 == 125000) {
-		new_gain = VEML6035_SENS;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS);
 		gain_idx = 5;
 	} else if (val == 0 && val2 == 250000) {
-		new_gain = VEML6035_SENS | VEML6035_GAIN;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS |
+				      VEML6035_GAIN);
 		gain_idx = 4;
 	} else if (val == 0 && val2 == 500000) {
-		new_gain = VEML6035_SENS | VEML6035_GAIN |
-			VEML6035_DG;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS |
+				      VEML6035_GAIN | VEML6035_DG);
 		gain_idx = 3;
 	} else if (val == 1 && val2 == 0) {
 		new_gain = 0x0000;
 		gain_idx = 2;
 	} else if (val == 2 && val2 == 0) {
-		new_gain = VEML6035_GAIN;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_GAIN);
 		gain_idx = 1;
 	} else if (val == 4 && val2 == 0) {
-		new_gain = VEML6035_GAIN | VEML6035_DG;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_GAIN |
+				      VEML6035_DG);
 		gain_idx = 0;
 	} else {
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-				 VEML6035_GAIN_M, new_gain);
+	ret = regmap_field_write(data->rf.gain, new_gain);
 	if (ret) {
 		dev_err(&data->client->dev, "can't set als gain %d\n", ret);
 		return ret;
@@ -581,17 +594,17 @@ static int veml6035_set_als_gain(struct iio_dev *indio_dev, int val, int val2)
 static int veml6030_get_als_gain(struct iio_dev *indio_dev,
 						int *val, int *val2)
 {
-	int ret, reg;
+	int gain, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.gain, &gain);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch ((reg >> 11) & 0x03) {
+	switch (gain) {
 	case 0:
 		*val = 1;
 		*val2 = 0;
@@ -617,17 +630,17 @@ static int veml6030_get_als_gain(struct iio_dev *indio_dev,
 
 static int veml6035_get_als_gain(struct iio_dev *indio_dev, int *val, int *val2)
 {
-	int ret, reg;
+	int gain, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.gain, &gain);
 	if (ret) {
 		dev_err(&data->client->dev,
-			"can't read als conf register %d\n", ret);
+				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch (FIELD_GET(VEML6035_GAIN_M, reg)) {
+	switch (gain) {
 	case 0:
 		*val = 1;
 		*val2 = 0;
@@ -990,6 +1003,27 @@ static int veml7700_set_info(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int veml6030_regfield_init(struct iio_dev *indio_dev)
+{
+	struct veml6030_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = &data->client->dev;
+	struct regmap_field *rm_field;
+	struct veml6030_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, data->chip->it_rf);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, data->chip->gain_rf);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->gain = rm_field;
+
+	return 0;
+}
+
 /*
  * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
  * persistence to 1 x integration time and the threshold
@@ -1143,6 +1177,11 @@ static int veml6030_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = veml6030_regfield_init(indio_dev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to init regfields\n");
+
 	ret = data->chip->hw_init(indio_dev, &client->dev);
 	if (ret < 0)
 		return ret;
@@ -1191,6 +1230,8 @@ static const struct veml603x_chip veml6030_chip = {
 	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
 	.channels = veml6030_channels,
 	.num_channels = ARRAY_SIZE(veml6030_channels),
+	.gain_rf = VEML6030_GAIN_RF,
+	.it_rf = VEML6030_IT_RF,
 	.hw_init = veml6030_hw_init,
 	.set_info = veml6030_set_info,
 	.set_als_gain = veml6030_set_als_gain,
@@ -1203,6 +1244,8 @@ static const struct veml603x_chip veml6035_chip = {
 	.num_scale_vals = ARRAY_SIZE(veml6035_scale_vals),
 	.channels = veml6030_channels,
 	.num_channels = ARRAY_SIZE(veml6030_channels),
+	.gain_rf = VEML6035_GAIN_RF,
+	.it_rf = VEML6030_IT_RF,
 	.hw_init = veml6035_hw_init,
 	.set_info = veml6030_set_info,
 	.set_als_gain = veml6035_set_als_gain,
@@ -1215,6 +1258,8 @@ static const struct veml603x_chip veml7700_chip = {
 	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
 	.channels = veml7700_channels,
 	.num_channels = ARRAY_SIZE(veml7700_channels),
+	.gain_rf = VEML6030_GAIN_RF,
+	.it_rf = VEML6030_IT_RF,
 	.hw_init = veml6030_hw_init,
 	.set_info = veml7700_set_info,
 	.set_als_gain = veml6030_set_als_gain,
-- 
2.39.5




