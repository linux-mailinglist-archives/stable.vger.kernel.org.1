Return-Path: <stable+bounces-20610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C685A8CB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB92CB26BD1
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F3374DD;
	Mon, 19 Feb 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1Zk15qB"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DE3BB3B
	for <Stable@vger.kernel.org>; Mon, 19 Feb 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359750; cv=none; b=aRLv7maKquePaG/YpRD5WoxRrJnbcnO/LrrVb51DXqhDjeIrJqLg0H+RTrEpLXvdU0leDQwzUEUUp2akbBWxs4HTforIJ21F2m7FjJtsd+KOknnSM/xqoVvQMs7uvZAtS2Digt+0bkbJKSLX+QLxWgk1M0UgQnxFerTjsf9vo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359750; c=relaxed/simple;
	bh=IK/+hu4+hGK5yfKG/PMhHhU0Eonx3ResbFto7qQgWWU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Eo9Pkl9HhJZjXjrSCjy97LHJvlYc4oDxSNT3/QfMG/eHVHbXkDhAo2VBSIWPBuf8IIg9HgItGbRqM4yXYsBt1q4THhavBWiVMwYBm2ZCTUKerw/8CaZwkjt777tiv0jJkjDH/0xlc1MCQ3NyVWQpIrmZrrqhU1vtK0dOHlXuijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1Zk15qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB6AC433F1;
	Mon, 19 Feb 2024 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359749;
	bh=IK/+hu4+hGK5yfKG/PMhHhU0Eonx3ResbFto7qQgWWU=;
	h=Subject:To:Cc:From:Date:From;
	b=N1Zk15qBQH8uVHtIcR0i6iaZcQwJVW9DJjlohmXfgAN6wDRGg45u09UHsaVCZWBJf
	 y7tgkZ+CH/ENeYHKkSfvMmUogpqZb57RZrou98Jh7hAZtOdb6/qTfSWX4VX62z6sUf
	 nVLZMp3ONO9tH5DBOjneJipsoe1xXyojfdj4KREY=
Subject: FAILED: patch "[PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id table" failed to apply to 4.19-stable tree
To: semen.protsenko@linaro.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@linux.intel.com,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:22:17 +0100
Message-ID: <2024021917-kangaroo-truce-ec20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x b67f3e653e305abf1471934d7b9fdb9ad2df3eef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021917-kangaroo-truce-ec20@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

b67f3e653e30 ("iio: pressure: bmp280: Add missing bmp085 to SPI id table")
0b0b772637cd ("iio: pressure: bmp280: Use chip_info pointers for each chip as driver data")
12491d35551d ("iio: pressure: bmp280: convert to i2c's .probe_new()")
10b40ffba2f9 ("iio: pressure: bmp280: Add more tunable config parameters for BMP380")
8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
18d1bb377023 ("iio: pressure: bmp280: reorder i2c device tables declarations")
327b5c0512c1 ("iio: pressure: bmp280: Fix alignment for DMA safety")
b00e805a47a8 ("iio: pressure: bmp280: simplify driver initialization logic")
83cb40beaefa ("iio: pressure: bmp280: Simplify bmp280 calibration data reading")
2405f8cc8485 ("iio: pressure: bmp280: use FIELD_GET, FIELD_PREP and GENMASK")
5f0c359defea ("iio: pressure: bmp280: reorder local variables following reverse xmas tree")
5d5129b17f83 ("iio: pressure: bmp280: fix datasheet links")
0f26b9db8dfd ("iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace")
a7a047ea5e01 ("iio: pressure: bmp280: Drop unneeded explicit castings")
6085102c494b ("iio: pressure: bmp280: Convert to use ->read_avail()")
2f4292a82171 ("iio: pressure: bmp280: use devm action and remove labels from probe")
1372d1a19799 ("iio: pressure: bmp280: use bulk regulator ops")
6b943a6f23d0 ("iio: pressure: bmp280 endian tidy ups")
a521d52d1eb2 ("iio: pressure: bmp280: remove stray newline")
6282b5c62018 ("iio: pressure: bmp280: BMP280 calibration to entropy")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b67f3e653e305abf1471934d7b9fdb9ad2df3eef Mon Sep 17 00:00:00 2001
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 20 Dec 2023 12:47:53 -0600
Subject: [PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id table

"bmp085" is missing in bmp280_spi_id[] table, which leads to the next
warning in dmesg:

    SPI driver bmp280 has no spi_device_id for bosch,bmp085

Add "bmp085" to bmp280_spi_id[] by mimicking its existing description in
bmp280_of_spi_match[] table to fix the above warning.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: b26b4e91700f ("iio: pressure: bmp280: add SPI interface driver")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 433d6fac83c4..e8a5fed07e88 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -87,6 +87,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
 
 static const struct spi_device_id bmp280_spi_id[] = {
+	{ "bmp085", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp180", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp181", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp280", (kernel_ulong_t)&bmp280_chip_info },


