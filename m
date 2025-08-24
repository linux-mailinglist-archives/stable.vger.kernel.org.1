Return-Path: <stable+bounces-172680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A84B32CD8
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 03:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6063189315C
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C28165F1A;
	Sun, 24 Aug 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePVZJA7u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E313211F
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755998411; cv=none; b=beoeKY3dqBh2EXwiz+xItB8FdzNYZ+M2GhY2sIRGYu3EDVGbT8EZU8mwD1YcMg1gbodAWwD+JDWu7ZY/eHjdoGYv53PMpbxEw6GUf88oI1y3kTno96++FM63CPcy3+1JGG1h9ob+Zc8N0axQMm6ovsdYAmkA3tS7cOb5uJN2IEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755998411; c=relaxed/simple;
	bh=GcGtUY9/ohflnanoWfhy5ik2ngXkam+ZyWgjVUhtIzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QISuIHknXcYkN6Lqk17SgI4Iu3jNig49MORtzelVSqBr86Q2E4c22j4/XAAnq9lZwWi0xQzcbgEWMjlMgomhOerAQUo1rit0M5Dv4yOv3LBcnhh4me+9WdFWzQ9JqX9OeDeaUZKDwJWP8eS1iODETXKG8vKydC5yxn8/OrAOZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePVZJA7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51394C4CEE7;
	Sun, 24 Aug 2025 01:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755998411;
	bh=GcGtUY9/ohflnanoWfhy5ik2ngXkam+ZyWgjVUhtIzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePVZJA7uj5IjGM2NURluL+jYcRqNtoJc7sdOhK6aL5UAmRrUjonGoiTwO2fb3unGK
	 79mS33LyAXMPGuxCsshUMfTnvMXWoRaS5TCQ/LyBo5EEu0tUzb9N7oO9S/8pcDMYPZ
	 Ql74qwxMmB/msEE98VQkJGY9FGbDdNl6y8h2wlD6sOqK4RTOWrNL2UFJqPZLoW+ysx
	 +AfKjJdNUNrmqnmfS58y+rA2KyX3wx2n2bh/DPUfioa7dvkQKE6oQCugK3qrrOBvLx
	 +4IVzBIxCKHmTcQYQzzA2PkC7XlvQTALtrbz8NplRBdsGDTD2OFS0JUKriR44mxfaC
	 0SiT/LGEiZDAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: temperature: maxim_thermocouple: use DMA-safe buffer for spi_read()
Date: Sat, 23 Aug 2025 21:20:08 -0400
Message-ID: <20250824012008.2575688-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082359-tall-affected-36cf@gregkh>
References: <2025082359-tall-affected-36cf@gregkh>
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


