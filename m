Return-Path: <stable+bounces-196490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25373C7A489
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A5398337EF
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D3337BAF;
	Fri, 21 Nov 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T7JNPNcf"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B12D1932
	for <Stable@vger.kernel.org>; Fri, 21 Nov 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735602; cv=none; b=CyIt7kZrVN9Yl7dFltqD6vbvDYs+3qZSJSAZ3zleiFjGSUQT01IaMv3x3Sydv6c6T5uUwH1/pbmd1zEch9f1PRg2jayb8qi5kUjKi97iO4gjD9tu/sP8Q2nNEUiY//1UxI+qXpSBmHSql1wirXKV/AwDJFYxZ0FttSQ5/9pxhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735602; c=relaxed/simple;
	bh=JbMyuna0M9qmGrDnsDSvWfQ707bnNqfhgIOKljHFkZA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=WceqlaPri1Kbm6u1JlWOr5iJlB6HVxCaCOq7xVwdpFMsFyFYvyffYtnhmh83PyfBjHzxKuIpet9Nj/naU5IxNK4MHKBp3qp4N6hofXds7FabLrLI0S8BzU6Hxp5M+1sYbCgGaTE0xrXr2MkGFC9MGo+KcPNqQw/mX409tF2cAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T7JNPNcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D310C4CEF1;
	Fri, 21 Nov 2025 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763735601;
	bh=JbMyuna0M9qmGrDnsDSvWfQ707bnNqfhgIOKljHFkZA=;
	h=Subject:To:From:Date:From;
	b=T7JNPNcf8vkFap7xUaerMImDUqkCrL9ZEh1xthY4S9/di7ZbW2d5/wWXEzjd5fDUJ
	 FZbbbOYzcieTFobTg1vcueWiX2VnNbLnYvXYJvDVDvzXyaWd7baSMpq3lpmxiJVceZ
	 y7bXVmuwcQQ4PLdZ6g1BgD3vU1C0dxQXfYkE7Xt8=
Subject: patch "iio: adc: ad4080: fix chip identification" added to char-misc-testing
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Nov 2025 15:26:41 +0100
Message-ID: <2025112141-aground-dugout-fcd2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad4080: fix chip identification

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From b66cddc8be7278fd14650ff9182f3794397f8b31 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Tue, 7 Oct 2025 11:15:20 +0000
Subject: iio: adc: ad4080: fix chip identification
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix AD4080 chip identification by using the correct 16-bit product ID
(0x0050) instead of GENMASK(2, 0). Update the chip reading logic to
use regmap_bulk_read to read both PRODUCT_ID_L and PRODUCT_ID_H
registers and combine them into a 16-bit value.

The original implementation was incorrectly reading only 3 bits,
which would not correctly identify the AD4080 chip.

Fixes: 6b31ba1811b6 ("iio: adc: ad4080: add driver support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4080.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 6e61787ed321..e15310fcd21a 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -125,7 +125,7 @@
 
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
-#define AD4080_CHIP_ID						GENMASK(2, 0)
+#define AD4080_CHIP_ID						0x0050
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -445,7 +445,8 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->regmap);
-	unsigned int id;
+	__le16 id_le;
+	u16 id;
 	int ret;
 
 	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
@@ -458,10 +459,12 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
+	ret = regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id_le,
+			       sizeof(id_le));
 	if (ret)
 		return ret;
 
+	id = le16_to_cpu(id_le);
 	if (id != AD4080_CHIP_ID)
 		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
 
-- 
2.52.0



