Return-Path: <stable+bounces-12798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1C8373D6
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4397228AD60
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04873FB10;
	Mon, 22 Jan 2024 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QfYxuoqw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFC1DFE5
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955584; cv=none; b=qvnqHFgO9JZPNTZvE+MRnnf+awNXyoP6YbWWT4R3IngGjLI4jScH0X2ge2uBX3lvG6I+dyh97hh5rzab8C06pvnlbEic8RYDGPvrm7S/CzZWQ8jiXfcriIy0BQ6fHW1xo+0VXlcMV1JwwJpuY3/9S4nz8b6OszRKmN6vsvecfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955584; c=relaxed/simple;
	bh=4E0JtELJBm04bRyVvU8FtadV0xdCvDDg77pBMxbZ5OM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YyCmGZ4Rdhh0uRLo/w7CQeM/q/QF2dPzXPr/fnZ5AIE2TcbenVl/bT78Yyqrjf9TbTgL+yERRQ1IppfhCPYwmbcxZeBRg5T57m+vPjLB66pWsPffi2OBqyo9Z8cNu0PAuv5T6XI1Zt+2yYc1/6PmkDRHgzH/n9Mx4d/FtW34b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QfYxuoqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51488C433C7;
	Mon, 22 Jan 2024 20:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705955584;
	bh=4E0JtELJBm04bRyVvU8FtadV0xdCvDDg77pBMxbZ5OM=;
	h=Subject:To:Cc:From:Date:From;
	b=QfYxuoqwQck+ThcU3ZRmTuPVjkLmk8f6rnHqsLQcUviV9seSBuWUz4lOrcIogMk6W
	 p9xncBCfqHaSZFxuFBeRc/Le4iCxYzv474vJbKdJegStXkhjv9WYfYcSs/0O2sSQXx
	 LgOaxy7P8HuZHAvb97v403S5nP2zcGq7mzIYoJLI=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: add check for unsupported SPI modes during" failed to apply to 4.19-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:32:59 -0800
Message-ID: <2024012259-headset-sludge-38da@gregkh>
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
git cherry-pick -x 6d710b769c1f5f0d55c9ad9bb49b7dce009ec103
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012259-headset-sludge-38da@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


