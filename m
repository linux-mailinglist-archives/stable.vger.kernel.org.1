Return-Path: <stable+bounces-83640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314C99BA09
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8991F21251
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1ED146A63;
	Sun, 13 Oct 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rKWxnNoy"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38314600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833227; cv=none; b=LntpFYVUwy2xDtYO9wyNL93i713Z3W6ItCqAT6n87iG7mRgpI2lTyR/xGkixHnCWYNG+f1vkF3a0xC9ICfIvBpDqkGhEumBrWhrA3H6oycregKZgjPAqnyKpbfqrM1IQqoCDQMaVCGeoc/GyNfWT4zgr/YQHcskGR2CczOakxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833227; c=relaxed/simple;
	bh=PUV03K7IrBZ9KGgICiYntCWRTq5/eHSPJMplJDPDVMk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=oPY3SnYUjiGSblrawsRpE39oeAEfYGfFn37ZtlTABbU12KHWd6CQBUfcCdR9TEn9XtDbOEHwNFZgH4k4oAPctQPvH3udMa9Q/hXOruAbezyzzB+NxHHkeiPSInuAyknbDIWHcUlEgTqmu89bdeTxI47qQB78q9Pezy5BsUX6GPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rKWxnNoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A79C4CEC5;
	Sun, 13 Oct 2024 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833227;
	bh=PUV03K7IrBZ9KGgICiYntCWRTq5/eHSPJMplJDPDVMk=;
	h=Subject:To:From:Date:From;
	b=rKWxnNoy0Cc3nN886Hwp/1PVOdgj2XmHGJ32bFjq+Uu96nf0iMJxZcoKPUb7ESuGy
	 ZAWP2LQpgjIhZV8Icy4vlzgsli/K8fsQOsYYKfXQe5OHUveAPA1yKb7UxghpCu0ltL
	 2R5KMaPnWG3J6J/E8x93JZU0OWguvEei1xc07kOo=
Subject: patch "iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:04 +0200
Message-ID: <2024101304-awhile-tutu-6525@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From c64643ed4eaa5dfd0b3bab7ef1c50b84f3dbaba4 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 18:49:35 +0200
Subject: iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: eda549e2e524 ("iio: frequency: adf4377: add support for ADF4377")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-3-4019453f8c33@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/frequency/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index c455be7d4a1c..89ae09db5ca5 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -53,6 +53,7 @@ config ADF4371
 config ADF4377
 	tristate "Analog Devices ADF4377 Microwave Wideband Synthesizer"
 	depends on SPI && COMMON_CLK
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices ADF4377 Microwave
 	  Wideband Synthesizer.
-- 
2.47.0



