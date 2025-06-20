Return-Path: <stable+bounces-155081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639CAE18B9
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A00D4A5373
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8489253F34;
	Fri, 20 Jun 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jYEnpvlQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C49199947
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414919; cv=none; b=C8df2ivacs/cfSAOCfmXtTcxQuWa22emt9M056r8exlhWk2Vb01nwhb9tYv5KCEyxnWI0ENvEXRjMnMdvztk2Y+pAdNGm8E0OxwYCG41DfnSOlqxA7LzC5FA8klf9nsMi+n7hKt4OjWsCObiNajqqqDjCUFA3yWaX3KJB1on0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414919; c=relaxed/simple;
	bh=5TGszwBpwdYAbe4DOXrRgXhwbwKEUgW6YXfJ9zRnzhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRcRDKdJ2x2+0e0vYF88gqx04ouBvzbeSaMQXK4fzswbJVE4RyWkXfzKWVmHnktDKBVSJOJMb07FfT4sIOHiyGSFLiOpQR+D1X5kaAqyDQqU87+qCyOz1f4qiAHm3V06wCy+jwNgdqQNHkS+gybPf7ZqBmhRMk6ArWHrPrkKBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jYEnpvlQ; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750414913; x=1750674113;
	bh=lYciz9raw3zSZfhenjb8Jv8eeXRChygUxsqlTBt64vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=jYEnpvlQFkEzVb5xOyGVjFzd6WA+v8550E013LJ0f+CY2kwPRTryuQooVj6y9ckBU
	 bWArg/t45RnhNXP2ROCCnnZV7hFE4PSIroHZi3LGCGteizMoLk+Ou15r5ya7KXTH5V
	 zNupk/qaB1OXqLJWSSGikDitx3bCn/krJmsWUv/QtbJLns8LO5mV6IK81FYPzQxd5a
	 5KkHt7L4WCqpIR/QxR46gGZOsUWyCQVkKW2XFQwesY1uo56fhcMOZRscUc0sd/nZq+
	 oRkeI7wREkp4BZ25Hn7c68t0E9vGijSN8C0VaTpsN9JJSkDMZUXyf2pJFT/bqMtMXS
	 IgZJeJEJW1sHA==
X-Pm-Submission-Id: 4bNtnC43VqzNg
From: Sean Nyekjaer <sean@geanix.com>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15.y] iio: accel: fxls8962af: Fix temperature calculation
Date: Fri, 20 Jun 2025 12:21:35 +0200
Message-ID: <20250620102136.222541-1-sean@geanix.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025062052-collar-amuser-47fe@gregkh>
References: <2025062052-collar-amuser-47fe@gregkh>
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
index 548a8c4269e7..1cdb03d4dc71 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -416,8 +417,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
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
@@ -494,6 +503,7 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \
-- 
2.49.0


