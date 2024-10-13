Return-Path: <stable+bounces-83637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA0A99BA05
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65591F21667
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD85146D78;
	Sun, 13 Oct 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v+mRyfxu"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A314600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833217; cv=none; b=FAh0ivKlPV5m7yfX0ZWzqOJhSJWUerXsCzQkXPW6Tq7VzfYtBOCx9t04U2RpNdh5t/vuUZaw5pvVu1eaT234+Xdh3LfQMq/RYjI5/yCe60riVy05bss+UlQ+Yu07dQOS2TQ8Khhs+Twj9w3+lJTJZHIXJ5UmQPXo1hsZEPDY8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833217; c=relaxed/simple;
	bh=EfDhPMRhv9XL0H9bQbHL7WMAYO7LJ9+KbyRdDV7DTfw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=hUIHNMryLWZxWi4w7YBUrDI6o5nNbzJ7FB9CqBZeOCgHGLvkCt6O9Eqh3OJMe+FyU+OPYuvK63kNWsjy88Fhdzz0ZMqpo6JWKogsquPBsAD5ZSavo+IW27ZhkymGv0i1/FAUEDyZmj9QxZp/w6PiK0uGDnZgYJavgXbw/pXemrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v+mRyfxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E7C4CEC5;
	Sun, 13 Oct 2024 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833217;
	bh=EfDhPMRhv9XL0H9bQbHL7WMAYO7LJ9+KbyRdDV7DTfw=;
	h=Subject:To:From:Date:From;
	b=v+mRyfxuHrGSqmVEGBmnRFeyrI9daTJXpMgK4D94P4cULfgLMBifN5swvmTwsvuG2
	 I2qtoGkTx/MskG0X8MkjLBl8+syju2RrJCfnYBrKMAeASX/DHQ2uJlF6FQ2gBn1TDV
	 9qwJC+vJkovyuRU+CyP/7YEtSis2JRT8DINDycaY=
Subject: patch "iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:03 +0200
Message-ID: <2024101303-batch-iciness-4359@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 75461a0b15d7c026924d0001abce0476bbc7eda8 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:59 +0200
Subject: iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 16b05261537e ("mb1232.c: add distance iio sensor with i2c")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-13-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 31c679074b25..a562a78b7d0d 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -86,6 +86,8 @@ config LIDAR_LITE_V2
 config MB1232
 	tristate "MaxSonar I2CXL family ultrasonic sensors"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y to build a driver for the ultrasonic sensors I2CXL of
 	  MaxBotix which have an i2c interface. It can be used to measure
-- 
2.47.0



