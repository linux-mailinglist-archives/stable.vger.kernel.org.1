Return-Path: <stable+bounces-41319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1AD8B007E
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 06:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746E71F23DA0
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 04:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0710D86277;
	Wed, 24 Apr 2024 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="THBWn889"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3755171CC
	for <Stable@vger.kernel.org>; Wed, 24 Apr 2024 04:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932853; cv=none; b=McFM0uBxo1fiKc7y9Tv6x/bRJ656+5lBO+jVUXu9VGa844+9VpVpvIT+JTfP9s10e8b7NG5cOaVnhV8lUDF+IGFWbc8YeoPjzMWxCOT8N0YpW6L9fgOVDvj5ih+xFSsJTNopCRIE+qBQg4HQh9SiCjmvcaQUoTLM792venV/T8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932853; c=relaxed/simple;
	bh=5M8n0Ds2J0V6CnlpU2vC9zuDQ/I1yuw2ApSKmBb54/k=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=aXkXE1muAEbg56aLMz3IsdTkiiiKiYYSkRLtlokKsvC1bLP6qRQ6P1a7Kzz9flEpL6Su8xHU0kSniMXQECVkTmJy8xX2tWyANIGnqiH/qf+/WOv5E5Oc+Xnj+nBuzSdXSC0x1bXqmJStPgDOAjcLN0bQbDQ4mfCnmIijfhF1tYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=THBWn889; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CA3C113CE;
	Wed, 24 Apr 2024 04:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713932853;
	bh=5M8n0Ds2J0V6CnlpU2vC9zuDQ/I1yuw2ApSKmBb54/k=;
	h=Subject:To:From:Date:From;
	b=THBWn889mF3q0ilNSILtg9WSE9HrqStd07rMk5v+OVoLgxnygfCmSQDgHm0Y5BK1i
	 W8X83QWUu5f68wMiDUKzdQJPYsIRoYzwl2O/EQnIDPRsgjeRcciROu62dZGBnMYxcw
	 voeLkfeKdkz9OPVqVQ5AM8Y0nbXY124rsQ+vKRas=
Subject: patch "iio: pressure: Fixes BME280 SPI driver data" added to char-misc-linus
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 21:27:24 -0700
Message-ID: <2024042323-drainpipe-casing-c7f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: Fixes BME280 SPI driver data

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 546a4f4b5f4d930ea57f5510e109acf08eca5e87 Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Sat, 16 Mar 2024 12:07:42 +0100
Subject: iio: pressure: Fixes BME280 SPI driver data

Use bme280_chip_info structure instead of bmp280_chip_info
in SPI support for the BME280 sensor.

Fixes: 0b0b772637cd ("iio: pressure: bmp280: Use chip_info pointers for each chip as driver data")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240316110743.1998400-2-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/bmp280-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index a444d4b2978b..038d36aad3eb 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -127,7 +127,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 	{ .compatible = "bosch,bmp180", .data = &bmp180_chip_info },
 	{ .compatible = "bosch,bmp181", .data = &bmp180_chip_info },
 	{ .compatible = "bosch,bmp280", .data = &bmp280_chip_info },
-	{ .compatible = "bosch,bme280", .data = &bmp280_chip_info },
+	{ .compatible = "bosch,bme280", .data = &bme280_chip_info },
 	{ .compatible = "bosch,bmp380", .data = &bmp380_chip_info },
 	{ .compatible = "bosch,bmp580", .data = &bmp580_chip_info },
 	{ },
@@ -139,7 +139,7 @@ static const struct spi_device_id bmp280_spi_id[] = {
 	{ "bmp180", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp181", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp280", (kernel_ulong_t)&bmp280_chip_info },
-	{ "bme280", (kernel_ulong_t)&bmp280_chip_info },
+	{ "bme280", (kernel_ulong_t)&bme280_chip_info },
 	{ "bmp380", (kernel_ulong_t)&bmp380_chip_info },
 	{ "bmp580", (kernel_ulong_t)&bmp580_chip_info },
 	{ }
-- 
2.44.0



