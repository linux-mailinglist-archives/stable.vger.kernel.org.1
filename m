Return-Path: <stable+bounces-83631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75C99B9FF
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1398281826
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD3146A83;
	Sun, 13 Oct 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fKStwxjx"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598381DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833198; cv=none; b=r61KEaL2J1/99M6VeattrOXnVoAU/fE0bVI3k9DOfiJjrNdfxYVF+1R5COKLrDgVoOoJ/GBBPBVQDEn2AWGq1/qzwvkdKuXOGa68d9yXeAdB6vR9unGQG5KtAdzmG0ajLNi+aKJYSm6tGnO+5f0nxPrMksjEUH8UsLf3f/zE7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833198; c=relaxed/simple;
	bh=Rk9Fz6e50W0u8FhkVO0qUPBFgUAC7Vl7ZvUbM79cshs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=J3jPXcNfIU2AmBeYLe7rs+tmBNLJygDla2Jgb86LH4GHqOWCcHLm7Sdzd7wPdWE/zwqxiY2qygzOhA55uGew7vdY4jnygw2Fkp0myndk9fXNygdtT8RdXaGL6RWr2TNVCdVvzKM27u2DesGrqqH2HyPpBbMI0jNLmUwEKYIu1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fKStwxjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6070C4CEC5;
	Sun, 13 Oct 2024 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833198;
	bh=Rk9Fz6e50W0u8FhkVO0qUPBFgUAC7Vl7ZvUbM79cshs=;
	h=Subject:To:From:Date:From;
	b=fKStwxjxppUrLDUpe/iF2+HxKLnJX0Bw5RgN4Y6nRjrJfUaKJTmVL/z8gNZNgcyAF
	 VR7sYHqlHtwBqS1U0rItRn/8c3hLciqLVzKZ0STeAGDl34Ws5t+9tN9satT/efohY9
	 elfCNEPZOVLSo2ghtKCGrPeL9nsidbkmMav4wWzA=
Subject: patch "iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:00 +0200
Message-ID: <2024101300-stipend-ouch-9b30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 5bede948670f447154df401458aef4e2fd446ba8 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:53 +0200
Subject: iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-7-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 1cfd7e2a622f..9d4600ce0427 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -9,6 +9,8 @@ menu "Digital to analog converters"
 config AD3552R
 	tristate "Analog Devices AD3552R DAC driver"
 	depends on SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD3552R
 	  Digital to Analog Converter.
-- 
2.47.0



