Return-Path: <stable+bounces-83638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47DB99BA07
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776B2281BF5
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DC146D6A;
	Sun, 13 Oct 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0e73fMi8"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059C14600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833221; cv=none; b=FQqgCLCdCK1OMveNYgOLClXb0D6ih50GMJJ+DmbHdcaXeKJi172kHZsVgJ7STeKhS/5Olm+SvHzoPbAaYjt7JdBOyzRW8HCOYVnRjNqfg8mUTjAX2sGf3L5haDYaWXJvyyrRTaWMUUHGKuHjL3aZt8Q9Ib5SKdlYuSqAPS2CHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833221; c=relaxed/simple;
	bh=rYmM6GT4xnGw94FcYcVApWWQooAdU6j7lx3SVDb997Y=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=gT2s6XHv1jNO6MAiL+crBiIJNxm4JNefJRGKUvnzqVCuoVqUgVFgRfSdLa+a0HpFawAHFkgA+GvmNZVehB7j1ej6Oc6OnaUIwpbLkC7nsXbEoh4LUCv8OWgPNFXDo7e6qLhzTfoxtVGKLftfVRQyFm8Uwb+fLAoYSZ6SUcEezk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0e73fMi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D94C4CEC5;
	Sun, 13 Oct 2024 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833220;
	bh=rYmM6GT4xnGw94FcYcVApWWQooAdU6j7lx3SVDb997Y=;
	h=Subject:To:From:Date:From;
	b=0e73fMi86DolGcl+5ptVi/ErajqkTVfCJc2zpR5zAhBaLWWY/Ns/qZ1APqHG3Lfdg
	 Cwe97t+EkDc1POtlOd39pLvBvresyGqZvjOfY/1t3JLBM5yG07u0wqBwJ2rrkGKjZP
	 o62nt5HNUcaYm1SyIEeYXyX90mWP55y5iqe4szj4=
Subject: patch "iio: resolver: ad2s1210 add missing select REGMAP in Kconfig" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:03 +0200
Message-ID: <2024101303-professor-reformer-172a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: resolver: ad2s1210 add missing select REGMAP in Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 17a99360184cf02b2b3bc3c1972e777326bfa63b Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 18:49:33 +0200
Subject: iio: resolver: ad2s1210 add missing select REGMAP in Kconfig

This driver makes use of regmap, but does not select the required
module.
Add the missing 'select REGMAP'.

Fixes: b3689e14415a ("staging: iio: resolver: ad2s1210: use regmap for config registers")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-1-4019453f8c33@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/resolver/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
index 424529d36080..640aef3e5c94 100644
--- a/drivers/iio/resolver/Kconfig
+++ b/drivers/iio/resolver/Kconfig
@@ -31,6 +31,7 @@ config AD2S1210
 	depends on SPI
 	depends on COMMON_CLK
 	depends on GPIOLIB || COMPILE_TEST
+	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices spi resolver
 	  to digital converters, ad2s1210, provides direct access via sysfs.
-- 
2.47.0



