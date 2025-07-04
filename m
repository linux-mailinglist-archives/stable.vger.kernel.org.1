Return-Path: <stable+bounces-160204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE53AF9586
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 16:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C933ACF7C
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9936D1A5B8F;
	Fri,  4 Jul 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="noEmGDbB"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23672614
	for <Stable@vger.kernel.org>; Fri,  4 Jul 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639453; cv=none; b=k95Xojadk6+88jr6OQ3L9VQG5UfFDqs2X+FIySgNxL4dIoLZFNPkxmbSJHLe01gQ9zqH0HTuYxbmVV6hsyDoE1/xUcfRRii1e0etMwnc7/f/zWiDZW87PdHL2pjHj1bWuH0JcejHv5xF8lb/CElIDw+3RQsj99vCE5PXNtsTu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639453; c=relaxed/simple;
	bh=JAAZxwBDfqhQ5qVMcGHWQgm1PcKQPnjZOdoJbp7Z4uk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Isr3oLBWEzZF7S6mBHlQyp8EPw/53oe3eqfj9q7lVwGqkQJxaNUCXSHiQhkOiWiJvUPyB9MgOth2VMN61OdaZSvHG8QGbJ+d9973yQg3GWBFGvh9cYk53UcUIFQJGi3KXQv7SNCQMp2Gqoj3t6KzqUq2sO9KWPagJJktE3wg6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=noEmGDbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810CEC4CEE3;
	Fri,  4 Jul 2025 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751639451;
	bh=JAAZxwBDfqhQ5qVMcGHWQgm1PcKQPnjZOdoJbp7Z4uk=;
	h=Subject:To:From:Date:From;
	b=noEmGDbB2a2ZPlRAdCDVyH7pL/SJwL4qQ83c+/f+cRIKMxZoeDVSxvhBYYovYUp7u
	 ITVEDKxGXjyFqcdulBohERPFZvC10eQUHO4SN6EWlXb5Ld2HFwHHX7pP8mOOLChhI5
	 x17o5Quw9/B3PxcF4DJjIDjd4GaUN6c8yhHzYZD4=
Subject: patch "iio: adc: stm32-adc: Fix race in installing chained IRQ handler" added to char-misc-linus
To: nichen@iscas.ac.cn,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,fabrice.gasnier@foss.st.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Jul 2025 16:30:46 +0200
Message-ID: <2025070446-valid-scavenger-110a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: stm32-adc: Fix race in installing chained IRQ handler

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From e8ad595064f6ebd5d2d1a5d5d7ebe0efce623091 Mon Sep 17 00:00:00 2001
From: Chen Ni <nichen@iscas.ac.cn>
Date: Thu, 15 May 2025 16:31:01 +0800
Subject: iio: adc: stm32-adc: Fix race in installing chained IRQ handler
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a race where a pending interrupt could be received and the handler
called before the handler's data has been setup, by converting to
irq_set_chained_handler_and_data().

Fixes: 1add69880240 ("iio: adc: Add support for STM32 ADC core")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Link: https://patch.msgid.link/20250515083101.3811350-1-nichen@iscas.ac.cn
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/stm32-adc-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index bd3458965bff..21c04a98b3b6 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -430,10 +430,9 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < priv->cfg->num_irqs; i++) {
-		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
-		irq_set_handler_data(priv->irq[i], priv);
-	}
+	for (i = 0; i < priv->cfg->num_irqs; i++)
+		irq_set_chained_handler_and_data(priv->irq[i],
+						 stm32_adc_irq_handler, priv);
 
 	return 0;
 }
-- 
2.50.0



