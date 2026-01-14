Return-Path: <stable+bounces-208350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC730D1E5EA
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F309230042B2
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DDB39524A;
	Wed, 14 Jan 2026 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zPruRDqq"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB3393DD5
	for <Stable@vger.kernel.org>; Wed, 14 Jan 2026 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389906; cv=none; b=aoB99+3gtFTbTHE6xoote+cLO9dnQEzHLB6+R1O9ymJIX7vvaMwHE3TLi3NfG+XJKNlhxyfzdjsXi0W9Lq3nD6kxb8ExT42NzX1YZrqf8U+ratKRCEDp2vsoIs8LL+ll8aYE0A2QNVABSDDUZwtMNqapOzo3Z+Vjil04xBCzM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389906; c=relaxed/simple;
	bh=iOeYaySMqH1QuBMCfGGe4Okp8QHuutwGYq32i7R+348=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ntXMAaLMKCWi5O24Cu3sFEE3hf2PovIraSKJIFow7ptmph5VqCXyxm2t2cHhOO4SuqT7Yhen7mP3rUHqdWpd171psf+HsKFWNSGuxDf8tbGjityj42rEb/aEcSbNX7qJEO4jIyOrfsiS+abWORMfrlBWRR7GIMNjA7gNyjUe1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zPruRDqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6275EC4CEF7;
	Wed, 14 Jan 2026 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768389905;
	bh=iOeYaySMqH1QuBMCfGGe4Okp8QHuutwGYq32i7R+348=;
	h=Subject:To:From:Date:From;
	b=zPruRDqqWJL2d13vGvX/LJQdrfN5w7JkDHXuRA83CHyIA1sZKFA9XdBvc42/8EDoR
	 zenU43Rsed7ZyVOkfPXRJv3PkQCZ8hHcI/BVjOZZHlEU1b0sibX7VsrpIUVwlC7HBC
	 AW/lNPm6Ys896uGSqgDYLE8Xe0Fo7VFPdn2jzgJk=
Subject: patch "iio: adc: at91-sama5d2_adc: Fix potential use-after-free in" added to char-misc-linus
To: xiaopei01@kylinos.cn,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Jan 2026 12:25:03 +0100
Message-ID: <2026011403-thirteen-citation-ad63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: at91-sama5d2_adc: Fix potential use-after-free in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From dbdb442218cd9d613adeab31a88ac973f22c4873 Mon Sep 17 00:00:00 2001
From: Pei Xiao <xiaopei01@kylinos.cn>
Date: Wed, 29 Oct 2025 10:40:16 +0800
Subject: iio: adc: at91-sama5d2_adc: Fix potential use-after-free in
 sama5d2_adc driver

at91_adc_interrupt can call at91_adc_touch_data_handler function
to start the work by schedule_work(&st->touch_st.workq).

If we remove the module which will call at91_adc_remove to
make cleanup, it will free indio_dev through iio_device_unregister but
quite a bit later. While the work mentioned above will be used. The
sequence of operations that may lead to a UAF bug is as follows:

CPU0                                      CPU1

                                     | at91_adc_workq_handler
at91_adc_remove                      |
iio_device_unregister(indio_dev)     |
//free indio_dev a bit later         |
                                     | iio_push_to_buffers(indio_dev)
                                     | //use indio_dev

Fix it by ensuring that the work is canceled before proceeding with
the cleanup in at91_adc_remove.

Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b4c36e6a7490..aa4ba3f5a506 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2481,6 +2481,7 @@ static void at91_adc_remove(struct platform_device *pdev)
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	cancel_work_sync(&st->touch_st.workq);
 
 	at91_adc_dma_disable(st);
 
-- 
2.52.0



