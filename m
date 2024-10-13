Return-Path: <stable+bounces-83645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0099BA0D
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0FF1C20A8E
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008A146D7E;
	Sun, 13 Oct 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FpUgAsm/"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF792146A63
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833243; cv=none; b=DORmNXDC7QwtraGvGZpCsngvVBEWGhMAUGz8mp4FjuecTeQC+rI8wlop3tAc4/idhZXL/CZ4NSiIsmo2aq0jrmTRYPnG6uwO2MBUiWXaTspsXZQMBcbBH6eBAhqnWIhiIIZaH9CnEYS55J3M6+udqMzwDcofcytNgoTW9Lf2lDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833243; c=relaxed/simple;
	bh=J6qcXxyPmq4buBDWY1No0SsdbOt3M44wEBKCL/qHqVI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=U/W56JadqYI7ctzK+jRreDpLmT2UrpR2D8XXy4PRbNK2h79yJmC9e8jYnblyS3LyLmg/ozQMHwdRCXagUXAEikQbACUDPy+x2Cd6QceL8xAYYt8uiYnvp8QUGDcY77IW3sYi/nhmkzwIEElcqg3Cj8fQpbp7L5zylIZrRadxsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FpUgAsm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DEEC4CEC5;
	Sun, 13 Oct 2024 15:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833243;
	bh=J6qcXxyPmq4buBDWY1No0SsdbOt3M44wEBKCL/qHqVI=;
	h=Subject:To:From:Date:From;
	b=FpUgAsm/ickMbZYqZ+Zjyd9aHX8VogxlnXpmhP+R8aoRSPrCPbXCz6JyNDL75f+n2
	 1Vwqa3lFeviukebW1mzirn7PrH4EvLMilY0PhtPn7lNKQhpPIswDT8OQHupT2ZPRl3
	 htVRvjUmeyoq6oKThpJP/hYGQsBCfoJti6J5M99A=
Subject: patch "iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:06 +0200
Message-ID: <2024101306-catapult-crop-4f75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 252ff06a4cb4e572cb3c7fcfa697db96b08a7781 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 18:49:39 +0200
Subject: iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: 8316cebd1e59 ("iio: dac: add support for ltc1660")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-7-4019453f8c33@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 2e0a9c94439f..25f6d1fd62df 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -358,6 +358,7 @@ config LPC18XX_DAC
 config LTC1660
 	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
 	depends on SPI
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Linear Technology
 	  LTC1660 and LTC1665 Digital to Analog Converters.
-- 
2.47.0



