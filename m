Return-Path: <stable+bounces-134139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DCFA9296D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0111B63236
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2361DF733;
	Thu, 17 Apr 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EPzIhK4M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0771D07BA;
	Thu, 17 Apr 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915216; cv=none; b=l6nZaqQMTf1R5387blXUtLxrz99AwLAPFKVa2vYWNPEkHzTjXNDpraabmUeaJi4f10HsVgIx1jjOpt5DHP6L/boJkAA+4K3umUAxsp05FJ3XBcHa8nnNCGk4vVNINdGn+3FqNczLXFQZvcrNRPrDxf677z+VDmUX4HYPxJSfjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915216; c=relaxed/simple;
	bh=jXlvXIWq7rHBr54dtlSpLXBgQinAprOh9jFlsoOUPyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9iNh98JFziEk0VHGZ1bKWoKlM+22TSJrZfiBTjdKEB/0gePUQ+9aDQuCMQeQUGA+sNKih1O+lV1TcV9dDIRouJEitpvqy3nKSRKTO/RON0NtqDKS7QB3SAqKDSFtcEt8JZidb3OLOTHt3PANZmnomUL9rw0Hm72E/1k8cku2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EPzIhK4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246FEC4CEE4;
	Thu, 17 Apr 2025 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915216;
	bh=jXlvXIWq7rHBr54dtlSpLXBgQinAprOh9jFlsoOUPyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPzIhK4MA4U5fGuX9VknroZIRWWYMJsENEwDb5IKwCLLmAtfg2eOPr10Q99e0OcHx
	 R+V0gGdqCGKWxZqUhftTkHtJ/tnV28es1ZMZAbFxiC2MeAfLnVM/m7j99ha6tSlP/G
	 KFVQOUxpRapPZymfiovZp2oOGnKiRBUk5cJzjIO0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+ace60642828c074eb913@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 054/393] PM: hibernate: Avoid deadlock in hibernate_compressor_param_set()
Date: Thu, 17 Apr 2025 19:47:43 +0200
Message-ID: <20250417175109.760597369@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit 52323ed1444ea5c2a5f1754ea0a2d9c8c216ccdf ]

syzbot reported a deadlock in lock_system_sleep() (see below).

The write operation to "/sys/module/hibernate/parameters/compressor"
conflicts with the registration of ieee80211 device, resulting in a deadlock
when attempting to acquire system_transition_mutex under param_lock.

To avoid this deadlock, change hibernate_compressor_param_set() to use
mutex_trylock() for attempting to acquire system_transition_mutex and
return -EBUSY when it fails.

Task flags need not be saved or adjusted before calling
mutex_trylock(&system_transition_mutex) because the caller is not going
to end up waiting for this mutex and if it runs concurrently with system
suspend in progress, it will be frozen properly when it returns to user
space.

syzbot report:

syz-executor895/5833 is trying to acquire lock:
ffffffff8e0828c8 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_sleep+0x87/0xa0 kernel/power/main.c:56

but task is already holding lock:
ffffffff8e07dc68 (param_lock){+.+.}-{4:4}, at: kernel_param_lock kernel/params.c:607 [inline]
ffffffff8e07dc68 (param_lock){+.+.}-{4:4}, at: param_attr_store+0xe6/0x300 kernel/params.c:586

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (param_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       ieee80211_rate_control_ops_get net/mac80211/rate.c:220 [inline]
       rate_control_alloc net/mac80211/rate.c:266 [inline]
       ieee80211_init_rate_ctrl_alg+0x18d/0x6b0 net/mac80211/rate.c:1015
       ieee80211_register_hw+0x20cd/0x4060 net/mac80211/main.c:1531
       mac80211_hwsim_new_radio+0x304e/0x54e0 drivers/net/wireless/virtual/mac80211_hwsim.c:5558
       init_mac80211_hwsim+0x432/0x8c0 drivers/net/wireless/virtual/mac80211_hwsim.c:6910
       do_one_initcall+0x128/0x700 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c7/0x900 init/main.c:1568
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       wg_pm_notification drivers/net/wireguard/device.c:80 [inline]
       wg_pm_notification+0x49/0x180 drivers/net/wireguard/device.c:64
       notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
       notifier_call_chain_robust kernel/notifier.c:120 [inline]
       blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
       blocking_notifier_call_chain_robust+0xc9/0x170 kernel/notifier.c:333
       pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
       snapshot_open+0x189/0x2b0 kernel/power/user.c:77
       misc_open+0x35a/0x420 drivers/char/misc.c:179
       chrdev_open+0x237/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x735/0x1c40 fs/open.c:956
       vfs_open+0x82/0x3f0 fs/open.c:1086
       do_open fs/namei.c:3830 [inline]
       path_openat+0x1e88/0x2d80 fs/namei.c:3989
       do_filp_open+0x20c/0x470 fs/namei.c:4016
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
       do_sys_open fs/open.c:1443 [inline]
       __do_sys_openat fs/open.c:1459 [inline]
       __se_sys_openat fs/open.c:1454 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1454
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 ((pm_chain_head).rwsem){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       blocking_notifier_call_chain_robust kernel/notifier.c:344 [inline]
       blocking_notifier_call_chain_robust+0xa9/0x170 kernel/notifier.c:333
       pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
       snapshot_open+0x189/0x2b0 kernel/power/user.c:77
       misc_open+0x35a/0x420 drivers/char/misc.c:179
       chrdev_open+0x237/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x735/0x1c40 fs/open.c:956
       vfs_open+0x82/0x3f0 fs/open.c:1086
       do_open fs/namei.c:3830 [inline]
       path_openat+0x1e88/0x2d80 fs/namei.c:3989
       do_filp_open+0x20c/0x470 fs/namei.c:4016
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
       do_sys_open fs/open.c:1443 [inline]
       __do_sys_openat fs/open.c:1459 [inline]
       __se_sys_openat fs/open.c:1454 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1454
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (system_transition_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       lock_system_sleep+0x87/0xa0 kernel/power/main.c:56
       hibernate_compressor_param_set+0x1c/0x210 kernel/power/hibernate.c:1452
       param_attr_store+0x18f/0x300 kernel/params.c:588
       module_attr_store+0x55/0x80 kernel/params.c:924
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0x5ae/0x1150 fs/read_write.c:679
       ksys_write+0x12b/0x250 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  system_transition_mutex --> rtnl_mutex --> param_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(param_lock);
                               lock(rtnl_mutex);
                               lock(param_lock);
  lock(system_transition_mutex);

 *** DEADLOCK ***

Reported-by: syzbot+ace60642828c074eb913@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ace60642828c074eb913
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20250224013139.3994500-1-lizhi.xu@windriver.com
[ rjw: New subject matching the code changes, changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/hibernate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index b483fcea811b1..d8bad1eeedd3e 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1443,10 +1443,10 @@ static const char * const comp_alg_enabled[] = {
 static int hibernate_compressor_param_set(const char *compressor,
 		const struct kernel_param *kp)
 {
-	unsigned int sleep_flags;
 	int index, ret;
 
-	sleep_flags = lock_system_sleep();
+	if (!mutex_trylock(&system_transition_mutex))
+		return -EBUSY;
 
 	index = sysfs_match_string(comp_alg_enabled, compressor);
 	if (index >= 0) {
@@ -1458,7 +1458,7 @@ static int hibernate_compressor_param_set(const char *compressor,
 		ret = index;
 	}
 
-	unlock_system_sleep(sleep_flags);
+	mutex_unlock(&system_transition_mutex);
 
 	if (ret)
 		pr_debug("Cannot set specified compressor %s\n",
-- 
2.39.5




