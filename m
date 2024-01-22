Return-Path: <stable+bounces-12795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693778373D3
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4AE286FCB
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7B208C3;
	Mon, 22 Jan 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="05xTvnm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD41BF5A
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955548; cv=none; b=r8GNhQaFUk54K0mezeOozk9xbq31ZoYEndsKcNW02rpqrHdK1XhiDtukw7684tGs5GaQANUH8RMxgzgSVJKNzkra5nY+CiSv+BTGU80JsNGbp7kbID7gqeftfF+DD+vUu+TzaKaP084rnBgTP/iDbGTKJ+cf7VUK8giE+K6UlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955548; c=relaxed/simple;
	bh=ZPRDPS6M4+gbDaffFRfh9O1aymEhXXu5zVdg4M1eQfU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M0HQPjl0gvzfUJPIXxZERGzu0fOjYq2VrnkHg4i87bnyJCGfDWP7h6eI3cDO38WsXFeYeiAFiasfDzB1oOcZP5jJeQ9l32tLa+73DpHD+pq+Uj/PLyZNdArOiZfA0uOfRsH6odMb2rdso6+SrFH+zdhUbPeKPGGGtFU6n2vhpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=05xTvnm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042D7C433C7;
	Mon, 22 Jan 2024 20:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705955548;
	bh=ZPRDPS6M4+gbDaffFRfh9O1aymEhXXu5zVdg4M1eQfU=;
	h=Subject:To:Cc:From:Date:From;
	b=05xTvnm66X6ikvHUo9+/fDeGEpVRg+wh0MEchvckoVpmgmcjY5k1vLHCn4ziXAM4+
	 Dsp4CU3C1xqQbM5Zx/iFkbPQpd2A2Uw4Vb7ukEdd53mCgoNS4iZwfgkInd4iQZPFPf
	 +1PR2VwKZn6xAboDdny6+i+uJAvoxzToMwdpDSTo=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: set safe default SPI clock frequency" failed to apply to 5.10-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:32:26 -0800
Message-ID: <2024012226-nuttiness-uproot-f978@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3ef79cd1412236d884ab0c46b4d1921380807b48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012226-nuttiness-uproot-f978@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

3ef79cd14122 ("serial: sc16is7xx: set safe default SPI clock frequency")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ef79cd1412236d884ab0c46b4d1921380807b48 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:10 -0500
Subject: [PATCH] serial: sc16is7xx: set safe default SPI clock frequency

15 MHz is supported only by 76x variants.

If the SPI clock frequency is not specified, use a safe default clock value
of 4 MHz that is supported by all variants.

Also use HZ_PER_MHZ macro to improve readability.

Fixes: 2c837a8a8f9f ("sc16is7xx: spi interface is added")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-4-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 798fa115b28a..ced2446909a2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -24,6 +24,7 @@
 #include <linux/tty_flip.h>
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 #include <uapi/linux/sched/types.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
@@ -1738,7 +1739,7 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, -EINVAL, "Unsupported SPI mode\n");
 
 	spi->mode		= spi->mode ? : SPI_MODE_0;
-	spi->max_speed_hz	= spi->max_speed_hz ? : 15000000;
+	spi->max_speed_hz	= spi->max_speed_hz ? : 4 * HZ_PER_MHZ;
 	ret = spi_setup(spi);
 	if (ret)
 		return ret;


