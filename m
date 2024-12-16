Return-Path: <stable+bounces-104371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197919F3490
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DA51618C5
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053E136337;
	Mon, 16 Dec 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7+EM56q"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342917C64
	for <Stable@vger.kernel.org>; Mon, 16 Dec 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363171; cv=none; b=ECDy0RgYwtpDv8COqNoAsiK/M1feuHjdmHv9zwi0Jd70uV9797W00FWOFRBZUbYESCoLBo6OgAqnKJq54YzyAsYLoEsZFYUAL+2UaTOjBh2HcCBrLDHOLTLTdFoY4dSvU20N+zURWmRWmeeWhIsGZhSTjZsCOXFUevdyBPEQ3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363171; c=relaxed/simple;
	bh=5xvlgFatrz+YHhdFeTRJiC7dHDpJRHGhbEpWxg38TMM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=EOv9iAGIQgloVGKSGwgCYFRHJSaWWBazrbZKKW/8XqYC5pL92z/AFLS+Sm8sX0bHGRptSTaYciXWpt85QmA8R8uKEbeuZVyMNfI9v6Hjpbbkk+L64rza35sC+Ir5QQBA38tdqpVqyQ2zqV5iqXp3u55b7LZFMlfn392+zseSOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y7+EM56q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D6FC4CED0;
	Mon, 16 Dec 2024 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363170;
	bh=5xvlgFatrz+YHhdFeTRJiC7dHDpJRHGhbEpWxg38TMM=;
	h=Subject:To:From:Date:From;
	b=y7+EM56qnbtxMvkjl6CEeoFPksVgi3zZABoMtuqPsW4qcmEqUNj1YdhYpMkx16Nfd
	 Co9+ck59ucu8si9/xioNkyiL0m2DcHRzE5sw/L8egK52fDluPzn1U/KKWp0SdgDIxP
	 E19OMyL2K85uKpJHMly8Tf9Z+x1PzEE1ps0RTPeQ=
Subject: patch "iio: adc: ad7173: fix using shared static info struct" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,granquet@baylibre.com,u.kleine-koenig@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Dec 2024 16:31:43 +0100
Message-ID: <2024121643-dolphin-exquisite-a589@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7173: fix using shared static info struct

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 36a44e05cd807a54e5ffad4b96d0d67f68ad8576 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 27 Nov 2024 14:01:53 -0600
Subject: iio: adc: ad7173: fix using shared static info struct
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a possible race condition during driver probe in the ad7173 driver
due to using a shared static info struct. If more that one instance of
the driver is probed at the same time, some of the info could be
overwritten by the other instance, leading to incorrect operation.

To fix this, make the static info struct const so that it is read-only
and make a copy of the info struct for each instance of the driver that
can be modified.

Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Tested-by: Guillaume Ranquet <granquet@baylibre.com>
Link: https://patch.msgid.link/20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-1-b6d7022b7466@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7173.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 8a0c931ca83a..8b03c1e5567e 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -200,6 +200,7 @@ struct ad7173_channel {
 
 struct ad7173_state {
 	struct ad_sigma_delta sd;
+	struct ad_sigma_delta_info sigma_delta_info;
 	const struct ad7173_device_info *info;
 	struct ad7173_channel *channels;
 	struct regulator_bulk_data regulators[3];
@@ -753,7 +754,7 @@ static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
 }
 
-static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.set_channel = ad7173_set_channel,
 	.append_status = ad7173_append_status,
 	.disable_all = ad7173_disable_all,
@@ -1403,7 +1404,7 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Interrupt 'rdy' is required\n");
 
-	ad7173_sigma_delta_info.irq_line = ret;
+	st->sigma_delta_info.irq_line = ret;
 
 	return ad7173_fw_parse_channel_config(indio_dev);
 }
@@ -1436,8 +1437,9 @@ static int ad7173_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_3;
 	spi_setup(spi);
 
-	ad7173_sigma_delta_info.num_slots = st->info->num_configs;
-	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
+	st->sigma_delta_info = ad7173_sigma_delta_info;
+	st->sigma_delta_info.num_slots = st->info->num_configs;
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &st->sigma_delta_info);
 	if (ret)
 		return ret;
 
-- 
2.47.1



