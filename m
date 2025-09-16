Return-Path: <stable+bounces-179700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F36B590C1
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75A0167172
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798527FB1B;
	Tue, 16 Sep 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wces58aP"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661172135B8
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011603; cv=none; b=XAi2N/TSOQHmebbviL+1XuS7ayPuQo5rpItls0DUQtpJNpZMiSObCZHUCx8rd3saWEITKIFkQQfkBrPAWXiLA2agt7kT+DETJI3tSTsF59GBQHlCZ97p4LVPSfCY0GwUDHPgX22wmxU4HESvOUx3l+DQPiRMk7mnnUYbXNniVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011603; c=relaxed/simple;
	bh=Qy5w8dXPWdWJDmoe2eD5XpdD7FnpIpOwc4pzFYGgbo4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=YMP4tJ8H2S2bITzrvfi8SpDLJSNrUCcmq3k4RpkkaRyJHIE6RtOrhd7nyw1ETfh1OwWELqP5TCE5u8YyaV8ka7gi1mCC8ZpdQEMepfAcFHNnVK4uK9mPim2HIiv3L7/CzxYJtOiUbA41hszcBy4/bxFEhPs3xubbFf9KO6ZFhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wces58aP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8593C4CEEB;
	Tue, 16 Sep 2025 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011603;
	bh=Qy5w8dXPWdWJDmoe2eD5XpdD7FnpIpOwc4pzFYGgbo4=;
	h=Subject:To:From:Date:From;
	b=Wces58aPI0otM+PC+Mt97ZK7P90re4hINVfahs+QZf14CHPHt9wGD8D5AYtKf1A5B
	 ALD8Nj9O6GOQljV8VxUOAqq3siYQiOV0/mKgKfcbL+kbQkcp1z8gsmKOHMS4sZrmvp
	 5kPC4YsK6fUde/Ey6Nv3XHexYawWN4VpPO3+oTdA=
Subject: patch "iio/adc/pac1934: fix channel disable configuration" added to char-misc-next
To: aleksandar.gerasimovski@belden.com, Jonathan.Cameron@huawei.com,
	Stable@vger.kernel.org, "mailto:rene.straub"@belden.com,
	marius.cristea@microchip.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:32:59 +0200
Message-ID: <2025091659-starring-tribesman-f18d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio/adc/pac1934: fix channel disable configuration

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 3c63ba1c430af1c0dcd68dd36f2246980621dcba Mon Sep 17 00:00:00 2001
From: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
Date: Mon, 11 Aug 2025 13:09:04 +0000
Subject: iio/adc/pac1934: fix channel disable configuration

There are two problems with the chip configuration in this driver:
- First, is that writing 12 bytes (ARRAY_SIZE(regs)) would anyhow
  lead to a config overflow due to HW auto increment implementation
  in the chip.
- Second, the i2c_smbus_write_block_data write ends up in writing
  unexpected value to the channel_dis register, this is because
  the smbus size that is 0x03 in this case gets written to the
  register. The PAC1931/2/3/4 data sheet does not really specify
  that block write is indeed supported.

This problem is probably not visible on PAC1934 version where all
channels are used as the chip is properly configured by luck,
but in our case whenusing PAC1931 this leads to nonfunctional device.

Fixes: 0fb528c8255b (iio: adc: adding support for PAC193x)
Suggested-by: Rene Straub <mailto:rene.straub@belden.com>
Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
Reviewed-by: Marius Cristea <marius.cristea@microchip.com>
Link: https://patch.msgid.link/20250811130904.2481790-1-aleksandar.gerasimovski@belden.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/pac1934.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 09fe88eb3fb0..2e442e46f679 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -88,6 +88,7 @@
 #define PAC1934_VPOWER_3_ADDR			0x19
 #define PAC1934_VPOWER_4_ADDR			0x1A
 #define PAC1934_REFRESH_V_REG_ADDR		0x1F
+#define PAC1934_SLOW_REG_ADDR			0x20
 #define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
 #define PAC1934_PID_REG_ADDR			0xFD
 #define PAC1934_MID_REG_ADDR			0xFE
@@ -1265,8 +1266,23 @@ static int pac1934_chip_configure(struct pac1934_chip_info *info)
 	/* no SLOW triggered REFRESH, clear POR */
 	regs[PAC1934_SLOW_REG_OFF] = 0;
 
-	ret =  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
-					  ARRAY_SIZE(regs), (u8 *)regs);
+	/*
+	 * Write the three bytes sequentially, as the device does not support
+	 * block write.
+	 */
+	ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
+					regs[PAC1934_CHANNEL_DIS_REG_OFF]);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client,
+					PAC1934_CTRL_STAT_REGS_ADDR + PAC1934_NEG_PWR_REG_OFF,
+					regs[PAC1934_NEG_PWR_REG_OFF]);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, PAC1934_SLOW_REG_ADDR,
+					regs[PAC1934_SLOW_REG_OFF]);
 	if (ret)
 		return ret;
 
-- 
2.51.0



