Return-Path: <stable+bounces-12793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB28373CD
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717F2282EE6
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C2208C3;
	Mon, 22 Jan 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zDsTMlXV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD752CA8
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955503; cv=none; b=h5XsSAYmQmFnlkyJL0XYQcsASu3ev/shuHK3OD3FrtdLBeQG6UGXS0BAbdI5VIvEDByoRrV2V8ZK4wNKb8D5WfFS2HzslVGZVHGefafyQ22sKs5Eu6DaXTghNWuWyu9bKe5kFqlyTgm4012I++pZMROS0FK6wnqDgibFOK4k5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955503; c=relaxed/simple;
	bh=YByg9BbD4Fxn59FezxxYuoXqEu2h3ZCSGMzqLTPhEtU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kp884whgrxRpnml3ZP1ZO2WKkAQZvIl9B06XH6XYXIMxG7vOaSOJ06m1RMHR3lg/mWIldQNM+T7wv0usNNALDzJ/MLUO6eVS5lEpsq+5B69XmliJYT7ag5a+aTy/gKSht/EIH3Dv//nRobqBB1FvzLQ4JrsDUiWLsGZAZbZBOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zDsTMlXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACBC433C7;
	Mon, 22 Jan 2024 20:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705955503;
	bh=YByg9BbD4Fxn59FezxxYuoXqEu2h3ZCSGMzqLTPhEtU=;
	h=Subject:To:Cc:From:Date:From;
	b=zDsTMlXVbDuQo8BGeeFfs6WW64Cp/qdcCXHvN6dm/dWCam0MGELubBm9gmU7k/fea
	 HE4vPOyDIecXXMy7tWClErYbFuy5/6V6CSF0TDQACimC5BkBJ0IaD6cKGZbspHjzjQ
	 h4V0fU2izoQSzaAIfjCVNOc4kJHSKT4VWDsyWy3g=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: set safe default SPI clock frequency" failed to apply to 4.19-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:31:41 -0800
Message-ID: <2024012241-tactile-unison-0225@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 3ef79cd1412236d884ab0c46b4d1921380807b48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012241-tactile-unison-0225@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


