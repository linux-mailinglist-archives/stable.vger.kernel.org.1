Return-Path: <stable+bounces-83635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39099BA04
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D50281C24
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA5146D6A;
	Sun, 13 Oct 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xhruNpU1"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660661DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833211; cv=none; b=MmH9dEN3xHMOQd0G6HT0/0AqfTgnciaBfSLwobrGgpFX5CckByKRmVHP5aR/8AnmrtpEAkDujHN/uBBeLuFzujGxUC7hNON5ApmQBVJOB/iPqaA3LYNJivBjcwfVjPrKX5uf+rqtinL9iUyUxkRCPq24h+zhqGDHeuE6GUKezeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833211; c=relaxed/simple;
	bh=19XrSyzH0tv8rXRNlRJ98RLpzBgpda0aQZPczWSIoBs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=pBP9jUQoV8Nho3LBBEIDYR/ewXKGb0zh1dnnwhy25zPWdwCs7xvk7KUNvEovD1Qh+o8K0ZOkwWuFVGMhbtl3Lfcqa5lcgw2/389nWvip9Y5hqs5fLrRlr6PPFcYETIR3Qgm2ahl9GP80AV9vD7AQPVReVO4KHMdj2SRQbT65GOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xhruNpU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E701C4CEC5;
	Sun, 13 Oct 2024 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833211;
	bh=19XrSyzH0tv8rXRNlRJ98RLpzBgpda0aQZPczWSIoBs=;
	h=Subject:To:From:Date:From;
	b=xhruNpU1sPQOyTm0dHHMCLUdAFylEiuJsz6PZqBJ7QBtwGpxpkmjLCoP0GKjbK8Nv
	 X8upF5ulIuKf3y2Y8wKVcfuY5fBqA7EUNlJ8XkNgmleRFPV1WYUqaWtT6jgePrqNCJ
	 BHAn7V8kSiyX2hvtAbuftkFd/NkS0HQImtqcIb5Q=
Subject: patch "iio: chemical: ens160: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,gustavograzs@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:01 +0200
Message-ID: <2024101301-agonize-herring-c2ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: ens160: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3fd8bbf93926162eb59153a5bcd2a53b0cc04cf0 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:55 +0200
Subject: iio: chemical: ens160: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 0fc26596b4b3 ("iio: chemical: ens160: add triggered buffer support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Acked-by: Gustavo Silva <gustavograzs@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-9-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 678a6adb9a75..6c87223f58d9 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -80,6 +80,8 @@ config ENS160
 	tristate "ScioSense ENS160 sensor driver"
 	depends on (I2C || SPI)
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select ENS160_I2C if I2C
 	select ENS160_SPI if SPI
 	help
-- 
2.47.0



