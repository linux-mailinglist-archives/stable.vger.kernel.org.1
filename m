Return-Path: <stable+bounces-25793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E986F3E6
	for <lists+stable@lfdr.de>; Sun,  3 Mar 2024 08:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D8E1F220C7
	for <lists+stable@lfdr.de>; Sun,  3 Mar 2024 07:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E68F40;
	Sun,  3 Mar 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="17eq9m3+"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB91877
	for <Stable@vger.kernel.org>; Sun,  3 Mar 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709451352; cv=none; b=WgNc1ZifQmOHb2m6PrxkZSeKVoSir1VS0NzH4+0YaAdNPsfimO8WqLTRfidwXqQUQI+odqb1hGl3eV2Wr0hY5HcFpQGCbn3oXtkF3Zsy1ZFppIrv12lwCT3yH2oWohCs4jN6XnJKwOEdvEFAJPy2HrxzjMrHTmwkeqtTjdlQwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709451352; c=relaxed/simple;
	bh=Dy/YM/pxUOzyYV4GOMwW8wHsjMkFBat6hev5VG3TJPM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=nIOJ5RuPqtKDdAORGYDyavSkAQr0aeEic+PrMGunsGvuVnlGE9hTXcaG6l3xMcGSPPaCLLjzHy9imWMrAdHZtNRGG1UmxG6cV9P035wzf014HDbRpBE9dxrCXndFyPQ0+ul6SAzcNpRZzZOlUOAlLYh3LJQus6IW9hR/9srt5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=17eq9m3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8222FC433F1;
	Sun,  3 Mar 2024 07:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709451351;
	bh=Dy/YM/pxUOzyYV4GOMwW8wHsjMkFBat6hev5VG3TJPM=;
	h=Subject:To:From:Date:From;
	b=17eq9m3+YorGmGb482yvlvIwEYA7pNMJ7N9N+A5AA5GLF7RhmgIElz1LwhvLgsG23
	 BwyGBgQDRtNJwwvWMIGdNz+13LPHEwuhu+lnG8lkBZtRBYzqiFqslVOQkBDb7/jvc1
	 kyFVoOhplewhjwCe3ocWvWwgmnsDov2C5WyMGGUI=
Subject: patch "iio: accel: adxl367: fix DEVID read after reset" added to char-misc-linus
To: demonsingur@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Mar 2024 08:35:42 +0100
Message-ID: <2024030342-delegate-guise-f573@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: accel: adxl367: fix DEVID read after reset

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 1b926914bbe4e30cb32f268893ef7d82a85275b8 Mon Sep 17 00:00:00 2001
From: Cosmin Tanislav <demonsingur@gmail.com>
Date: Wed, 7 Feb 2024 05:36:50 +0200
Subject: iio: accel: adxl367: fix DEVID read after reset

regmap_read_poll_timeout() will not sleep before reading,
causing the first read to return -ENXIO on I2C, since the
chip does not respond to it while it is being reset.

The datasheet specifies that a soft reset operation has a
latency of 7.5ms.

Add a 15ms sleep between reset and reading the DEVID register,
and switch to a simple regmap_read() call.

Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240207033657.206171-1-demonsingur@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl367.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 90b7ae6d42b7..484fe2e9fb17 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1429,9 +1429,11 @@ static int adxl367_verify_devid(struct adxl367_state *st)
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read_poll_timeout(st->regmap, ADXL367_REG_DEVID, val,
-				       val == ADXL367_DEVID_AD, 1000, 10000);
+	ret = regmap_read(st->regmap, ADXL367_REG_DEVID, &val);
 	if (ret)
+		return dev_err_probe(st->dev, ret, "Failed to read dev id\n");
+
+	if (val != ADXL367_DEVID_AD)
 		return dev_err_probe(st->dev, -ENODEV,
 				     "Invalid dev id 0x%02X, expected 0x%02X\n",
 				     val, ADXL367_DEVID_AD);
@@ -1510,6 +1512,8 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	if (ret)
 		return ret;
 
+	fsleep(15000);
+
 	ret = adxl367_verify_devid(st);
 	if (ret)
 		return ret;
-- 
2.44.0



