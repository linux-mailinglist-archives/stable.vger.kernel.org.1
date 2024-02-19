Return-Path: <stable+bounces-20606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD885A8C5
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9351C217E7
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6B22DF73;
	Mon, 19 Feb 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pmpXeJ3j"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C43C498
	for <Stable@vger.kernel.org>; Mon, 19 Feb 2024 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359737; cv=none; b=Z38txRZGhVA7IMttv9n5keJACCSAVQTu4kw4fQ8jsdjVLv/dnI53HF4UUqLGiu5K4E5iUjaGCsQYROglw9NxBBdVRn7oT92ESEqiE4jFGCu/J075sKJiIPtHfFcJNp8oblpIejhgNq578c23d/Bd2gpfLABSphbmhVhhVNDt7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359737; c=relaxed/simple;
	bh=ih8Asy3DYiBtFcgoz4QhodP3rQ0QteD05WMm0e0pXdU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JAVzp+zwdSsMd8AhWz++hRa8rSzL1WxvyNE9Hg7rdE6DBLPTnZRgvKAIG2ZZbJSEH9VErtcvxDRk59IXYdEapUYkkzWPMz9mKHQDXk4xB0/ntTSRwWyxo5IkEr758M8FXaIe0/bSWL6QGr1B9WRxPOK33JuYnzDo7/VO0sS1AeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pmpXeJ3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F9EC433F1;
	Mon, 19 Feb 2024 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359736;
	bh=ih8Asy3DYiBtFcgoz4QhodP3rQ0QteD05WMm0e0pXdU=;
	h=Subject:To:Cc:From:Date:From;
	b=pmpXeJ3jdNhi2rxLa4dZimeioG9R+7inCzY+X/W9pBmDsmmp8Qatys1L5Yf8+gXKc
	 HIn8gNIXF1tu2lKwQ7VxiwjT7o1T9gb4n8Udz+PFzht3c/7MtPyVWP29EGrMBSdM33
	 z7eM2SVZBwJ+8KVsYq5rbaaaywSz1mc/sLOzZwC0=
Subject: FAILED: patch "[PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id table" failed to apply to 6.1-stable tree
To: semen.protsenko@linaro.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@linux.intel.com,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:22:13 +0100
Message-ID: <2024021913-jawline-fade-63d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b67f3e653e305abf1471934d7b9fdb9ad2df3eef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021913-jawline-fade-63d3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b67f3e653e30 ("iio: pressure: bmp280: Add missing bmp085 to SPI id table")
0b0b772637cd ("iio: pressure: bmp280: Use chip_info pointers for each chip as driver data")
12491d35551d ("iio: pressure: bmp280: convert to i2c's .probe_new()")

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


