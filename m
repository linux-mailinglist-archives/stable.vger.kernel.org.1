Return-Path: <stable+bounces-155082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FDAE18C0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D73B1BC2C43
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF5127D781;
	Fri, 20 Jun 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Tq5tZSks"
X-Original-To: stable@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71525F963
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415065; cv=none; b=clxnXml90xVTND6mQOcb6O3T9N3I4WZED2Kp7WijYxX8b5c7Bs8PILAwsjQUpDcVlOm2ImkaF3ZFcoW6JcEDHI4HqWcpqQjRwiQFW9KPyp7wof9eLKOa4BjXaSMSBVMhQpWv45ymqDK6A8eB2Qx1oT9ZfI3CAOlC9BEyPt8IegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415065; c=relaxed/simple;
	bh=4aUUf0hYcp3L4/ADU0qjWz8F1XtNmHQuCyyR/qHcZKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOlevzqVkuwodGDuDvKxfje+jE+wBFWpEij+9lnQevjsvBjuSpwHPwLPLIQjeqF29W20Brt8NmQpxhqeiWqyvEzANIvL2qU8jxETRLw56gMVoxojMGu+pd26YQR/l6+4aGiv7dMP/G+q2jbY29HMresgGDtTbJkj4ftNtHfttCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Tq5tZSks; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750415052; x=1750674252;
	bh=xbso6cS1pLu+NozeEBwAQHhS+QCF7drJomXd9p+BO7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Tq5tZSksq0FT65D5v3pYRUxGZT7sNBFswjF4dXD5fF3NwhuNorzp0icwPI2T+vRuf
	 tmDSiJEpVlsE/ULF8tbHdMxWBAXLUQ+S0GlihFTYCuq9E/HCb9Ukf3/0Sal45Q2Fy3
	 u69nvEqL0KpC908KIkGBIrObd7ZaqHdmJy44jKg/Wd+6JbVKJ/g1covq13LIDf+/mq
	 lWPWNI53Vfvlza4+5DPnxD3uoovYn0WaChIycANDasIQWYdPQa4Q41Wv5QorMXwnqT
	 RO3aQGTCOf6bUGYu5Lol3+ETerlDRpollYPJHbAVa7vjSkODPXfXn/jyyUqk/oWXbY
	 EDsb2K6Q7yJ/A==
X-Pm-Submission-Id: 4bNtqv6bJhz4x66f
From: Sean Nyekjaer <sean@geanix.com>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6.y] iio: accel: fxls8962af: Fix temperature calculation
Date: Fri, 20 Jun 2025 12:24:07 +0200
Message-ID: <20250620102408.536990-1-sean@geanix.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025062052-exceeding-exchange-46e3@gregkh>
References: <2025062052-exceeding-exchange-46e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to spec temperature should be returned in milli degrees Celsius.
Add in_temp_scale to calculate from Celsius to milli Celsius.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Cc: stable@vger.kernel.org
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250505-fxls-v4-1-a38652e21738@geanix.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 16038474e3a0263572f36326ef85057aaf341814)
---
 drivers/iio/accel/fxls8962af-core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index be8a15cb945f..1805142be023 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -434,8 +435,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 		*val = FXLS8962AF_TEMP_CENTER_VAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		return fxls8962af_read_full_scale(data, val2);
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = MILLIDEGREE_PER_DEGREE;
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
@@ -734,6 +743,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \
-- 
2.49.0


