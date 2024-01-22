Return-Path: <stable+bounces-12797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F48373D4
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3B51F2511F
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3AE3AC08;
	Mon, 22 Jan 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xab4vzV5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160D1DFE5
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955583; cv=none; b=q73jEAKk7hSXLsPVqq6MNgLsYzekUK6/rhPU5oJLrkHQQO/5WOaSacE5b5xXtGBReX86NUManwUeb2EHCxpmq0dPqPRpoZXVimiX3GZXZAEqcu0DQRxwsbde4wzg7ihjKE5C6562S7jXnuH5ZJ9v1YWAKSZG/xPuVY40vimekts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955583; c=relaxed/simple;
	bh=Im4rgh7uSOUdYi1T3hiMfR38l5znDZo7CzWHJPg4HVQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Eu4mzx5YhpaJARfpttFpcJFxnqZI0GSGUvdx589/2xI+8ytXqQlInqsVPWzWQGA+ypjCGc1IKeTJpuIoU7tnvcxZSJHF+H69lBQE4bWwyf6nUG+ErEsLj5psgOQVk2sqVxbx34pibmJGa/Up1byWbMI3+lWKqi0uXmevS46lywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xab4vzV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07AEC433F1;
	Mon, 22 Jan 2024 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705955582;
	bh=Im4rgh7uSOUdYi1T3hiMfR38l5znDZo7CzWHJPg4HVQ=;
	h=Subject:To:Cc:From:Date:From;
	b=xab4vzV5QUF5C/k5siXgxfAV26wB9yfyWUTc7pdmfOFW1/RbrwP34zApumajXG5eN
	 8DknHDGBW+QJzFiCKtR/i0NyuNBP8sEG/arsxxYodu4RzMFx8dyuFOSUdU6cj+xoA2
	 SmX5doJwjuUDg80Qb9jrZu8jzKqLCM8nZFgidtHk=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: add check for unsupported SPI modes during" failed to apply to 5.10-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:32:56 -0800
Message-ID: <2024012255-elephant-mannish-5753@gregkh>
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
git cherry-pick -x 6d710b769c1f5f0d55c9ad9bb49b7dce009ec103
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012255-elephant-mannish-5753@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

6d710b769c1f ("serial: sc16is7xx: add check for unsupported SPI modes during probe")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d710b769c1f5f0d55c9ad9bb49b7dce009ec103 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:09 -0500
Subject: [PATCH] serial: sc16is7xx: add check for unsupported SPI modes during
 probe

The original comment is confusing because it implies that variants other
than the SC16IS762 supports other SPI modes beside SPI_MODE_0.

Extract from datasheet:
    The SC16IS762 differs from the SC16IS752 in that it supports SPI clock
    speeds up to 15 Mbit/s instead of the 4 Mbit/s supported by the
    SC16IS752... In all other aspects, the SC16IS762 is functionally and
    electrically the same as the SC16IS752.

The same is also true of the SC16IS760 variant versus the SC16IS740 and
SC16IS750 variants.

For all variants, only SPI mode 0 is supported.

Change comment and abort probing if the specified SPI mode is not
SPI_MODE_0.

Fixes: 2c837a8a8f9f ("sc16is7xx: spi interface is added")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 17b90f971f96..798fa115b28a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1733,7 +1733,10 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 
 	/* Setup SPI bus */
 	spi->bits_per_word	= 8;
-	/* only supports mode 0 on SC16IS762 */
+	/* For all variants, only mode 0 is supported */
+	if ((spi->mode & SPI_MODE_X_MASK) != SPI_MODE_0)
+		return dev_err_probe(&spi->dev, -EINVAL, "Unsupported SPI mode\n");
+
 	spi->mode		= spi->mode ? : SPI_MODE_0;
 	spi->max_speed_hz	= spi->max_speed_hz ? : 15000000;
 	ret = spi_setup(spi);


