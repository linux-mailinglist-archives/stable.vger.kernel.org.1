Return-Path: <stable+bounces-99053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329159E6E69
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E231416D41F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D6201253;
	Fri,  6 Dec 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsB6aUjH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF091D5AC9
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488457; cv=none; b=kTLUT3HQQJwXvTaG4UYqxKSo2O1a5gAswceH8F8p2E0WZ6rwARZRjR5NAGrQZ+qM/FP8WQGJYelIxKrsWUU0dLC7NlFN13dMom5pB8soS7jpgmRbv9THUXNbj+W6k83IY4BHnl8fFsbKx0Wjx9x1Xq/4GoST+nrS8dLzPLyhMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488457; c=relaxed/simple;
	bh=NnuBix/lcxDqLLEAoLBnaLPwI38L2h4Yl/PxM6rvTu8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lc2+wX6/nswa9YSEr+DrANTPRaf8XJ+qo8e9YPH24mTDlqH1/AeJYUORwZJcm9aHmeC+fO7oDTx61jLS1422/OmWRzaDxHNAJG3Qkb75eWvbtUJF3pw6H3ANBMi0PepK1+oO66fq3ED2h0qMj5W+vL/DkKbYVz1trZIs8Of5Wq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsB6aUjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6376C4CED1;
	Fri,  6 Dec 2024 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733488457;
	bh=NnuBix/lcxDqLLEAoLBnaLPwI38L2h4Yl/PxM6rvTu8=;
	h=Subject:To:Cc:From:Date:From;
	b=dsB6aUjHBRAd8vyyeZhiqH7QLbkry8y5DhyGAO/euHrqiE4kz5hu82KMHCWrLW5/4
	 rYjF05OVMXEyG95/R8nXbQivnCLJB4ihbM8KH8PAtxHP445gpVpk55jTQIzCsSCOaf
	 +BYUwuDoaovH9iQ1GnRsAu6gbEnjkZODxcqdLMxM=
Subject: FAILED: patch "[PATCH] iio: invensense: fix multiple odr switch when FIFO is off" failed to apply to 6.6-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:34:14 +0100
Message-ID: <2024120613-exploring-lifter-215f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ef5f5e7b6f73f79538892a8be3a3bee2342acc9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120613-exploring-lifter-215f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef5f5e7b6f73f79538892a8be3a3bee2342acc9f Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Mon, 21 Oct 2024 10:38:42 +0200
Subject: [PATCH] iio: invensense: fix multiple odr switch when FIFO is off

When multiple ODR switch happens during FIFO off, the change could
not be taken into account if you get back to previous FIFO on value.
For example, if you run sensor buffer at 50Hz, stop, change to
200Hz, then back to 50Hz and restart buffer, data will be timestamped
at 200Hz. This due to testing against mult and not new_mult.

To prevent this, let's just run apply_odr automatically when FIFO is
off. It will also simplify driver code.

Update inv_mpu6050 and inv_icm42600 to delete now useless apply_odr.

Fixes: 95444b9eeb8c ("iio: invensense: fix odr switching to same value")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241021-invn-inv-sensors-timestamp-fix-switch-fifo-off-v2-1-39ffd43edcc4@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index f44458c380d9..37d0bdaa8d82 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -70,6 +70,10 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 	if (mult != ts->mult)
 		ts->new_mult = mult;
 
+	/* When FIFO is off, directly apply the new ODR */
+	if (!fifo)
+		inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 56ac19814250..7968aa27f9fd 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -200,7 +200,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
-	struct inv_sensors_timestamp *ts = &accel_st->ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -229,7 +228,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 938af5b640b0..c6bb68bf5e14 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -99,8 +99,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
-	struct inv_sensors_timestamp *ts = &gyro_st->ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -128,7 +126,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 3bfeabab0ec4..5b1088cc3704 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -112,7 +112,6 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 	if (enable) {
 		/* reset timestamping */
 		inv_sensors_timestamp_reset(&st->timestamp);
-		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
 		/* reset FIFO */
 		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);


