Return-Path: <stable+bounces-86996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6BB9A5C14
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13E21C21B46
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9E1D0DE6;
	Mon, 21 Oct 2024 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1RwLGXqh"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708D1940A2
	for <Stable@vger.kernel.org>; Mon, 21 Oct 2024 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494554; cv=none; b=Z27nXuY34soiJdYkw1fVoFT/HCfurdni2KjAt5LI6lH5ke1aieIEe3Sr7MdlvANPSiUe4XFhg8SRKMui24/hB/1vJDi+5KLw0LJOnSGimwGUy/4d02HUIoGL1XgZUqC4womjn9KoZsMtRpBT/BXaZ+lZTcx2vJs5CIzCwEfRx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494554; c=relaxed/simple;
	bh=cwF47iSerwHX6TyUTzfTgTxnAuGpFE5DwI/7ya4GMi4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tz6iisvnmwKci8u0gdF3XfvLpNIM16kwLsxUWkXdZ1xAGbf/YrpmISfF0z2L9JNrYRWWw74WjTWu0JF7c1rUYaHUhVbWSBrca+HFdcjuAGrh0eiwu4MjOZ22C8nJGsiFH/eSGrv5IZGZXu8ZHY2c7zA0YysAKSX0zVqY2y/A4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1RwLGXqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267FAC4CEC3;
	Mon, 21 Oct 2024 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729494553;
	bh=cwF47iSerwHX6TyUTzfTgTxnAuGpFE5DwI/7ya4GMi4=;
	h=Subject:To:Cc:From:Date:From;
	b=1RwLGXqhXQ0hNLAU8CVPWw0rM8jDxE7QjM551FkkzzMBUt/p+XyEqJwdEUFhuXSMY
	 K3krzb45Ry1mnKdv88rWxBjYMM8R/Q0+0M+umEw+f547UogahD7bXwkLequB2kXtgB
	 NpWT9xGOLoovZ7YvF4vV+uiZcGkz7TPZzRU7Vjdk=
Subject: FAILED: patch "[PATCH] iio: adc: ti-lmp92064: add missing select" failed to apply to 6.6-stable tree
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 09:09:10 +0200
Message-ID: <2024102110-tableful-unnatural-5dab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a985576af824426e33100554a5958a6beda60a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102110-tableful-unnatural-5dab@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a985576af824426e33100554a5958a6beda60a13 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:52 +0200
Subject: [PATCH] iio: adc: ti-lmp92064: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 6c7bc1d27bb2 ("iio: adc: ti-lmp92064: add buffering support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-6-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 68640fa26f4e..c1197ee3dc68 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1530,6 +1530,8 @@ config TI_LMP92064
 	tristate "Texas Instruments LMP92064 ADC driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the LMP92064 Precision Current and Voltage
 	  sensor.


