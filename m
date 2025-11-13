Return-Path: <stable+bounces-194742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ECFC5A531
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42AA3B0777
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4602DEA83;
	Thu, 13 Nov 2025 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdKhob+h"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02482E0926
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073290; cv=none; b=EhvlPmz4lK/P14nPkuGbdL6nlAd1jbBqpOGHTAzVOSCmOGI2RJY5ceSat4FbcsPWxESVIdL2Z4gn2H0m8Wu6xZStI58XCc8Rm6+7mSXmnN2MlhoCd9/YqkcK6Gy70XdME4F6ohTG2USOI/sUu5S7c9tWfBvnco6VfRed7npewX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073290; c=relaxed/simple;
	bh=GJrIkF5uZpcuEs1kOMfMn5W1fN5ABTPWGRcUxOCP/jU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=hCX4WLv2XkF+B3s1VfUEc/PAOLvWlsOl30z9FK1AfTFDwqmbWW+JuPJb798QDHsiP5zBf8w1yA4Q7jATFOS4zVEDpgLy3+MlXbZgsLz1DUelL/XIfbvsLqBkuOw3RJ3aElrS8fSu34KktXGgcSdfhdZEhIAs6LJr2a/t6XsgkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdKhob+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3949CC16AAE;
	Thu, 13 Nov 2025 22:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073290;
	bh=GJrIkF5uZpcuEs1kOMfMn5W1fN5ABTPWGRcUxOCP/jU=;
	h=Subject:To:From:Date:From;
	b=mdKhob+hqa+CP6dLYuBwvD0YhKNMypKt+qa9hk8Vha1Qm+jSZ64tyDCdfJFz8lAm5
	 7ZhpyRYqOyOX6Z9xIw737oOKV38yYsTE19HUgfEJJkQ+RutkGMcf6c98wLDu1qGZGx
	 9IVL8PEb6AbxAH6LePDDoh6ssMDQDl4l/Ik74tLE=
Subject: patch "iio: adc: ad4030: Fix _scale value for common-mode channels" added to char-misc-linus
To: marcelo.schmitt@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:49 -0500
Message-ID: <2025111349-voucher-sculptor-ac07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad4030: Fix _scale value for common-mode channels

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From ffc74ad539136ae9e16f7b5f2e4582e88018cd49 Mon Sep 17 00:00:00 2001
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
Date: Thu, 18 Sep 2025 14:37:27 -0300
Subject: iio: adc: ad4030: Fix _scale value for common-mode channels

Previously, the driver always used the amount of precision bits of
differential input channels to provide the scale to mV. Though,
differential and common-mode voltage channels have different amount of
precision bits and the correct number of precision bits must be considered
to get to a proper mV scale factor for each one. Use channel specific
number of precision bits to provide the correct scale value for each
channel.

Fixes: de67f28abe58 ("iio: adc: ad4030: check scan_type for error")
Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 1bc2f9a22470..d8bee6a4215a 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -385,7 +385,7 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	struct ad4030_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
 
-	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
-- 
2.51.2



