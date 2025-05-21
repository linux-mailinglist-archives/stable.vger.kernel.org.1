Return-Path: <stable+bounces-145818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C9ABF3F4
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795053A4654
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8623A2343C9;
	Wed, 21 May 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="blDLO7mS"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677221FF58
	for <Stable@vger.kernel.org>; Wed, 21 May 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829754; cv=none; b=NuJ/9Xv351Doe4IuuJwvOxn2fjvldqSfxXYNcKhNUCs393VJdeltYBWmyKcFjkaDSjjTFx+C8F9KcWDALuNQKAzxu+Bj6cjREFf4Kd8kYApPXJhhcI0inG74nNDeRA4QHE9xVXejXR/lNJZG++rbzhh03CdAdFbdxlz/w6F1Y6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829754; c=relaxed/simple;
	bh=Mqz28zEJYxKUZKOfyizt2hWDghirr0zTzKsqT9VxV/U=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=p6yyr5ixdmsKLAHUsPCzPp6JiXjR7SO++d9egcFkBlyVmsjAI927gLT42WEIT++gGZOB9xyNmMpNJlEXQYIYkxzmk0pJIjv3wTbp8CEB4B6ZPOduC8yKyKC46YK+HZg7rY/h7LPwIi/DxP7/blbIYLm+cdZy/P7HQq1WWMO+ZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=blDLO7mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED2AC4CEE4;
	Wed, 21 May 2025 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829753;
	bh=Mqz28zEJYxKUZKOfyizt2hWDghirr0zTzKsqT9VxV/U=;
	h=Subject:To:From:Date:From;
	b=blDLO7mSuRhk7UN4xThEDgQEabKaK2f/iBxqJo8pfHGUyCppc24ZMesXAyKfpL9wV
	 qpQEgBBZICjQ/FrKAY1NWzDr0mw7W717QU5cLFwrwDjGjGGEhZ2i0svaK+rS6b3j8q
	 OrVtLTkuJLFPxW1EoDr1YyDE3qoHc/vxT+SkdfPc=
Subject: patch "iio: adc: ad7606_spi: fix reg write value mask" added to char-misc-testing
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,adureghello@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 May 2025 14:15:48 +0200
Message-ID: <2025052148-cornhusk-snowsuit-e6d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7606_spi: fix reg write value mask

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 89944d88f8795c6c89b9514cb365998145511cd4 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 20:55:34 -0500
Subject: iio: adc: ad7606_spi: fix reg write value mask

Fix incorrect value mask for register write. Register values are 8-bit,
not 9. If this function was called with a value > 0xFF and an even addr,
it would cause writing to the next register.

Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250428-iio-adc-ad7606_spi-fix-write-value-mask-v1-1-a2d5e85a809f@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 179115e90988..b37458ce3c70 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -155,7 +155,7 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 	struct spi_device *spi = to_spi_device(st->dev);
 
 	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
-				  (val & 0x1FF));
+				  (val & 0xFF));
 
 	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
 }
-- 
2.49.0



