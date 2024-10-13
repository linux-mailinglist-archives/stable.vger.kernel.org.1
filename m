Return-Path: <stable+bounces-83648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D599BA11
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AEE281BEC
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F4146A63;
	Sun, 13 Oct 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8tW5Jvs"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB614600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833255; cv=none; b=eDQNuKd56tznAZo+aUzkOoB54ynoLPxhIHkWH1/YIlNd2nR1XrZt7vCAm9htN2Gt5aknZpJ7IG1nOP7eih4y84/Ycq/HxM4iwF9oL3CsF3q0/mUeSVmHD3onlcaulHnYzPBUFzYC5vOG1k3i6HjvCeI0keILwsb4EvfQhu4edc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833255; c=relaxed/simple;
	bh=D4EhhlWZR/WWA78hcR6WhSpVSv2Z62vGEezGvO60S64=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=YaOFDsBHa1W7k+v6h1Z6zCxEZSi/y6asau1TRaS/DALbdAGwV/TcJd0fGiIzWlfDn7oycxAKri1AsXJmFYveC9gEgiDJ36MMGRaaxmSW0ujlrE/RQ/2xdQO6uA2ZIK9gSA8J6BTTrwMW3LGfFY5BdaOaZIALA5klrvEcQtpeg54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8tW5Jvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963FCC4CEC5;
	Sun, 13 Oct 2024 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833255;
	bh=D4EhhlWZR/WWA78hcR6WhSpVSv2Z62vGEezGvO60S64=;
	h=Subject:To:From:Date:From;
	b=Q8tW5Jvsm10SaaMOc2/9hqxLax6oW5TAdiRd8XaA+jxHbD7oBRa+Tc1K3VLWSP1Xe
	 lNcmpYLm2bKpepTqqEIwkpweCnGLQyTZq5BMSWgDIXfvK9CY0e35afSoESagLtCswJ
	 eRJ/cLTMw1Xrtiu1bwmA7au9opYrysip3WG87s3A=
Subject: patch "iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,sean@geanix.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:08 +0200
Message-ID: <2024101308-sampling-upcoming-6d8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 4c4834fd8696a949d1b1f1c2c5b96e1ad2083b02 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:50 +0200
Subject: iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Fixes: 2a86487786b5 ("iio: adc: ti-ads8688: add trigger and buffer support")
Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-4-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index c1197ee3dc68..1bf915c3d053 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1483,6 +1483,8 @@ config TI_ADS8344
 config TI_ADS8688
 	tristate "Texas Instruments ADS8688"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS8684 and
 	  and ADS8688 ADC chips
-- 
2.47.0



