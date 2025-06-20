Return-Path: <stable+bounces-155078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72DDAE18A6
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E253A9760
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1229E1D54F7;
	Fri, 20 Jun 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="o7J4FySK"
X-Original-To: stable@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9181CD3F
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414620; cv=none; b=uSC/4SlsPslL5eX1lYZFQbVjaoD1HkPiOlF0XiuHa3AVbmbOQipkgF9E0CWGj7/dvpnxfVS+Y0fJE7XFM/6Np0cgVbu7q342v57vreIuLAtmI4GwKgB+TdIQ4d1b6DOz49FgLeIE5t0yzM9HpRODjUDKVJ0Ji9cP4Tu9//hKkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414620; c=relaxed/simple;
	bh=T7bD1JgjwYNp1Kg+NNO+HInhmOfqQWvCFdUcFs1hTOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcmLULWVmTEaAEtB7xkwbHvWqApnvrUhLBpODppHK/6yJdpEJhWdptVY91viRgw35eDTGk+CBdvOuzv+V0pkxtaDUOn0uTTO130ZsL77c8lRsTV+LYjGU4jTl+fQYZmvZoTw8MWw6vOJI3dNZFiHnXfw+Sj9MJQbGCQDbvKwTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=o7J4FySK; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750414607; x=1750673807;
	bh=Dy0RlznXEylx5THZaLhqQBAEp3WRV3n3e9p1cnR2DuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=o7J4FySK27nsHtu5JWBQdjsK3H2Q+iiSFbCAEyYeGRcmuGYcJn/6lHo6TbR+X+j4o
	 kc9l9N4iyDvem7UHRIp6JAHjTL85QAOxhMzCyAQ9uwR5DdeLZ7SrgYsRLJRZhHV50W
	 twrBG+By2/KmhxTUF2iDG0NzIFg9UAbd6QCdx/wmK9BfCYIi4AHuKh2ZojcUek3N53
	 DjOp/B9+JuZuixgGGzIOnxOEJUGG2zWDcYZWDCRSexNmZlMEIqRy4JV6b8J4wMgWij
	 qgv7glGC2pKVCbqhVj2P8igKbb6TuhCBFUqYm1Udfb/tHe/Juf7OzLES4O2mK8ewtp
	 5a5RUGGmS7pnQ==
X-Pm-Submission-Id: 4bNtgL6zY7z1DDWk
From: Sean Nyekjaer <sean@geanix.com>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12.y] iio: accel: fxls8962af: Fix temperature calculation
Date: Fri, 20 Jun 2025 12:16:34 +0200
Message-ID: <20250620101638.4137650-1-sean@geanix.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025062051-boxer-reheat-0fff@gregkh>
References: <2025062051-boxer-reheat-0fff@gregkh>
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
index acadabec4df7..a0f0fef51334 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -22,6 +22,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -436,8 +437,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
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
@@ -736,6 +745,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \
-- 
2.49.0


