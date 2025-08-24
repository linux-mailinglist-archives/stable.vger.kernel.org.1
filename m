Return-Path: <stable+bounces-172728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF2BB33006
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F904201A29
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284152D7DEB;
	Sun, 24 Aug 2025 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvbvvlNR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3162D7BF
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756041186; cv=none; b=Xhpw08lYhPSR10l2bf6O6V1ySNHrSs3eTVUA1wI2LDcwVxPhqISR9H6mSFjffdk4w2qsINa6XDDqJIYJXOYslY9Jm7ymNVBz9MXlfBuUNVb+LUKD5UtT724Wq4x4rI0ZwGarproTHES2PbfqxnA+cczOa0wzcWzNMpYvMjRTBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756041186; c=relaxed/simple;
	bh=GcGtUY9/ohflnanoWfhy5ik2ngXkam+ZyWgjVUhtIzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFd4wd2gmCOL502920Yjg+9mSjtJTAvqw+/3yO9lmdWYQtLQPXSAgRR9+Wk6SYXM1CnzbOdF4AACYmTdEKuGTp40PmgI/kbs/6+U6mRqZWrQ5hO/qI2wzLBTnrhUY5pyQmRRFdnqAlpFFGg3K/wyh/A7aEi0cv9Gdy086PUGq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvbvvlNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6651AC4CEEB;
	Sun, 24 Aug 2025 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756041186;
	bh=GcGtUY9/ohflnanoWfhy5ik2ngXkam+ZyWgjVUhtIzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvbvvlNRlNSRBAyLCVy5BMCovbZ3o8LppqQ6GVn8LuCqcyjsK2iT4p0444k0gRPhI
	 ulnaRO6vFPfWUarg/KIRD8g8vbK3u8ydv4J2OK1xZfwdrhiXqd2n6+ibwWFWK5s9tI
	 NuQ5CdUSvrHYDHAXUPNCQR0KPoNp79TonYMjVrgehVgj7Ik1goEUPTb4uBdX5ms74a
	 FC9GXijpbRJB6s1aMnuXr+n8d07UWx3OoSYSlvcSi9Xo+ZuvS9ZYFKYb6hP0DKff3z
	 phULTmUf5UneDrEez752a4vGs2jK8jJiz+RmrFi539hIvpDM4R9tFLx0MJfhD1A4w0
	 zOe7Gn3fx6mOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: temperature: maxim_thermocouple: use DMA-safe buffer for spi_read()
Date: Sun, 24 Aug 2025 09:13:03 -0400
Message-ID: <20250824131303.2806125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082300-collapse-wireless-5bdc@gregkh>
References: <2025082300-collapse-wireless-5bdc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit ae5bc07ec9f73a41734270ef3f800c5c8a7e0ad3 ]

Replace using stack-allocated buffers with a DMA-safe buffer for use
with spi_read(). This allows the driver to be safely used with
DMA-enabled SPI controllers.

The buffer array is also converted to a struct with a union to make the
usage of the memory in the buffer more clear and ensure proper alignment.

Fixes: 1f25ca11d84a ("iio: temperature: add support for Maxim thermocouple chips")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250721-iio-use-more-iio_declare_buffer_with_ts-3-v2-1-0c68d41ccf6c@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ iio_push_to_buffers_with_ts() => iio_push_to_buffers_with_timestamp() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/temperature/maxim_thermocouple.c | 26 ++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 555a61e2f3fd..44fba61ccfe2 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -122,8 +123,15 @@ struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
 	char tc_type;
-
-	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
+	/* Buffer for reading up to 2 hardware channels. */
+	struct {
+		union {
+			__be16 raw16;
+			__be32 raw32;
+			__be16 raw[2];
+		};
+		aligned_s64 timestamp;
+	} buffer __aligned(IIO_DMA_MINALIGN);
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
@@ -131,18 +139,16 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
 {
 	unsigned int storage_bytes = data->chip->read_size;
 	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
-	__be16 buf16;
-	__be32 buf32;
 	int ret;
 
 	switch (storage_bytes) {
 	case 2:
-		ret = spi_read(data->spi, (void *)&buf16, storage_bytes);
-		*val = be16_to_cpu(buf16);
+		ret = spi_read(data->spi, &data->buffer.raw16, storage_bytes);
+		*val = be16_to_cpu(data->buffer.raw16);
 		break;
 	case 4:
-		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
-		*val = be32_to_cpu(buf32);
+		ret = spi_read(data->spi, &data->buffer.raw32, storage_bytes);
+		*val = be32_to_cpu(data->buffer.raw32);
 		break;
 	default:
 		ret = -EINVAL;
@@ -167,9 +173,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
 	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
+	ret = spi_read(data->spi, data->buffer.raw, data->chip->read_size);
 	if (!ret) {
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 						   iio_get_time_ns(indio_dev));
 	}
 
-- 
2.50.1


