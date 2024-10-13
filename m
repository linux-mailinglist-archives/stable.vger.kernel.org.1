Return-Path: <stable+bounces-83634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CAE99BA03
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D761C20A94
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4F146D6A;
	Sun, 13 Oct 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S3pB/zuO"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B281DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833208; cv=none; b=SIpzTsrEZCo5t6kN0T6m/CS0/oYl4J1DV97DV+nVaTwbanmbMe9CA+Q1IMoNFPQbJCwlEMXe0Enu/ppyOwH+wePuGWCRHcetoqRIQ81wfn4to9AS39vtBOvwmn471f4FQF36RAJouYeue58NfjO95i6/XyT53xFQ59lpXAivV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833208; c=relaxed/simple;
	bh=WUOSrlXFNJ3/WS4+l+FSKTYFEK7ADAwwh0gLlUw0MUQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=nRYLfXe5YZldCV1E6XA2KXB9WS7YqkYbqwO+GVbMuxUypADkrk+qz3+kDVEYiUXZWwFkUGi+KxtE97wDkCSccnbnIrFxZyUyrFzCX7LLwtmu6phT/G28eFV0dKmqRdGLBhZahL6H6HDyH+b0NZ4LRTP4lt5L/tQms21/QB/cEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S3pB/zuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6356DC4CED0;
	Sun, 13 Oct 2024 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833207;
	bh=WUOSrlXFNJ3/WS4+l+FSKTYFEK7ADAwwh0gLlUw0MUQ=;
	h=Subject:To:From:Date:From;
	b=S3pB/zuOGH0JyzmClK0H+KJqLVjNmfk6UGeYRIBZrmZngldiZAQf1S0UEdOG20Iyq
	 POci36ZnyqEg25Tk6ZDilptjgx9L9HlEuaGnJKXh4UHB3k0JKchk68PhQea8U1r/pP
	 G9Hybk0hSnyyJMlvtuU4ZCKCo2pym79rCHGufKFU=
Subject: patch "iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,mazziesaccount@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:01 +0200
Message-ID: <2024101301-prayer-dividend-b959@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From aa99ef68eff5bc6df4959a372ae355b3b73f9930 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:56 +0200
Subject: iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 41ff93d14f78 ("iio: light: ROHM BU27008 color sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-10-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 515ff46b5b82..f2f3e414849a 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -335,6 +335,8 @@ config ROHM_BU27008
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_GTS_HELPER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Enable support for the ROHM BU27008 color sensor.
 	  The ROHM BU27008 is a sensor with 5 photodiodes (red, green,
-- 
2.47.0



