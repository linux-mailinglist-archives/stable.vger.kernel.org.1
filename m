Return-Path: <stable+bounces-83630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1DE99BA00
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB151C209E6
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A6146A63;
	Sun, 13 Oct 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+HLiPOY"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE241DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833195; cv=none; b=UZfSK3o46HKoQAn3DTBU+ZcSljLwPGJxJpwOvtlfkOUFthxp+uBOZpbpSKfIj9NarnExuN95WWATVsxEh3whkzxdd3ho/scj/Q3muxOYK2WhB6UqoRctNtHz3+Hsr9fl/SJxRpWHabsePuhfrUZtKTJE/Zr9/IQwBXhwSsniYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833195; c=relaxed/simple;
	bh=cQfMv76PgBwB3YvU0vbyeUeqtzDGOpgPmGerfuBbiYY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Le4spBg4Ci3/posuMsvyMd6BdEBVOG61ChLnisW5QrzgH1Ap82z6SwOBrOmnMEtfVsbPGEktP5XcC9jn+OczZj+OecKP+zo7QaDL8fn4DTPa0//Nm+/xUFnFqA/F0UikYVoxuxrFszkNuXS4DXELd+bEYNDQEYBf8n/vHJYs0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+HLiPOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81694C4CEC5;
	Sun, 13 Oct 2024 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833194;
	bh=cQfMv76PgBwB3YvU0vbyeUeqtzDGOpgPmGerfuBbiYY=;
	h=Subject:To:From:Date:From;
	b=g+HLiPOYLxOCYbcFzm2MnH9v0OFrcAgTluGoUR5v+RD6AHpDwa7UJgVEzWCxn0Mjp
	 NMAoLZHGS1yEMTV4dy2c1GhGMr3ppB/sgpVkZOQL+2PNzuQFmnrM5AO2E7w0sHfOpN
	 u5J3HZXtzsxAGk6Ht8BrdBjPHnb5wfXo9FLDNGjU=
Subject: patch "iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:25:59 +0200
Message-ID: <2024101358-jitters-heading-1051@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From eb143d05def52bc6d193e813018e5fa1a0e47c77 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:49 +0200
Subject: iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-3-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6790e62700fe..45872a4e2acf 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1493,6 +1493,8 @@ config TI_ADS8688
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS124S08
 	  and ADS124S06 ADC chips
-- 
2.47.0



