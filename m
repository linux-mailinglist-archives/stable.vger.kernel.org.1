Return-Path: <stable+bounces-122214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF84A59E67
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C08188F678
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480423372C;
	Mon, 10 Mar 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLo/bWzv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B823026D;
	Mon, 10 Mar 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627853; cv=none; b=ojSMtiNEwEjlP6FOvzzwKWV6kXDvOawWIp6vCi4xtBlnsJVxyvHIc+0oBGKx0uYIkuKWFcEdg7wPbYtyjj1+nfPDeTbt3WqO4rqtZEs0gEJ5VeYytPbTaBMYF73Yh1kX4bCmDgfAy3MyWkcWx5zw2AwnWYqv4hVAlqA+rTwXQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627853; c=relaxed/simple;
	bh=OKoICI5tNCqMxlE2eUckimKWoin0V7p+S6rICbSypuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPgg8CJAIvJdTo8XPswpa68iRT1p3lhFgWY9XVpH80OeMOtDhObPzfepwX73xDGHLqu8UU/8OlwqrEcSwZDYOs0nXorex6CV8dCJOIuH7HDNRRH7wg7o3oWEm4Q+Ops4pkgAaI0s3njnT8XvDoNp7WvZn4c/chavpxdmZQSGrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLo/bWzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD0FC4CEE5;
	Mon, 10 Mar 2025 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627853;
	bh=OKoICI5tNCqMxlE2eUckimKWoin0V7p+S6rICbSypuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLo/bWzvbcJpBYG9V/ab43LBGGKzOeYN5QentAT3qORfnBu+1MAGUcH7i116w6Pj8
	 Di4ud6yLepPr2IEG2kiLufOCz7rApmBcMcYI2Mr2+y683a+DB2wTNw5ftmo78nUJct
	 o2sOJR6l90x7Hxjp49AZEsvbBYZC4Q+PZvQIeqEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nayab Sayed <nayabbasha.sayed@microchip.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 253/269] iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value
Date: Mon, 10 Mar 2025 18:06:46 +0100
Message-ID: <20250310170507.881085765@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nayab Sayed <nayabbasha.sayed@microchip.com>

commit aa5119c36d19639397d29ef305aa53a5ecd72b27 upstream.

The number of valid bits in SAMA7G5 ADC channel data register are 16.
Hence changing the realbits value to 16

Fixes: 840bf6cb983f ("iio: adc: at91-sama5d2_adc: add support for sama7g5 device")
Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
Link: https://patch.msgid.link/20250115-fix-sama7g5-adc-realbits-v2-1-58a6e4087584@microchip.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/at91-sama5d2_adc.c |   68 +++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 28 deletions(-)

--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -329,7 +329,7 @@ static const struct at91_adc_reg_layout
 #define AT91_HWFIFO_MAX_SIZE_STR	"128"
 #define AT91_HWFIFO_MAX_SIZE		128
 
-#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+#define AT91_SAMA_CHAN_SINGLE(index, num, addr, rbits)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
@@ -337,7 +337,7 @@ static const struct at91_adc_reg_layout
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 'u',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -350,7 +350,13 @@ static const struct at91_adc_reg_layout
 		.indexed = 1,						\
 	}
 
-#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 16)
+
+#define AT91_SAMA_CHAN_DIFF(index, num, num2, addr, rbits)		\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.differential = 1,					\
@@ -360,7 +366,7 @@ static const struct at91_adc_reg_layout
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 's',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -373,6 +379,12 @@ static const struct at91_adc_reg_layout
 		.indexed = 1,						\
 	}
 
+#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 16)
+
 #define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
 	{								\
 		.type = IIO_POSITIONRELATIVE,				\
@@ -666,30 +678,30 @@ static const struct iio_chan_spec at91_s
 };
 
 static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
-	AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x60),
-	AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x64),
-	AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x68),
-	AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x6c),
-	AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x70),
-	AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x74),
-	AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x78),
-	AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x7c),
-	AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x80),
-	AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x84),
-	AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x88),
-	AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x8c),
-	AT91_SAMA5D2_CHAN_SINGLE(12, 12, 0x90),
-	AT91_SAMA5D2_CHAN_SINGLE(13, 13, 0x94),
-	AT91_SAMA5D2_CHAN_SINGLE(14, 14, 0x98),
-	AT91_SAMA5D2_CHAN_SINGLE(15, 15, 0x9c),
-	AT91_SAMA5D2_CHAN_DIFF(16, 0, 1, 0x60),
-	AT91_SAMA5D2_CHAN_DIFF(17, 2, 3, 0x68),
-	AT91_SAMA5D2_CHAN_DIFF(18, 4, 5, 0x70),
-	AT91_SAMA5D2_CHAN_DIFF(19, 6, 7, 0x78),
-	AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x80),
-	AT91_SAMA5D2_CHAN_DIFF(21, 10, 11, 0x88),
-	AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
-	AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(0, 0, 0x60),
+	AT91_SAMA7G5_CHAN_SINGLE(1, 1, 0x64),
+	AT91_SAMA7G5_CHAN_SINGLE(2, 2, 0x68),
+	AT91_SAMA7G5_CHAN_SINGLE(3, 3, 0x6c),
+	AT91_SAMA7G5_CHAN_SINGLE(4, 4, 0x70),
+	AT91_SAMA7G5_CHAN_SINGLE(5, 5, 0x74),
+	AT91_SAMA7G5_CHAN_SINGLE(6, 6, 0x78),
+	AT91_SAMA7G5_CHAN_SINGLE(7, 7, 0x7c),
+	AT91_SAMA7G5_CHAN_SINGLE(8, 8, 0x80),
+	AT91_SAMA7G5_CHAN_SINGLE(9, 9, 0x84),
+	AT91_SAMA7G5_CHAN_SINGLE(10, 10, 0x88),
+	AT91_SAMA7G5_CHAN_SINGLE(11, 11, 0x8c),
+	AT91_SAMA7G5_CHAN_SINGLE(12, 12, 0x90),
+	AT91_SAMA7G5_CHAN_SINGLE(13, 13, 0x94),
+	AT91_SAMA7G5_CHAN_SINGLE(14, 14, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(15, 15, 0x9c),
+	AT91_SAMA7G5_CHAN_DIFF(16, 0, 1, 0x60),
+	AT91_SAMA7G5_CHAN_DIFF(17, 2, 3, 0x68),
+	AT91_SAMA7G5_CHAN_DIFF(18, 4, 5, 0x70),
+	AT91_SAMA7G5_CHAN_DIFF(19, 6, 7, 0x78),
+	AT91_SAMA7G5_CHAN_DIFF(20, 8, 9, 0x80),
+	AT91_SAMA7G5_CHAN_DIFF(21, 10, 11, 0x88),
+	AT91_SAMA7G5_CHAN_DIFF(22, 12, 13, 0x90),
+	AT91_SAMA7G5_CHAN_DIFF(23, 14, 15, 0x98),
 	IIO_CHAN_SOFT_TIMESTAMP(24),
 	AT91_SAMA5D2_CHAN_TEMP(AT91_SAMA7G5_ADC_TEMP_CHANNEL, "temp", 0xdc),
 };



