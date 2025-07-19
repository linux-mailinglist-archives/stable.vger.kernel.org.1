Return-Path: <stable+bounces-163417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736CB0AE87
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 09:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D258EAA7387
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10E222584;
	Sat, 19 Jul 2025 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGKcwNHM"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5122D4E2
	for <Stable@vger.kernel.org>; Sat, 19 Jul 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911994; cv=none; b=Iycf7k6BzBxYJ72/V6QFGuchbAdg/JR0PTOfOae3IUAGgN5Ciqz6onZoC6PFG3/zsGvxj/p7Uxejan4NAPRpUnBPTugnJdKpgNIJx+I8aEM8oL8V89OLa/vc7wKjyDeCNzrjfgeWVgasZTFEfabSlqqkLDyC+LKfTMLTJbWXHfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911994; c=relaxed/simple;
	bh=HFu4t+kDbKRkHl+n+Fb/NgqlfDmQ7Q9Mjp9vf9IWLww=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=AgW8ZxxkOwG/7fos0+ozHw7k4p+veXqaKDfeyoRX4eIXEimmQPD2r7XIbmnuAZUZ7bcEMM8qO6EZjnh8U6rBnmWiicAXCu4zq9NwSjJjjjN8FlgTb5vjve3Kl5BB4pBrTV2LEdw9XMM9ojChjSrpg6wCQGovkF4YNu07Gf9p7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGKcwNHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A23C4CEE3;
	Sat, 19 Jul 2025 07:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752911993;
	bh=HFu4t+kDbKRkHl+n+Fb/NgqlfDmQ7Q9Mjp9vf9IWLww=;
	h=Subject:To:From:Date:From;
	b=ZGKcwNHMEOdSQ5ZmFWgZqYpgPSfd+f9dp1bmC03zM3lA+rPmi4MO4AD7m061KL6k7
	 o50H80uxKDJI1sQ30QjChVXzGhZNfHHJasbNMxbyNbpk5Zu3rfbNu3fUbJ0sFavylr
	 f+XBBVBK5Iim5npnvU0Twh1sfiLd2Gk7qXdi+Pds=
Subject: patch "iio: adc: ad7173: fix channels index for syscalib_mode" added to char-misc-testing
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 19 Jul 2025 09:49:35 +0200
Message-ID: <2025071935-uncheck-trickster-d416@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7173: fix channels index for syscalib_mode

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 0eb8d7b25397330beab8ee62c681975b79f37223 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 3 Jul 2025 14:51:17 -0500
Subject: iio: adc: ad7173: fix channels index for syscalib_mode

Fix the index used to look up the channel when accessing the
syscalib_mode attribute. The address field is a 0-based index (same
as scan_index) that it used to access the channel in the
ad7173_channels array throughout the driver. The channels field, on
the other hand, may not match the address field depending on the
channel configuration specified in the device tree and could result
in an out-of-bounds access.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-v1-1-7fdaedb9cac0@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7173.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index dd9fa35555c7..03412895f6dc 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -318,7 +318,7 @@ static int ad7173_set_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 
-	st->channels[chan->channel].syscalib_mode = mode;
+	st->channels[chan->address].syscalib_mode = mode;
 
 	return 0;
 }
@@ -328,7 +328,7 @@ static int ad7173_get_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 
-	return st->channels[chan->channel].syscalib_mode;
+	return st->channels[chan->address].syscalib_mode;
 }
 
 static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
@@ -347,7 +347,7 @@ static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	mode = st->channels[chan->channel].syscalib_mode;
+	mode = st->channels[chan->address].syscalib_mode;
 	if (sys_calib) {
 		if (mode == AD7173_SYSCALIB_ZERO_SCALE)
 			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_SYS_ZERO,
-- 
2.50.1



