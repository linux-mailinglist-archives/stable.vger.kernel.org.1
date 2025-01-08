Return-Path: <stable+bounces-107972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8FA0535B
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 07:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2686165166
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 06:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A61A7AF7;
	Wed,  8 Jan 2025 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ou2rJIlc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC51A7046;
	Wed,  8 Jan 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736318549; cv=none; b=Ir9QRiEe1EFQqobmEK1EUUGkb8XEtgV09z0NMbqZq8NJb37oB1fNEbJ0x31ZCWqdHrqiGnjgXYPXLQluQVRaEoSwt7S7iwRMIObLoY2moJ9iFxS1sBIPS1knY1UyS5kjFnuDcnd3BscgkxxTfWd2B/a2yHjtIwmTinpK3MCdnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736318549; c=relaxed/simple;
	bh=eqQyL6uXRSBkobZ5H5C6/zVISQanWe64Esxtx85Tx5s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=syqT4FI8NTgMLTt/VkYi2SIN74t8xAiQbUqeG5zPorNRGixFZRJ0v3pfk+quxZzdFQiGYteW61y0GoE/o0t32jrv2W0DLhQnuH8Svz5+cjRuDy9qltEnQFpmAOsH9C5Jo+Ql6L3CLci2iJafxgmqsE2E1IB+IhdCUbZQVZUu3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ou2rJIlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AE0C4CED0;
	Wed,  8 Jan 2025 06:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736318546;
	bh=eqQyL6uXRSBkobZ5H5C6/zVISQanWe64Esxtx85Tx5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ou2rJIlcwB17AxGpGf99JyAmieT95M9Rl55xPTMsU3d9RJkMJ971cUB+cLCvc34Jl
	 Kvs56MiDaU8lc3FMWUUhzH7dnRto8wr3RBsg9wlpcoM04KOtmM0Ei2bNnrsSVfrTgM
	 HmUNQ+IPH52/hF9HeGGMsJU8tt8/eRKS0aLj2qpc=
Date: Tue, 7 Jan 2025 22:42:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool
 <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, Sam Sun
 <samsun1006219@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU
 hotunplug
Message-Id: <20250107224225.ca41ec2f0340b6b768f44a6a@linux-foundation.org>
In-Reply-To: <CAJD7tkZffK+05e8fLnUWFA0+2AsJKf9xjEKFoX4mgyFxqd5rSQ@mail.gmail.com>
References: <20250107074724.1756696-1-yosryahmed@google.com>
	<20250107074724.1756696-2-yosryahmed@google.com>
	<20250107180345.GD37530@cmpxchg.org>
	<CAJD7tkYNvyVh2ETdbHrmtJRzKwVX3pPvite+cy0aS6cwJe5ePw@mail.gmail.com>
	<CAJD7tkYhO7DAQTrmb1A2H_FsaExoa1fp+C8vQw0MmzkmM+KyUA@mail.gmail.com>
	<CAKEwX=M_wTnd9yWf4yzjjgPEsjMFW-TAr_m_29YK4-tDE0UMpA@mail.gmail.com>
	<CAJD7tkZffK+05e8fLnUWFA0+2AsJKf9xjEKFoX4mgyFxqd5rSQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 
> Andrew, could you please pick up patch 1 (the revert) while we figure
> out the alternative fix? It's important that it lands in v6.13 to
> avoid the possibility of deadlock. Figuring out an alternative fix is
> less important.

I have the below patch in mm-hotfixes-unstable.

I also have
https://lkml.kernel.org/r/20250107222236.2715883-2-yosryahmed@google.com
in mm-hotfixes-unstable.  Don't know what to do with it.

I have no patch "mm: zswap: use SRCU to synchronize with CPU hotunplug"
in mm-unstable.



From: Yosry Ahmed <yosryahmed@google.com>
Subject: Revert "mm: zswap: fix race between [de]compression and CPU hotunplug"
Date: Tue, 7 Jan 2025 22:22:34 +0000

This reverts commit eaebeb93922ca6ab0dd92027b73d0112701706ef.

Commit eaebeb93922c ("mm: zswap: fix race between [de]compression and CPU
hotunplug") used the CPU hotplug lock in zswap compress/decompress
operations to protect against a race with CPU hotunplug making some
per-CPU resources go away.

However, zswap compress/decompress can be reached through reclaim while
the lock is held, resulting in a potential deadlock as reported by syzbot:
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc6-syzkaller-00006-g5428dc1906dd #0 Not tainted
------------------------------------------------------
kswapd0/89 is trying to acquire lock:
 ffffffff8e7d2ed0 (cpu_hotplug_lock){++++}-{0:0}, at: acomp_ctx_get_cpu mm/zswap.c:886 [inline]
 ffffffff8e7d2ed0 (cpu_hotplug_lock){++++}-{0:0}, at: zswap_compress mm/zswap.c:908 [inline]
 ffffffff8e7d2ed0 (cpu_hotplug_lock){++++}-{0:0}, at: zswap_store_page mm/zswap.c:1439 [inline]
 ffffffff8e7d2ed0 (cpu_hotplug_lock){++++}-{0:0}, at: zswap_store+0xa74/0x1ba0 mm/zswap.c:1546

but task is already holding lock:
 ffffffff8ea355a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6871 [inline]
 ffffffff8ea355a0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb58/0x2f30 mm/vmscan.c:7253

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
        __fs_reclaim_acquire mm/page_alloc.c:3853 [inline]
        fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3867
        might_alloc include/linux/sched/mm.h:318 [inline]
        slab_pre_alloc_hook mm/slub.c:4070 [inline]
        slab_alloc_node mm/slub.c:4148 [inline]
        __kmalloc_cache_node_noprof+0x40/0x3a0 mm/slub.c:4337
        kmalloc_node_noprof include/linux/slab.h:924 [inline]
        alloc_worker kernel/workqueue.c:2638 [inline]
        create_worker+0x11b/0x720 kernel/workqueue.c:2781
        workqueue_prepare_cpu+0xe3/0x170 kernel/workqueue.c:6628
        cpuhp_invoke_callback+0x48d/0x830 kernel/cpu.c:194
        __cpuhp_invoke_callback_range kernel/cpu.c:965 [inline]
        cpuhp_invoke_callback_range kernel/cpu.c:989 [inline]
        cpuhp_up_callbacks kernel/cpu.c:1020 [inline]
        _cpu_up+0x2b3/0x580 kernel/cpu.c:1690
        cpu_up+0x184/0x230 kernel/cpu.c:1722
        cpuhp_bringup_mask+0xdf/0x260 kernel/cpu.c:1788
        cpuhp_bringup_cpus_parallel+0xf9/0x160 kernel/cpu.c:1878
        bringup_nonboot_cpus+0x2b/0x50 kernel/cpu.c:1892
        smp_init+0x34/0x150 kernel/smp.c:1009
        kernel_init_freeable+0x417/0x5d0 init/main.c:1569
        kernel_init+0x1d/0x2b0 init/main.c:1466
        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
        check_prev_add kernel/locking/lockdep.c:3161 [inline]
        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
        cpus_read_lock+0x42/0x150 kernel/cpu.c:490
        acomp_ctx_get_cpu mm/zswap.c:886 [inline]
        zswap_compress mm/zswap.c:908 [inline]
        zswap_store_page mm/zswap.c:1439 [inline]
        zswap_store+0xa74/0x1ba0 mm/zswap.c:1546
        swap_writepage+0x647/0xce0 mm/page_io.c:279
        shmem_writepage+0x1248/0x1610 mm/shmem.c:1579
        pageout mm/vmscan.c:696 [inline]
        shrink_folio_list+0x35ee/0x57e0 mm/vmscan.c:1374
        shrink_inactive_list mm/vmscan.c:1967 [inline]
        shrink_list mm/vmscan.c:2205 [inline]
        shrink_lruvec+0x16db/0x2f30 mm/vmscan.c:5734
        mem_cgroup_shrink_node+0x385/0x8e0 mm/vmscan.c:6575
        mem_cgroup_soft_reclaim mm/memcontrol-v1.c:312 [inline]
        memcg1_soft_limit_reclaim+0x346/0x810 mm/memcontrol-v1.c:362
        balance_pgdat mm/vmscan.c:6975 [inline]
        kswapd+0x17b3/0x2f30 mm/vmscan.c:7253
        kthread+0x2f0/0x390 kernel/kthread.c:389
        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(cpu_hotplug_lock);
                               lock(fs_reclaim);
  rlock(cpu_hotplug_lock);

 *** DEADLOCK ***

1 lock held by kswapd0/89:
  #0: ffffffff8ea355a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6871 [inline]
  #0: ffffffff8ea355a0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb58/0x2f30 mm/vmscan.c:7253

stack backtrace:
CPU: 0 UID: 0 PID: 89 Comm: kswapd0 Not tainted 6.13.0-rc6-syzkaller-00006-g5428dc1906dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
  check_prev_add kernel/locking/lockdep.c:3161 [inline]
  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
  percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
  cpus_read_lock+0x42/0x150 kernel/cpu.c:490
  acomp_ctx_get_cpu mm/zswap.c:886 [inline]
  zswap_compress mm/zswap.c:908 [inline]
  zswap_store_page mm/zswap.c:1439 [inline]
  zswap_store+0xa74/0x1ba0 mm/zswap.c:1546
  swap_writepage+0x647/0xce0 mm/page_io.c:279
  shmem_writepage+0x1248/0x1610 mm/shmem.c:1579
  pageout mm/vmscan.c:696 [inline]
  shrink_folio_list+0x35ee/0x57e0 mm/vmscan.c:1374
  shrink_inactive_list mm/vmscan.c:1967 [inline]
  shrink_list mm/vmscan.c:2205 [inline]
  shrink_lruvec+0x16db/0x2f30 mm/vmscan.c:5734
  mem_cgroup_shrink_node+0x385/0x8e0 mm/vmscan.c:6575
  mem_cgroup_soft_reclaim mm/memcontrol-v1.c:312 [inline]
  memcg1_soft_limit_reclaim+0x346/0x810 mm/memcontrol-v1.c:362
  balance_pgdat mm/vmscan.c:6975 [inline]
  kswapd+0x17b3/0x2f30 mm/vmscan.c:7253
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Revert the change. A different fix for the race with CPU hotunplug will
follow.

Link: https://lkml.kernel.org/r/20250107222236.2715883-1-yosryahmed@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Sam Sun <samsun1006219@gmail.com>
Cc: Vitaly Wool <vitalywool@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/zswap.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/mm/zswap.c~revert-mm-zswap-fix-race-between-compression-and-cpu-hotunplug
+++ a/mm/zswap.c
@@ -880,18 +880,6 @@ static int zswap_cpu_comp_dead(unsigned
 	return 0;
 }
 
-/* Prevent CPU hotplug from freeing up the per-CPU acomp_ctx resources */
-static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_ctx __percpu *acomp_ctx)
-{
-	cpus_read_lock();
-	return raw_cpu_ptr(acomp_ctx);
-}
-
-static void acomp_ctx_put_cpu(void)
-{
-	cpus_read_unlock();
-}
-
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -905,7 +893,8 @@ static bool zswap_compress(struct page *
 	gfp_t gfp;
 	u8 *dst;
 
-	acomp_ctx = acomp_ctx_get_cpu(pool->acomp_ctx);
+	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
+
 	mutex_lock(&acomp_ctx->mutex);
 
 	dst = acomp_ctx->buffer;
@@ -961,7 +950,6 @@ unlock:
 		zswap_reject_alloc_fail++;
 
 	mutex_unlock(&acomp_ctx->mutex);
-	acomp_ctx_put_cpu();
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -972,7 +960,7 @@ static void zswap_decompress(struct zswa
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
 
-	acomp_ctx = acomp_ctx_get_cpu(entry->pool->acomp_ctx);
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
@@ -1002,7 +990,6 @@ static void zswap_decompress(struct zswa
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
-	acomp_ctx_put_cpu();
 }
 
 /*********************************
_


