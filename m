Return-Path: <stable+bounces-83628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBA99B9FD
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CD51F21650
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B6146D6E;
	Sun, 13 Oct 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oqMlgtcV"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62C1DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833189; cv=none; b=uwDgPLR+6RQWITKOeO4UYSc2rVROPYqi2yywgi7WvgdD66o9hgFkgFikxHWeHOZ7TovVJ+nQ5Cqivbw5u1LXA1bUINyfw/RitAXV64vT51KC6kJPG5xUcYs3URN+edy/5+ZpTBn2f79QqXkSywSOg5+GvG3DZUKb7RDElaESpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833189; c=relaxed/simple;
	bh=TIiFtwWhzKovxtT8wH8qp02GtKqBS2Z7yza09v92qLs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=OhJpLDJA4wNFarvw3pr1FsNnBpV0/UIhL19a609ZORm+ccIvpcPYfGZ7ad1ZYmvuRi3Zvsx5g3T0hZxFHr8oUcNQKmHtv00eKwbJH/RVVWw5CbVU2p1vEzHK2jpplt1JkKicMbyCwZo2PSr4jtBLD7pHfIlc2RpPV4g73cZOSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oqMlgtcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A956C4CEC5;
	Sun, 13 Oct 2024 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833188;
	bh=TIiFtwWhzKovxtT8wH8qp02GtKqBS2Z7yza09v92qLs=;
	h=Subject:To:From:Date:From;
	b=oqMlgtcVFWXxJHGe9Ig3DDamNc1qDEFpOQ9PqEZOMLeIdoOlSRHvypHS3/10y23cc
	 vSmTI75AiWOS90lAGsopgQ5/CNZHhJHFX58qfKYKoos1TseP5pTc4l/DT2HB/3fKg2
	 /rsKyiM/TIRN86vd1Bv2MJ5apt2BVKHrSGWWD9/4=
Subject: patch "iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,mazziesaccount@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:25:58 +0200
Message-ID: <2024101357-headrest-ethics-4de2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 96666f05d11acf0370cedca17a4c3ab6f9554b35 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:47 +0200
Subject: iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-1-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 516c1a8e4d56..8c3f7cf55d5f 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -447,6 +447,8 @@ config IIO_ST_ACCEL_SPI_3AXIS
 
 config IIO_KX022A
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config IIO_KX022A_SPI
 	tristate "Kionix KX022A tri-axis digital accelerometer SPI interface"
-- 
2.47.0



