Return-Path: <stable+bounces-194750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D7C5A573
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 161B74F003E
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39E29A9CD;
	Thu, 13 Nov 2025 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0lZjV1h"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CC2DE714
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073307; cv=none; b=JTjhiPTvSJjsuDNIZiLugCIMIaCuUugVJDySnobJX5ECWuHX2f/mY2Uu1OM2xNMOm3HRL20rzA2JQNIANZQuRgAM1i9b2+cBh04Mc93LCzdG5fqbPFWa/S06Zi72jPtDKkm9Vqu/zG2+efsBYkFyiiTZ+x7O4T0tV0FY8lbveDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073307; c=relaxed/simple;
	bh=Irszn9S1m7gTSU0B1dzBxLN9yi3DBjLYYN05bjnC2+A=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ZmByPnuW2x4C6kBFsUP27a+7EBSkQ339oOz2ptN+j1oH9n4s3T8nXfL+tvVX20dd4Tr3xB8LZI5Hg/oxA+sRC9WE51GIwu851fFVlpBkTmOcm7JIlU98zK54aV+uONeJzWR6XNpmim1j4NlrMndp/oaj8fFX4QVH6iHiaAeQc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0lZjV1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26152C4CEF5;
	Thu, 13 Nov 2025 22:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073307;
	bh=Irszn9S1m7gTSU0B1dzBxLN9yi3DBjLYYN05bjnC2+A=;
	h=Subject:To:From:Date:From;
	b=N0lZjV1hVMyIBp4oLuKk5/ooL4cFhW9C2ISqr5QNiQa/S+rxCqIAe8KWaJR6SAgT3
	 RkBByhtGuV+Gsxm87chZwjuiHij0JHuuOoW7bXLxVR7aiofUVBP1KsN0gD6K36Q5Je
	 awd8UT+e3AMomGbWcm9qhyrewt7H94AZc2fQ5uqo=
Subject: patch "iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields" added to char-misc-linus
To: flavra@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,lorenzo@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:53 -0500
Message-ID: <2025111353-wager-hurray-8861@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3af0c1fb1cdc351b64ff1a4bc06d491490c1f10a Mon Sep 17 00:00:00 2001
From: Francesco Lavra <flavra@baylibre.com>
Date: Fri, 17 Oct 2025 19:32:08 +0200
Subject: iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields

The `decimator` and `batch` fields of struct st_lsm6dsx_settings
are arrays indexed by sensor type, not by sensor hardware
identifier; moreover, the `batch` field is only used for the
accelerometer and gyroscope.
Change the array size for `decimator` from ST_LSM6DSX_MAX_ID to
ST_LSM6DSX_ID_MAX, and change the array size for `batch` from
ST_LSM6DSX_MAX_ID to 2; move the enum st_lsm6dsx_sensor_id
definition so that the ST_LSM6DSX_ID_MAX value is usable within
the struct st_lsm6dsx_settings definition.

Fixes: 801a6e0af0c6c ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..bca136392e99 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -252,6 +252,15 @@ struct st_lsm6dsx_event_settings {
 	u8 wakeup_src_x_mask;
 };
 
+enum st_lsm6dsx_sensor_id {
+	ST_LSM6DSX_ID_GYRO,
+	ST_LSM6DSX_ID_ACC,
+	ST_LSM6DSX_ID_EXT0,
+	ST_LSM6DSX_ID_EXT1,
+	ST_LSM6DSX_ID_EXT2,
+	ST_LSM6DSX_ID_MAX
+};
+
 enum st_lsm6dsx_ext_sensor_id {
 	ST_LSM6DSX_ID_MAGN,
 };
@@ -337,23 +346,14 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
-	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
-	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
+	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_ID_MAX];
+	struct st_lsm6dsx_reg batch[2];
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
 	struct st_lsm6dsx_event_settings event_settings;
 };
 
-enum st_lsm6dsx_sensor_id {
-	ST_LSM6DSX_ID_GYRO,
-	ST_LSM6DSX_ID_ACC,
-	ST_LSM6DSX_ID_EXT0,
-	ST_LSM6DSX_ID_EXT1,
-	ST_LSM6DSX_ID_EXT2,
-	ST_LSM6DSX_ID_MAX,
-};
-
 enum st_lsm6dsx_fifo_mode {
 	ST_LSM6DSX_FIFO_BYPASS = 0x0,
 	ST_LSM6DSX_FIFO_CONT = 0x6,
-- 
2.51.2



