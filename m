Return-Path: <stable+bounces-83643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB37399BA0C
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713C8281B65
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8E3146A83;
	Sun, 13 Oct 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2mpoTaxn"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98D14600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833240; cv=none; b=VcbSe3ctl2ZDLDdxaKmulkO21wba20pXm/ssOVOb6Z/O5rpc0WFzlVTQorAlPQhhgk9/h4hR+YYOrWUVzYl6bD0t8ZODB5y9OWIWHRDujAJV2zy2DAsOiUCcZSIGgRQ+cmVuSW0yT0C1RlkM5BVYSgg8Xe0tNhV8kmE6uF1dra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833240; c=relaxed/simple;
	bh=deilq5BcqHyLW8TfLM/eY9IWFv9KQ6FPiP7pDNbCBBU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=mlwFsd0nEKBERlyd3f3frt/utj3mwYbEdnynrra71YjCzffufn5V9KTVveWp3H/cBdBO3iRKVGZ8puaLAXptd1d9TTSTjwpZ9HAl4MvOpLg2leAMvPPJvkSNfBtGUTEZa2Z8656Y9gHUIVWbLt9s9afOHCTmiaw+M6vBl6SrjaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2mpoTaxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9988C4CEC7;
	Sun, 13 Oct 2024 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833240;
	bh=deilq5BcqHyLW8TfLM/eY9IWFv9KQ6FPiP7pDNbCBBU=;
	h=Subject:To:From:Date:From;
	b=2mpoTaxn0Crr+IfOSZdn+KPvUWUJ+oqxFr4jjM3oGRD8gAZ6gLBHsIvxihue1ephv
	 Joic7nzwCaJ9wUxMtJg1U+oRB/G1Hff/Qz5it5LCxNltuRCZ8YgDe9z0xbnX0g1/fk
	 akNKW6MR4z60Xx+5TI42iQGsCwSwsbBj11SIrk1U=
Subject: patch "iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:06 +0200
Message-ID: <2024101306-retainer-chatty-321d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 27b6aa68a68105086aef9f0cb541cd688e5edea8 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 18:49:40 +0200
Subject: iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig

This driver makes use of regmap_mmio, but does not select the required
module.
Add the missing 'select REGMAP_MMIO'.

Fixes: 4d4b30526eb8 ("iio: dac: add support for stm32 DAC")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-ad2s1210-select-v1-8-4019453f8c33@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 25f6d1fd62df..45e337c6d256 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -489,6 +489,7 @@ config STM32_DAC
 
 config STM32_DAC_CORE
 	tristate
+	select REGMAP_MMIO
 
 config TI_DAC082S085
 	tristate "Texas Instruments 8/10/12-bit 2/4-channel DAC driver"
-- 
2.47.0



