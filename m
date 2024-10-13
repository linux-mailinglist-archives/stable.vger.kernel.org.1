Return-Path: <stable+bounces-83632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBC99BA01
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA15B21019
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3197146D6A;
	Sun, 13 Oct 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLwj58m8"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C11DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833201; cv=none; b=tKHWUqr66gmrazIGFjyqEDqjitnOJpwSTmgrF3GGqJPJ7QzUqf8e76cCoDTIKBf03vnPEy6dlxQfb9fAZuDMxqtkrWMeiSP0MrbnrrDHn+klLX8tWBLOKwPMPX2C8bxeqgvUvdfN9r4p/U111EILNjEo9AgtOIhhaZbR0r7G758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833201; c=relaxed/simple;
	bh=AKLxQBZ25N602YQG3EPzRDhZwDdgkqdaYb8c8tjKyCs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=k2KrW0kB/rWtuX+3tBJCswVw1jg2xs/Is9ltxOkmVVHy7nfSMy0YmmQXKZ4xZFM8MwXipJsYAGoeqNTqkCDGCcU9m7PWAAngHt6XXExRyoxK8PMRK7THDn/BFdvrboqRlAb/qlvNnRmyYfDi3jURwBmbLojNwnALZpm0sssFZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLwj58m8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17209C4CEC5;
	Sun, 13 Oct 2024 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833201;
	bh=AKLxQBZ25N602YQG3EPzRDhZwDdgkqdaYb8c8tjKyCs=;
	h=Subject:To:From:Date:From;
	b=gLwj58m8DoxsS+bH4p7KhbBz7W824YYvA2BPECMt7f+kXEV0qqmuWJs4xAx3M054D
	 SucrIsRKA7Oiq7TOi8zf4vuL+JA1s47rSiRQGDTI8eWVWoLxLc8/cPQl8g8ejOUI3b
	 Xi24BOjc4FHg+HAWwFqd+INtdUdof/mWR1jZCCu0=
Subject: patch "iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:00 +0200
Message-ID: <2024101300-pushover-fiscally-c61c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 62ec3df342cca6a8eb7ed33fd4ac8d0fbfcb9391 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:54 +0200
Subject: iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 885b9790c25a ("drivers:iio:dac:ad5766.c: Add trigger buffer")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-8-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 9d4600ce0427..bb6cb9af9ed9 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -254,6 +254,8 @@ config AD5764
 config AD5766
 	tristate "Analog Devices AD5766/AD5767 DAC driver"
 	depends on SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD5766, AD5767
 	  Digital to Analog Converter.
-- 
2.47.0



