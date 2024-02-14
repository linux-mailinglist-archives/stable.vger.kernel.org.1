Return-Path: <stable+bounces-20189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649FA854CA1
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DC6B27054
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847955C604;
	Wed, 14 Feb 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jfoxgcIb"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470605B691
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924393; cv=none; b=GDyg15q4IpW7e/EtMfNt86oGPWhO+WmSAHsA87FYeSFo0j+eJEXUW9a8qeC89ptc9JbCGCD0gQJgkWCxDCO/zc0ggvvOI6uTOMykeHrvyZnAMS7z8IRM5yHjji+GZgf5dgWCCtSfyC5HTz9sM6e3DayHwU29Rj9TGIwlBXFCc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924393; c=relaxed/simple;
	bh=iKnxa7xf1z6gEpPqiH4IrqSYWxitBJBjiUHBLhaDej4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=jE8fkxxHZrGJ03pqX1SS8+NsmAUZ/hw39i1a9gaxe+hfp/bdv3UOwhTFpNWtzZUI3MxtGbak0y9Gv8jEURCGEBtWw1/VbY3MYRbw5KqE6E+tiIL4GZEfLIx0DA91QbM1Eqk8I47oVL4nLP2hHRPDT6pkjlM9QxGEEk9OjH25ZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jfoxgcIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B95C433C7;
	Wed, 14 Feb 2024 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924393;
	bh=iKnxa7xf1z6gEpPqiH4IrqSYWxitBJBjiUHBLhaDej4=;
	h=Subject:To:From:Date:From;
	b=jfoxgcIbjDRgJAH2kMWBw/lfMqAZpMRy+94ffrv/2jivrjN0uEWWwE3kb8hlZJP0p
	 HoSjc4AdmNT+chgJGs1yG0goq48kv7mNKq0jN2H58TOdEHS1fZgJQkB0v73sqzQMZU
	 r23U8xQmHZfW5SphzkwArHsOP1RkxQ4PTDAY6Wq4=
Subject: patch "iio: adc: ad_sigma_delta: ensure proper DMA alignment" added to char-misc-linus
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:07 +0100
Message-ID: <2024021407-tanning-carload-7394@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad_sigma_delta: ensure proper DMA alignment

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 59598510be1d49e1cff7fd7593293bb8e1b2398b Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 13:41:03 +0100
Subject: iio: adc: ad_sigma_delta: ensure proper DMA alignment

Aligning the buffer to the L1 cache is not sufficient in some platforms
as they might have larger cacheline sizes for caches after L1 and thus,
we can't guarantee DMA safety.

That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
for the sigma_delta ADCs.

[1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: 0fb6ee8d0b5e ("iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240117-dev_sigma_delta_no_irq_flags-v1-1-db39261592cf@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/adc/ad_sigma_delta.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7852f6c9a714..719cf9cc6e1a 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -8,6 +8,8 @@
 #ifndef __AD_SIGMA_DELTA_H__
 #define __AD_SIGMA_DELTA_H__
 
+#include <linux/iio/iio.h>
+
 enum ad_sigma_delta_mode {
 	AD_SD_MODE_CONTINUOUS = 0,
 	AD_SD_MODE_SINGLE = 1,
@@ -99,7 +101,7 @@ struct ad_sigma_delta {
 	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
 	 * rounded to 16 bytes to take into account padding.
 	 */
-	uint8_t				tx_buf[4] ____cacheline_aligned;
+	uint8_t				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
 	uint8_t				rx_buf[16] __aligned(8);
 };
 
-- 
2.43.1



