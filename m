Return-Path: <stable+bounces-15327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC68384CB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C6A28DCA4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474376905;
	Tue, 23 Jan 2024 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TogdCouh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225974E23;
	Tue, 23 Jan 2024 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975492; cv=none; b=bwmJ9Kz4WeF8Kija87oU7Rz7yWAzb/NS3AyCNb37nna2bVXyID4LOwYGeV7rJRMhe4SZme1CgNAP2p3FT2w7trvaohwF8zfSLKS+8/rOa4dCkhTbPYGaJc+2/jD7hj092MwOSHkMnrFrnJMXDkJ9hyKKJrkBURWxqub3CkVU8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975492; c=relaxed/simple;
	bh=yHbhnqpRmS/WZBJgpqyCiW7kqjklI0J/ZB/3ylEORMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5YOVfEU3Ulpa7bOp3SVK+Ifhy9VB7gTk4tidPPBjzjVpdYSqcYfxHlRtQ48Gd5ONkI7iKNuV9e40mAfBG2PM/iVNNwzGbx0DF4dqkbr4fFcU63Uaa2sfItSUJR1NcMu/odH/Ac9+yjTlN/tJS6IrEqrz3/FnsFty5gQzCjMvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TogdCouh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE11C433C7;
	Tue, 23 Jan 2024 02:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975492;
	bh=yHbhnqpRmS/WZBJgpqyCiW7kqjklI0J/ZB/3ylEORMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TogdCouh79wOxba97reW3DfzZ8BK/69sIDbWYOvBOnGdtQ8F1quNyjOYiVddKBBjn
	 S/qXucJ2AmLZM0hVwMh7xwcKHCUiRoZIT87xrvcFeAOsZqr/BXap33ecKV5X6WPhhI
	 mfTc7NMBzkc9VcXbci5oC8y4oo+culbCxR/Gr/Tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adam Green <greena88@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 438/583] mfd: rk8xx: fixup devices registration with PLATFORM_DEVID_AUTO
Date: Mon, 22 Jan 2024 15:58:09 -0800
Message-ID: <20240122235825.377147984@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 4aedcd4aa61d536ca17e67ecd5bc5d42529164f4 ]

Since commit 210f418f8ace ("mfd: rk8xx: Add rk806 support"), devices are
registered with "0" as id, causing devices to not have an automatic device id
and prevents having multiple RK8xx PMICs on the same system.

Properly pass PLATFORM_DEVID_AUTO to devm_mfd_add_devices() and since
it will ignore the cells .id with this special value, also cleanup
by removing all now ignored cells .id values.

Now we have the same behaviour as before rk806 introduction and rk806
retains the intended behavior.

This fixes a regression while booting the Odroid Go Ultra on v6.6.1:
sysfs: cannot create duplicate filename '/bus/platform/devices/rk808-clkout'
CPU: 3 PID: 97 Comm: kworker/u12:2 Not tainted 6.6.1 #1
Hardware name: Hardkernel ODROID-GO-Ultra (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
dump_backtrace+0x9c/0x11c
show_stack+0x18/0x24
dump_stack_lvl+0x78/0xc4
dump_stack+0x18/0x24
sysfs_warn_dup+0x64/0x80
sysfs_do_create_link_sd+0xf0/0xf8
sysfs_create_link+0x20/0x40
bus_add_device+0x114/0x160
device_add+0x3f0/0x7cc
platform_device_add+0x180/0x270
mfd_add_device+0x390/0x4a8
devm_mfd_add_devices+0xb0/0x150
rk8xx_probe+0x26c/0x410
rk8xx_i2c_probe+0x64/0x98
i2c_device_probe+0x104/0x2e8
really_probe+0x184/0x3c8
__driver_probe_device+0x7c/0x16c
driver_probe_device+0x3c/0x10c
__device_attach_driver+0xbc/0x158
bus_for_each_drv+0x80/0xdc
__device_attach+0x9c/0x1ac
device_initial_probe+0x14/0x20
bus_probe_device+0xac/0xb0
deferred_probe_work_func+0xa0/0xf4
process_one_work+0x1bc/0x378
worker_thread+0x1dc/0x3d4
kthread+0x104/0x118
ret_from_fork+0x10/0x20
rk8xx-i2c 0-001c: error -EEXIST: failed to add MFD devices
rk8xx-i2c: probe of 0-001c failed with error -17

Fixes: 210f418f8ace ("mfd: rk8xx: Add rk806 support")
Reported-by: Adam Green <greena88@gmail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v2-1-3f1bad68ab9d@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/rk8xx-core.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 11a831e92da8..a577f950c632 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -53,76 +53,68 @@ static const struct resource rk817_charger_resources[] = {
 };
 
 static const struct mfd_cell rk805s[] = {
-	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk805-pinctrl", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
+	{ .name = "rk805-pinctrl", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = &rtc_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
 	{	.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk805_key_resources),
 		.resources = &rk805_key_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk806s[] = {
-	{ .name = "rk805-pinctrl", .id = PLATFORM_DEVID_AUTO, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_AUTO, },
+	{ .name = "rk805-pinctrl", },
+	{ .name = "rk808-regulator", },
 	{
 		.name = "rk805-pwrkey",
 		.resources = rk806_pwrkey_resources,
 		.num_resources = ARRAY_SIZE(rk806_pwrkey_resources),
-		.id = PLATFORM_DEVID_AUTO,
 	},
 };
 
 static const struct mfd_cell rk808s[] = {
-	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = rtc_resources,
-		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk817s[] = {
-	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
 	{
 		.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk817_pwrkey_resources),
 		.resources = &rk817_pwrkey_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rk817_rtc_resources),
 		.resources = &rk817_rtc_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
-	{ .name = "rk817-codec", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk817-codec", },
 	{
 		.name = "rk817-charger",
 		.num_resources = ARRAY_SIZE(rk817_charger_resources),
 		.resources = &rk817_charger_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk818s[] = {
-	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = rtc_resources,
-		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
@@ -680,7 +672,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 					     pre_init_reg[i].addr);
 	}
 
-	ret = devm_mfd_add_devices(dev, 0, cells, nr_cells, NULL, 0,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, nr_cells, NULL, 0,
 			      regmap_irq_get_domain(rk808->irq_data));
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
-- 
2.43.0




