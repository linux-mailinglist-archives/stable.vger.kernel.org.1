Return-Path: <stable+bounces-165213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B49B15C22
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E61D4E295E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E5295DA9;
	Wed, 30 Jul 2025 09:37:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CFA293C4D
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868245; cv=none; b=rGi5G75a/+1ynIhOT9ZPHux/VjHq+WO83bnMGThvUzwhZSoMz/5TmlX4QTHWbpeZ72hEjEXS/Km9y2fsJ/IgiQaqZ7Y78LXIwOADhsd6XkMGEpWYqUL8jT/U3O+gmGcVG+rKMknSL1qTXPEH/pj29dN473cQainiukO2SMjfvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868245; c=relaxed/simple;
	bh=geII3f8+1IufOfFybpj3YqkxAHg1oMCAenlz5bYxVnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XcO8R/w/14m2iPTs52FKldfO2jogmvE440tbnZH/tpKHpzUKkirzh6DpTu5WPSYmW2cCw4i21WZA5fQd74x9CYM624osTo+cBErhZN9aJdtH2wRjdLK+HzX1/FYiRHXY2RrZFYIgTyIQjcXRyL5/6iNbyBPOGYvrC/kLTXnRF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bsRpT4k5RzphTk;
	Wed, 30 Jul 2025 17:33:05 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id E9F8B1A0171;
	Wed, 30 Jul 2025 17:37:18 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Jul
 2025 17:37:18 +0800
From: Gu Bowen <gubowen5@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <linux-mm@kvack.org>, Lu Jialin
	<lujialin4@huawei.com>, Gu Bowen <gubowen5@huawei.com>
Subject: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
Date: Wed, 30 Jul 2025 17:49:14 +0800
Message-ID: <20250730094914.566582-1-gubowen5@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh100007.china.huawei.com (7.202.181.92)

kmemleak_scan_thread() invokes scan_block() which may invoke a nomal
printk() to print warning message. This can cause a deadlock in the
scenario reported below:

       CPU0                    CPU1
       ----                    ----
  lock(kmemleak_lock);
                               lock(&port->lock);
                               lock(kmemleak_lock);
  lock(console_owner);

To solve this problem, switch to printk_safe mode before printing warning
message, this will redirect all printk()-s to a special per-CPU buffer,
which will be flushed later from a safe context (irq work), and this
deadlock problem can be avoided.

Our syztester report the following lockdep error:

======================================================
WARNING: possible circular locking dependency detected
5.10.0-22221-gca646a51dd00 #16 Not tainted
------------------------------------------------------
kmemleak/182 is trying to acquire lock:
ffffffffaf9e9020 (console_owner){-...}-{0:0}, at: console_trylock_spinning+0xda/0x1d0 kernel/printk/printk.c:1900

but task is already holding lock:
ffffffffb007cf58 (kmemleak_lock){-.-.}-{2:2}, at: scan_block+0x3d/0x220 mm/kmemleak.c:1310

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (kmemleak_lock){-.-.}-{2:2}:
       validate_chain+0x5df/0xac0 kernel/locking/lockdep.c:3729
       __lock_acquire+0x514/0x940 kernel/locking/lockdep.c:4958
       lock_acquire+0x15a/0x3a0 kernel/locking/lockdep.c:5569
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3b/0x60 kernel/locking/spinlock.c:164
       create_object.isra.0+0x36/0x80 mm/kmemleak.c:691
       kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
       slab_post_alloc_hook mm/slab.h:518 [inline]
       slab_alloc_node mm/slub.c:2987 [inline]
       slab_alloc mm/slub.c:2995 [inline]
       __kmalloc+0x637/0xb60 mm/slub.c:4100
       kmalloc include/linux/slab.h:620 [inline]
       tty_buffer_alloc+0x127/0x140 drivers/tty/tty_buffer.c:176
       __tty_buffer_request_room+0x9b/0x110 drivers/tty/tty_buffer.c:276
       tty_insert_flip_string_fixed_flag+0x60/0x130 drivers/tty/tty_buffer.c:321
       tty_insert_flip_string include/linux/tty_flip.h:36 [inline]
       tty_insert_flip_string_and_push_buffer+0x3a/0xb0 drivers/tty/tty_buffer.c:578
       process_output_block+0xc2/0x2e0 drivers/tty/n_tty.c:592
       n_tty_write+0x298/0x540 drivers/tty/n_tty.c:2433
       do_tty_write drivers/tty/tty_io.c:1041 [inline]
       file_tty_write.constprop.0+0x29b/0x4b0 drivers/tty/tty_io.c:1147
       redirected_tty_write+0x51/0x90 drivers/tty/tty_io.c:1176
       call_write_iter include/linux/fs.h:2117 [inline]
       do_iter_readv_writev+0x274/0x350 fs/read_write.c:741
       do_iter_write+0xbb/0x1f0 fs/read_write.c:867
       vfs_writev+0xfa/0x380 fs/read_write.c:940
       do_writev+0xd6/0x1d0 fs/read_write.c:983
       do_syscall_64+0x2b/0x40 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x6c/0xd6

-> #2 (&port->lock){-.-.}-{2:2}:
       validate_chain+0x5df/0xac0 kernel/locking/lockdep.c:3729
       __lock_acquire+0x514/0x940 kernel/locking/lockdep.c:4958
       lock_acquire+0x15a/0x3a0 kernel/locking/lockdep.c:5569
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3b/0x60 kernel/locking/spinlock.c:164
       tty_port_tty_get+0x1f/0xa0 drivers/tty/tty_port.c:289
       tty_port_default_wakeup+0xb/0x30 drivers/tty/tty_port.c:48
       serial8250_tx_chars+0x259/0x430 drivers/tty/serial/8250/8250_port.c:1906
       __start_tx drivers/tty/serial/8250/8250_port.c:1598 [inline]
       serial8250_start_tx+0x304/0x320 drivers/tty/serial/8250/8250_port.c:1720
       uart_write+0x1a1/0x2e0 drivers/tty/serial/serial_core.c:635
       do_output_char+0x2c0/0x370 drivers/tty/n_tty.c:444
       process_output drivers/tty/n_tty.c:511 [inline]
       n_tty_write+0x269/0x540 drivers/tty/n_tty.c:2445
       do_tty_write drivers/tty/tty_io.c:1041 [inline]
       file_tty_write.constprop.0+0x29b/0x4b0 drivers/tty/tty_io.c:1147
       call_write_iter include/linux/fs.h:2117 [inline]
       do_iter_readv_writev+0x274/0x350 fs/read_write.c:741
       do_iter_write+0xbb/0x1f0 fs/read_write.c:867
       vfs_writev+0xfa/0x380 fs/read_write.c:940
       do_writev+0xd6/0x1d0 fs/read_write.c:983
       do_syscall_64+0x2b/0x40 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x6c/0xd6

-> #1 (&port_lock_key){-.-.}-{2:2}:
       validate_chain+0x5df/0xac0 kernel/locking/lockdep.c:3729
       __lock_acquire+0x514/0x940 kernel/locking/lockdep.c:4958
       lock_acquire+0x15a/0x3a0 kernel/locking/lockdep.c:5569
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3b/0x60 kernel/locking/spinlock.c:164
       serial8250_console_write+0x292/0x320 drivers/tty/serial/8250/8250_port.c:3458
       call_console_drivers.constprop.0+0x185/0x240 kernel/printk/printk.c:1988
       console_unlock+0x2b4/0x640 kernel/printk/printk.c:2648
       register_console.part.0+0x2a1/0x390 kernel/printk/printk.c:3024
       univ8250_console_init+0x24/0x2b drivers/tty/serial/8250/8250_core.c:724
       console_init+0x188/0x24b kernel/printk/printk.c:3134
       start_kernel+0x2b0/0x41e init/main.c:1072
       secondary_startup_64_no_verify+0xc3/0xcb

-> #0 (console_owner){-...}-{0:0}:
       check_prev_add+0xfa/0x1380 kernel/locking/lockdep.c:2988
       check_prevs_add+0x1d8/0x3c0 kernel/locking/lockdep.c:3113
       validate_chain+0x5df/0xac0 kernel/locking/lockdep.c:3729
       __lock_acquire+0x514/0x940 kernel/locking/lockdep.c:4958
       lock_acquire+0x15a/0x3a0 kernel/locking/lockdep.c:5569
       console_trylock_spinning+0x10d/0x1d0 kernel/printk/printk.c:1921
       vprintk_emit+0x1a5/0x270 kernel/printk/printk.c:2134
       printk+0xb2/0xe7 kernel/printk/printk.c:2183
       lookup_object.cold+0xf/0x24 mm/kmemleak.c:405
       scan_block+0x1fa/0x220 mm/kmemleak.c:1357
       scan_object+0xdd/0x140 mm/kmemleak.c:1415
       scan_gray_list+0x8f/0x1c0 mm/kmemleak.c:1453
       kmemleak_scan+0x649/0xf30 mm/kmemleak.c:1608
       kmemleak_scan_thread+0x94/0xb6 mm/kmemleak.c:1721
       kthread+0x1c4/0x210 kernel/kthread.c:328
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:299

other info that might help us debug this:

Chain exists of:
  console_owner --> &port->lock --> kmemleak_lock

Cc: stable@vger.kernel.org # 5.10
Signed-off-by: Gu Bowen <gubowen5@huawei.com>
---
 mm/kmemleak.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 4801751cb6b6..d322897a1de1 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -390,9 +390,11 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
 		else if (object->pointer == ptr || alias)
 			return object;
 		else {
+			__printk_safe_enter();
 			kmemleak_warn("Found object by alias at 0x%08lx\n",
 				      ptr);
 			dump_object_info(object);
+			__printk_safe_exit();
 			break;
 		}
 	}
-- 
2.25.1


