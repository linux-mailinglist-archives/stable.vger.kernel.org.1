Return-Path: <stable+bounces-81406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F578993426
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDC71F23659
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D71DD542;
	Mon,  7 Oct 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGHoTGYN"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDF1DD540
	for <Stable@vger.kernel.org>; Mon,  7 Oct 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320103; cv=none; b=Scx18qMj3n6+64Z3VhCqdVyH0e1PC4n+qYYMmudXHS5BSzj292v/DlFD2t4it74P19i+6U7J2eQINhz5nYnUHGlwcabMYqBKuSurR0MWVzffj36WUFCppwh/nvQqvM7OHF/5v7X2SaE3GSkh6Aqg8G9epz4x0r5oNhK6ioAHl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320103; c=relaxed/simple;
	bh=72aacUIWUu+dJMFSO5N2DGCRShT5mKmgQFQ2KQticag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ta26riPGVR3ybWcm3gcbu29iaomGxA60eHOcJliXjMwDtXkmFPOBRNs2QxfPyegAHjN2kVc+dLIr3bPgPAKd+7KrPY7m36dd9UKSN3nF3OsYVbly+2sIZUMncWH2TzaftSq7G36iuHcClw+CmIUxhHWyxa24jt82nib2O6w7XRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NGHoTGYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F43C4CEC6;
	Mon,  7 Oct 2024 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320102;
	bh=72aacUIWUu+dJMFSO5N2DGCRShT5mKmgQFQ2KQticag=;
	h=Subject:To:Cc:From:Date:From;
	b=NGHoTGYNzbAktY6xkV+vP+WY1YDz9sDM7Fxr8qFyabxHOorzqxwa3taRnmMC/u52I
	 VGxO7Vh+ngfIMwIjNetTVDfV6JipxSdgg+89/m5CE/mlFXVMM7a0tULG5SbU/tWFGt
	 Zhg9IL4dK15U9d7qyiel334w+SDMCd5USfq1kOcc=
Subject: FAILED: patch "[PATCH] iio: pressure: bmp280: Fix waiting time for BMP3xx" failed to apply to 6.1-stable tree
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:54:41 +0200
Message-ID: <2024100740-engaging-splendor-8e75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 262a6634bcc4f0c1c53d13aa89882909f281a6aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100740-engaging-splendor-8e75@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

262a6634bcc4 ("iio: pressure: bmp280: Fix waiting time for BMP3xx configuration")
439ce8961bdd ("iio: pressure: bmp280: Improve indentation and line wrapping")
a2d43f44628f ("iio: pressure: fix some word spelling errors")
accb9d05df39 ("iio: pressure: bmp280: Add nvmem operations for BMP580")
597dfb2af052 ("iio: pressure: bmp280: Add support for new sensor BMP580")
42cde8808573 ("iio: pressure: Kconfig: Delete misleading I2C reference on bmp280 title")
0b0b772637cd ("iio: pressure: bmp280: Use chip_info pointers for each chip as driver data")
12491d35551d ("iio: pressure: bmp280: convert to i2c's .probe_new()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 262a6634bcc4f0c1c53d13aa89882909f281a6aa Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 11 Jul 2024 23:15:50 +0200
Subject: [PATCH] iio: pressure: bmp280: Fix waiting time for BMP3xx
 configuration

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


