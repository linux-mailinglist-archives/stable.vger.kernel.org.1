Return-Path: <stable+bounces-56496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 539999244A5
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEF3B24F35
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA31BE235;
	Tue,  2 Jul 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bAO21jIP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0615B0FE;
	Tue,  2 Jul 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940377; cv=none; b=I8OkzXInHnSGSU3ATQnFjsWJhZ2UBLEpa2HIpJULXhGCy6LDn0wXmprrAphJvawkccGg0xmSVICF1/UXkhQ6op+A81L7rF4XBFcsQ1Zumm0+i560XJSE3TOSISqUqpp3zFZUzM+Me8OlvswpA9CNdXb3mx5Qije2TVoiDPNDMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940377; c=relaxed/simple;
	bh=VqPtxNumxBfLqOy2/3IWkVNn4i48eTl53r5xKkHhaSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIW/Z1h4g9bO7g/ZEcBhjsxKGJ1FQVwJ3NzDsIU9zNxCc5tVcSrNX9c1Jg9KYYU4n/GVM419CQkzdxoxN0QPv7ZEyWW60ZmBIg08s5KQDuLilcHT8VtWLHbcbj6iOYWk3XD1n8a6HCw4BAN5+v7LwFn5ercFxzfz20qq07nb4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bAO21jIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B2FC4AF07;
	Tue,  2 Jul 2024 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940377;
	bh=VqPtxNumxBfLqOy2/3IWkVNn4i48eTl53r5xKkHhaSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAO21jIPAWP7yf2rdMJcFDPqyBDRK9CwARyFF/83rMtmST6JxFD3zp5+m2f8Q0AnM
	 tffAgPedfIsmdSJb9vaxC9LLGkG1fxZb1MzCign7LQdO2nzaS/Ns1aBI5Llxypl8FT
	 mj/shU5xv9RPAnZGNHm8BNvQDQWo5xNMQnrMgdpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.9 136/222] iio: humidity: hdc3020: fix hysteresis representation
Date: Tue,  2 Jul 2024 19:02:54 +0200
Message-ID: <20240702170249.169858814@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dimitri Fedrau <dima.fedrau@gmail.com>

commit 9547d6a4c65e975e40e203900322342ef7379c52 upstream.

According to the ABI docs hysteresis values are represented as offsets to
threshold values. Current implementation represents hysteresis values as
absolute values which is wrong. Nevertheless the device stores them as
absolute values and the datasheet refers to them as clear thresholds. Fix
the reading and writing of hysteresis values by including thresholds into
calculations. Hysteresis values that result in threshold clear values
that are out of limits will be truncated.

To check that the threshold clear values are correct, registers are read
out using i2ctransfer and the corresponding temperature and relative
humidity thresholds are calculated using the formulas in the datasheet.

Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://lore.kernel.org/r/20240605192136.38146-1-dima.fedrau@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/humidity/hdc3020.c |  325 +++++++++++++++++++++++++++++++----------
 1 file changed, 249 insertions(+), 76 deletions(-)

--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/units.h>
@@ -63,8 +64,10 @@
 
 #define HDC3020_CRC8_POLYNOMIAL		0x31
 
-#define HDC3020_MIN_TEMP		-40
-#define HDC3020_MAX_TEMP		125
+#define HDC3020_MIN_TEMP_MICRO		-39872968
+#define HDC3020_MAX_TEMP_MICRO		124875639
+#define HDC3020_MAX_TEMP_HYST_MICRO	164748607
+#define HDC3020_MAX_HUM_MICRO		99220264
 
 struct hdc3020_data {
 	struct i2c_client *client;
@@ -363,6 +366,105 @@ static int hdc3020_write_raw(struct iio_
 	return -EINVAL;
 }
 
+static int hdc3020_thresh_get_temp(u16 thresh)
+{
+	int temp;
+
+	/*
+	 * Get the temperature threshold from 9 LSBs, shift them to get
+	 * the truncated temperature threshold representation and
+	 * calculate the threshold according to the formula in the
+	 * datasheet. Result is degree celsius scaled by 65535.
+	 */
+	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
+	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
+
+	return -2949075 + (175 * temp);
+}
+
+static int hdc3020_thresh_get_hum(u16 thresh)
+{
+	int hum;
+
+	/*
+	 * Get the humidity threshold from 7 MSBs, shift them to get the
+	 * truncated humidity threshold representation and calculate the
+	 * threshold according to the formula in the datasheet. Result is
+	 * percent scaled by 65535.
+	 */
+	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
+	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
+
+	return hum * 100;
+}
+
+static u16 hdc3020_thresh_set_temp(int s_temp, u16 curr_thresh)
+{
+	u64 temp;
+	u16 thresh;
+
+	/*
+	 * Calculate temperature threshold, shift it down to get the
+	 * truncated threshold representation in the 9LSBs while keeping
+	 * the current humidity threshold in the 7 MSBs.
+	 */
+	temp = (u64)(s_temp + 45000000) * 65535ULL;
+	temp = div_u64(temp, 1000000 * 175) >> HDC3020_THRESH_TEMP_TRUNC_SHIFT;
+	thresh = FIELD_PREP(HDC3020_THRESH_TEMP_MASK, temp);
+	thresh |= (FIELD_GET(HDC3020_THRESH_HUM_MASK, curr_thresh) <<
+		  HDC3020_THRESH_HUM_TRUNC_SHIFT);
+
+	return thresh;
+}
+
+static u16 hdc3020_thresh_set_hum(int s_hum, u16 curr_thresh)
+{
+	u64 hum;
+	u16 thresh;
+
+	/*
+	 * Calculate humidity threshold, shift it down and up to get the
+	 * truncated threshold representation in the 7MSBs while keeping
+	 * the current temperature threshold in the 9 LSBs.
+	 */
+	hum = (u64)(s_hum) * 65535ULL;
+	hum = div_u64(hum, 1000000 * 100) >> HDC3020_THRESH_HUM_TRUNC_SHIFT;
+	thresh = FIELD_PREP(HDC3020_THRESH_HUM_MASK, hum);
+	thresh |= FIELD_GET(HDC3020_THRESH_TEMP_MASK, curr_thresh);
+
+	return thresh;
+}
+
+static
+int hdc3020_thresh_clr(s64 s_thresh, s64 s_hyst, enum iio_event_direction dir)
+{
+	s64 s_clr;
+
+	/*
+	 * Include directions when calculation the clear value,
+	 * since hysteresis is unsigned by definition and the
+	 * clear value is an absolute value which is signed.
+	 */
+	if (dir == IIO_EV_DIR_RISING)
+		s_clr = s_thresh - s_hyst;
+	else
+		s_clr = s_thresh + s_hyst;
+
+	/* Divide by 65535 to get units of micro */
+	return div_s64(s_clr, 65535);
+}
+
+static int _hdc3020_write_thresh(struct hdc3020_data *data, u16 reg, u16 val)
+{
+	u8 buf[5];
+
+	put_unaligned_be16(reg, buf);
+	put_unaligned_be16(val, buf + 2);
+	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
+
+	return hdc3020_write_bytes(data, buf, 5);
+}
+
 static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
@@ -371,67 +473,126 @@ static int hdc3020_write_thresh(struct i
 				int val, int val2)
 {
 	struct hdc3020_data *data = iio_priv(indio_dev);
-	u8 buf[5];
-	u64 tmp;
-	u16 reg;
-	int ret;
-
-	/* Supported temperature range is from –40 to 125 degree celsius */
-	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
-		return -EINVAL;
-
-	/* Select threshold register */
-	if (info == IIO_EV_INFO_VALUE) {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_S_T_RH_THRESH_HIGH;
-		else
-			reg = HDC3020_S_T_RH_THRESH_LOW;
+	u16 reg, reg_val, reg_thresh_rd, reg_clr_rd, reg_thresh_wr, reg_clr_wr;
+	s64 s_thresh, s_hyst, s_clr;
+	int s_val, thresh, clr, ret;
+
+	/* Select threshold registers */
+	if (dir == IIO_EV_DIR_RISING) {
+		reg_thresh_rd = HDC3020_R_T_RH_THRESH_HIGH;
+		reg_thresh_wr = HDC3020_S_T_RH_THRESH_HIGH;
+		reg_clr_rd = HDC3020_R_T_RH_THRESH_HIGH_CLR;
+		reg_clr_wr = HDC3020_S_T_RH_THRESH_HIGH_CLR;
 	} else {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_S_T_RH_THRESH_HIGH_CLR;
-		else
-			reg = HDC3020_S_T_RH_THRESH_LOW_CLR;
+		reg_thresh_rd = HDC3020_R_T_RH_THRESH_LOW;
+		reg_thresh_wr = HDC3020_S_T_RH_THRESH_LOW;
+		reg_clr_rd = HDC3020_R_T_RH_THRESH_LOW_CLR;
+		reg_clr_wr = HDC3020_S_T_RH_THRESH_LOW_CLR;
 	}
 
 	guard(mutex)(&data->lock);
-	ret = hdc3020_read_be16(data, reg);
+	ret = hdc3020_read_be16(data, reg_thresh_rd);
 	if (ret < 0)
 		return ret;
 
+	thresh = ret;
+	ret = hdc3020_read_be16(data, reg_clr_rd);
+	if (ret < 0)
+		return ret;
+
+	clr = ret;
+	/* Scale value to include decimal part into calculations */
+	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
 	switch (chan->type) {
 	case IIO_TEMP:
-		/*
-		 * Calculate temperature threshold, shift it down to get the
-		 * truncated threshold representation in the 9LSBs while keeping
-		 * the current humidity threshold in the 7 MSBs.
-		 */
-		tmp = ((u64)(((val + 45) * MICRO) + val2)) * 65535ULL;
-		tmp = div_u64(tmp, MICRO * 175);
-		val = tmp >> HDC3020_THRESH_TEMP_TRUNC_SHIFT;
-		val = FIELD_PREP(HDC3020_THRESH_TEMP_MASK, val);
-		val |= (FIELD_GET(HDC3020_THRESH_HUM_MASK, ret) <<
-			HDC3020_THRESH_HUM_TRUNC_SHIFT);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			s_val = max(s_val, HDC3020_MIN_TEMP_MICRO);
+			s_val = min(s_val, HDC3020_MAX_TEMP_MICRO);
+			reg = reg_thresh_wr;
+			reg_val = hdc3020_thresh_set_temp(s_val, thresh);
+			ret = _hdc3020_write_thresh(data, reg, reg_val);
+			if (ret < 0)
+				return ret;
+
+			/* Calculate old hysteresis */
+			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
+			s_clr = (s64)hdc3020_thresh_get_temp(clr) * 1000000;
+			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			/* Set new threshold */
+			thresh = reg_val;
+			/* Set old hysteresis */
+			s_val = s_hyst;
+			fallthrough;
+		case IIO_EV_INFO_HYSTERESIS:
+			/*
+			 * Function hdc3020_thresh_get_temp returns temperature
+			 * in degree celsius scaled by 65535. Scale by 1000000
+			 * to be able to subtract scaled hysteresis value.
+			 */
+			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
+			/*
+			 * Units of s_val are in micro degree celsius, scale by
+			 * 65535 to get same units as s_thresh.
+			 */
+			s_val = min(abs(s_val), HDC3020_MAX_TEMP_HYST_MICRO);
+			s_hyst = (s64)s_val * 65535;
+			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
+			s_clr = max(s_clr, HDC3020_MIN_TEMP_MICRO);
+			s_clr = min(s_clr, HDC3020_MAX_TEMP_MICRO);
+			reg = reg_clr_wr;
+			reg_val = hdc3020_thresh_set_temp(s_clr, clr);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		break;
 	case IIO_HUMIDITYRELATIVE:
-		/*
-		 * Calculate humidity threshold, shift it down and up to get the
-		 * truncated threshold representation in the 7MSBs while keeping
-		 * the current temperature threshold in the 9 LSBs.
-		 */
-		tmp = ((u64)((val * MICRO) + val2)) * 65535ULL;
-		tmp = div_u64(tmp, MICRO * 100);
-		val = tmp >> HDC3020_THRESH_HUM_TRUNC_SHIFT;
-		val = FIELD_PREP(HDC3020_THRESH_HUM_MASK, val);
-		val |= FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
+		s_val = (s_val < 0) ? 0 : min(s_val, HDC3020_MAX_HUM_MICRO);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			reg = reg_thresh_wr;
+			reg_val = hdc3020_thresh_set_hum(s_val, thresh);
+			ret = _hdc3020_write_thresh(data, reg, reg_val);
+			if (ret < 0)
+				return ret;
+
+			/* Calculate old hysteresis */
+			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
+			s_clr = (s64)hdc3020_thresh_get_hum(clr) * 1000000;
+			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			/* Set new threshold */
+			thresh = reg_val;
+			/* Try to set old hysteresis */
+			s_val = min(abs(s_hyst), HDC3020_MAX_HUM_MICRO);
+			fallthrough;
+		case IIO_EV_INFO_HYSTERESIS:
+			/*
+			 * Function hdc3020_thresh_get_hum returns relative
+			 * humidity in percent scaled by 65535. Scale by 1000000
+			 * to be able to subtract scaled hysteresis value.
+			 */
+			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
+			/*
+			 * Units of s_val are in micro percent, scale by 65535
+			 * to get same units as s_thresh.
+			 */
+			s_hyst = (s64)s_val * 65535;
+			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
+			s_clr = max(s_clr, 0);
+			s_clr = min(s_clr, HDC3020_MAX_HUM_MICRO);
+			reg = reg_clr_wr;
+			reg_val = hdc3020_thresh_set_hum(s_clr, clr);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
-	put_unaligned_be16(reg, buf);
-	put_unaligned_be16(val, buf + 2);
-	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
-	return hdc3020_write_bytes(data, buf, 5);
+	return _hdc3020_write_thresh(data, reg, reg_val);
 }
 
 static int hdc3020_read_thresh(struct iio_dev *indio_dev,
@@ -442,48 +603,60 @@ static int hdc3020_read_thresh(struct ii
 			       int *val, int *val2)
 {
 	struct hdc3020_data *data = iio_priv(indio_dev);
-	u16 reg;
-	int ret;
+	u16 reg_thresh, reg_clr;
+	int thresh, clr, ret;
 
-	/* Select threshold register */
-	if (info == IIO_EV_INFO_VALUE) {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_R_T_RH_THRESH_HIGH;
-		else
-			reg = HDC3020_R_T_RH_THRESH_LOW;
+	/* Select threshold registers */
+	if (dir == IIO_EV_DIR_RISING) {
+		reg_thresh = HDC3020_R_T_RH_THRESH_HIGH;
+		reg_clr = HDC3020_R_T_RH_THRESH_HIGH_CLR;
 	} else {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_R_T_RH_THRESH_HIGH_CLR;
-		else
-			reg = HDC3020_R_T_RH_THRESH_LOW_CLR;
+		reg_thresh = HDC3020_R_T_RH_THRESH_LOW;
+		reg_clr = HDC3020_R_T_RH_THRESH_LOW_CLR;
 	}
 
 	guard(mutex)(&data->lock);
-	ret = hdc3020_read_be16(data, reg);
+	ret = hdc3020_read_be16(data, reg_thresh);
 	if (ret < 0)
 		return ret;
 
 	switch (chan->type) {
 	case IIO_TEMP:
-		/*
-		 * Get the temperature threshold from 9 LSBs, shift them to get
-		 * the truncated temperature threshold representation and
-		 * calculate the threshold according to the formula in the
-		 * datasheet.
-		 */
-		*val = FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
-		*val = *val << HDC3020_THRESH_TEMP_TRUNC_SHIFT;
-		*val = -2949075 + (175 * (*val));
+		thresh = hdc3020_thresh_get_temp(ret);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			*val = thresh;
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = hdc3020_read_be16(data, reg_clr);
+			if (ret < 0)
+				return ret;
+
+			clr = hdc3020_thresh_get_temp(ret);
+			*val = abs(thresh - clr);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		*val2 = 65535;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_HUMIDITYRELATIVE:
-		/*
-		 * Get the humidity threshold from 7 MSBs, shift them to get the
-		 * truncated humidity threshold representation and calculate the
-		 * threshold according to the formula in the datasheet.
-		 */
-		*val = FIELD_GET(HDC3020_THRESH_HUM_MASK, ret);
-		*val = (*val << HDC3020_THRESH_HUM_TRUNC_SHIFT) * 100;
+		thresh = hdc3020_thresh_get_hum(ret);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			*val = thresh;
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = hdc3020_read_be16(data, reg_clr);
+			if (ret < 0)
+				return ret;
+
+			clr = hdc3020_thresh_get_hum(ret);
+			*val = abs(thresh - clr);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		*val2 = 65535;
 		return IIO_VAL_FRACTIONAL;
 	default:



