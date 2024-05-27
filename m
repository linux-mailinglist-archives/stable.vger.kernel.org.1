Return-Path: <stable+bounces-46488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB778D06CC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A411F22112
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240815FA7B;
	Mon, 27 May 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czkf/IJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6513AD30;
	Mon, 27 May 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825139; cv=none; b=fnUirEOLrD7K/FdWjx7WilRL5xEjXpXeq0XhTY5bPabAltHFquMoP7EXf7G6ygTRGgKTwMXadFKs8tfDulNjrHpziAXoj+NPQLx/KRPirOxbRPdgKdxH5+PEvtiibYVMbiLh9KmvQHNppfy5sS7oBhnO2KQ6aOK8ffoAYsJ2pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825139; c=relaxed/simple;
	bh=GL/YyZxx6BMIEvrWqNV8jDJEZ68VHY39gC1UA0WX4rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyN0l2drrdwlcpY2RHVjBUgEoy1cdKRuVy+JBylzY9IGzUR7cRdYhK11dEZVGIZ8CAcbNcI8ZCSJRU/0dVnnospud5SxNBnbpnL1oIqaBPs8+CkYspefQSMHClN2RIq3LNuNjOR9TPWXWfUb5uO6H4hSI+WegH951mqTEh4EzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czkf/IJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4607C2BBFC;
	Mon, 27 May 2024 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825138;
	bh=GL/YyZxx6BMIEvrWqNV8jDJEZ68VHY39gC1UA0WX4rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czkf/IJRDpsCPPU/JdP5T2Yhk+ccJzHE6VVa4nxD1IrdVhDaIxgKGNvR0M8xEoV/0
	 91HWqNG414cgloDgkN7PqS+B9ix8Z1Cny61NRp44CZK73FTp8z0tq5cfWpdhpzv8yP
	 mBHePMe1WzopF3ZhsEIy1DZtsMMiRCkSvPnM0RvA9Wc/CLQUVwv4Y06hs+yni0mKY7
	 u6t86EC7KbyLJ1ZsVP8iwUooTaUCnQnbjW2sG8jPHxqUhLqHTZUOqxy5ECmZCEIgvm
	 PVLvgveOje0EbUvgI0a8Ae2tP8GWT/U7kExl9Fb35cNz3iffbHBiXfm9VDNy6k8gry
	 yXVosO/ZyMwyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 13/23] platform/x86: x86-android-tablets: Unregister devices in reverse order
Date: Mon, 27 May 2024 11:50:14 -0400
Message-ID: <20240527155123.3863983-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 3de0f2627ef849735f155c1818247f58404dddfe ]

Not all subsystems support a device getting removed while there are
still consumers of the device with a reference to the device.

One example of this is the regulator subsystem. If a regulator gets
unregistered while there are still drivers holding a reference
a WARN() at drivers/regulator/core.c:5829 triggers, e.g.:

 WARNING: CPU: 1 PID: 1587 at drivers/regulator/core.c:5829 regulator_unregister
 Hardware name: Intel Corp. VALLEYVIEW C0 PLATFORM/BYT-T FFD8, BIOS BLADE_21.X64.0005.R00.1504101516 FFD8_X64_R_2015_04_10_1516 04/10/2015
 RIP: 0010:regulator_unregister
 Call Trace:
  <TASK>
  regulator_unregister
  devres_release_group
  i2c_device_remove
  device_release_driver_internal
  bus_remove_device
  device_del
  device_unregister
  x86_android_tablet_remove

On the Lenovo Yoga Tablet 2 series the bq24190 charger chip also provides
a 5V boost converter output for powering USB devices connected to the micro
USB port, the bq24190-charger driver exports this as a Vbus regulator.

On the 830 (8") and 1050 ("10") models this regulator is controlled by
a platform_device and x86_android_tablet_remove() removes platform_device-s
before i2c_clients so the consumer gets removed first.

But on the 1380 (13") model there is a lc824206xa micro-USB switch
connected over I2C and the extcon driver for that controls the regulator.
The bq24190 i2c-client *must* be registered first, because that creates
the regulator with the lc824206xa listed as its consumer. If the regulator
has not been registered yet the lc824206xa driver will end up getting
a dummy regulator.

Since in this case both the regulator provider and consumer are I2C
devices, the only way to ensure that the consumer is unregistered first
is to unregister the I2C devices in reverse order of in which they were
created.

For consistency and to avoid similar problems in the future change
x86_android_tablet_remove() to unregister all device types in reverse
order.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240406125058.13624-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/x86-android-tablets/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index a3415f1c0b5f8..6559bb4ea7305 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -278,25 +278,25 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
 {
 	int i;
 
-	for (i = 0; i < serdev_count; i++) {
+	for (i = serdev_count - 1; i >= 0; i--) {
 		if (serdevs[i])
 			serdev_device_remove(serdevs[i]);
 	}
 
 	kfree(serdevs);
 
-	for (i = 0; i < pdev_count; i++)
+	for (i = pdev_count - 1; i >= 0; i--)
 		platform_device_unregister(pdevs[i]);
 
 	kfree(pdevs);
 	kfree(buttons);
 
-	for (i = 0; i < spi_dev_count; i++)
+	for (i = spi_dev_count - 1; i >= 0; i--)
 		spi_unregister_device(spi_devs[i]);
 
 	kfree(spi_devs);
 
-	for (i = 0; i < i2c_client_count; i++)
+	for (i = i2c_client_count - 1; i >= 0; i--)
 		i2c_unregister_device(i2c_clients[i]);
 
 	kfree(i2c_clients);
-- 
2.43.0


