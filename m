Return-Path: <stable+bounces-50003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB5900C40
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 21:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0448CB23C85
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235F1459F4;
	Fri,  7 Jun 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQoNCxkX"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848061FF6
	for <Stable@vger.kernel.org>; Fri,  7 Jun 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787211; cv=none; b=to8dJUVkKKmlJIk9gLL9gO3BHS9VX0A0EaqzpSIU/vANCmCXFJsNEGXo4O7D9RY/Qx+7NEJhYY3/mMxKGSFmbj3Whpi6gwfXD0bN8Zj/vM+jax9aGzkJ9swyQR46/i5YsYyuR/ljAhX3B4cdaSWwG51V7dy+X0FlyHZOfwLO6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787211; c=relaxed/simple;
	bh=oRzBeoYBytEtoFXQ6IgQadyzkwPRK6jrgmoiWcGMnzA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BjeWLtySmmgEYf4Ku7tgkniNDrdhLWyYSqsydv36l2IlcGaxOjCF3LOXm5PIA3s6FUm/r+hM6HoTfeTUoRxGdJqdxkb/VUkFaGyfFwZ/PLp11CDXp8iB3Jbxp7dWLIKmTNiRJC0Qu/F5Ro9vHqLthhO68eBGzBzCBvFvEfm4m6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQoNCxkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083F0C2BBFC;
	Fri,  7 Jun 2024 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717787211;
	bh=oRzBeoYBytEtoFXQ6IgQadyzkwPRK6jrgmoiWcGMnzA=;
	h=Subject:To:From:Date:From;
	b=uQoNCxkXeSJ9nVv0f3McfrY0j7C5jpkYD+j7njsyBxU+2BgSVzm827ObY2sTyM4wd
	 ZYKT0mKMCsXKxB8zeJbDTY2fFvnzDeyRcVQsDSlPKLMfJiYb/VTQNYa+INAB1/asDL
	 vFZBL507RADH/pSH6grn3W/thG6mkxas3vp1a+2w=
Subject: patch "iio: imu: bmi323: Fix trigger notification in case of error" added to char-misc-linus
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Jun 2024 21:06:49 +0200
Message-ID: <2024060749-clamor-divinity-9996@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: bmi323: Fix trigger notification in case of error

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From bedb2ccb566de5ca0c336ca3fd3588cea6d50414 Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Wed, 8 May 2024 17:54:07 +0200
Subject: iio: imu: bmi323: Fix trigger notification in case of error

In case of error in the bmi323_trigger_handler() function, the
function exits without calling the iio_trigger_notify_done()
which is responsible for informing the attached trigger that
the process is done and in case there is a .reenable(), to
call it.

Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240508155407.139805-1-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 5d42ab9b176a..67d74a1a1b26 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1391,7 +1391,7 @@ static irqreturn_t bmi323_trigger_handler(int irq, void *p)
 				       &data->buffer.channels,
 				       ARRAY_SIZE(data->buffer.channels));
 		if (ret)
-			return IRQ_NONE;
+			goto out;
 	} else {
 		for_each_set_bit(bit, indio_dev->active_scan_mask,
 				 BMI323_CHAN_MAX) {
@@ -1400,13 +1400,14 @@ static irqreturn_t bmi323_trigger_handler(int irq, void *p)
 					      &data->buffer.channels[index++],
 					      BMI323_BYTES_PER_SAMPLE);
 			if (ret)
-				return IRQ_NONE;
+				goto out;
 		}
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
+out:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.45.2



