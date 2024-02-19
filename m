Return-Path: <stable+bounces-20609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5355285A8CA
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE97B25DFB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E463C46F;
	Mon, 19 Feb 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SUD387iP"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840F374DD
	for <Stable@vger.kernel.org>; Mon, 19 Feb 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359747; cv=none; b=eGi6JVhNVc4uwcwBw1O/9jjH5IR56uZOYY8+EW5KPv2yXR5gPAg2suO7nJaHXHlLHIckPRuUnq7mDkNJhAiThm2+MLLBvo5l70u+WRmp+baDGHM3qZu+Tn8ncHpp62byg2gQH2DGnZx8i5+HYdoMGZal1Y28wrHayCGM+BSCxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359747; c=relaxed/simple;
	bh=llcMiTUOn676j3ZtTWiKv7d1b6U4keMMXs+a5Cad4RQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ovhjYyRvbT2G0ShdoJ0Ijcn35MBFMv7Pct4Hf3RAosd0JVqaV+aXQSfw/96ojJ2TR4p0kufaZkvSIKEAeJ1Mh6+ePDXAo8XzUtbXO+aNYVpRsmwB9CBoMcM5CKPn2kMON3cN6wFrxS/fp53ak/KZTpHQGuq7dJMDFRABNUNMen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SUD387iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29522C433F1;
	Mon, 19 Feb 2024 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359746;
	bh=llcMiTUOn676j3ZtTWiKv7d1b6U4keMMXs+a5Cad4RQ=;
	h=Subject:To:Cc:From:Date:From;
	b=SUD387iPkUrIT9I/gQFc7XAXLKtnWuH8PI2PP9ZWaOSOAOTKib6iNA11q5Z9xIMyy
	 cQORwecKC9JaRP0A1lli1xagOuL51hayk95RM7O86GLAgJtb5rep/B68LQa7EJsaTD
	 hsAYITfet5YhySxev1hszkrfpFjInwkC1LJ7JRPE=
Subject: FAILED: patch "[PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id table" failed to apply to 5.4-stable tree
To: semen.protsenko@linaro.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@linux.intel.com,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:22:16 +0100
Message-ID: <2024021916-drowsily-perm-02e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b67f3e653e305abf1471934d7b9fdb9ad2df3eef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021916-drowsily-perm-02e5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


