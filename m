Return-Path: <stable+bounces-83644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBC99BA0E
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F44B21063
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6BF14600F;
	Sun, 13 Oct 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyLE5WsU"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F078146A63
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833240; cv=none; b=ucExOwXhmLLvU7ZlYHaXFLEcE7P2sqpoM5wEnxC4713WP+nyeUn/mnk8md1dp9FY1lN9x8MiptyPxtQvOJuxpaAzOFYEag5kq/D1xJWXjSM8bXXvrEWetmoLD/w9uVKoF+uvbscVZeH2U/LiY4GJVtVIPfVfJo22apEIHWGcBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833240; c=relaxed/simple;
	bh=pxzs/D3F5FfR6ckzphmyP6gcnQ8RMp71R0NHVDyVJs0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=CWxVSrkgXzQ2Tom8VN2EIZFuMJI0uOcz6vJvoi+4zuxism5X8R2wCYYlorJdORDA/UllaJ1rKcTc9BIa/qgF8shmf/K7pzZ/rHfxhlDFVN08h0we0/dEaSMaVSlhULlHJcPIlatZKAU9j+BDEkYR7I6daX2vRSHcI62GCMQBIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyLE5WsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF90C4CEC5;
	Sun, 13 Oct 2024 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833237;
	bh=pxzs/D3F5FfR6ckzphmyP6gcnQ8RMp71R0NHVDyVJs0=;
	h=Subject:To:From:Date:From;
	b=JyLE5WsUuMrOseIq0QWb8iPZ+EiZ/qVms4Bfqt4PcwrWR+3E+a+N685lsFxnKqvGy
	 jgXp8sofLvi+f05TsRuF8wLbWQNO8wrBJDkkW5MsCOxFFoajScSNSGtv2N8NOFQl1t
	 rkvu0Pioa+FjhtWzicKF5RjVqwjcnlpgI2PnvGOM=
Subject: patch "iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:05 +0200
Message-ID: <2024101305-player-amusing-5ffe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From b7983033a10baa0d98784bb411b2679bfb207d9a Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 18:49:37 +0200
Subject: iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: 28b4c30bfa5f ("iio: amplifiers: ada4250: add support for ADA4250")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-5-4019453f8c33@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/amplifiers/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index b54fe01734b0..55eb16b32f6c 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -27,6 +27,7 @@ config AD8366
 config ADA4250
 	tristate "Analog Devices ADA4250 Instrumentation Amplifier"
 	depends on SPI
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices ADA4250
 	  SPI Amplifier's support. The driver provides direct access via
-- 
2.47.0



