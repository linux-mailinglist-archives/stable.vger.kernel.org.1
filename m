Return-Path: <stable+bounces-20193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39216854CA7
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBFD1C2158F
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C397B5D480;
	Wed, 14 Feb 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTzjSrhi"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C65D467
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924413; cv=none; b=YcTm0j7QKVUQfcVbtS3PyAoCoMBubTDwT2BFy0iGi11sBrGbF42D9kdToqIP0TeUIEPF51lq5CTK18RSK2rbeet4uwQQk+ckN+Wr6IMxSeHdePVW/qSfZ8XqVcINXjgiD9I5WYP8JbffcjKF4GXcY5N2xGpbqL4H7RSqmzqbrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924413; c=relaxed/simple;
	bh=FuJpeeRm/oAFUDIsfDsz8iMYRPJUYAdfX63huvw+guw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Wtvbi6eqbLEWaGyv9Vra1Fmfo+7wp3zWEhcFmbmFerJzxohpyLv0oFIP95iDsEXP4OGYHdyN7FTFIERQFG0hpeXIRPsNmTt2YP+5702/VsaoUW+AqBVoIC7MbIGO4zcvi7S4ah3xTQXjdxgfWmRRtZmB7VoHVdBkTWg2YS2uhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTzjSrhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F77C433C7;
	Wed, 14 Feb 2024 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924413;
	bh=FuJpeeRm/oAFUDIsfDsz8iMYRPJUYAdfX63huvw+guw=;
	h=Subject:To:From:Date:From;
	b=mTzjSrhiO3+d14ME0KNHnOw9u29qudTv4/RqK4/iudGsjxzzmu2Aj/11wjLbF0Vhh
	 xfeXds2ReSJCsFmv/vi2fZWeKxgCIH7wtYmDxD//LUyS9TJtEqTUnMNwqR1W0YZYaZ
	 GM2bdHUKpkUmZieAe8LWlbbCxrxh7NbuYuSt1TsM=
Subject: patch "iio: accel: bma400: Fix a compilation problem" added to char-misc-linus
To: mario.limonciello@amd.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:12 +0100
Message-ID: <2024021412-handbrake-jubilant-91ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: accel: bma400: Fix a compilation problem

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 4cb81840d8f29b66d9d05c6d7f360c9560f7e2f4 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 31 Jan 2024 16:52:46 -0600
Subject: iio: accel: bma400: Fix a compilation problem

The kernel fails when compiling without `CONFIG_REGMAP_I2C` but with
`CONFIG_BMA400`.
```
ld: drivers/iio/accel/bma400_i2c.o: in function `bma400_i2c_probe':
bma400_i2c.c:(.text+0x23): undefined reference to `__devm_regmap_init_i2c'
```

Link: https://download.01.org/0day-ci/archive/20240131/202401311634.FE5CBVwe-lkp@intel.com/config
Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
Fixes: 9bea10642396 ("iio: accel: bma400: add support for bma400 spi")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20240131225246.14169-1-mario.limonciello@amd.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 91adcac875a4..c9d7afe489e8 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -219,10 +219,12 @@ config BMA400
 
 config BMA400_I2C
 	tristate
+	select REGMAP_I2C
 	depends on BMA400
 
 config BMA400_SPI
 	tristate
+	select REGMAP_SPI
 	depends on BMA400
 
 config BMC150_ACCEL
-- 
2.43.1



