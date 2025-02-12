Return-Path: <stable+bounces-115036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA78A3221C
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1D07A344A
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBDB205E24;
	Wed, 12 Feb 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2M64S1N8"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AF2046A1
	for <Stable@vger.kernel.org>; Wed, 12 Feb 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352510; cv=none; b=lAO+FyXtpWou1XxXD01061Kx4dpV8hayF3hayf3SB37CBxKRjNPjeDr2naLNYn0RQu2ilST/ceehVolAhAUp3nfLPX0cwoaqayQ5lyh7vvipz3mcZa/cGGxw2WgG0erO91RFOPm7P8DoYzlaP8qEapGcJQbbRwSCU43MQJn5aUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352510; c=relaxed/simple;
	bh=9UNdkxgwbyCocLRLJcm/nyDZOsI9Kmr7YocVOdEXFmA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BuDGtBRNU/9wZ3JhOaQ4aILL4YHSqnpvZ0xgBInpCC3BcYy8qxBAVW+IiOeXH+HI9wpVnQEBbMCBgiC9j+JTTS8OstQuBN3rexvwEsDuszdMrlFlmkQGDpSLxYOoSnNTDFc0XM5vgUjhr87dgkCpyAKJlWvSfKba7iqNU8jhAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2M64S1N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B629CC4CEDF;
	Wed, 12 Feb 2025 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739352510;
	bh=9UNdkxgwbyCocLRLJcm/nyDZOsI9Kmr7YocVOdEXFmA=;
	h=Subject:To:From:Date:From;
	b=2M64S1N8CgH53u/fLpOPy1cnXOAzux6PcQp+r/D3a8gkghjh4pr7f9QwDeqQd0bL/
	 ABfD55phMif/43nKWWZ7FOlud5rDJqyKOsMatChsVyzHQ7kG+/gO5hpOQd5hL+dbaU
	 mB7F1+RPLqVV7yYIhAmnataBzycRvow++r3EjzkE=
Subject: patch "iio: filter: admv8818: Force initialization of SDO" added to char-misc-linus
To: swinchenbach@arka.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Feb 2025 10:27:05 +0100
Message-ID: <2025021205-cornea-important-0507@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: filter: admv8818: Force initialization of SDO

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From cc2c3540d9477a9931fb0fd851fcaeba524a5b35 Mon Sep 17 00:00:00 2001
From: Sam Winchenbach <swinchenbach@arka.org>
Date: Mon, 3 Feb 2025 13:34:34 +0000
Subject: iio: filter: admv8818: Force initialization of SDO

When a weak pull-up is present on the SDO line, regmap_update_bits fails
to write both the SOFTRESET and SDOACTIVE bits because it incorrectly
reads them as already set.

Since the soft reset disables the SDO line, performing a
read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line
doesn't make sense. This change directly writes to the register instead
of using regmap_update_bits.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
Link: https://patch.msgid.link/SA1P110MB106904C961B0F3FAFFED74C0BCF5A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/filter/admv8818.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 848baa6e3bbf..d85b7d3de866 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -574,21 +574,15 @@ static int admv8818_init(struct admv8818_state *st)
 	struct spi_device *spi = st->spi;
 	unsigned int chip_id;
 
-	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SOFTRESET_N_MSK |
-				 ADMV8818_SOFTRESET_MSK,
-				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
+	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
 		return ret;
 	}
 
-	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SDOACTIVE_N_MSK |
-				 ADMV8818_SDOACTIVE_MSK,
-				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
+	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
 		return ret;
-- 
2.48.1



