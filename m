Return-Path: <stable+bounces-52578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770190B899
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 19:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29681B2247D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1A19046E;
	Mon, 17 Jun 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WS4oiiPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370F16CD3D
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647002; cv=none; b=AK1eRaepsO9Fe/KdkxYru4D2bfyBpAvst3m8mRRflwz5LytdgfpOiTCXKmiAGmFXGfHNXkdPV2CnNM+qznS1nYLnLEQXKdBMI0Mu1Ld3K1a2ZT80Q5YCzm58UZ3+Me8y6EF6zUrUKLMHByhA5czUFn2R2SWZmV1nfKjZGil+cJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647002; c=relaxed/simple;
	bh=bmQstYbXf6i8ipjrMoanpbaPqQp0seeX2gH1ZUGwPVk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NAnqc1SOr90Mhn/uoGOqLT1qbPVVDjq1E0aTed/Aq//LK6OqaAsyMc9QqCbbDvQEr4Ef08EJoOrRaKVwjJQB/4+AchFYD6ZCp48Fvtjg1xQKJkCmE2/ZWd1tHHjQoTusoC7mu6C1jqJDDFsEYOAWNLx0ZRV9kZjgbo1zFn8xTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WS4oiiPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25939C2BD10;
	Mon, 17 Jun 2024 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647001;
	bh=bmQstYbXf6i8ipjrMoanpbaPqQp0seeX2gH1ZUGwPVk=;
	h=Subject:To:Cc:From:Date:From;
	b=WS4oiiPYLshT59EQfZy8wQLjTJDIgqlksdfmizyjPQVN6EW1bzbkfsANsV5p2+ZCn
	 XJsQ7F1FaNQSt0gPn5CoKvaXGlhwF/JyVmwDnQTCWAvbThceMU9uZahfwoLGpVd+yr
	 vxCEdlyJp/uwhoJs28uTIF3ZsgAYZQlombA+7QW4=
Subject: FAILED: patch "[PATCH] iio: imu: inv_mpu6050: stabilized timestamping in interrupt" failed to apply to 6.6-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 19:56:30 +0200
Message-ID: <2024061730-float-nephew-920b@gregkh>
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
git cherry-pick -x 8844ed0a6e063acf7173b231021b2d301e31ded9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061730-float-nephew-920b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8844ed0a6e06 ("iio: imu: inv_mpu6050: stabilized timestamping in interrupt")
bf8367b00c33 ("iio: invensense: fix timestamp glitches when switching frequency")
a1432b5b4f4c ("iio: imu: inv_icm42600: add support of ICM-42686-P")
5537f653d9be ("iio: imu: inv_mpu6050: add new interrupt handler for WoM events")
b58b13f156c0 ("iio: invensense: remove redundant initialization of variable period")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8844ed0a6e063acf7173b231021b2d301e31ded9 Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Mon, 27 May 2024 15:01:17 +0000
Subject: [PATCH] iio: imu: inv_mpu6050: stabilized timestamping in interrupt

Use IRQ ONESHOT flag to ensure the timestamp is not updated in the
hard handler during the thread handler. And use a fixed value of 1
sample that correspond to this first timestamp.

This way we can ensure the timestamp is always corresponding to the
value used by the timestamping mechanism. Otherwise, it is possible
that between FIFO count read and FIFO processing the timestamp is
overwritten in the hard handler.

Fixes: 111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors timestamp module")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://lore.kernel.org/r/20240527150117.608792-1-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 0dc0f22a5582..3d3b27f28c9d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -100,8 +100,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto end_session;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
-	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);
-	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
+	inv_sensors_timestamp_interrupt(&st->timestamp, 1, pf->timestamp);
+	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, 1, 0);
 
 	/* clear internal data buffer for avoiding kernel data leak */
 	memset(data, 0, sizeof(data));
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 1b603567ccc8..84273660ca2e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -300,6 +300,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 	if (!st->trig)
 		return -ENOMEM;
 
+	irq_type |= IRQF_ONESHOT;
 	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
 					&inv_mpu6050_interrupt_timestamp,
 					&inv_mpu6050_interrupt_handle,


