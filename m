Return-Path: <stable+bounces-73860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593F9706D2
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AED31C20D29
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A014D715;
	Sun,  8 Sep 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NArb6u/M"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529536B0D
	for <Stable@vger.kernel.org>; Sun,  8 Sep 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794698; cv=none; b=aftWRgDtrAhXCL5N/JCCq2WaPsJg2JtbFK4Wy9GiRqK7RCqnXm7ayroeOnZLMSU2oOAd5cNc3mEdGB8BjUcQ2AjWfZE/1qBReBliTWWvyvhlA+J6GgkXj30id+AwI51lAoKJAzTWk3wsb4eNMEsekNWwFrNgTuRSB6weLVdZ0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794698; c=relaxed/simple;
	bh=rVjUJ+bo00Yw1FjKOIcWOVsLkGG5lWzM4zSpucrNWBs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=UAiXukp9rgp2Zn+V/ZctXSlLf03ChkId1/uu6w2cW/YInYPDH3TAophChwin24AH5V17lFEvOnavNaIxOstOGglrF9AUDV653Uzdlc+0sbcsZ9TegzhBrDKwwYEz5FSd60hnnrXok7FPKltis6xcD3Hg3O0L87M2P09CZyUNVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NArb6u/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47FDC4CEC3;
	Sun,  8 Sep 2024 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725794698;
	bh=rVjUJ+bo00Yw1FjKOIcWOVsLkGG5lWzM4zSpucrNWBs=;
	h=Subject:To:From:Date:From;
	b=NArb6u/MSba4E20MYkKhDf3Vc8YGvZ5Vg3G9V2UaPrcRk29/ZrtqlGq3dJuIU67aL
	 cW4x5uK25fmOIrl0z/Nb6xIMSgKK4kbVu0Ft6KTt0OCCqt2Mh7ey5WpTTd+OfxDu1t
	 SK7mjtKI+cj9/F8y3txPSrdxJ2KK1GcEaTY5Ceq8=
Subject: patch "iio: magnetometer: ak8975: Fix reading for ak099xx sensors" added to char-misc-testing
To: barnabas.czeman@mainlining.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:24:44 +0200
Message-ID: <2024090843-epidermal-lubricate-356a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: magnetometer: ak8975: Fix reading for ak099xx sensors

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 129464e86c7445a858b790ac2d28d35f58256bbe Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
Date: Mon, 19 Aug 2024 00:29:40 +0200
Subject: iio: magnetometer: ak8975: Fix reading for ak099xx sensors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move ST2 reading with overflow handling after measurement data
reading.
ST2 register read have to be read after read measurment data,
because it means end of the reading and realease the lock on the data.
Remove ST2 read skip on interrupt based waiting because ST2 required to
be read out at and of the axis read.

Fixes: 57e73a423b1e ("iio: ak8975: add ak09911 and ak09912 support")
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Link: https://patch.msgid.link/20240819-ak09918-v4-2-f0734d14cfb9@mainlining.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/ak8975.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 67d5d1f2402f..1d5f79b7005b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -696,22 +696,8 @@ static int ak8975_start_read_axis(struct ak8975_data *data,
 	if (ret < 0)
 		return ret;
 
-	/* This will be executed only for non-interrupt based waiting case */
-	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST2]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST2\n");
-			return ret;
-		}
-		if (ret & (data->def->ctrl_masks[ST2_DERR] |
-			   data->def->ctrl_masks[ST2_HOFL])) {
-			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
+	/* Return with zero if the data is ready. */
+	return !data->def->ctrl_regs[ST1_DRDY];
 }
 
 /* Retrieve raw flux value for one of the x, y, or z axis.  */
@@ -738,6 +724,20 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret < 0)
 		goto exit;
 
+	/* Read out ST2 for release lock on measurment data. */
+	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error in reading ST2\n");
+		goto exit;
+	}
+
+	if (ret & (data->def->ctrl_masks[ST2_DERR] |
+		   data->def->ctrl_masks[ST2_HOFL])) {
+		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	mutex_unlock(&data->lock);
 
 	pm_runtime_mark_last_busy(&data->client->dev);
-- 
2.46.0



