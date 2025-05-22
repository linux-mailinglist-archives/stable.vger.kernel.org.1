Return-Path: <stable+bounces-146096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1167AC0DD3
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3361E3AF5A1
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F345328C029;
	Thu, 22 May 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHESKPPU"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173A28A700
	for <Stable@vger.kernel.org>; Thu, 22 May 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923272; cv=none; b=AwfCiOdYJ0nT7xliU0jvCHrs6o6Q9cyJ52LrOKj5R1kcA/xPpEJS9d2sBQX0xEnOyyhx3t4wmyLsc9z1RkOTQpeN/DfZytrEtULzmQWHiVVqlB7xoB5WYxooTGyJrQlTyKuL5p8ZtIf6jF9R2ZT7xC9vHk1U9V9dpoaFtFYVzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923272; c=relaxed/simple;
	bh=PAFbB9PP2YkkGoELwTSiymwn5hK3QxSZGr5SfJ5IA8M=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=m2saHlehzGL0vBf3SlFC1VRfG/E5RnDBmeChaDtS9Flr3NyKIpKtE32+chNQ/5+8lO2uU8+gjHjkFnGdclsB5O1p+tAuvfx7JFzl/MBUGeqZdhSzn2QUtvjNMvtXYCk7GKKJ2YelNvZR318svLy8r+ChUHxbYljmucn1xnGY28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHESKPPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6932C4CEE4;
	Thu, 22 May 2025 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747923272;
	bh=PAFbB9PP2YkkGoELwTSiymwn5hK3QxSZGr5SfJ5IA8M=;
	h=Subject:To:From:Date:From;
	b=VHESKPPUWUnQBT05c2XLt6/9BC71xhMz2eLiQt642hNpb8HTytwiML1Hke0DbYN7f
	 rIL9d5s06vLS79pGU+7WWFXTjzw3tFCig6j94Z4t8PZXmQc6AiiXph3pSLBc4n4aNw
	 QQbovNAYrM9o9rYX/vZ1bj45tftF3p/R0LW+qPSE=
Subject: patch "iio: adc: ti-ads1298: Kconfig: add kfifo dependency to fix module" added to char-misc-testing
To: r2.arthur.prince@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,mariana.valerio2@hotmail.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 May 2025 15:58:43 +0200
Message-ID: <2025052243-stride-cannot-37de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads1298: Kconfig: add kfifo dependency to fix module

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 3c5dfea39a245b2dad869db24e2830aa299b1cf2 Mon Sep 17 00:00:00 2001
From: Arthur-Prince <r2.arthur.prince@gmail.com>
Date: Wed, 30 Apr 2025 16:07:37 -0300
Subject: iio: adc: ti-ads1298: Kconfig: add kfifo dependency to fix module
 build
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add dependency to Kconfig’s ti-ads1298 because compiling it as a module
failed with an undefined kfifo symbol.

Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
Co-developed-by: Mariana Valério <mariana.valerio2@hotmail.com>
Signed-off-by: Mariana Valério <mariana.valerio2@hotmail.com>
Link: https://patch.msgid.link/20250430191131.120831-1-r2.arthur.prince@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ad06cf556785..0fe6601e59ed 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1562,6 +1562,7 @@ config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  If you say yes here you get support for Texas Instruments ADS1298
 	  medical ADC chips
-- 
2.49.0



