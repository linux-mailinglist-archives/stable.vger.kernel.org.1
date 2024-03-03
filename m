Return-Path: <stable+bounces-25794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224986F3E7
	for <lists+stable@lfdr.de>; Sun,  3 Mar 2024 08:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB151F22051
	for <lists+stable@lfdr.de>; Sun,  3 Mar 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C98F40;
	Sun,  3 Mar 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cwJaNKUd"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A81877
	for <Stable@vger.kernel.org>; Sun,  3 Mar 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709451359; cv=none; b=B81kWOvHzcd3XoqNfOsw+7o1ye195aMxC9ULWXrCJbNHbHGOcEW8Yew5uk5o2iX/3HCKhM1/ws3PbrPR0AhVUhEmNq6K5GO7I/VPxCjrY20VpUkXBHTINZaez0YyEbfdWBIfgiPm0OC4hsb6lCoUpBWfJ5y8jV9q3DZQICqcQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709451359; c=relaxed/simple;
	bh=L+kBnoprjwOiWawwAgAVYkdK4YCX2oCd+GY6ExsuySs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=uITog5TdF0mrEfGRHqjZfBd8rHE9bniazx0kNtgOJYmXYWxge++bsT12gKU02ewGCh4aijmEAOXr5rPOWHHIrvp0qST8CuxMOorlGQFZ3OzHy0xShc0JD81WsE4yWSIuyAzzXyU0vUhVPzQIH1qbi7eplaPmP10BgqvJCFpcoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cwJaNKUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7604C433C7;
	Sun,  3 Mar 2024 07:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709451359;
	bh=L+kBnoprjwOiWawwAgAVYkdK4YCX2oCd+GY6ExsuySs=;
	h=Subject:To:From:Date:From;
	b=cwJaNKUdOfVrdml1NiufLpoSaAWN/armMnp0OLi2MEXRgcs9Qb4PQH8PpU6fAN5PC
	 evkBvfxVVsvPUt55nN5OtyTxOuYLTUK2Ar8VeMKgqAHITlWsu9owaHkCZQSfxdWexp
	 TPPfzVWlwrX0yQjoHLegWSe+pNaMb5aOR3K/p6iY=
Subject: patch "iio: accel: adxl367: fix I2C FIFO data register" added to char-misc-linus
To: demonsingur@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Mar 2024 08:35:43 +0100
Message-ID: <2024030343-hassle-deviator-2550@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: accel: adxl367: fix I2C FIFO data register

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 11dadb631007324c7a8bcb2650eda88ed2b9eed0 Mon Sep 17 00:00:00 2001
From: Cosmin Tanislav <demonsingur@gmail.com>
Date: Wed, 7 Feb 2024 05:36:51 +0200
Subject: iio: accel: adxl367: fix I2C FIFO data register

As specified in the datasheet, the I2C FIFO data register is
0x18, not 0x42. 0x42 was used by mistake when adapting the
ADXL372 driver.

Fix this mistake.

Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240207033657.206171-2-demonsingur@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl367_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
index b595fe94f3a3..62c74bdc0d77 100644
--- a/drivers/iio/accel/adxl367_i2c.c
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -11,7 +11,7 @@
 
 #include "adxl367.h"
 
-#define ADXL367_I2C_FIFO_DATA	0x42
+#define ADXL367_I2C_FIFO_DATA	0x18
 
 struct adxl367_i2c_state {
 	struct regmap *regmap;
-- 
2.44.0



