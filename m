Return-Path: <stable+bounces-20187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86492854C9F
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E9E1F224E2
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B85B696;
	Wed, 14 Feb 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWGHxuAx"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2943157
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924383; cv=none; b=LmTFJM4jvdpegSmZIuu0KK5HtCcUCCa/jpN8vT1uVT5wPrbfYigeRBoVYxT7EHzgP2qEHRiATTZ+eksTTzD3NoFgj/JXQQtteXODTJfrsTcAMGUyXF/talgWTc1AQ+B9h2hfbbLWvUy9BcuKcepPoKm41i3L5r3XLnVcUOLArjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924383; c=relaxed/simple;
	bh=h88HO2OWx/AtF/xfM7rJmwjE6a9Imyg78b1nmdXZqhU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=qWmcTb5kKvXjAyZ3fGu5GYvu/5WlwtUrb8O/LbVATYnX0k47NUivOfemEzjFedOS+VmeJIU+geQHQh8r5INcDAcDloZfwPOUtYUaFwtIkyY+xbo2dgw5Q5BtnwPnxuFKFwnGvIuoFEM4m/h8rEZUMuduZ5bT5H0lbC6cVU8hDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWGHxuAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA583C433F1;
	Wed, 14 Feb 2024 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924383;
	bh=h88HO2OWx/AtF/xfM7rJmwjE6a9Imyg78b1nmdXZqhU=;
	h=Subject:To:From:Date:From;
	b=MWGHxuAxlumN1SI6Ti04j7mw2tnibZ6OPyRqmdnOCXfUIdg4CS4y2fiaVjwv2otFg
	 01OCltqe8dLiP6JFnkuiPuhOYp226KrUlmSekGHKx/TuOtlkwP38+h93TIafP6pQ4o
	 nVZDuSKWuPv3J7Ta3VCexOTYFmSUJ0+hvwbTfReo=
Subject: patch "iio: imu: bno055: serdev requires REGMAP" added to char-misc-linus
To: rdunlap@infradead.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andrea.merello@iit.it,jic23@kernel.org,lars@metafoo.de
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:05 +0100
Message-ID: <2024021404-renounce-answering-8a31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: bno055: serdev requires REGMAP

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 35ec2d03b282a939949090bd8c39eb37a5856721 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 10 Jan 2024 10:56:11 -0800
Subject: iio: imu: bno055: serdev requires REGMAP

There are a ton of build errors when REGMAP is not set, so select
REGMAP to fix all of them.

Examples (not all of them):

../drivers/iio/imu/bno055/bno055_ser_core.c:495:15: error: variable 'bno055_ser_regmap_bus' has initializer but incomplete type
  495 | static struct regmap_bus bno055_ser_regmap_bus = {
../drivers/iio/imu/bno055/bno055_ser_core.c:496:10: error: 'struct regmap_bus' has no member named 'write'
  496 |         .write = bno055_ser_write_reg,
../drivers/iio/imu/bno055/bno055_ser_core.c:497:10: error: 'struct regmap_bus' has no member named 'read'
  497 |         .read = bno055_ser_read_reg,
../drivers/iio/imu/bno055/bno055_ser_core.c: In function 'bno055_ser_probe':
../drivers/iio/imu/bno055/bno055_ser_core.c:532:18: error: implicit declaration of function 'devm_regmap_init'; did you mean 'vmem_map_init'? [-Werror=implicit-function-declaration]
  532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
../drivers/iio/imu/bno055/bno055_ser_core.c:532:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
../drivers/iio/imu/bno055/bno055_ser_core.c: At top level:
../drivers/iio/imu/bno055/bno055_ser_core.c:495:26: error: storage size of 'bno055_ser_regmap_bus' isn't known
  495 | static struct regmap_bus bno055_ser_regmap_bus = {

Fixes: 2eef5a9cc643 ("iio: imu: add BNO055 serdev driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrea Merello <andrea.merello@iit.it>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240110185611.19723-1-rdunlap@infradead.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/bno055/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index 83e53acfbe88..c7f5866a177d 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -8,6 +8,7 @@ config BOSCH_BNO055
 config BOSCH_BNO055_SERIAL
 	tristate "Bosch BNO055 attached via UART"
 	depends on SERIAL_DEV_BUS
+	select REGMAP
 	select BOSCH_BNO055
 	help
 	  Enable this to support Bosch BNO055 IMUs attached via UART.
-- 
2.43.1



