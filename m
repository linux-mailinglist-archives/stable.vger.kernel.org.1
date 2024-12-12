Return-Path: <stable+bounces-103700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42FE9EF875
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817EB2950E8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B869F6F2FE;
	Thu, 12 Dec 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IzF2rD2S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF013CA81;
	Thu, 12 Dec 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025343; cv=none; b=GLmHG6dUNgVp3+3K6h2ayBWXK6xpg7JvUlHNRi4hhu78YWsNsvHoL3Eiyqd73n8IWE5jpogLAHc5Tn6HKtj87o1+3jWNZHihSfjmxiwwYJDIjnqXy9wBS7GY4G5o5Mwig0NMKOD5LHRRG/rmdqcEtlZhG3tA7lntALxCG77NvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025343; c=relaxed/simple;
	bh=x1u3HDQ7kgPbnTX07rHFmRgklqScUahQQVbad7Pt4aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnUPiNJwXPF+JGtkaE2b8Xamb+FVNNIanXJuoqklK1cMbfvvMeRIQI59h1IL8iOWu8rydgkMFZJFTOXum91whQcMKRXVsd3swoKfpC2rw2Nzb9h0XsIYMuJWTRVSrWYjyuGQqedp7aOA95sF8mFkzUmGyUDDLNkGAENA60gCJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IzF2rD2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9E8C4CECE;
	Thu, 12 Dec 2024 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025343;
	bh=x1u3HDQ7kgPbnTX07rHFmRgklqScUahQQVbad7Pt4aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IzF2rD2SjMXYdly7OEXsYWY7ASJlIjtCyOJXBxzkEY+IIXaUUJJQjEHoKaIZJrIlX
	 tz7fKwD7X628rWdMJ32l/M5RY17Q4/sDAovfiMNCP4czkuurGDLe+r6xHyw+KKINjP
	 4BlJzIjcD2cWKRYTUSK4rtLvg2yV8fm1j3rYBE90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com,
	syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com,
	Oliver Neukum <oneukum@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 137/321] USB: chaoskey: Fix possible deadlock chaoskey_list_lock
Date: Thu, 12 Dec 2024 16:00:55 +0100
Message-ID: <20241212144235.390868204@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit d73dc7b182be4238b75278bfae16afb4c5564a58 ]

[Syzbot reported two possible deadlocks]
The first possible deadlock is:
WARNING: possible recursive locking detected
6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0 Not tainted
--------------------------------------------
syz-executor363/2651 is trying to acquire lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x15d/0x2c0 drivers/usb/misc/chaoskey.c:322

but task is already holding lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x7f/0x2c0 drivers/usb/misc/chaoskey.c:299

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(chaoskey_list_lock);
  lock(chaoskey_list_lock);

 *** DEADLOCK ***

The second possible deadlock is:
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0 Not tainted
------------------------------------------------------
kworker/0:2/804 is trying to acquire lock:
ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186

but task is already holding lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_disconnect+0xa8/0x2a0 drivers/usb/misc/chaoskey.c:235

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (chaoskey_list_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       chaoskey_open+0xdd/0x220 drivers/usb/misc/chaoskey.c:274
       usb_open+0x186/0x220 drivers/usb/core/file.c:47
       chrdev_open+0x237/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x6cb/0x1390 fs/open.c:958
       vfs_open+0x82/0x3f0 fs/open.c:1088
       do_open fs/namei.c:3774 [inline]
       path_openat+0x1e6a/0x2d60 fs/namei.c:3933
       do_filp_open+0x1dc/0x430 fs/namei.c:3960
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
       do_sys_open fs/open.c:1430 [inline]
       __do_sys_openat fs/open.c:1446 [inline]
       __se_sys_openat fs/open.c:1441 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1441
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (minor_rwsem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
       chaoskey_disconnect+0xb7/0x2a0 drivers/usb/misc/chaoskey.c:236
       usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
       device_remove drivers/base/dd.c:569 [inline]
       device_remove+0x122/0x170 drivers/base/dd.c:561
       __device_release_driver drivers/base/dd.c:1273 [inline]
       device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
       bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
       device_del+0x396/0x9f0 drivers/base/core.c:3864
       usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
       usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
       hub_port_connect drivers/usb/core/hub.c:5361 [inline]
       hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
       port_event drivers/usb/core/hub.c:5821 [inline]
       hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(chaoskey_list_lock);
                               lock(minor_rwsem);
                               lock(chaoskey_list_lock);
  lock(minor_rwsem);

 *** DEADLOCK ***
[Analysis]
The first is AA lock, it because wrong logic, it need a unlock.
The second is AB lock, it needs to rearrange the order of lock usage.

Fixes: 422dc0a4d12d ("USB: chaoskey: fail open after removal")
Reported-by: syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com
Reported-by: syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=685e14d04fe35692d3bc
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Tested-by: syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com
Reported-by: syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com
Tested-by: syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com
Tested-by: syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/tencent_84EB865C89862EC22EE94CB3A7C706C59206@qq.com
Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/chaoskey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 32fa7fd50c380..d99d424c05a7a 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -233,10 +233,10 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	if (dev->hwrng_registered)
 		hwrng_unregister(&dev->hwrng);
 
-	mutex_lock(&chaoskey_list_lock);
 	usb_deregister_dev(interface, &chaoskey_class);
 
 	usb_set_intfdata(interface, NULL);
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
 
 	dev->present = false;
@@ -320,7 +320,7 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 bail:
 	mutex_unlock(&dev->lock);
 destruction:
-	mutex_lock(&chaoskey_list_lock);
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "release success");
 	return rv;
 }
-- 
2.43.0




