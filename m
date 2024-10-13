Return-Path: <stable+bounces-83641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D799BA0A
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5739F2818B6
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07787146D6A;
	Sun, 13 Oct 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGUkHjTB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15714600F
	for <stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833230; cv=none; b=UOX+8aDSBB/mezwncEh/TcpvcH23aeL1qUf1DUSc7VZ6YhDngdHubK5VQleBveUGGswiHGDzZ8cPwfadqJ0T737adyjVKbT9ayxF/qJdtZsiZULI9d3oj+1M8K7yYz63iDVQhYcO0SKhSO0xkc/pMc0aOZcCWTVKaTywHVnEYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833230; c=relaxed/simple;
	bh=/Lt4xbXLTa4Aj+ob4GIh3MI/V0JbjNydiDanmdnkpOo=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=SMwhPWVdD0o2IiC9bL29O41MSC6Y+x5xDR1KHRIAz96Vie8j/+JVZ1OeyrwrUqbwr9/WYNKgf7BgGq852e8WTDkt5MKpide+wgJSanvpKQQkCh/eM6Yb1mK17dHyjRODLckZZNnbc6Wf0eSlNNd5XGPXLUGJw9RaDl3lCKEXD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGUkHjTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4480CC4CEC5;
	Sun, 13 Oct 2024 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833230;
	bh=/Lt4xbXLTa4Aj+ob4GIh3MI/V0JbjNydiDanmdnkpOo=;
	h=Subject:To:From:Date:From;
	b=PGUkHjTB+kaCgTode2yjXJzA2rlxeCYJtgK5ykFMFAghBUOl8sxA18qvsFpueVF+x
	 27iNND2EAYOfQqCJ2Zm9gxtyMAqZG+yQ5jzYcA8LgVpmOalDk7gqabcjv00wvAuT1H
	 hzVHvfCkqLb4uxmy0a/lZsxpCQ4PVQLlXufOO84A=
Subject: patch "iio: resolver: ad2s1210: add missing select (TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,dlechner@baylibre.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:04 +0200
Message-ID: <2024101304-mushy-snitch-1a21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: resolver: ad2s1210: add missing select (TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 2caa67b6251c802e0c2257920b225c765e86bf4a Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 18:49:34 +0200
Subject: iio: resolver: ad2s1210: add missing select (TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 128b9389db0e ("staging: iio: resolver: ad2s1210: add triggered buffer support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-2-4019453f8c33@gmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/resolver/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
index 640aef3e5c94..de2dee3832a1 100644
--- a/drivers/iio/resolver/Kconfig
+++ b/drivers/iio/resolver/Kconfig
@@ -32,6 +32,8 @@ config AD2S1210
 	depends on COMMON_CLK
 	depends on GPIOLIB || COMPILE_TEST
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices spi resolver
 	  to digital converters, ad2s1210, provides direct access via sysfs.
-- 
2.47.0



