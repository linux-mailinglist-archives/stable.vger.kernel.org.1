Return-Path: <stable+bounces-194753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB05C5A534
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471533B1983
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63F2DE714;
	Thu, 13 Nov 2025 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NyJpMz4h"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD22D6E78
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073309; cv=none; b=FReGuPx/k89u2ULcisYETNvI32DcG9NoVahy7irFQRgNKp9OpCafBg45G+YW4b3DgaVurWL574JICI77rOcp80kHYQ52alIC7vjqs5AuDe7YgkPZTGFHm0nTmDZnFHJwDitDGBLG+h/bZosBjbB8L+bjgPx4GXkAhMVePQIDIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073309; c=relaxed/simple;
	bh=RMgvuAb7jeulX46qrNbnuosHx+bLz3NNcxX/8IxIUA8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=dT0+5k1HX9DkzuSCII5bPXz/Ad0l5VTI3KQW9+6Ll9hBf43vEhfngJAbocXprrKVmeUMBinnBK2heKgLM4RpDPSuceHy6x/uuH5wWF9kGtDo52FSYg7Bav0GUwtpvVyIKH2HBBDSdeI2ZeUAptWe8GJQ8wrILOA27X0SxkBWUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NyJpMz4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D93AC4CEF8;
	Thu, 13 Nov 2025 22:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073309;
	bh=RMgvuAb7jeulX46qrNbnuosHx+bLz3NNcxX/8IxIUA8=;
	h=Subject:To:From:Date:From;
	b=NyJpMz4hRxjN17qvcNlYR22edeh7AG7jFguhDZbCYBzPoO3QXLAODgwltClh9PT7s
	 k0mZBqpAskOPG9UUtmarqaStgmuxoV49ozfPqzVekAsGlt/cDupnju4rijjnKn+21a
	 +J5uja5/UM0CI3OTMg6XR+0VbmgfvlUdaHfcBU94=
Subject: patch "iio: humditiy: hdc3020: fix units for thresholds and hysteresis" added to char-misc-linus
To: dimitri.fedrau@liebherr.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,chris.lesiak@licorbio.com,javier.carrasco.cruz@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:54 -0500
Message-ID: <2025111354-platinum-emerald-14bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: humditiy: hdc3020: fix units for thresholds and hysteresis

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From cb372b4f46d4285e5d2c07ba734374151b8e34e7 Mon Sep 17 00:00:00 2001
From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Date: Thu, 16 Oct 2025 07:20:39 +0200
Subject: iio: humditiy: hdc3020: fix units for thresholds and hysteresis

According to the ABI the units after application of scale and offset are
milli degree celsius for temperature thresholds and milli percent for
relative humidity thresholds. Currently the resulting units are degree
celsius for temperature thresholds and hysteresis and percent for relative
humidity thresholds and hysteresis. Change scale factor to fix this issue.

Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/humidity/hdc3020.c | 69 ++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 8aa567d9aded..78b2c171c8da 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -72,6 +72,9 @@
 #define HDC3020_MAX_TEMP_HYST_MICRO	164748607
 #define HDC3020_MAX_HUM_MICRO		99220264
 
+/* Divide 65535 from the datasheet by 5 to avoid overflows */
+#define HDC3020_THRESH_FRACTION		(65535 / 5)
+
 struct hdc3020_data {
 	struct i2c_client *client;
 	struct gpio_desc *reset_gpio;
@@ -376,15 +379,18 @@ static int hdc3020_thresh_get_temp(u16 thresh)
 	int temp;
 
 	/*
-	 * Get the temperature threshold from 9 LSBs, shift them to get
-	 * the truncated temperature threshold representation and
-	 * calculate the threshold according to the formula in the
-	 * datasheet. Result is degree celsius scaled by 65535.
+	 * Get the temperature threshold from 9 LSBs, shift them to get the
+	 * truncated temperature threshold representation and calculate the
+	 * threshold according to the explicit formula in the datasheet:
+	 * T(C) = -45 + (175 * temp) / 65535.
+	 * Additionally scale by HDC3020_THRESH_FRACTION to avoid precision loss
+	 * when calculating threshold and hysteresis values. Result is degree
+	 * celsius scaled by HDC3020_THRESH_FRACTION.
 	 */
 	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
 	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
 
-	return -2949075 + (175 * temp);
+	return -2949075 / 5 + (175 / 5 * temp);
 }
 
 static int hdc3020_thresh_get_hum(u16 thresh)
@@ -394,13 +400,16 @@ static int hdc3020_thresh_get_hum(u16 thresh)
 	/*
 	 * Get the humidity threshold from 7 MSBs, shift them to get the
 	 * truncated humidity threshold representation and calculate the
-	 * threshold according to the formula in the datasheet. Result is
-	 * percent scaled by 65535.
+	 * threshold according to the explicit formula in the datasheet:
+	 * RH(%) = 100 * hum / 65535.
+	 * Additionally scale by HDC3020_THRESH_FRACTION to avoid precision loss
+	 * when calculating threshold and hysteresis values. Result is percent
+	 * scaled by HDC3020_THRESH_FRACTION.
 	 */
 	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
 	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
 
-	return hum * 100;
+	return hum * 100 / 5;
 }
 
 static u16 hdc3020_thresh_set_temp(int s_temp, u16 curr_thresh)
@@ -455,8 +464,8 @@ int hdc3020_thresh_clr(s64 s_thresh, s64 s_hyst, enum iio_event_direction dir)
 	else
 		s_clr = s_thresh + s_hyst;
 
-	/* Divide by 65535 to get units of micro */
-	return div_s64(s_clr, 65535);
+	/* Divide by HDC3020_THRESH_FRACTION to get units of micro */
+	return div_s64(s_clr, HDC3020_THRESH_FRACTION);
 }
 
 static int _hdc3020_write_thresh(struct hdc3020_data *data, u16 reg, u16 val)
@@ -507,7 +516,7 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 
 	clr = ret;
 	/* Scale value to include decimal part into calculations */
-	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
+	s_val = (val < 0) ? (val * 1000 - val2) : (val * 1000 + val2);
 	switch (chan->type) {
 	case IIO_TEMP:
 		switch (info) {
@@ -523,7 +532,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_temp(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr),
+					 HDC3020_THRESH_FRACTION);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Set old hysteresis */
@@ -532,16 +542,17 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_HYSTERESIS:
 			/*
 			 * Function hdc3020_thresh_get_temp returns temperature
-			 * in degree celsius scaled by 65535. Scale by 1000000
-			 * to be able to subtract scaled hysteresis value.
+			 * in degree celsius scaled by HDC3020_THRESH_FRACTION.
+			 * Scale by 1000000 to be able to subtract scaled
+			 * hysteresis value.
 			 */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			/*
 			 * Units of s_val are in micro degree celsius, scale by
-			 * 65535 to get same units as s_thresh.
+			 * HDC3020_THRESH_FRACTION to get same units as s_thresh.
 			 */
 			s_val = min(abs(s_val), HDC3020_MAX_TEMP_HYST_MICRO);
-			s_hyst = (s64)s_val * 65535;
+			s_hyst = (s64)s_val * HDC3020_THRESH_FRACTION;
 			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
 			s_clr = max(s_clr, HDC3020_MIN_TEMP_MICRO);
 			s_clr = min(s_clr, HDC3020_MAX_TEMP_MICRO);
@@ -565,7 +576,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_hum(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr),
+					 HDC3020_THRESH_FRACTION);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Try to set old hysteresis */
@@ -574,15 +586,16 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_HYSTERESIS:
 			/*
 			 * Function hdc3020_thresh_get_hum returns relative
-			 * humidity in percent scaled by 65535. Scale by 1000000
-			 * to be able to subtract scaled hysteresis value.
+			 * humidity in percent scaled by HDC3020_THRESH_FRACTION.
+			 * Scale by 1000000 to be able to subtract scaled
+			 * hysteresis value.
 			 */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			/*
-			 * Units of s_val are in micro percent, scale by 65535
-			 * to get same units as s_thresh.
+			 * Units of s_val are in micro percent, scale by
+			 * HDC3020_THRESH_FRACTION to get same units as s_thresh.
 			 */
-			s_hyst = (s64)s_val * 65535;
+			s_hyst = (s64)s_val * HDC3020_THRESH_FRACTION;
 			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
 			s_clr = max(s_clr, 0);
 			s_clr = min(s_clr, HDC3020_MAX_HUM_MICRO);
@@ -630,7 +643,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 		thresh = hdc3020_thresh_get_temp(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * MILLI;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -638,18 +651,18 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 				return ret;
 
 			clr = hdc3020_thresh_get_temp(ret);
-			*val = abs(thresh - clr);
+			*val = abs(thresh - clr) * MILLI;
 			break;
 		default:
 			return -EOPNOTSUPP;
 		}
-		*val2 = 65535;
+		*val2 = HDC3020_THRESH_FRACTION;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_HUMIDITYRELATIVE:
 		thresh = hdc3020_thresh_get_hum(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * MILLI;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -657,12 +670,12 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 				return ret;
 
 			clr = hdc3020_thresh_get_hum(ret);
-			*val = abs(thresh - clr);
+			*val = abs(thresh - clr) * MILLI;
 			break;
 		default:
 			return -EOPNOTSUPP;
 		}
-		*val2 = 65535;
+		*val2 = HDC3020_THRESH_FRACTION;
 		return IIO_VAL_FRACTIONAL;
 	default:
 		return -EOPNOTSUPP;
-- 
2.51.2



