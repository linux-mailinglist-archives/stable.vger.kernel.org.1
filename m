Return-Path: <stable+bounces-171879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D78FEB2D78A
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF8E1890AE9
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463622550CA;
	Wed, 20 Aug 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B66LJuGH"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016F18991E
	for <Stable@vger.kernel.org>; Wed, 20 Aug 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680750; cv=none; b=BPAVWDZFzt+BebfU4sF6SPBgcNFkcfW1TSQxEwVeuDrdHONFS7lWTzwcnq17yXDtsa8+csOu4rSv95o74XAvCCu+ONI2hbOXjCqOGt03YB6YhA/GHmxfQXrxqjJCJc33Bo93gn65Y6T2fsz2plUgrZJh7rnJ38uoZ04RDawKt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680750; c=relaxed/simple;
	bh=rBIWWgSgC3Z1+DJZd9LaEuOIL1k/8mC91rTAmBS9Y0I=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=axQks0JYCxxutUnNG1RS2bUZOayZ4askJfRkXSt8Avdu5jc8Gnyf8SnDKNrZzLk+QJrC9zHXmxzflJqcUN0BNtU6zEyhN8BevHzTtdbXY5LrPl4o+yDT5zPrpEp9+GkAF4rE0xEFCGwqL5JQxZ0EzuP/6S9roJAJW+NVUoTJl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B66LJuGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABE5C4CEEB;
	Wed, 20 Aug 2025 09:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680749;
	bh=rBIWWgSgC3Z1+DJZd9LaEuOIL1k/8mC91rTAmBS9Y0I=;
	h=Subject:To:From:Date:From;
	b=B66LJuGHgt0oI8KmfkdtEW6+GLoPyiS7+wX3vMf/YBmPSssRqx/K/uvN7cHYuu7uR
	 bSspLFIYeJHNevRA5DD1MJg5zxYFYBGDzW2QNWS/UfHJ4dlRNnoK8Jvg84QoUCg88B
	 gHW1x25l1ksRG3o3CPx6OXkwBi/kQaEE2pUKjR34=
Subject: patch "iio: temperature: maxim_thermocouple: use DMA-safe buffer for" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Aug 2025 11:05:34 +0200
Message-ID: <2025082034-zesty-matchless-b6aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: temperature: maxim_thermocouple: use DMA-safe buffer for

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From ae5bc07ec9f73a41734270ef3f800c5c8a7e0ad3 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 21 Jul 2025 18:04:04 -0500
Subject: iio: temperature: maxim_thermocouple: use DMA-safe buffer for
 spi_read()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/iio/temperature/maxim_thermocouple.c | 26 ++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index cae8e84821d7..205939680fd4 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -121,8 +122,15 @@ struct maxim_thermocouple_data {
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
@@ -130,18 +138,16 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
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
@@ -166,9 +172,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
 	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
+	ret = spi_read(data->spi, data->buffer.raw, data->chip->read_size);
 	if (!ret) {
-		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+		iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
 					    sizeof(data->buffer),
 					    iio_get_time_ns(indio_dev));
 	}
-- 
2.50.1



