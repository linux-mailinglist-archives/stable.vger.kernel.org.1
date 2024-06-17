Return-Path: <stable+bounces-52583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750D590B8A1
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5302A1C23BB4
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C0194A7B;
	Mon, 17 Jun 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YtxH1LqI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D7194A60
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647023; cv=none; b=lizvj6KSHOtzAWmGqmK9q0PLreKOY1REQEpOx572/Xqdj3CsoZ2RSDn09iTlJsTDFz+WQKEGBIa7miM1AfXMwsOOa7hnKv5S5w4oqHneCzoJRTmXSpB3QY/osBwjOdRMIBn3mqz6+pO0dtAVOmE0BngfVOHE3d48dpTBt5dFwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647023; c=relaxed/simple;
	bh=PLKwPwdP66zXnBa6MlFdO0aLmAuH4rbSDDoFDs7z6V0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JqYBZsqbqozsa09L4i25HUeFWl6E/lGqyOGkzVecE/tOBKolH5oFQMkMKvlBAur3FJEgr8y9G5a67ZlplLIJQG0l++Shq7AYhl+iRkIMGdqp4akqKjVznUvNAUYii/7OwVkl3BJWV2MX5XceM50pE/lBYt1jQJboqlHKivlocbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YtxH1LqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06A3C4AF1C;
	Mon, 17 Jun 2024 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647023;
	bh=PLKwPwdP66zXnBa6MlFdO0aLmAuH4rbSDDoFDs7z6V0=;
	h=Subject:To:Cc:From:Date:From;
	b=YtxH1LqIguQXQc15PcqPZdBieClPzlx1w+0XcDx00y6PArklZbf4wnG3h5KqjRLuK
	 LUjQOSLtlLG7d1y47oymXCi2T0Ah8ILUZ60CF5VmchOmnh1ZgqiCDTWM7i26wO6SuX
	 j47QaTAAEvHdoO5incPoCcoa1W4Kw3GeZoTp+LJg=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: stabilized timestamp in interrupt" failed to apply to 5.10-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 19:56:51 +0200
Message-ID: <2024061751-splinter-gap-68a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d7bd473632d07f8a54655c270c0940cc3671c548
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061751-splinter-gap-68a1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

d7bd473632d0 ("iio: imu: inv_icm42600: stabilized timestamp in interrupt")
bf8367b00c33 ("iio: invensense: fix timestamp glitches when switching frequency")
a1432b5b4f4c ("iio: imu: inv_icm42600: add support of ICM-42686-P")
b58b13f156c0 ("iio: invensense: remove redundant initialization of variable period")
111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors timestamp module")
0ecc363ccea7 ("iio: make invensense timestamp module generic")
d99ff463ecf6 ("iio: move inv_icm42600 timestamp module in common")
6e9f2d8375cb ("iio: imu: inv_icm42600: make timestamp module chip independent")
269b9d8fafbe ("Merge tag 'iio-for-6.5a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d7bd473632d07f8a54655c270c0940cc3671c548 Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Wed, 29 May 2024 15:47:17 +0000
Subject: [PATCH] iio: imu: inv_icm42600: stabilized timestamp in interrupt

Use IRQF_ONESHOT flag to ensure the timestamp is not updated in the
hard handler during the thread handler. And compute and use the
effective watermark value that correspond to this first timestamp.

This way we can ensure the timestamp is always corresponding to the
value used by the timestamping mechanism. Otherwise, it is possible
that between FIFO count read and FIFO processing the timestamp is
overwritten in the hard handler.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://lore.kernel.org/r/20240529154717.651863-1-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 63b85ec88c13..a8cf74c84c3c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -222,10 +222,15 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 	latency_accel = period_accel * wm_accel;
 
 	/* 0 value for watermark means that the sensor is turned off */
+	if (wm_gyro == 0 && wm_accel == 0)
+		return 0;
+
 	if (latency_gyro == 0) {
 		watermark = wm_accel;
+		st->fifo.watermark.eff_accel = wm_accel;
 	} else if (latency_accel == 0) {
 		watermark = wm_gyro;
+		st->fifo.watermark.eff_gyro = wm_gyro;
 	} else {
 		/* compute the smallest latency that is a multiple of both */
 		if (latency_gyro <= latency_accel)
@@ -241,6 +246,13 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 		watermark = latency / period;
 		if (watermark < 1)
 			watermark = 1;
+		/* update effective watermark */
+		st->fifo.watermark.eff_gyro = latency / period_gyro;
+		if (st->fifo.watermark.eff_gyro < 1)
+			st->fifo.watermark.eff_gyro = 1;
+		st->fifo.watermark.eff_accel = latency / period_accel;
+		if (st->fifo.watermark.eff_accel < 1)
+			st->fifo.watermark.eff_accel = 1;
 	}
 
 	/* compute watermark value in bytes */
@@ -514,7 +526,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 	/* handle gyroscope timestamp and FIFO data parsing */
 	if (st->fifo.nb.gyro > 0) {
 		ts = &gyro_st->ts;
-		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
 						st->timestamp.gyro);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
@@ -524,7 +536,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 	/* handle accelerometer timestamp and FIFO data parsing */
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
-		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
 						st->timestamp.accel);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
@@ -577,6 +589,9 @@ int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
 	unsigned int val;
 	int ret;
 
+	st->fifo.watermark.eff_gyro = 1;
+	st->fifo.watermark.eff_accel = 1;
+
 	/*
 	 * Default FIFO configuration (bits 7 to 5)
 	 * - use invalid value
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index 8b85ee333bf8..f6c85daf42b0 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -32,6 +32,8 @@ struct inv_icm42600_fifo {
 	struct {
 		unsigned int gyro;
 		unsigned int accel;
+		unsigned int eff_gyro;
+		unsigned int eff_accel;
 	} watermark;
 	size_t count;
 	struct {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 96116a68ab29..62fdae530334 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -537,6 +537,7 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 	if (ret)
 		return ret;
 
+	irq_type |= IRQF_ONESHOT;
 	return devm_request_threaded_irq(dev, irq, inv_icm42600_irq_timestamp,
 					 inv_icm42600_irq_handler, irq_type,
 					 "inv_icm42600", st);


