Return-Path: <stable+bounces-98433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFF09E415F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EBA167BCF
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE98223A9C;
	Wed,  4 Dec 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaiJa/1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE45223A96;
	Wed,  4 Dec 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331763; cv=none; b=rZCngLrmjqb8+HS7IBsicXAptwTwbpCD3b7F9jz0uHILADTe2RBTiMwnORGxAHxti8QCJqIwFP7F1zWlKQaXSMUWtfImsM8Se+cJe7rAM9MbnYySBHT6OS/ESiSgWEcC0fcUbcZtMzh0atT6SR7CjYx5V+ObW9t3vHYfJCygHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331763; c=relaxed/simple;
	bh=JyOC5EEdu2tdkVGstYkePGugiBeei51zMxzYS/bghik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG8jD3dWQSDqbfG078KP2gMc0/KqVh2KwJPyIrtZSudOoYKzFSfWLpA/YVbEEKe1MDlkg4hAFQiGdZIdLGEkVUTo6EIaLP3L51PVqJIgZ8f2erxAAYQSs+eDtoFhbs4+NTL7V1jT0hpjZasZ7nwpLeo+tHB2YhGDAmqWgVigWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaiJa/1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE58C4CED1;
	Wed,  4 Dec 2024 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331763;
	bh=JyOC5EEdu2tdkVGstYkePGugiBeei51zMxzYS/bghik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TaiJa/1vyiAX9O7pg35DjcFj05yUTCCbeIWi+tDimWfiqSpE74iWx/1nc6gdDlzF4
	 l5p/9qTViAOUFS5jCB+oAzUCH7zcCE6zw3UgBbkZjgcXC1jql2dUe1NDTc7Y/aZAsa
	 AwSjIiCJTldA0Ye0y+16wUD5+orF+NUxMNRwHlmiZL5o9yCOjoHcsxl7da4y9zJWAv
	 Xn/HoTyyyT7bAdlTQB8blw9RK18lZhrsQ2HEfRvtyImtDa1o1LiAz6bEa1ER0V7N2M
	 Nty/K7B3l+KSZU7dKuyy+RYm66GU3QAkgaTO1o6wXzuEcejUkqSrxKVmGR1P6BH+5e
	 wlwcdWqh8Ieag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 07/15] mfd: axp20x: Allow multiple regulators
Date: Wed,  4 Dec 2024 10:50:46 -0500
Message-ID: <20241204155105.2214350-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155105.2214350-1-sashal@kernel.org>
References: <20241204155105.2214350-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit e37ec32188701efa01455b9be42a392adab06ce4 ]

At the moment trying to register a second AXP chip makes the probe fail,
as some sysfs registration fails due to a duplicate name:

...
[    3.688215] axp20x-i2c 0-0035: AXP20X driver loaded
[    3.695610] axp20x-i2c 0-0036: AXP20x variant AXP323 found
[    3.706151] sysfs: cannot create duplicate filename '/bus/platform/devices/axp20x-regulator'
[    3.714718] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-00026-g50bf2e2c079d-dirty #192
[    3.724020] Hardware name: Avaota A1 (DT)
[    3.728029] Call trace:
[    3.730477]  dump_backtrace+0x94/0xec
[    3.734146]  show_stack+0x18/0x24
[    3.737462]  dump_stack_lvl+0x80/0xf4
[    3.741128]  dump_stack+0x18/0x24
[    3.744444]  sysfs_warn_dup+0x64/0x80
[    3.748109]  sysfs_do_create_link_sd+0xf0/0xf8
[    3.752553]  sysfs_create_link+0x20/0x40
[    3.756476]  bus_add_device+0x64/0x104
[    3.760229]  device_add+0x310/0x760
[    3.763717]  platform_device_add+0x10c/0x238
[    3.767990]  mfd_add_device+0x4ec/0x5c8
[    3.771829]  mfd_add_devices+0x88/0x11c
[    3.775666]  axp20x_device_probe+0x70/0x184
[    3.779851]  axp20x_i2c_probe+0x9c/0xd8
...

This is because we use PLATFORM_DEVID_NONE for the mfd_add_devices()
call, which would number the child devices in the same 0-based way, even
for the second (or any other) instance.

Use PLATFORM_DEVID_AUTO instead, which automatically assigns
non-conflicting device numbers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20241007001408.27249-4-andre.przywara@arm.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 880c41fa7021b..3c2582bc2d923 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1000,7 +1000,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		}
 	}
 
-	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
+	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x->cells,
 			      axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
-- 
2.43.0


