Return-Path: <stable+bounces-139448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A9AA6AA1
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAEB1BC0A56
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83F81C5F18;
	Fri,  2 May 2025 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LNamY64l"
X-Original-To: stable@vger.kernel.org
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70B1E0E0B;
	Fri,  2 May 2025 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166523; cv=none; b=EC/dVeTF7ffE5I6lllWgy7PyWgZNPqE9Y/hDOIAWs3X6Z37KGWPkQcMr5GZg3LA5dAgfW6j3z1vfQeO7GVkQUybqTkZM8qZgwQp7+YxUaOPc1dphqNk+J0xLb1SFMV/SUHrXIUBsSTQ0q3nwbwvhp5Qp4LkpQa+kde9eCk2S5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166523; c=relaxed/simple;
	bh=JqUrz+yQLsGFTGUjm66eTro/hg/GGoVJESB4pxHqkbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XoAxmRWyzX8ONkB1UrydJWo+cLeH1djKTS74rY+C+RNyf4dnr1qW8KiRSbSk8Nlu+APAEh20mg4INmDtNNmURhuUSZ5GC1ic7pWmaTYuEpfpqDsag23MwoFY76FWE9djCpO+AsMKVkgPr51B4vmKgi2zGMmD3Ie0FqMctYyZd8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LNamY64l; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746166516; x=1746425716;
	bh=g4Z460222XadO53LFXDxzVnUu8E6PN96LYtxDru3wHk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=LNamY64lhmNPmmXuXDEMPugkCIGHSYFs4lQdtBdmHxkdfNiYhbl3lF3JO9QDNnD9B
	 WRoZFl3FzNBPGQolZKaNqVZrcose1g1iVfz2knChw48NJ4njyOk44Hg0klfPZbSzGe
	 zhgiI7h5JluNeXiYhkzvCckWuMm5mE4/XkVkN9nsEhYhSiQE5q9ZwLMsOIwiSc54ec
	 5k/9W3HDCYB9bwBksfFJLE0SZl/wFXm0oYEpgguOU1h19jAytrce2MG2nANKs31+hH
	 iIXvjU4fDxOIjXQD4xqA7ZbidIwFKDAhTvdF7iw5LfC0zggumTK89ysxcSGKhebxJZ
	 I2tWoOIWC7KUw==
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 02 May 2025 08:15:06 +0200
Subject: [PATCH v2 1/2] iio: accel: fxls8962af: Fix temperature calculation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-fxls-v2-1-e1af65f1aa6c@geanix.com>
References: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
In-Reply-To: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

According to spec temperature should be returned in milli degrees Celsius.
Add in_temp_scale to calculate from Celsius to milli Celsius.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index bf1d3923a181798a1c884ee08b62d86ab5aed26f..f515222e008493687921879a0b0ef44fd4ae5d10 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -134,6 +134,8 @@
 
 /* Raw temp channel offset */
 #define FXLS8962AF_TEMP_CENTER_VAL		25
+/* Raw temp channel scale */
+#define FXLS8962AF_TEMP_SCALE			1000
 
 #define FXLS8962AF_AUTO_SUSPEND_DELAY_MS	2000
 
@@ -439,8 +441,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 		*val = FXLS8962AF_TEMP_CENTER_VAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		return fxls8962af_read_full_scale(data, val2);
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = FXLS8962AF_TEMP_SCALE;
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			*val = 0;
+			return fxls8962af_read_full_scale(data, val2);
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return fxls8962af_read_samp_freq(data, val, val2);
 	default:
@@ -736,6 +746,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \

-- 
2.47.1


