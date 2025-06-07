Return-Path: <stable+bounces-151794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A08AD0CA0
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A81E3B1D24
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC3F21ABDB;
	Sat,  7 Jun 2025 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mU+wZx/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A626207A22;
	Sat,  7 Jun 2025 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749291016; cv=none; b=XYbMyK1EmvBh+6cxh/qVHPxB+Qk09opeHaa0k/M/LdZdbzOIQG/lmkwwBjVgyf93wvfhjOvVuBb8v/c4hQbJv6oJNsAS+9LYzDhnwN8k2amNfxI8qWp0CxVzb4BFvKqoTZDnUnoe4iI+hLdQfkeC2HS90SouVlZFS/6bKdChUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749291016; c=relaxed/simple;
	bh=vtnj4zLckGoaq/TU0pvFQVdgkwnwOiwQdyjHmQ1IlDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBtqh7WOt5VAjExyv1Pr1XMg9E4+zNGn+a1JR+QHETCFoZFTY+bwLyjYXNtoVAPCqM6y9UsQv9EmUUsJfgjNwMxAKQ105owHfTH3ni1l74sN1R1wsnTYtDI1rRIjWXTjZpypoBGbl0NNEPgY58ayL6h5G4cFWeyiakTgHrXTEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mU+wZx/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1476C4CEE4;
	Sat,  7 Jun 2025 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749291016;
	bh=vtnj4zLckGoaq/TU0pvFQVdgkwnwOiwQdyjHmQ1IlDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mU+wZx/VevTZLhWQ7JDKlEWSwNfY1X8enKZwprADrgnpGm/YQ3wfY1MCrs2JEa3yp
	 LFKiB/pnSHevPQX2M0n7NzpJsRqYTkYtMV13oX2g+cO38edVPOkT9gD4mJ2YUvoE9W
	 kf4ei+k0t68PgoIQKwCCycOkbzpdWL7eF3c5WfOc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH 6.14 18/24] binder: fix use-after-free in binderfs_evict_inode()
Date: Sat,  7 Jun 2025 12:07:58 +0200
Message-ID: <20250607100718.410705406@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100717.706871523@linuxfoundation.org>
References: <20250607100717.706871523@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

commit 8c0a559825281764061a127632e5ad273f0466ad upstream.

Running 'stress-ng --binderfs 16 --timeout 300' under KASAN-enabled
kernel, I've noticed the following:

BUG: KASAN: slab-use-after-free in binderfs_evict_inode+0x1de/0x2d0
Write of size 8 at addr ffff88807379bc08 by task stress-ng-binde/1699

CPU: 0 UID: 0 PID: 1699 Comm: stress-ng-binde Not tainted 6.14.0-rc7-g586de92313fc-dirty #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x1c2/0x2a0
 ? __pfx_dump_stack_lvl+0x10/0x10
 ? __pfx__printk+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __virt_addr_valid+0x18c/0x540
 ? __virt_addr_valid+0x469/0x540
 print_report+0x155/0x840
 ? __virt_addr_valid+0x18c/0x540
 ? __virt_addr_valid+0x469/0x540
 ? __phys_addr+0xba/0x170
 ? binderfs_evict_inode+0x1de/0x2d0
 kasan_report+0x147/0x180
 ? binderfs_evict_inode+0x1de/0x2d0
 binderfs_evict_inode+0x1de/0x2d0
 ? __pfx_binderfs_evict_inode+0x10/0x10
 evict+0x524/0x9f0
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_evict+0x10/0x10
 ? do_raw_spin_unlock+0x4d/0x210
 ? _raw_spin_unlock+0x28/0x50
 ? iput+0x697/0x9b0
 __dentry_kill+0x209/0x660
 ? shrink_kill+0x8d/0x2c0
 shrink_kill+0xa9/0x2c0
 shrink_dentry_list+0x2e0/0x5e0
 shrink_dcache_parent+0xa2/0x2c0
 ? __pfx_shrink_dcache_parent+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 do_one_tree+0x23/0xe0
 shrink_dcache_for_umount+0xa0/0x170
 generic_shutdown_super+0x67/0x390
 kill_litter_super+0x76/0xb0
 binderfs_kill_super+0x44/0x90
 deactivate_locked_super+0xb9/0x130
 cleanup_mnt+0x422/0x4c0
 ? lockdep_hardirqs_on+0x9d/0x150
 task_work_run+0x1d2/0x260
 ? __pfx_task_work_run+0x10/0x10
 resume_user_mode_work+0x52/0x60
 syscall_exit_to_user_mode+0x9a/0x120
 do_syscall_64+0x103/0x210
 ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0xcac57b
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8
RSP: 002b:00007ffecf4226a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007ffecf422720 RCX: 0000000000cac57b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffecf422850
RBP: 00007ffecf422850 R08: 0000000028d06ab1 R09: 7fffffffffffffff
R10: 3fffffffffffffff R11: 0000000000000246 R12: 00007ffecf422718
R13: 00007ffecf422710 R14: 00007f478f87b658 R15: 00007ffecf422830
 </TASK>

Allocated by task 1705:
 kasan_save_track+0x3e/0x80
 __kasan_kmalloc+0x8f/0xa0
 __kmalloc_cache_noprof+0x213/0x3e0
 binderfs_binder_device_create+0x183/0xa80
 binder_ctl_ioctl+0x138/0x190
 __x64_sys_ioctl+0x120/0x1b0
 do_syscall_64+0xf6/0x210
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1705:
 kasan_save_track+0x3e/0x80
 kasan_save_free_info+0x46/0x50
 __kasan_slab_free+0x62/0x70
 kfree+0x194/0x440
 evict+0x524/0x9f0
 do_unlinkat+0x390/0x5b0
 __x64_sys_unlink+0x47/0x50
 do_syscall_64+0xf6/0x210
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

This 'stress-ng' workload causes the concurrent deletions from
'binder_devices' and so requires full-featured synchronization
to prevent list corruption.

I've found this issue independently but pretty sure that syzbot did
the same, so Reported-by: and Closes: should be applicable here as well.

Cc: stable@vger.kernel.org
Reported-by: syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
Fixes: e77aff5528a18 ("binderfs: fix use-after-free in binder_devices")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20250517170957.1317876-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder.c          |   15 +++++++++++++--
 drivers/android/binder_internal.h |    8 ++++++--
 drivers/android/binderfs.c        |    2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -79,6 +79,8 @@ static HLIST_HEAD(binder_deferred_list);
 static DEFINE_MUTEX(binder_deferred_lock);
 
 static HLIST_HEAD(binder_devices);
+static DEFINE_SPINLOCK(binder_devices_lock);
+
 static HLIST_HEAD(binder_procs);
 static DEFINE_MUTEX(binder_procs_lock);
 
@@ -6929,7 +6931,16 @@ const struct binder_debugfs_entry binder
 
 void binder_add_device(struct binder_device *device)
 {
+	spin_lock(&binder_devices_lock);
 	hlist_add_head(&device->hlist, &binder_devices);
+	spin_unlock(&binder_devices_lock);
+}
+
+void binder_remove_device(struct binder_device *device)
+{
+	spin_lock(&binder_devices_lock);
+	hlist_del_init(&device->hlist);
+	spin_unlock(&binder_devices_lock);
 }
 
 static int __init init_binder_device(const char *name)
@@ -6956,7 +6967,7 @@ static int __init init_binder_device(con
 		return ret;
 	}
 
-	hlist_add_head(&binder_device->hlist, &binder_devices);
+	binder_add_device(binder_device);
 
 	return ret;
 }
@@ -7018,7 +7029,7 @@ static int __init binder_init(void)
 err_init_binder_device_failed:
 	hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
 		misc_deregister(&device->miscdev);
-		hlist_del(&device->hlist);
+		binder_remove_device(device);
 		kfree(device);
 	}
 
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -584,9 +584,13 @@ struct binder_object {
 /**
  * Add a binder device to binder_devices
  * @device: the new binder device to add to the global list
- *
- * Not reentrant as the list is not protected by any locks
  */
 void binder_add_device(struct binder_device *device);
 
+/**
+ * Remove a binder device to binder_devices
+ * @device: the binder device to remove from the global list
+ */
+void binder_remove_device(struct binder_device *device);
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -274,7 +274,7 @@ static void binderfs_evict_inode(struct
 	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
-		hlist_del_init(&device->hlist);
+		binder_remove_device(device);
 		kfree(device->context.name);
 		kfree(device);
 	}



