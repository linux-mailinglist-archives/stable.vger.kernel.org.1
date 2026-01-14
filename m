Return-Path: <stable+bounces-208352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F096D1E609
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5878B3005022
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFCA38A288;
	Wed, 14 Jan 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Vi64/UQ"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D239524A
	for <Stable@vger.kernel.org>; Wed, 14 Jan 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389951; cv=none; b=hNYKSVnbDCpat8/FmA6Ef8etfy8Irr4BLJyQskZEeW1FUaMirliRy0YRTLfGfI0+K8NH6gpZfGCBWU3LxxLHlVESXdz1W9Mf2+Kyx+miVi3rGs3iFC25wtxqIj13WSgT51LSiRs7+zR7GKlIWHQhs7gEGmIWGhVGR2mq9ZN4rPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389951; c=relaxed/simple;
	bh=EBTiIbxSKnuLpjqCnxolAGwbOb/jc4ZLRpoFVyYJKlY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=bRULDVfSFue6f6eLrj4hqRP1l9f57m4hyH/PSIIDivkd5WNMtwkhM7xZV8BFKVkToRLu5GfKEg6xQrWgjXulGXszSQU3xtQ++tuhDVmSlJT0UuEx8W2BOk7XqISrJhhXb3Ip/avxEbBZdwOWVdvKcUPUdwwaIyu6gNeMFg9dOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Vi64/UQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976FEC16AAE;
	Wed, 14 Jan 2026 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768389951;
	bh=EBTiIbxSKnuLpjqCnxolAGwbOb/jc4ZLRpoFVyYJKlY=;
	h=Subject:To:From:Date:From;
	b=0Vi64/UQ7f/dp4ei2jVkFuy3UQpY0wr9iEkKJjRd8irmepn9k+ld2grPRJ3jEpL6t
	 w3/AV7reW2mk0wFnd4qtAk6ARkY2NPdoJgGbpd2+EBPt5Kq/l9b/waAK/AXMeKlmYc
	 vsthQhF4fvFoKC3eW1n36UyPq6nr98cn2mTy7jEI=
Subject: patch "iio: accel: iis328dq: fix gain values" added to char-misc-linus
To: markus.koeniger@liebherr.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dimitri.fedrau@liebherr.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Jan 2026 12:25:07 +0100
Message-ID: <2026011407-ransack-fog-b109@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: accel: iis328dq: fix gain values

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From b8f15d1df2e73322e2112de21a4a7f3553c7fb60 Mon Sep 17 00:00:00 2001
From: Markus Koeniger <markus.koeniger@liebherr.com>
Date: Wed, 7 Jan 2026 16:32:18 +0100
Subject: iio: accel: iis328dq: fix gain values

The sensors IIS328DQ and H3LIS331DL share one configuration but
H3LIS331DL has different gain parameters, configs therefore
need to be split up.
The gain parameters for the IIS328DQ are 0.98, 1.95 and 3.91,
depending on the selected measurement range.

See sensor manuals, chapter 2.1 "mechanical characteristics",
parameter "Sensitivity".

Datasheet: https://www.st.com/resource/en/datasheet/iis328dq.pdf
Datasheet: https://www.st.com/resource/en/datasheet/h3lis331dl.pdf
Fixes: 46e33707fe95 ("iio: accel: add support for IIS328DQ variant")
Reviewed-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Signed-off-by: Markus Koeniger <markus.koeniger@liebherr.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/st_accel_core.c | 72 ++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index a7961c610ed2..1a9447c81b0f 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -517,7 +517,6 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = H3LIS331DL_ACCEL_DEV_NAME,
-			[1] = IIS328DQ_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
@@ -584,6 +583,77 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x32,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = IIS328DQ_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0x18,
+			.odr_avl = {
+				{ .hz = 50, .value = 0x00, },
+				{ .hz = 100, .value = 0x01, },
+				{ .hz = 400, .value = 0x02, },
+				{ .hz = 1000, .value = 0x03, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0x20,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = 0x30,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_100G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(980),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_200G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(1950),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_400G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(3910),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x23,
+			.mask = 0x80,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x02,
+			},
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
+			.addr_ihl = 0x22,
+			.mask_ihl = 0x80,
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
 	{
 		/* No WAI register present */
 		.sensors_supported = {
-- 
2.52.0



