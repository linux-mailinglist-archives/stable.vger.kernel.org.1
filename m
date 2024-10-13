Return-Path: <stable+bounces-83629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C999B9FE
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D821C20A24
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A2146D7E;
	Sun, 13 Oct 2024 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RbhST3qu"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7A1DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833192; cv=none; b=qps15QMxk/5/7b8GhKVh1SzkbGPiF9fnI6/DujvYV+2ztJpahleMVYLyPBo5eAL3i1txkFPAQzB8Gw4j2UEHbCVZ/Hqt9F3X1ogoWah5AtQI8A0Pn39WuXyEct9QrqY/YcenuTqoxe9MNOsArSdrv+/ujXO1DwBVFGNfDIOWY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833192; c=relaxed/simple;
	bh=k5F5gPJDeMJkECbv040cU1qpbmPpn+RAGA5ZPSBQUws=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=LxL7o4z1gwsB4UMp0QdDYCQYQn/IhgzvXtdjz2nGyEWC0WfCfmPzLBcgk9UAS4Gq5WBSs+LbQ+YsuwNF6S4uMqz2u0LZmsIHhA30goZOSjPtQZDNWAb2iy50rZT+eccP2q5cMETeyeFFl0UWWN7O9uL82i5sZgmfeSK1+LLDlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RbhST3qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7E1C4CEC5;
	Sun, 13 Oct 2024 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833191;
	bh=k5F5gPJDeMJkECbv040cU1qpbmPpn+RAGA5ZPSBQUws=;
	h=Subject:To:From:Date:From;
	b=RbhST3qujlJ+cI7qNQc3En1ysWRC2CL38/l+FEchXXFwdYjJbOwHeXbYD1qRpp//V
	 tZbv04WG2Zz9NahNWVkYNFb2ZJaFpFyvPcWCGEsUVyNz1PtN2r8kqVA6j2xnOmwemR
	 gQBkTO9W1b62gOSttVVaKhgB3VK8/w0jcv4ObjaE=
Subject: patch "iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:25:59 +0200
Message-ID: <2024101359-mace-bonanza-a14f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From f3fe8c52c580e99c6dc0c7859472ec48176af32d Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:51 +0200
Subject: iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: 627198942641 ("iio: adc: add ADC driver for the TI LMP92064 controller")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-5-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 45872a4e2acf..68640fa26f4e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1529,6 +1529,7 @@ config TI_AM335X_ADC
 config TI_LMP92064
 	tristate "Texas Instruments LMP92064 ADC driver"
 	depends on SPI
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for the LMP92064 Precision Current and Voltage
 	  sensor.
-- 
2.47.0



