Return-Path: <stable+bounces-72796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDF9699D4
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F69E284005
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076C1A3A9F;
	Tue,  3 Sep 2024 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M30RQqGY"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9C45003
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358494; cv=none; b=iVeu8btM1GIN6j5ntsteE6TqvnkIY6GcU44Ibp1BJnugTH5+U2qNpvAahU3+h+t2ug5SctoDNFMnK/ZmBUio4WymxGycGWcfjIulgLrb/IzamVOIIw1lKu6KR9RiQXpmChC4/KnC7vU60dEwMrtX9H/UgiXK9CAUj/rdMDw3s1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358494; c=relaxed/simple;
	bh=Wa5HWDizl5Geghkc+KqQDs7o/RfoBA8yT1Xnucfqim4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=VKQrR56gR2sonoAgaT7bCPhafr5ZJrM8+1EecA0lQtuV+5vIqrjj7AxkMlUV/T+hqfI6DFMlaEB/vfasq94vleVkxrZ8NfOaEfvODNeU3Jld73KtHd/ytd5MdXP2Or+YsVYo60Xt+EylZgaRQeotSHDbmYvnjaAfXiXFPsGyLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M30RQqGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725C6C4CEC4;
	Tue,  3 Sep 2024 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725358493;
	bh=Wa5HWDizl5Geghkc+KqQDs7o/RfoBA8yT1Xnucfqim4=;
	h=Subject:To:From:Date:From;
	b=M30RQqGYI33IIrnhC+k6ciA7nNb2p86sGNEQOyQGh1GJ06g8Hrlk7IW+vfQ3bZASO
	 LMMRtQCFv6h6+3FPA+adJ80d5QZPW1TVWXDjvpRkJJIPDVbYUUqtDKImBTdTp8kafi
	 8l+lXCB1o1ZQ2uXjtTg0RsK9VDxbGmfLhE1vr5jU=
Subject: patch "iio: pressure: bmp280: Fix waiting time for BMP3xx configuration" added to char-misc-testing
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 11:34:43 +0200
Message-ID: <2024090343-absolve-serrated-0a85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: bmp280: Fix waiting time for BMP3xx configuration

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 262a6634bcc4f0c1c53d13aa89882909f281a6aa Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 11 Jul 2024 23:15:50 +0200
Subject: iio: pressure: bmp280: Fix waiting time for BMP3xx configuration

According to the datasheet, both pressure and temperature can go up to
oversampling x32. With this option, the maximum measurement time is not
80ms (this is for press x32 and temp x2), but it is 130ms nominal
(calculated from table 3.9.2) and since most of the maximum values
are around +15%, it is configured to 150ms.

Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://patch.msgid.link/20240711211558.106327-3-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/bmp280-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index cc8553177977..3deaa57bb3f5 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1581,10 +1581,11 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		}
 		/*
 		 * Waits for measurement before checking configuration error
-		 * flag. Selected longest measure time indicated in
-		 * section 3.9.1 in the datasheet.
+		 * flag. Selected longest measurement time, calculated from
+		 * formula in datasheet section 3.9.2 with an offset of ~+15%
+		 * as it seen as well in table 3.9.1.
 		 */
-		msleep(80);
+		msleep(150);
 
 		/* Check config error flag */
 		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
-- 
2.46.0



