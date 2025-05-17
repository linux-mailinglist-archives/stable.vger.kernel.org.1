Return-Path: <stable+bounces-144693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE0DABAB43
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 19:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657ED4A1E54
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920AC209F45;
	Sat, 17 May 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DcyE+Ih"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B1747F
	for <stable@vger.kernel.org>; Sat, 17 May 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747501803; cv=none; b=D6wFhdIHYoEcvY3Rawepfy/BkWNb+fq/MtNxqQbQlmtXGPwh2zleYSzCJV6gpsnjTiGCCm9W9Fo2InQkLXjFob2v6o+yxHdGKkQg/7iAPcQ0J1yOWXy3syjzKFa03CaAr9FQeonQGKOWXb7P4b10yULxuoKnOVn8Eo2z3ZlrvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747501803; c=relaxed/simple;
	bh=3Q2uQtbS0TwdJLonhG2wzutXgpQ/l87O196qpSBKW74=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h7rN/36/6zBYHaqUgWC4MSCMJJixuB8KeIlyQhVf7AQj7cm+Q7Urvls7Q6jwB1uTwebSE4Nrkx7n/rISV4ZVUqcLwg0xMmCIGlluliWtX0yL4m2ldS8pukJ7w69VmW5egpfXUZV0YRZtQoGHPXvm67zNTNUSqjEUTdfD7Q/lx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DcyE+Ih; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b115fb801bcso3023110a12.3
        for <stable@vger.kernel.org>; Sat, 17 May 2025 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747501801; x=1748106601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LtoZv7L+uQHZo85O7tV0lhxa0GdHzk5iFE9SupDBP24=;
        b=3DcyE+Ih1QPY3vhomPcernRSZJtenO66gIcHJhd42jj0DB2fvOrqBZszBP/LrpLvRL
         HIuPyH60kF+kTQZn74vKmFspPNOLdKxHvaVzj9JGn7b3laAv3M8apYUjmvet3z4hpHiB
         ZuIFdal/j6MwFS73/lxaECVUdCjYbeYonhUbwLXRTWEOYj9M0H9qc0E/F7qMZkS7xXwJ
         7QyFiBk08KaF6Z/dIFwTc9UkRTevN7zpNHIG4yWvq7nbWMH9W96QdIe0OxhrRQFYdd7F
         2RCIounxrD2KkDJDJ3gw/97Adex0y5E1PW9OxO7ATZJB6GOX8oGanPIm05BdO7rukT6k
         e1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747501801; x=1748106601;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtoZv7L+uQHZo85O7tV0lhxa0GdHzk5iFE9SupDBP24=;
        b=YYu5luWtIzAxVerksV10pFcbWjczmcy+7fdwUYDH+EeCbvoYD1Q2K7d3cKfOYhVXE6
         by9S5gJ5F+B2F66yOerFJtC8QsQlaXBO9m5n+Kura10le3q4D9POXgFshxnZArHq4V+2
         3iCFM5HrnS3skhZ8QBo0Wu3qWVSz5+/iH3J8Vzy5ZS+7/OphYgPAAIbZnvSTMMJcFfSo
         8RnCY/KX67Dcpitsr4wukS1mmpFOr9uyYOmeqPfhfgifgOKtd1WAFdyNc2xDUwnb1tVT
         bHjfpe/77FGaOnM2PLlnsGhw7eizDefdnz/9xKaden+HsSn3CpEyU+WSTeCIgSLaQ5+4
         7EqA==
X-Forwarded-Encrypted: i=1; AJvYcCXlIecbnunv/bvOJbRFnl+HDVLPdJmlWHjo5IIc2H34cespEU8bHgCZ84+Vwy/UDdG+w8VZ5vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nPAalHqE78M9fA7i6egbAZzAzHgt0djQkTpRPh3du6EJSiwp
	ovv0uFvC2IK8G78IaU43lGluQyZ7yTMWFb/9MVwmvZnsDPdSUlni6q8DpElBrd75GygNZkG2bQ4
	n1NKfbiDY99zqrA==
X-Google-Smtp-Source: AGHT+IFOUOpcz/ZDUCnYzVgtcWcR1sH4ylYN+CW1nr0jijT1SCfosVFbBi/eOfCIXHBMUFzKCx+3+3jyy+0UtQ==
X-Received: from pgii13.prod.google.com ([2002:a63:220d:0:b0:b1f:ffc9:5f4d])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a1a:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-216219eddfcmr11001348637.36.1747501801030;
 Sat, 17 May 2025 10:10:01 -0700 (PDT)
Date: Sat, 17 May 2025 17:09:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250517170957.1317876-1-cmllamas@google.com>
Subject: [PATCH v2] binder: fix use-after-free in binderfs_evict_inode()
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: kernel-team@android.com, Dmitry Antipov <dmantipov@yandex.ru>, stable@vger.kernel.org, 
	syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Dmitry Antipov <dmantipov@yandex.ru>

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
---
v1:
https://lore.kernel.org/all/20250324132427.922495-1-dmantipov@yandex.ru/

v2:
- Collect tags. Actually Cc Greg and stable@ this time.

 drivers/android/binder.c          | 15 +++++++++++++--
 drivers/android/binder_internal.h |  8 ++++++--
 drivers/android/binderfs.c        |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5fc2c8ee61b1..8d9c5f436fca 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -79,6 +79,8 @@ static HLIST_HEAD(binder_deferred_list);
 static DEFINE_MUTEX(binder_deferred_lock);
 
 static HLIST_HEAD(binder_devices);
+static DEFINE_SPINLOCK(binder_devices_lock);
+
 static HLIST_HEAD(binder_procs);
 static DEFINE_MUTEX(binder_procs_lock);
 
@@ -6929,7 +6931,16 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
 
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
@@ -6956,7 +6967,7 @@ static int __init init_binder_device(const char *name)
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
 
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 6a66c9769c6c..1ba5caf1d88d 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -583,9 +583,13 @@ struct binder_object {
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
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 94c6446604fc..44d430c4ebef 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -274,7 +274,7 @@ static void binderfs_evict_inode(struct inode *inode)
 	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
-		hlist_del_init(&device->hlist);
+		binder_remove_device(device);
 		kfree(device->context.name);
 		kfree(device);
 	}
-- 
2.49.0.1101.gccaa498523-goog


