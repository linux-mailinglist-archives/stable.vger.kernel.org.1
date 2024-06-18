Return-Path: <stable+bounces-53649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3390D553
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C1328950E
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856B15539D;
	Tue, 18 Jun 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2UXqh5hj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAF2139A2
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720296; cv=none; b=kP6tOFqkWvOYtyoxl5elOEC0og5KJlm3S8YdHQqHzRKABPDQqpKuJhlCSn+P9Kxc6jsg7FHOMSfM1NmNsf/Aipob9lQINOAJR+S55FO8hI6AD4aFiRcOFT42SPsChcyaWTnetXHQ5SKsuUrcieaE0Li7GEcwhQnTnV9kjsR/Whg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720296; c=relaxed/simple;
	bh=4xBGO41HoooettFAjXnadIJU+Lti0qEGeY2+Yb2FkEQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X30B7Heertz0QAVN6zwRgRBONrSGKNjGjnTG/krLnIbV4QN/rFUn8xa9jpyeE0oIKEQ2Nar309KcUMTWI4afgMTuhZqOorafw5UBLLQsM6B7yhBHrcRemLyhMzTR5PcNnswjCY8fXKw5lwp6m+4/9+TZfxiqEglrmsqnNAUnjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2UXqh5hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377B7C4AF1D;
	Tue, 18 Jun 2024 14:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718720295;
	bh=4xBGO41HoooettFAjXnadIJU+Lti0qEGeY2+Yb2FkEQ=;
	h=Subject:To:Cc:From:Date:From;
	b=2UXqh5hjtKEhI9jgunX9Ww3kJTSsJ00w27RVj+ATtuYewPFe7qSJG/9OiUCuK/CVF
	 75c/pX1siUl5CqcMMP+qpnwtQXt9twm2GYHexbixDeaw2iNQ22BHrv5NuR+CGU2uzU
	 geZci4b//3oiuzB9fCW7j6S7HMQSgwYjKbu2T7mQ=
Subject: FAILED: patch "[PATCH] iio: invensense: fix timestamp glitches when switching" failed to apply to 6.9-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 16:18:12 +0200
Message-ID: <2024061812-bagginess-kimono-e19c@gregkh>
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
git cherry-pick -x bf8367b00c33c64a9391c262bb2e11d274c9f2a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061812-bagginess-kimono-e19c@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

bf8367b00c33 ("iio: invensense: fix timestamp glitches when switching frequency")
a1432b5b4f4c ("iio: imu: inv_icm42600: add support of ICM-42686-P")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf8367b00c33c64a9391c262bb2e11d274c9f2a4 Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Fri, 26 Apr 2024 09:48:35 +0000
Subject: [PATCH] iio: invensense: fix timestamp glitches when switching
 frequency

When a sensor is running and there is a FIFO frequency change due to
another sensor turned on/off, there are glitches on timestamp. Fix that
by using only interrupt timestamp when there is the corresponding sensor
data in the FIFO.

Delete FIFO period handling and simplify internal functions.

Update integration inside inv_mpu6050 and inv_icm42600 drivers.

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
Cc: Stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://lore.kernel.org/r/20240426094835.138389-1-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 4b8ec16240b5..fa205f17bd90 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -70,13 +70,13 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
 
-static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period, uint32_t mult)
+static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period)
 {
 	uint32_t period_min, period_max;
 
 	/* check that period is acceptable */
-	period_min = ts->min_period * mult;
-	period_max = ts->max_period * mult;
+	period_min = ts->min_period * ts->mult;
+	period_max = ts->max_period * ts->mult;
 	if (period > period_min && period < period_max)
 		return true;
 	else
@@ -84,15 +84,15 @@ static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t perio
 }
 
 static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
-				    uint32_t mult, uint32_t period)
+				   uint32_t period)
 {
 	uint32_t new_chip_period;
 
-	if (!inv_validate_period(ts, period, mult))
+	if (!inv_validate_period(ts, period))
 		return false;
 
 	/* update chip internal period estimation */
-	new_chip_period = period / mult;
+	new_chip_period = period / ts->mult;
 	inv_update_acc(&ts->chip_period, new_chip_period);
 	ts->period = ts->mult * ts->chip_period.val;
 
@@ -125,16 +125,14 @@ static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 }
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      size_t sensor_nb, int64_t timestamp)
+				     size_t sample_nb, int64_t timestamp)
 {
 	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
-	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
 	uint32_t period;
 	bool valid = false;
 
-	if (fifo_nb == 0)
+	if (sample_nb == 0)
 		return;
 
 	/* update interrupt timestamp and compute chip and sensor periods */
@@ -144,14 +142,14 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	delta = it->up - it->lo;
 	if (it->lo != 0) {
 		/* compute period: delta time divided by number of samples */
-		period = div_s64(delta, fifo_nb);
-		valid = inv_update_chip_period(ts, fifo_mult, period);
+		period = div_s64(delta, sample_nb);
+		valid = inv_update_chip_period(ts, period);
 	}
 
 	/* no previous data, compute theoritical value from interrupt */
 	if (ts->timestamp == 0) {
 		/* elapsed time: sensor period * sensor samples number */
-		interval = (int64_t)ts->period * (int64_t)sensor_nb;
+		interval = (int64_t)ts->period * (int64_t)sample_nb;
 		ts->timestamp = it->up - interval;
 		return;
 	}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index cfb4a41ab7c1..63b85ec88c13 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -512,20 +512,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 		return 0;
 
 	/* handle gyroscope timestamp and FIFO data parsing */
-	ts = &gyro_st->ts;
-	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					st->fifo.nb.gyro, st->timestamp.gyro);
 	if (st->fifo.nb.gyro > 0) {
+		ts = &gyro_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
+						st->timestamp.gyro);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
 	}
 
 	/* handle accelerometer timestamp and FIFO data parsing */
-	ts = &accel_st->ts;
-	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					st->fifo.nb.accel, st->timestamp.accel);
 	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
+						st->timestamp.accel);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
@@ -555,9 +555,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
 	if (st->fifo.nb.gyro > 0) {
 		ts = &gyro_st->ts;
-		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
-						st->fifo.nb.total, st->fifo.nb.gyro,
-						gyro_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
@@ -565,9 +563,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
-		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
-						st->fifo.nb.total, st->fifo.nb.accel,
-						accel_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 86465226f7e1..0dc0f22a5582 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -100,7 +100,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto end_session;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
-	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
+	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);
 	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
 
 	/* clear internal data buffer for avoiding kernel data leak */
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
index a47d304d1ba7..8d506f1e9df2 100644
--- a/include/linux/iio/common/inv_sensors_timestamp.h
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -71,8 +71,7 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 				     uint32_t period, bool fifo);
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				     uint32_t fifo_period, size_t fifo_nb,
-				     size_t sensor_nb, int64_t timestamp);
+				     size_t sample_nb, int64_t timestamp);
 
 static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
 {


