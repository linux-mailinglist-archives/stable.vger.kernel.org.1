Return-Path: <stable+bounces-52579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEDE90B89A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 19:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC94D1C23B8B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16FA18FC96;
	Mon, 17 Jun 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KE3Fbidf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C516CD3D
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647011; cv=none; b=DdpepN+sxtqlzIcZ+5rqXkB7LRTciwrrRe0tv3gXrodhTs0WsZ7Jj5cp43ZdGh5zAtEEqUmzv5W7xqLWzbCCgjz5QkGLf73+GtvlwXnvly8ySeDMeaDIKGoqjPxtGhnxln0quIolwk7ZbiYSgOKY8zaM9G/LqCr6Kr/RrYwdTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647011; c=relaxed/simple;
	bh=sVQx2GZcj7TUwvljn/luoZ6b+97jRr/J6lm50GR+XyA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=drV/RRakqXOvlwEjAlL/ZGymmNKK6Vlp8wSN+n/fWfJkros3xpTNc2N0aLluOKm7JXkjLLuBu5LPWIzq9tOv3veFtzaqAbv7ChD/x0kL6/r1oa0rQem0aO3G+z5KoA/mfPL8GtHtYZP7LdrbjyaEeDT4LHzjozuFOKaczTZc0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KE3Fbidf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF01EC2BD10;
	Mon, 17 Jun 2024 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647011;
	bh=sVQx2GZcj7TUwvljn/luoZ6b+97jRr/J6lm50GR+XyA=;
	h=Subject:To:Cc:From:Date:From;
	b=KE3FbidfERebCQ+hJNmn32Mu9ONL9CqKZOv13mIMzrlHj0rd2sNcWa60psctVh2Dn
	 MqMim1SXiO8zKWV7aibAKYwCH8lotlyMOE3iIZ6DkLkBCL18Ul9o/cNuTRI5S4n5Pq
	 rvwgHpgc5u+AITZFD5tUPaXR4e4OYV1pKeqkI/sk=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: stabilized timestamp in interrupt" failed to apply to 6.9-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 19:56:48 +0200
Message-ID: <2024061748-flashbulb-manliness-72d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x d7bd473632d07f8a54655c270c0940cc3671c548
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061748-flashbulb-manliness-72d7@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

d7bd473632d0 ("iio: imu: inv_icm42600: stabilized timestamp in interrupt")
bf8367b00c33 ("iio: invensense: fix timestamp glitches when switching frequency")
a1432b5b4f4c ("iio: imu: inv_icm42600: add support of ICM-42686-P")

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


