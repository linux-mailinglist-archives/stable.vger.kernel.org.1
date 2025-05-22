Return-Path: <stable+bounces-146097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DB7AC0E07
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 16:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DED16B052
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8F528C5A0;
	Thu, 22 May 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0zBi7no"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23428A1D8
	for <Stable@vger.kernel.org>; Thu, 22 May 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924057; cv=none; b=OcMZ5Tk3FzHuMSLKJ1ChvZCRIwidfeufrAKsxNKtJab7Vk/RG3lO0qXAa12/CSfRYwcEh3aMjFBXpYvdeUOTzVPa0pZk5sEbIpYV1X3lrnrMzEHnEB7Pvfg5TZbhCUuPqYnO+lgZEn/HIPIPzR8n/gBRTXeTNRs8pf7ywZz4BVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924057; c=relaxed/simple;
	bh=dhGwMOWUftF4xNNfIpkwf3M6fYfSNgfesAPSdHiazOE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=bNDzP2iIjUMDQzA2tV65+ZNar7GJ8pjUU+stQDQOT7MBls1peDPuzbyu9btFeJplI8looqlV0pQ4k2aBSZOiZculeFUwtSKUp+FyGtfZiUJyJ63oQwtR+HENpJ+ZkhCwgYX+9uoQalUBGtG92tLVGFiT3CueCOg9j6ItUADoBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0zBi7no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7A8C4CEEB;
	Thu, 22 May 2025 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747924056;
	bh=dhGwMOWUftF4xNNfIpkwf3M6fYfSNgfesAPSdHiazOE=;
	h=Subject:To:From:Date:From;
	b=F0zBi7noTeTzQ3wK2NQifwyrCqnlxRQR4PiToglbhFNlNHBBKh/qSFmtQr3i2deIq
	 QXCegGwEmjU6rvZfO2UYwI5l4EnD1d5prC+9KgLorsixQpOWGFpxoBRHEK4Jk6T9TJ
	 hLbnMMRF39IL2EGojQBSwoyZdvBm/q0CGqFhYptk=
Subject: patch "iio: adc: ti-ads1298: Kconfig: add kfifo dependency to fix module" added to char-misc-next
To: r2.arthur.prince@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,mariana.valerio2@hotmail.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 May 2025 16:02:17 +0200
Message-ID: <2025052217-diffusion-palpitate-d22a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads1298: Kconfig: add kfifo dependency to fix module

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 3c5dfea39a245b2dad869db24e2830aa299b1cf2 Mon Sep 17 00:00:00 2001
From: Arthur-Prince <r2.arthur.prince@gmail.com>
Date: Wed, 30 Apr 2025 16:07:37 -0300
Subject: iio: adc: ti-ads1298: Kconfig: add kfifo dependency to fix module
 build
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add dependency to Kconfig’s ti-ads1298 because compiling it as a module
failed with an undefined kfifo symbol.

Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
Co-developed-by: Mariana Valério <mariana.valerio2@hotmail.com>
Signed-off-by: Mariana Valério <mariana.valerio2@hotmail.com>
Link: https://patch.msgid.link/20250430191131.120831-1-r2.arthur.prince@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ad06cf556785..0fe6601e59ed 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1562,6 +1562,7 @@ config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  If you say yes here you get support for Texas Instruments ADS1298
 	  medical ADC chips
-- 
2.49.0



