Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021CC713C29
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjE1TFe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjE1TFd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:05:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB89C4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BD7B618CB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E90C433EF;
        Sun, 28 May 2023 19:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300731;
        bh=jq5FADlxi+1fPQ6+CA0d5jznCsi95ODlbNPvNmdqOBQ=;
        h=Subject:To:From:Date:From;
        b=q/uwhuBbA+rC6UO9UzV/g5uhISvIprdkluvQsbUy+cAOweBETikX4xL4sSNusCIFB
         DAw0KxnSUvC+MTmH/hekiVot4xDyxWa3RVuHc2+7NxIIoYoiTV91hNm/LELPL2KmB+
         u8GCPmgNMIxbqJzAFqjnYat09XtgIgYNBh0xRasM=
Subject: patch "iio: imu: inv_icm42600: fix timestamp reset" added to char-misc-linus
To:     jean-baptiste.maneyrol@tdk.com, Jonathan.Cameron@huawei.com,
        stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:45 +0100
Message-ID: <2023052845-theatrics-moonrise-2102@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: imu: inv_icm42600: fix timestamp reset

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From bbaae0c79ebd49f61ad942a8bf9e12bfc7f821bb Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Tue, 9 May 2023 15:22:02 +0000
Subject: iio: imu: inv_icm42600: fix timestamp reset

Timestamp reset is not done in the correct place. It must be done
before enabling buffer. The reason is that interrupt timestamping
is always happening when the chip is on, even if the
corresponding sensor is off. When the sensor restarts, timestamp
is wrong if you don't do a reset first.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230509152202.245444-1-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 99576b2c171f..32d7f8364230 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -275,9 +275,14 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(dev);
 
+	mutex_lock(&st->lock);
+	inv_icm42600_timestamp_reset(ts);
+	mutex_unlock(&st->lock);
+
 	return 0;
 }
 
@@ -375,7 +380,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
-	struct inv_icm42600_timestamp *ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int sleep_temp = 0;
 	unsigned int sleep_sensor = 0;
@@ -385,11 +389,9 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (indio_dev == st->indio_gyro) {
 		sensor = INV_ICM42600_SENSOR_GYRO;
 		watermark = &st->fifo.watermark.gyro;
-		ts = iio_priv(st->indio_gyro);
 	} else if (indio_dev == st->indio_accel) {
 		sensor = INV_ICM42600_SENSOR_ACCEL;
 		watermark = &st->fifo.watermark.accel;
-		ts = iio_priv(st->indio_accel);
 	} else {
 		return -EINVAL;
 	}
@@ -417,8 +419,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (!st->fifo.on)
 		ret = inv_icm42600_set_temp_conf(st, false, &sleep_temp);
 
-	inv_icm42600_timestamp_reset(ts);
-
 out_unlock:
 	mutex_unlock(&st->lock);
 
-- 
2.40.1


