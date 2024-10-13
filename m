Return-Path: <stable+bounces-83633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1684A99BA02
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50191F21744
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB78146A63;
	Sun, 13 Oct 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WnRHHIXI"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B214600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833205; cv=none; b=avzX4gPOXtrP03mRHfUwHph9QCdmI199RACO5U4KKXiH/n+CjDiAIVRvXtBZn6ty5psk2rrDFfeKUcwpxkxykPqd+VGRmMnvmbh2NGr/Lj3F3EdcZ/zwkJorR2VrYXdI1/RySOForbarRsBdcK36LQwyXuDguogA8OJZFCSR/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833205; c=relaxed/simple;
	bh=OzdeRAv/97m0p+DxEvzKPpDAV0cucGg/dvdjqjcywQI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Ml+j4FOdg8cd9BQK4pgLnfxewIT5hX0OPHRNWAM6OvsGETYiR+xSpLPkvNhW69DlNeY4GXg5rB6i51vjKT2gMUO2ixzGJtZCYTLJP8lAFmj7pejTUaQhELRebpdSBtx3W5x/gIerI6iSvrbcfQXsF6gYCsrS3c9ICJ8khRTFIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WnRHHIXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDC2C4CEC5;
	Sun, 13 Oct 2024 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833204;
	bh=OzdeRAv/97m0p+DxEvzKPpDAV0cucGg/dvdjqjcywQI=;
	h=Subject:To:From:Date:From;
	b=WnRHHIXITSf/3x/1lWrM01wPebLQm88ed4dlHWnob4u4UUKxW/t4NFt5lBqmBlCBg
	 fyFQOFVErtBTwb1kndfiP5T0vZgxXOcBipNv0xXM6pKfRj8cSWMFrGYa1VrQupsWV5
	 8CzNVzCqXICGwEB/H9HzlugAX8nlnEKkUPje0V9M=
Subject: patch "iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:00 +0200
Message-ID: <2024101359-cultural-latticed-dac2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a985576af824426e33100554a5958a6beda60a13 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:52 +0200
Subject: iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 6c7bc1d27bb2 ("iio: adc: ti-lmp92064: add buffering support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-6-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 68640fa26f4e..c1197ee3dc68 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1530,6 +1530,8 @@ config TI_LMP92064
 	tristate "Texas Instruments LMP92064 ADC driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the LMP92064 Precision Current and Voltage
 	  sensor.
-- 
2.47.0



