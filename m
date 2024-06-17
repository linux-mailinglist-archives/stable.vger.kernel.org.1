Return-Path: <stable+bounces-52588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29190B904
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17621F2188B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6BF19B5AC;
	Mon, 17 Jun 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJ0DgBj+"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB019B5A7
	for <Stable@vger.kernel.org>; Mon, 17 Jun 2024 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647386; cv=none; b=Mo28Q+nnPjoinyc6UOevmicgpw13bYsE8OD3CWIn1He8ZI9MdYQsTVproMZZveuSQuZ4pNAi1JR5JrIYeSS5ClL8gU7KiAJxuUUaAGs6Z8ySVJhVZJZfHj0fEf5xbkt2yQPP2P8iE1+u6Wi+L9LtaqIcokQzUIuwBxyxtfI8/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647386; c=relaxed/simple;
	bh=E7pdM4gcXFw/Pv1dWl+V0NYkFjl79bxwdBqVkFAafr0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=eV0elNdgHIFhD2Q9oeob63yhNXliUq+t55657OvCsYoqKGU901QINlGnTpmao9jrHsbC4n02SXW8qfgfQXDFJWyuICUT3dtqJcd4rXUr6GKsJv/hwE6k6LMJNYObYb/RHxdcD84WHos8LdhPh6c7ujWZqPvM4dUU+1naxqKACYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJ0DgBj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3692C4AF1C;
	Mon, 17 Jun 2024 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647386;
	bh=E7pdM4gcXFw/Pv1dWl+V0NYkFjl79bxwdBqVkFAafr0=;
	h=Subject:To:From:Date:From;
	b=vJ0DgBj+yOpX7RnsQGt8UlaYJ6/X0HzsEmAIK+JKTgnwJjgEy6x55rp2hG9GPtxS0
	 1J5+PKh4814WQ1HAKhNBhPZ01ZEqrIELjfbzTe/3Z5X2gZqfCqVVdjnFH8obd0h8Om
	 Lt3nkql2PBWfjpVfNkedWmeAc3IiLW08fOaGyCVA=
Subject: patch "iio: chemical: bme680: Fix overflows in compensate() functions" added to char-misc-linus
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:02:43 +0200
Message-ID: <2024061742-pastrami-thrift-89d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: bme680: Fix overflows in compensate() functions

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From fdd478c3ae98c3f13628e110dce9b6cfb0d9b3c8 Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 6 Jun 2024 23:22:55 +0200
Subject: iio: chemical: bme680: Fix overflows in compensate() functions

There are cases in the compensate functions of the driver that
there could be overflows of variables due to bit shifting ops.
These implications were initially discussed here [1] and they
were mentioned in log message of Commit 1b3bd8592780 ("iio:
chemical: Add support for Bosch BME680 sensor").

[1]: https://lore.kernel.org/linux-iio/20180728114028.3c1bbe81@archlinux/

Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240606212313.207550-4-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/bme680_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 812829841733..5db48f6d646c 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -342,10 +342,10 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
 	if (!calib->par_t2)
 		bme680_read_calib(data, calib);
 
-	var1 = (adc_temp >> 3) - (calib->par_t1 << 1);
+	var1 = (adc_temp >> 3) - ((s32)calib->par_t1 << 1);
 	var2 = (var1 * calib->par_t2) >> 11;
 	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
-	var3 = (var3 * (calib->par_t3 << 4)) >> 14;
+	var3 = (var3 * ((s32)calib->par_t3 << 4)) >> 14;
 	data->t_fine = var2 + var3;
 	calc_temp = (data->t_fine * 5 + 128) >> 8;
 
@@ -368,9 +368,9 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var1 = (data->t_fine >> 1) - 64000;
 	var2 = ((((var1 >> 2) * (var1 >> 2)) >> 11) * calib->par_p6) >> 2;
 	var2 = var2 + (var1 * calib->par_p5 << 1);
-	var2 = (var2 >> 2) + (calib->par_p4 << 16);
+	var2 = (var2 >> 2) + ((s32)calib->par_p4 << 16);
 	var1 = (((((var1 >> 2) * (var1 >> 2)) >> 13) *
-			(calib->par_p3 << 5)) >> 3) +
+			((s32)calib->par_p3 << 5)) >> 3) +
 			((calib->par_p2 * var1) >> 1);
 	var1 = var1 >> 18;
 	var1 = ((32768 + var1) * calib->par_p1) >> 15;
@@ -388,7 +388,7 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var3 = ((press_comp >> 8) * (press_comp >> 8) *
 			(press_comp >> 8) * calib->par_p10) >> 17;
 
-	press_comp += (var1 + var2 + var3 + (calib->par_p7 << 7)) >> 4;
+	press_comp += (var1 + var2 + var3 + ((s32)calib->par_p7 << 7)) >> 4;
 
 	return press_comp;
 }
@@ -414,7 +414,7 @@ static u32 bme680_compensate_humid(struct bme680_data *data,
 		 (((temp_scaled * ((temp_scaled * calib->par_h5) / 100))
 		   >> 6) / 100) + (1 << 14))) >> 10;
 	var3 = var1 * var2;
-	var4 = calib->par_h6 << 7;
+	var4 = (s32)calib->par_h6 << 7;
 	var4 = (var4 + ((temp_scaled * calib->par_h7) / 100)) >> 4;
 	var5 = ((var3 >> 14) * (var3 >> 14)) >> 10;
 	var6 = (var4 * var5) >> 1;
-- 
2.45.2



