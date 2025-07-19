Return-Path: <stable+bounces-163418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56254B0AE89
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 10:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212A47AAC5B
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244922D4E2;
	Sat, 19 Jul 2025 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0StxtQpT"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B453597C
	for <Stable@vger.kernel.org>; Sat, 19 Jul 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911997; cv=none; b=VgXg0A0nizTbd0x0uWOLU+nE7LIA+lf4i0DaoD+zeZ3Q2jBF2VBHi3LLateBODv9Y7DoceVOlPbQecSVmXZXBqGIZuQnEwR2wU6VML0/vvnmuDS3RprxjSD9x8JZ21vBp59Ah9Irzcd9ZxHPgNspXl18PwzDMRQGT9Nh8vn1MrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911997; c=relaxed/simple;
	bh=A29oeFLUuDJWLPfGDa21u1qnn+B3hKflohZr6P2XJ2M=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ly4E9WWz6sdhGN7w1kLGVerNew7X0YxBKC0up3zlPmuSAtyuGO90PR60kbCP9FxVB6b7WzYa72SlsFu5Nif348l6+1TjZIzz5N542E/Wbm5BFHYoudRU2v6OZhgER/2xiZHG5xwFB9DNcE6EO2xVHknBxkjvc/R9SfAGke/wWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0StxtQpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E12BC4CEE3;
	Sat, 19 Jul 2025 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752911996;
	bh=A29oeFLUuDJWLPfGDa21u1qnn+B3hKflohZr6P2XJ2M=;
	h=Subject:To:From:Date:From;
	b=0StxtQpTz7BMJ4Igj/UBJAZ79I6mv6+vq6mdFElBYIdBZhTTO8J62HJ0eXEShyn0D
	 65KOlzsNjbRqTRUG+ZJHcPxqOE2bsRo607uhymWbxogAg9TlubQbQ8DJC1WIjgjq4u
	 +eZuGozGfKfRvBNvNyUUtc6IbBQadhmMKfTrPPoQ=
Subject: patch "iio: adc: ad7173: fix calibration channel" added to char-misc-testing
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sat, 19 Jul 2025 09:49:36 +0200
Message-ID: <2025071936-limit-flogging-6cf0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7173: fix calibration channel

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 1d9a21ffb43b6fd326ead98f0d0afd6d104b739a Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 8 Jul 2025 20:38:33 -0500
Subject: iio: adc: ad7173: fix calibration channel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the channel index values passed to ad_sd_calibrate() in
ad7173_calibrate_all().

ad7173_calibrate_all() expects these values to be that of the CHANNELx
register assigned to the channel, not the datasheet INPUTx number of the
channel. The incorrect values were causing register writes to fail for
some channels because they set the WEN bit that must always be 0 for
register access and set the R/W bit to read instead of write. For other
channels, the channel number was just wrong because the CHANNELx
registers are generally assigned in reverse order and so almost never
match the INPUTx numbers.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250708-iio-adc-ad7313-fix-calibration-channel-v1-1-e6174e2c7cbf@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7173.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 1f9e91a2e3f9..2173455c0169 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -391,13 +391,12 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
 		if (indio_dev->channels[i].type != IIO_VOLTAGE)
 			continue;
 
-		ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, st->channels[i].ain);
+		ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, i);
 		if (ret < 0)
 			return ret;
 
 		if (st->info->has_internal_fs_calibration) {
-			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_FULL,
-					      st->channels[i].ain);
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_FULL, i);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.50.1



