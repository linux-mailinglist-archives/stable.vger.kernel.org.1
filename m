Return-Path: <stable+bounces-83627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D487C99B9FC
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE601F21683
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41022146A63;
	Sun, 13 Oct 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7gFYQYw"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A571DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833188; cv=none; b=PQ6rJZCTxT2HUOMfqjCSEOi8JUQYREJHRmQ0fKucrYuqj+E8OgEOWEhEnX1kYBw46kbG2vv5SeazJTrWFbt/819LZeCU54x/fVxRuT4ctbI2wAjExukucNPKTMNQqfgYM/ZNFLCY2FE6G7+LYs4uR3H6ZDCCdcGKkqW5aYSZufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833188; c=relaxed/simple;
	bh=qjsh3uyJQMqfnAXO+i8bQ9bziM1gc/pmSs0hoWDryQg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=p/0F1Zth6ZlthV0St+tKmaH8FpRsbLarNQ1lIA2n/9i0/pH+TSfSnVJxzisooQXbAsnBIjoXs1dtabXWLYgbta3LuLttLaWDa5u3MeIyJrClvgWwZCQ2vyd5OH3za3VbGOibtS2biTVRn0n22x7lAco9H2pbobFepSiQ4t1FPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h7gFYQYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14212C4CEC5;
	Sun, 13 Oct 2024 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833185;
	bh=qjsh3uyJQMqfnAXO+i8bQ9bziM1gc/pmSs0hoWDryQg=;
	h=Subject:To:From:Date:From;
	b=h7gFYQYwQFy3SCJcC0+bo/hZqJVI++y4aP1pEZjmNpLt1xLK3mTSHU/fdL0TTxrvv
	 aqFQ4u96vB8OI6YkV15VzFGc4ihqBSzncadbGYmkOFMgPFRHbxjkCGYWO6mYEodYY5
	 pal3HZcJyuvgwdoz10ZrfYJl/6pw/TG1Tv6J0LU8=
Subject: patch "iio: adc: ad7944: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:25:58 +0200
Message-ID: <2024101358-iron-collected-48fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7944: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From f4dc96f05149d5e14d7a03c3b16171098847fee9 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:48 +0200
Subject: iio: adc: ad7944: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: d1efcf8871db ("iio: adc: ad7944: add driver for AD7944/AD7985/AD7986")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-2-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 97ece1a4b7e3..6790e62700fe 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -328,6 +328,8 @@ config AD7923
 config AD7944
 	tristate "Analog Devices AD7944 and similar ADCs driver"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices
 	  AD7944, AD7985, AD7986 ADCs.
-- 
2.47.0



