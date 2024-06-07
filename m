Return-Path: <stable+bounces-50001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9F900C3D
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 21:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21561C21CD8
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D16143865;
	Fri,  7 Jun 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWJcFHAP"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7813E3FD
	for <Stable@vger.kernel.org>; Fri,  7 Jun 2024 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787209; cv=none; b=RyejdtmbIuni9C2Wx4rl4jVJVAj580u6Q4qjw2/QttdZLlE6feC8V5f0yMYlwiDULeeidxpNUcfa1iaYVRgjcEQjyxzSWjfDESl+lybcBD5TRN0hFiUFIznLOD+ZK/+djBWEbI55OdI15V2lOup1nXCc9VwyhHi/0whGbtQL0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787209; c=relaxed/simple;
	bh=gFtJYpfyHTvtnZNU3gZuIF0XqeRFnFsv3u4VA5O69fA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Xs2nBZ/R/cwLNoc7JO7n351H7clj/XOV+4VRqUXE0x0wHhkgMTIO8BbDM5XF7pRbyO3Mw7PhfwkMw3iC1hLSSAA5yb5vluHmT7YKOvhiFpm+7dSL23z+tcio6ZOFdDJq2yGwC4RLAFXc4rU9vKrSoOBpmB35+VGtjuEkklam194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWJcFHAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B96AC32781;
	Fri,  7 Jun 2024 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717787208;
	bh=gFtJYpfyHTvtnZNU3gZuIF0XqeRFnFsv3u4VA5O69fA=;
	h=Subject:To:From:Date:From;
	b=bWJcFHAPpwN4iQCaTP68m3uX+MW5Uf4ISDvByPw0CVlWZ9I1TQYYRDmXw4xc4UTht
	 GsX+Ei9yzCJoe/a5mDFx2b6cyMCenmC99mMHsR3F72Vilvr/ZTJMrAJNs2ZR3C2Ht5
	 ZlD95nQe19Hbjmce1U/mtPlHciIP3A5ToGmcv6SU=
Subject: patch "iio: pressure: bmp280: Fix BMP580 temperature reading" added to char-misc-linus
To: ajarizzo@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,ang.iglesiasg@gmail.com,vassilisamir@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Jun 2024 21:06:47 +0200
Message-ID: <2024060746-recede-getaway-6e40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: bmp280: Fix BMP580 temperature reading

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 0f0f6306617cb4b6231fc9d4ec68ab9a56dba7c0 Mon Sep 17 00:00:00 2001
From: Adam Rizkalla <ajarizzo@gmail.com>
Date: Thu, 25 Apr 2024 01:22:49 -0500
Subject: iio: pressure: bmp280: Fix BMP580 temperature reading

Fix overflow issue when storing BMP580 temperature reading and
properly preserve sign of 24-bit data.

Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>
Tested-By: Vasileios Amoiridis <vassilisamir@gmail.com>
Acked-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Link: https://lore.kernel.org/r/Zin2udkXRD0+GrML@adam-asahi.lan
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/bmp280-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 09f53d987c7d..221fa2c552ae 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1394,12 +1394,12 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 	/*
 	 * Temperature is returned in Celsius degrees in fractional
-	 * form down 2^16. We rescale by x1000 to return milli Celsius
-	 * to respect IIO ABI.
+	 * form down 2^16. We rescale by x1000 to return millidegrees
+	 * Celsius to respect IIO ABI.
 	 */
-	*val = raw_temp * 1000;
-	*val2 = 16;
-	return IIO_VAL_FRACTIONAL_LOG2;
+	raw_temp = sign_extend32(raw_temp, 23);
+	*val = ((s64)raw_temp * 1000) / (1 << 16);
+	return IIO_VAL_INT;
 }
 
 static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
-- 
2.45.2



