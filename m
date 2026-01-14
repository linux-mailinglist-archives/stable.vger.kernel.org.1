Return-Path: <stable+bounces-208351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 175CFD1E61B
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8413021E61
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8F7387379;
	Wed, 14 Jan 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbFvxUFe"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70736C5A7
	for <Stable@vger.kernel.org>; Wed, 14 Jan 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389923; cv=none; b=qle0HzrTk/BrdUAjpGzIExJ98iiFoOs0kSUtpmPrDuXdx3gp8k1bsz7bZXbClXMjtcVb1UuAcRzufHWpdzTR+ukPyfTNXJJk73dzBGfx8cV3oPEEfO1MpabhNu88nNAQN5wHacFZeIuRGat7VWkeqhI5MRiubBO98toI7jy3ko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389923; c=relaxed/simple;
	bh=eIkc3Ybobc9EFgKB6YuCW9SiIvi6M14ZGt6pxMZOO64=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=jG9THn6GwyAJ1UO9DFmSGycgMRT1FovHcVFc+EszSWay8lwxseL1kj4J1YBQPrhKiq8ooX9KIHLcK4JDxma7mSPBCWDPzXm5EOaBDqBFNiM+aFK4UXeh6c9hhAwPOnR915GVLwC2W+gOgaEzwkcRiRVjVydzMpsJ2TaB/n0HiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hbFvxUFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71742C4CEF7;
	Wed, 14 Jan 2026 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768389923;
	bh=eIkc3Ybobc9EFgKB6YuCW9SiIvi6M14ZGt6pxMZOO64=;
	h=Subject:To:From:Date:From;
	b=hbFvxUFe7Mf937lQBeVpAV0zyW0zyllmB491IxRt4/H4aPWeED2h9nyMIqpnfDHnb
	 PTBmSN6Gr3y0Tkr3s7mZ4Rm5+fYHdAy9J8ruvFLFH0ZONp0x5MewwG94w//VTi/3y9
	 xKotMBh309H8CEFOhXWVr2jT8KC7iU2+s16jRiRw=
Subject: patch "iio: adc: ad9467: fix ad9434 vref mask" added to char-misc-linus
To: tomas.melin@vaisala.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,dlechner@baylibre.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Jan 2026 12:25:04 +0100
Message-ID: <2026011404-smuggling-jeeringly-a776@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad9467: fix ad9434 vref mask

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 92452b1760ff2d1d411414965d4d06f75e1bda9a Mon Sep 17 00:00:00 2001
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 3 Dec 2025 09:28:11 +0000
Subject: iio: adc: ad9467: fix ad9434 vref mask
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mask setting is 5 bits wide for the ad9434
(ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
from ad9265 were copied by mistake when support for the device was added
to the driver.

Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed ADC")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad9467.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc..2d8f8da3671d 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -95,7 +95,7 @@
 
 #define CHIPID_AD9434			0x6A
 #define AD9434_DEF_OUTPUT_MODE		0x00
-#define AD9434_REG_VREF_MASK		0xC0
+#define AD9434_REG_VREF_MASK		GENMASK(4, 0)
 
 /*
  * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
-- 
2.52.0



