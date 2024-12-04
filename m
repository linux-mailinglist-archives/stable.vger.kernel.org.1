Return-Path: <stable+bounces-98498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4709E455A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BC2B36696
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC822F38A;
	Wed,  4 Dec 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsR+YJhr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6C22F383;
	Wed,  4 Dec 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332344; cv=none; b=rfghSARxN88RCjd9GYywO3JhhBZdWMZIsVKTq4NYkCYoJzhQnjB6FrO2ZBU9VhiVuez+rm1j10byVIjr0J5dM0384kauLDY5oZZJb6d01TzdAeULPQhIdgs6ajFgsahGC1eZl2Esso85+UQIj5X5gCV2MfKY4XXoknitY9IodCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332344; c=relaxed/simple;
	bh=rxoBcMFbJyrz7iCwfBybM9Sod743Iqe6GpVYyVawzFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3YlJNeHPPjgmZUTKiuwvh3ufp44+r6hN3tbex/fE3fhuFYXbKPHvsXOc1zmCD+XRm/x3q5rtHrXWsD5Bg9E/6N8/ONj/vB8PMpvw3FbTXqzXjnikJZe2Vp6otN8NJGfNEN4sOEd8xudVssFEHfqPLjDzhlL+iI9i7boGKFmm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsR+YJhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21A6C4CECD;
	Wed,  4 Dec 2024 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332344;
	bh=rxoBcMFbJyrz7iCwfBybM9Sod743Iqe6GpVYyVawzFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsR+YJhraxY1ps9zz+bLi2TrgvT7PpEAVoLq9ttNro2KefwMImRvLHcuTvfPxkjqa
	 5iZ6v6ohmmaCZyLJZMTazhu8C2qr/o2YapC1BihXgBLBX/qDYgZqGIccF5bkGF5cyb
	 c84EUUFqTRG/n5Ln4yVNhsjSlyESDdXAvsLOF26h7GqjXy5StiL8jYvjSwDApghoEE
	 mJx6urO36bv+JvLbsbU5mGX2ED7KYNp5XyMGA4IcvygNkBSo6TMjg/jojDL16u057u
	 +v1Ied5JhKEFz0+kjVpJ1WMT5UTAo6G4vE7dd/HlMD88IJvHfBdlXuJKYcMPsv2gIn
	 PTjgbO9maQkRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Defa Li <defa.li@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-i3c@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 11/13] i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock
Date: Wed,  4 Dec 2024 11:00:36 -0500
Message-ID: <20241204160044.2216380-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Defa Li <defa.li@mediatek.com>

[ Upstream commit 6cf7b65f7029914dc0cd7db86fac9ee5159008c6 ]

A deadlock may happen since the i3c_master_register() acquires
&i3cbus->lock twice. See the log below.
Use i3cdev->desc->info instead of calling i3c_device_info() to
avoid acquiring the lock twice.

v2:
  - Modified the title and commit message

============================================
WARNING: possible recursive locking detected
6.11.0-mainline
--------------------------------------------
init/1 is trying to acquire lock:
f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_bus_normaluse_lock

but task is already holding lock:
f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_master_register

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&i3cbus->lock);
  lock(&i3cbus->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by init/1:
 #0: fcffff809b6798f8 (&dev->mutex){....}-{3:3}, at: __driver_attach
 #1: f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_master_register

stack backtrace:
CPU: 6 UID: 0 PID: 1 Comm: init
Call trace:
 dump_backtrace+0xfc/0x17c
 show_stack+0x18/0x28
 dump_stack_lvl+0x40/0xc0
 dump_stack+0x18/0x24
 print_deadlock_bug+0x388/0x390
 __lock_acquire+0x18bc/0x32ec
 lock_acquire+0x134/0x2b0
 down_read+0x50/0x19c
 i3c_bus_normaluse_lock+0x14/0x24
 i3c_device_get_info+0x24/0x58
 i3c_device_uevent+0x34/0xa4
 dev_uevent+0x310/0x384
 kobject_uevent_env+0x244/0x414
 kobject_uevent+0x14/0x20
 device_add+0x278/0x460
 device_register+0x20/0x34
 i3c_master_register_new_i3c_devs+0x78/0x154
 i3c_master_register+0x6a0/0x6d4
 mtk_i3c_master_probe+0x3b8/0x4d8
 platform_probe+0xa0/0xe0
 really_probe+0x114/0x454
 __driver_probe_device+0xa0/0x15c
 driver_probe_device+0x3c/0x1ac
 __driver_attach+0xc4/0x1f0
 bus_for_each_dev+0x104/0x160
 driver_attach+0x24/0x34
 bus_add_driver+0x14c/0x294
 driver_register+0x68/0x104
 __platform_driver_register+0x20/0x30
 init_module+0x20/0xfe4
 do_one_initcall+0x184/0x464
 do_init_module+0x58/0x1ec
 load_module+0xefc/0x10c8
 __arm64_sys_finit_module+0x238/0x33c
 invoke_syscall+0x58/0x10c
 el0_svc_common+0xa8/0xdc
 do_el0_svc+0x1c/0x28
 el0_svc+0x50/0xac
 el0t_64_sync_handler+0x70/0xbc
 el0t_64_sync+0x1a8/0x1ac

Signed-off-by: Defa Li <defa.li@mediatek.com>
Link: https://lore.kernel.org/r/20241107132549.25439-1-defa.li@mediatek.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42e..5e3b63f78d2d2 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -282,7 +282,8 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
 	struct i3c_device_info devinfo;
 	u16 manuf, part, ext;
 
-	i3c_device_get_info(i3cdev, &devinfo);
+	if (i3cdev->desc)
+		devinfo = i3cdev->desc->info;
 	manuf = I3C_PID_MANUF_ID(devinfo.pid);
 	part = I3C_PID_PART_ID(devinfo.pid);
 	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
-- 
2.43.0


