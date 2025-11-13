Return-Path: <stable+bounces-194745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F89C5A564
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7221C4E77AA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE0A2E54B3;
	Thu, 13 Nov 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NiJeIbXW"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F22DEA83
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073295; cv=none; b=do5k/1bfKV3ISeysGhf8ok0MSVyXPpfwPCgBTka2seEDgEjnsoIcK+eELrKz02V+rezgPWI5AkqGp/lFrJNbQl48pjKFs7c2iqnk/gUlrCjKnYOY4haduC96+XLueYzp0ciRjN6ipN8r791p89koxHim+s++o3TN8BanY5NhSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073295; c=relaxed/simple;
	bh=YHAy59a0u+ShxK6BTTg1SQrVl+NJV4agg4ln4PoAnzM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=PEvWhztMCwikaK5uf4RySaPyRIjXxqRc5dAxBDG5CDAoSu8LwuCtbgC8Rfm9VLXaQFI/sg/SqvYiA1KKSl3b1Jmla+5QBvUiwXD1lkXnDkKYV4YUndgwGmEdfzD62NkeBaDUKw3tzoFuu/2470j5Fxgl9E7/0AZ58GuR3F2qSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NiJeIbXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3671BC4CEF8;
	Thu, 13 Nov 2025 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073294;
	bh=YHAy59a0u+ShxK6BTTg1SQrVl+NJV4agg4ln4PoAnzM=;
	h=Subject:To:From:Date:From;
	b=NiJeIbXW3aEXoodfgHB82MvMqfPw54Pr3sfH+mbEQ8+vwfKstuD0ZO+MlOFA+Cl9k
	 x/ZNVwEhc3Y6+f864t+BtjKTeNyOKgpK+H0xRB6dCtfM4h2YQFoNy4Jgu0qDRt4480
	 FOAje3eMAIVBnXDWpLTlB7EDMiaVXMAkxdQCeRpQ=
Subject: patch "iio: pressure: bmp280: correct meas_time_us calculation" added to char-misc-linus
To: Achim.Gratz@Stromeko.DE,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:50 -0500
Message-ID: <2025111350-negation-guileless-6893@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: bmp280: correct meas_time_us calculation

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 0bf1bfde53b30da7fd7f4a6c3db5b8e77888958d Mon Sep 17 00:00:00 2001
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
Date: Sun, 28 Sep 2025 19:26:28 +0200
Subject: iio: pressure: bmp280: correct meas_time_us calculation

Correction of meas_time_us initialization based on an observation and
partial patch by David Lechner.

The constant part of the measurement time (as described in the
datasheet and implemented in the BM(P/E)2 Sensor API) was apparently
forgotten (it was already correctly applied for the BMP380) and is now
used.

There was also another thinko in bmp280_wait_conv:
data->oversampling_humid can actually have a value of 0 (for an
oversampling_ratio of 1), so it can not be used to detect the presence
of the humidity measurement capability.  Use
data->chip_info->oversampling_humid_avail instead, which is NULL for
chips that cannot measure humidity and therefore must skip that part
of the calculation.

Closes: https://lore.kernel.org/linux-iio/875xgfg0wz.fsf@Gerda.invalid/
Fixes: 26ccfaa9ddaa ("iio: pressure: bmp280: Use sleep and forced mode for oneshot captures")
Suggested-by: David Lechner <dlechner@baylibre.com>
Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/bmp280-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c04e8bb4c993..d983ce9c0b99 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1040,13 +1040,16 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	unsigned int reg, meas_time_us;
 	int ret;
 
-	/* Check if we are using a BME280 device */
-	if (data->oversampling_humid)
-		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
-				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
+	/* Constant part of the measurement time */
+	meas_time_us = BMP280_MEAS_OFFSET;
 
-	else
-		meas_time_us = 0;
+	/*
+	 * Check if we are using a BME280 device,
+	 * Humidity measurement time
+	 */
+	if (data->chip_info->oversampling_humid_avail)
+		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
+				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
 
 	/* Pressure measurement time */
 	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
-- 
2.51.2



