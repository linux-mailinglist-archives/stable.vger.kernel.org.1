Return-Path: <stable+bounces-83642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7AB99BA0B
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9271D2818B1
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43798146A63;
	Sun, 13 Oct 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bBpUfRNz"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC914600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833234; cv=none; b=h//Wdd0U+JwxexEs6fmuuQYDPW0p4jbwyMldjWE8zEEr/KVy8+HGuUGdmO0T8rwmf+pSZQJDd0UMSqmp7ntT6ge9EiKDCu/Z0Xp8myjGNukeWQyExtC1TVObGxNlt6dFmmK3/bD1Cucq+zpr0XA9z9SWl1SPspZ9Gh5MJJHrKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833234; c=relaxed/simple;
	bh=3zg1H6veSFkPHE9Y+M0l6qg58IoRgHnxdKtO+OZICBc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Yv8sXxJgECdjlx45oW56nO5YUj6NpX25R+Okemzr8zN5BsexgdN6Z4GVsy0UIx6jnV1ip71DooN+njJAirIa6ed05OCjFlK73CC5wlAZNZpy7weHWiTYTUFYjMJNNzILrJ0DnZu64/Ppkd6kjRYbZXO1mjefnLOqI0mF3ADKac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bBpUfRNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2DEC4CEC5;
	Sun, 13 Oct 2024 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833233;
	bh=3zg1H6veSFkPHE9Y+M0l6qg58IoRgHnxdKtO+OZICBc=;
	h=Subject:To:From:Date:From;
	b=bBpUfRNzdTAIGaeG1YmA+6BrMeunhwhoGVmV5x0I4LZ9STHahq5OWX8uNHOCbIgyr
	 RUNyEnJvslvIk9N2ruJrGwsK7E5p8MCTwnzrqvFyFb7fFFo6PruOwP/MMkD8y75FQW
	 fAQSkbP+VI8yqncn5QWD//hYSXAx3CdaW2Qau2ZA=
Subject: patch "iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:05 +0200
Message-ID: <2024101305-antacid-barber-edca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From bcdab6f74c91cda19714354fd4e9e3ef3c9a78b3 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 18:49:38 +0200
Subject: iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-6-4019453f8c33@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index bb6cb9af9ed9..2e0a9c94439f 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -266,6 +266,7 @@ config AD5766
 config AD5770R
 	tristate "Analog Devices AD5770R IDAC driver"
 	depends on SPI_MASTER
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices AD5770R Digital to
 	  Analog Converter.
-- 
2.47.0



