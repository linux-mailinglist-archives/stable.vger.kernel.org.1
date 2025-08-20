Return-Path: <stable+bounces-171880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34821B2D781
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423933A9DA1
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E8827056D;
	Wed, 20 Aug 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FiGg5ur/"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A218991E
	for <Stable@vger.kernel.org>; Wed, 20 Aug 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680754; cv=none; b=Bclb3rZX/dvFtf7fXYOQGRUhSVaZEUUXW+pe7Cr7AG1e0MbTOUzJD1xAketV3Z8dXBmBT6r01WthRavB+/wWRbgLhretrmEZqG72tRIX/zbX+/lRaPqGCYiRI0ZGkYGgY2qmsPFPqLCaX7drgTpcUEj95sA+8kJZYSKeem0af8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680754; c=relaxed/simple;
	bh=xDhLK3UQDI//y9HtMGi7ySP7/fgqdfub4tnqY2n/H18=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=hq1FVXkSLwp4IFRTloxQy/hvazGRWe4Bn9orblsWMHAH8ayiznos3Ztd19azsauX9MW8/jm02BOkhNrh3AcnX4VZmDgzbgjuOPWd2ee+ZC6gFoypSWOjCGXZ5N3HlGHcGSIhB5lHshbd/rH/ZmaWs7pcVnYs9RxpwWhq/Db0liY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FiGg5ur/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C355C4CEEB;
	Wed, 20 Aug 2025 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680753;
	bh=xDhLK3UQDI//y9HtMGi7ySP7/fgqdfub4tnqY2n/H18=;
	h=Subject:To:From:Date:From;
	b=FiGg5ur/t6cRrszdCU6PtZE3bSRY/q8CjYN3yfdVCwEMk9xG0ACZvgfZ/zM/N9ZQz
	 cQbPrs+J1IUv8miMxm9c2fXVW2jdZHEJVUXAjUl5ZOyJ8FVNdpk+ZLNZKbTE3fNeKG
	 lj+OmVS/mO7P1PhJKxlNCAG2lSAxHfOdG69hoGKI=
Subject: patch "iio: adc: bd79124: Add GPIOLIB dependency" added to char-misc-linus
To: mazziesaccount@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,bartosz.golaszewski@linaro.org,lkp@intel.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Aug 2025 11:05:35 +0200
Message-ID: <2025082035-cycling-security-a6d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: bd79124: Add GPIOLIB dependency

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8a6ededaad2d2dcaac8e545bffee1073dca9db95 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Wed, 13 Aug 2025 12:16:06 +0300
Subject: iio: adc: bd79124: Add GPIOLIB dependency

The bd79124 has ADC inputs which can be muxed to be GPIOs. The driver
supports this by registering a GPIO-chip for channels which aren't used
as ADC.

The Kconfig entry does not handle the dependency to GPIOLIB, which
causes errors:

ERROR: modpost: "devm_gpiochip_add_data_with_key" [drivers/iio/adc/rohm-bd79124.ko] undefined!
ERROR: modpost: "gpiochip_get_data" [drivers/iio/adc/rohm-bd79124.ko] undefined!

at linking phase if GPIOLIB is not configured to be used.

Fix this by adding dependency to the GPIOLIB.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508131533.5sSkq80B-lkp@intel.com/
Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://patch.msgid.link/6837249bddf358924e67566293944506206d2d62.1755076369.git.mazziesaccount@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6de2abad0197..24f2572c487e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1300,7 +1300,7 @@ config RN5T618_ADC
 
 config ROHM_BD79124
 	tristate "Rohm BD79124 ADC driver"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	select REGMAP_I2C
 	select IIO_ADC_HELPER
 	help
-- 
2.50.1



