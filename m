Return-Path: <stable+bounces-41320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A78B007F
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 06:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDA92835FE
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 04:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A7913D8AA;
	Wed, 24 Apr 2024 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XumKMuay"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B513D886
	for <Stable@vger.kernel.org>; Wed, 24 Apr 2024 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932855; cv=none; b=uA3KmPIM5xPHF4FunrEDCCe441xYMYQSTIY3n6R6Z/6WVaYnrI4pbWATatinMyvNLm1dNff0b2DUuwewdLqCf49IP8cz3Mp1T/QFZKIh0uQmkqxq18kp0vr7W/qPU+Xs5mRLljMQsyTEW8ox9dDIZxQ9G450a3BS6/SGnWtKoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932855; c=relaxed/simple;
	bh=mt0DE2L/OEvq2FznX/Kcs/19zdgQ25RrfrFSpgkUr8k=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=AQcmq3VehfW+U5rkWn1qURthg1C9VVVEnm1aHOqRaz3k0Kch7jScxv636D7VQac6wD4aOK32tF3TBcDC/QjWP8AOdrPXGR+J5UFS3KC8zjSBvsayXsBVfEHnoAUMHHelrC4I/CJtb3n66WL+IZCNS2aOvA3/l7J1M2Ytg595RGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XumKMuay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E040C113CE;
	Wed, 24 Apr 2024 04:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713932854;
	bh=mt0DE2L/OEvq2FznX/Kcs/19zdgQ25RrfrFSpgkUr8k=;
	h=Subject:To:From:Date:From;
	b=XumKMuayLOYmBhxSckys9EfEJEUeUukgy/Nu7m0WD0R4wbYjFr7nm8GKZBiMsRf+j
	 gNNB50RRzcMqD27HCeYvET/lUTRQq/3kZg51CBV+saksQpUfezH0viI1C/o3G3exJp
	 BICJtUV2Ubeu02RVHcqlqV/dK1R7/pfyXHJGbUyU=
Subject: patch "iio: pressure: Fixes SPI support for BMP3xx devices" added to char-misc-linus
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 21:27:24 -0700
Message-ID: <2024042324-drinkable-herbs-6347@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: Fixes SPI support for BMP3xx devices

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 5ca29ea4e4073b3caba750efe155b1bd4c597ca9 Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Sat, 16 Mar 2024 12:07:43 +0100
Subject: iio: pressure: Fixes SPI support for BMP3xx devices

Bosch does not use unique BMPxxx_CHIP_ID for the different versions
of the device which leads to misidentification of devices if their
ID is used. Use a new value in the chip_info structure instead of
the BMPxxx_CHIP_ID, in order to choose the correct regmap_bus to
be used.

Fixes: a9dd9ba32311 ("iio: pressure: Fixes BMP38x and BMP390 SPI support")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240316110743.1998400-3-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/bmp280-core.c | 1 +
 drivers/iio/pressure/bmp280-spi.c  | 9 ++-------
 drivers/iio/pressure/bmp280.h      | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe8734468ed3..62e9e93d915d 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1233,6 +1233,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.chip_id = bmp380_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
 	.regmap_config = &bmp380_regmap_config,
+	.spi_read_extra_byte = true,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
 	.num_channels = 2,
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 038d36aad3eb..4e19ea0b4d39 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -96,15 +96,10 @@ static int bmp280_spi_probe(struct spi_device *spi)
 
 	chip_info = spi_get_device_match_data(spi);
 
-	switch (chip_info->chip_id[0]) {
-	case BMP380_CHIP_ID:
-	case BMP390_CHIP_ID:
+	if (chip_info->spi_read_extra_byte)
 		bmp_regmap_bus = &bmp380_regmap_bus;
-		break;
-	default:
+	else
 		bmp_regmap_bus = &bmp280_regmap_bus;
-		break;
-	}
 
 	regmap = devm_regmap_init(&spi->dev,
 				  bmp_regmap_bus,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4012387d7956..5812a344ed8e 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -423,6 +423,7 @@ struct bmp280_chip_info {
 	int num_chip_id;
 
 	const struct regmap_config *regmap_config;
+	bool spi_read_extra_byte;
 
 	const struct iio_chan_spec *channels;
 	int num_channels;
-- 
2.44.0



