Return-Path: <stable+bounces-42423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30478B72F0
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E060283B33
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F18C12CDA5;
	Tue, 30 Apr 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nliLXsJe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD9211C;
	Tue, 30 Apr 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475616; cv=none; b=dApr6ezheYQkUHhF34k8DLsKqJkAAD2qB7TFlPWYUrE6WREmcL6ztNcLuP3QbCVk/LfXPhraDvaDaeWzrw04qSNRgpuknF0vBQBd7xlNJPjJRmbsbref1hpTeMRZKlVfoCyFcuRb+ZXlt3jELL8DCFMd7N9I3YzA3rkH9NnPlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475616; c=relaxed/simple;
	bh=xkRiNl+JTwKW6JCSVn08RklchVI0MpFtE67IMGrdnRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Khq6EQ4pxpClRdDjwBPSH5nyC+KhDds7NjiFZhJx8VesY5bnkquzraMNR82wg4tA1hSlSeiAFAtMcIQw4WIMeuPZ4ZjtbWkngPxpKmolz1afgw+Sm4GAxeHMqk4nybJl9gqQtXIu7p3rPGb1ikduuL9cxJ2hmpq17SW+CjxYAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nliLXsJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4566CC2BBFC;
	Tue, 30 Apr 2024 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475616;
	bh=xkRiNl+JTwKW6JCSVn08RklchVI0MpFtE67IMGrdnRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nliLXsJeSc/eyd9SHszlteT+mNaGwCVTRPGu2H4p5rysGZRNjn0DV+DUhTjJcAcJb
	 f/fnrmor0ByayDsa6Ikc0YEe3G/qNgniI8PMjQyWcFYAL5J0htCnttYAmf4BEOQS+q
	 8xHv9/3WRlJf/udyOrX062Ob9BwrHae6xINV+8f4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 150/186] stackdepot: respect __GFP_NOLOCKDEP allocation flag
Date: Tue, 30 Apr 2024 12:40:02 +0200
Message-ID: <20240430103102.388641717@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
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

From: Andrey Ryabinin <ryabinin.a.a@gmail.com>

commit 6fe60465e1d53ea321ee909be26d97529e8f746c upstream.

If stack_depot_save_flags() allocates memory it always drops
__GFP_NOLOCKDEP flag.  So when KASAN tries to track __GFP_NOLOCKDEP
allocation we may end up with lockdep splat like bellow:

======================================================
 WARNING: possible circular locking dependency detected
 6.9.0-rc3+ #49 Not tainted
 ------------------------------------------------------
 kswapd0/149 is trying to acquire lock:
 ffff88811346a920
(&xfs_nondir_ilock_class){++++}-{4:4}, at: xfs_reclaim_inode+0x3ac/0x590
[xfs]

 but task is already holding lock:
 ffffffff8bb33100 (fs_reclaim){+.+.}-{0:0}, at:
balance_pgdat+0x5d9/0xad0

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:
 -> #1 (fs_reclaim){+.+.}-{0:0}:
        __lock_acquire+0x7da/0x1030
        lock_acquire+0x15d/0x400
        fs_reclaim_acquire+0xb5/0x100
 prepare_alloc_pages.constprop.0+0xc5/0x230
        __alloc_pages+0x12a/0x3f0
        alloc_pages_mpol+0x175/0x340
        stack_depot_save_flags+0x4c5/0x510
        kasan_save_stack+0x30/0x40
        kasan_save_track+0x10/0x30
        __kasan_slab_alloc+0x83/0x90
        kmem_cache_alloc+0x15e/0x4a0
        __alloc_object+0x35/0x370
        __create_object+0x22/0x90
 __kmalloc_node_track_caller+0x477/0x5b0
        krealloc+0x5f/0x110
        xfs_iext_insert_raw+0x4b2/0x6e0 [xfs]
        xfs_iext_insert+0x2e/0x130 [xfs]
        xfs_iread_bmbt_block+0x1a9/0x4d0 [xfs]
        xfs_btree_visit_block+0xfb/0x290 [xfs]
        xfs_btree_visit_blocks+0x215/0x2c0 [xfs]
        xfs_iread_extents+0x1a2/0x2e0 [xfs]
 xfs_buffered_write_iomap_begin+0x376/0x10a0 [xfs]
        iomap_iter+0x1d1/0x2d0
 iomap_file_buffered_write+0x120/0x1a0
        xfs_file_buffered_write+0x128/0x4b0 [xfs]
        vfs_write+0x675/0x890
        ksys_write+0xc3/0x160
        do_syscall_64+0x94/0x170
 entry_SYSCALL_64_after_hwframe+0x71/0x79

Always preserve __GFP_NOLOCKDEP to fix this.

Link: https://lkml.kernel.org/r/20240418141133.22950-1-ryabinin.a.a@gmail.com
Fixes: cd11016e5f52 ("mm, kasan: stackdepot implementation. Enable stackdepot for SLAB")
Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Reported-by: Xiubo Li <xiubli@redhat.com>
Closes: https://lore.kernel.org/all/a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com/
Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Closes: https://lore.kernel.org/all/f9ff999a-e170-b66b-7caf-293f2b147ac2@opensource.wdc.com/
Suggested-by: Dave Chinner <david@fromorbit.com>
Tested-by: Xiubo Li <xiubli@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/stackdepot.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -402,10 +402,10 @@ depot_stack_handle_t __stack_depot_save(
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
-		 * contexts and I/O.
+		 * contexts, I/O, nolockdep.
 		 */
 		alloc_flags &= ~GFP_ZONEMASK;
-		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL);
+		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL | __GFP_NOLOCKDEP);
 		alloc_flags |= __GFP_NOWARN;
 		page = alloc_pages(alloc_flags, DEPOT_POOL_ORDER);
 		if (page)



