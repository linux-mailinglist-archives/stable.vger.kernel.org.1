Return-Path: <stable+bounces-108416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58511A0B4C6
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E7A18869DA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628E222C34C;
	Mon, 13 Jan 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKoeZ0ow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7416EC19
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736765265; cv=none; b=k80Goa7ct6cF4v21XkwaNs124nZ6egXsUY4WJy3JGNZ/Ni8cUh4rKyxTnVVjeTaB04lLb0bcctIC7QwIKfGuvILQkPMzrVgKi5Y3iQSVGXta5wdBicyeP0Tul570b7rSOfmYIV6i/U97GtvZaxzRDzcKiswWYp7m7zBHS/4QB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736765265; c=relaxed/simple;
	bh=VZHeO0kp4Iv/jGJIOq6k4LBJFBeN+GubJcb8u06xuuQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X1bOerAzZb3Xih3rFjE66ZAkwyBxrResk0u6EVXkrapFd011qo05Ar+DNMQJg5dvZCYwhXwhWmrTTF6Dv2DnRFycFMqwogA0ppoTZwBMKY9ymsZMHVX27W5f8M4gYzp09liuPm+BGoDJZ1p/0/Dg60e4AnV6ueN5DGd08+DLqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKoeZ0ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87526C4CEDD;
	Mon, 13 Jan 2025 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736765265;
	bh=VZHeO0kp4Iv/jGJIOq6k4LBJFBeN+GubJcb8u06xuuQ=;
	h=Subject:To:Cc:From:Date:From;
	b=WKoeZ0owFHBPpl7di5Rk3fEMuzRHPvB1toVIKPCiFB823E6MynqYIdZtWRfNGzYbo
	 1v/oYFAej5S8/4sKYckD2Glf4VCETocM3W8H9xgGi+VDFResFno1OMgSfsOgyy6n2C
	 Luht1y3/5z5o0jy6NFrfxwpGKyVfIGUheDcXP0bM=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: fix timestamps after suspend if" failed to apply to 6.6-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:45:53 +0100
Message-ID: <2025011353-untried-juniper-fe92@gregkh>
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
git cherry-pick -x 65a60a590142c54a3f3be11ff162db2d5b0e1e06
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011353-untried-juniper-fe92@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65a60a590142c54a3f3be11ff162db2d5b0e1e06 Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Wed, 13 Nov 2024 21:25:45 +0100
Subject: [PATCH] iio: imu: inv_icm42600: fix timestamps after suspend if
 sensor is on

Currently suspending while sensors are one will result in timestamping
continuing without gap at resume. It can work with monotonic clock but
not with other clocks. Fix that by resetting timestamping.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241113-inv_icm42600-fix-timestamps-after-suspend-v1-1-dfc77c394173@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index e43538e536f0..ef9875d3b79d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -829,6 +829,8 @@ static int inv_icm42600_suspend(struct device *dev)
 static int inv_icm42600_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -849,9 +851,12 @@ static int inv_icm42600_resume(struct device *dev)
 		goto out_unlock;
 
 	/* restore FIFO data streaming */
-	if (st->fifo.on)
+	if (st->fifo.on) {
+		inv_sensors_timestamp_reset(&gyro_st->ts);
+		inv_sensors_timestamp_reset(&accel_st->ts);
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
+	}
 
 out_unlock:
 	mutex_unlock(&st->lock);


