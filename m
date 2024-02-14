Return-Path: <stable+bounces-20186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67196854C9D
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B931F21539
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B465B691;
	Wed, 14 Feb 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JptZc37N"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB143157
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924373; cv=none; b=pzmtyplPHVqqPNYng5OzhVABnCdR2qaVVfILOHo/Wz4aU+pFG0YmZgTnox5RUsERkRb6XgUSDfPxChLhjd+sn4jBKFDxXoOaGZkFMSIeW27glt6fQf6P1yURHFBLj8KyKSvQM3fZYzfnh1SY5GoS8taB7CFiZXcYVW4NBCKGWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924373; c=relaxed/simple;
	bh=6qQ/Cvpw2ZeSZTPMMHnZr8A69f4okY9tUiKQKNaIwsc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=K/rlxHdJsQUl+OmhYeLQ9VvKHp4lQrk+iZuRc2DofE8dKyxI+G7QFtkggUr1Gp38A0R7WkNF4+vvhWAFwy2V9+VC1LlAzt/xOhulZnqZdcF2ypPqwUtWF4XpNc3zeQK090pPoYwOaP5lYBpoFVKfeKAHK9m2Py4CbCTOHQvLoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JptZc37N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18D7C433F1;
	Wed, 14 Feb 2024 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924373;
	bh=6qQ/Cvpw2ZeSZTPMMHnZr8A69f4okY9tUiKQKNaIwsc=;
	h=Subject:To:From:Date:From;
	b=JptZc37NJjIjItLmw+IYCY+yZ/Ro7vN/oJ6xhy48EwEXFJEeLyksKAf0O9ZPvGk/7
	 0FvKdKOKU59SOHy9lkvphabT9biT+CEyTBG8+8sX2mbTSvNQkEPMF5aKBPo7KlaKQx
	 66YjtJHa6uDCPpDeCzGG+Crq3qPGp9+kQFhe+yIw=
Subject: patch "iio: pressure: bmp280: Add missing bmp085 to SPI id table" added to char-misc-linus
To: semen.protsenko@linaro.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@linux.intel.com,linus.walleij@linaro.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:03 +0100
Message-ID: <2024021402-preteen-used-efee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: bmp280: Add missing bmp085 to SPI id table

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From b67f3e653e305abf1471934d7b9fdb9ad2df3eef Mon Sep 17 00:00:00 2001
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 20 Dec 2023 12:47:53 -0600
Subject: iio: pressure: bmp280: Add missing bmp085 to SPI id table

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
---
 drivers/iio/pressure/bmp280-spi.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.43.1



