Return-Path: <stable+bounces-83636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E84E99BA06
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C370FB21029
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C05D146A63;
	Sun, 13 Oct 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MDR56DNI"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37814600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833214; cv=none; b=HRljucQW/AlzTjpPtVDAJGCuHzKdVDnSyHH50YjxtIWruwq3UExx2Ger1ydqRKPD+dENBgy5GkDIW+vgFcDD2HE+h72xT0xmluoSQo1tiCrCGyq3Ee75dnijDpooHI9noB5ZdNFfk68890zIXXjzGjTM0ZdiKh0ajF7MpJSKF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833214; c=relaxed/simple;
	bh=AY/kMoDLw3agCnTMu8clSbzeOTTRN+/gDAocw7VSnbU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=OFMXPtUTPEvedjHLtKNSoRtrqWA9Qc5oGP0WvvzaF343vYf7s8eViYg49zRDcJVGIt2FFKgvT6ioI853thRLhfEtBbzl716b19YtRIH59RN0DPD+jPxydX2h87ZFsxSKt4FMrttJz5SgjP1cQf8n8N+mV+YSOFCZLSrxtsJg1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MDR56DNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8145C4CEC5;
	Sun, 13 Oct 2024 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833214;
	bh=AY/kMoDLw3agCnTMu8clSbzeOTTRN+/gDAocw7VSnbU=;
	h=Subject:To:From:Date:From;
	b=MDR56DNIkP3iaLqmk0OO84UG3Vj9iE3+L9mLohe7HMS3xU1gGUmc+ZPIGL17tQGNf
	 cOJgwTLNG6EBxE9u1raueklMLaKvjsA1MJR5UI1aaSjS9fOZtIF81ATSqkVsEItVBT
	 CfEOAAkg3ehWAGx6wOspvgY7eiG4DYEBMK04S4o8=
Subject: patch "iio: magnetometer: af8133j: add missing select IIO_(TRIGGERED_)BUFFER" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andrej.skvortzov@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:02 +0200
Message-ID: <2024101302-maggot-gorgeous-2875@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: magnetometer: af8133j: add missing select IIO_(TRIGGERED_)BUFFER

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From fbb913895e3da36cb42e1e7a5a3cae1c6d150cf6 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:57 +0200
Subject: iio: magnetometer: af8133j: add missing select IIO_(TRIGGERED_)BUFFER
 in Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 1d8f4b04621f ("iio: magnetometer: add a driver for Voltafield AF8133J magnetometer")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-11-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 8eb718f5e50f..f69ac75500f9 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -11,6 +11,8 @@ config AF8133J
 	depends on I2C
 	depends on OF
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Voltafield AF8133J I2C-based
 	  3-axis magnetometer chip.
-- 
2.47.0



