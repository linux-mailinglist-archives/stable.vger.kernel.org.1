Return-Path: <stable+bounces-104368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECD9F3486
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18764161730
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7E53363;
	Mon, 16 Dec 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dmxi2HYd"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734A847B
	for <Stable@vger.kernel.org>; Mon, 16 Dec 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363100; cv=none; b=EgZchulIAYowlC2ieS04XxlSyMXRs7z9eTNd9IeuI9SjvwV2vtf92asFB7seCv+jlbW6GlPGm0qOFy4Jew2xicGJ1KLpr6vQfYHNiavHE14yBCrM7U4RDXYlH4eCH7WM02POvaEkWrKWmaHopH9LgEwyWWAr+j5+nIdIIui/VMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363100; c=relaxed/simple;
	bh=FPeNxYxhdtL9j0E3F6H3G7P0Qx4ZPzyYdForL7xDlTg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=PDOE6vf8R8TexPmRmaa0APLdZrYqEDX9eZeM6Ct0zhSO5o8EkwwARKO3Y7bMrig/beEnNhGaSMxvRMKIhgUfJliBe1i5QfPy2ociU2P0kJvnk40QhGPLGzN3hHA9VCUTbmaFIrej6vD0KnuXyFUAzbRJBEiicK41eV/+mvkkRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dmxi2HYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ECEC4CED0;
	Mon, 16 Dec 2024 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363099;
	bh=FPeNxYxhdtL9j0E3F6H3G7P0Qx4ZPzyYdForL7xDlTg=;
	h=Subject:To:From:Date:From;
	b=dmxi2HYdQODl81fco0mJywQcVr5K4sVEUwVNWJ1555uwALUOnw3vbbq9EB3NTu/bM
	 yj+wZNiY6xX0I+zuuZfRmQPHTEGu/xQ/rWq0uo9SiIEojWcbFq1BVZFV6y2qQ6Hxsx
	 qBAFoJ0v3coZXykPVbOvNqe4TevZ3giQn9y5RXX4=
Subject: patch "iio: adc: ad7124: Disable all channels at probe time" added to char-misc-linus
To: u.kleine-koenig@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Dec 2024 16:31:32 +0100
Message-ID: <2024121632-enviable-defy-e021@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7124: Disable all channels at probe time

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 4be339af334c283a1a1af3cb28e7e448a0aa8a7c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Mon, 4 Nov 2024 11:19:04 +0100
Subject: iio: adc: ad7124: Disable all channels at probe time
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When during a measurement two channels are enabled, two measurements are
done that are reported sequencially in the DATA register. As the code
triggered by reading one of the sysfs properties expects that only one
channel is enabled it only reads the first data set which might or might
not belong to the intended channel.

To prevent this situation disable all channels during probe. This fixes
a problem in practise because the reset default for channel 0 is
enabled. So all measurements before the first measurement on channel 0
(which disables channel 0 at the end) might report wrong values.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/20241104101905.845737-2-u.kleine-koenig@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 7314fb32bdec..3d678c420cbf 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -917,6 +917,9 @@ static int ad7124_setup(struct ad7124_state *st)
 		 * set all channels to this default value.
 		 */
 		ad7124_set_channel_odr(st, i, 10);
+
+		/* Disable all channels to prevent unintended conversions. */
+		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0);
 	}
 
 	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
-- 
2.47.1



