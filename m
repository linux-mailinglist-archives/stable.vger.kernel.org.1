Return-Path: <stable+bounces-42264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788868B7226
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CD31F237EA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16412C530;
	Tue, 30 Apr 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOkCpkz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894412C462;
	Tue, 30 Apr 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475098; cv=none; b=PFnPuidbbeTYPAZ3qlwbJVkekHYPtr07962YiYmmSr6edNlptWxyX+81mrltTYhsOo8GNtjkyK+yLyByKxxMF51HZJw+uuzI7Iozjx/WJAtFgYxsof+orAOohfONJTDBULMH+y2cLpQzRf0PKrPKzZnqE0fu1J7XRNA5gdWhQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475098; c=relaxed/simple;
	bh=Qw0hIr41ecjcdViz1nemcXvNboxAeRC5fVFyd+rXsPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvFmzcOJnpHGPN274EQkFZKGremXng26jS+wmOZvVWpiixrnzxW5QdwaSvF7gMBe19SNOZABUR02T1HpuL8WBt8ev5oIMh7wchVJU2JTD0St+/clMIc9mWyh4LOin6tz3RnPp3uB5vA18LXXf0U4bTFj0xmY43GEwTNV97uiRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOkCpkz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD119C2BBFC;
	Tue, 30 Apr 2024 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475098;
	bh=Qw0hIr41ecjcdViz1nemcXvNboxAeRC5fVFyd+rXsPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOkCpkz8oBX1t+Lhcr1VjRtHAkpIS1oFPcXZifuCZbjjJBqN/pYsnva+/B8pa6qUy
	 5F8PvgNkObJtlMEEYyq5kmwTtm6vcz7AGtvxY76VK/QMCnnypqMbaOXZZ1zc1Uo18G
	 G9zakLRMoe341tbROlkA1y4schMrckWoK6XaQa8E=
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
Subject: [PATCH 5.10 124/138] stackdepot: respect __GFP_NOLOCKDEP allocation flag
Date: Tue, 30 Apr 2024 12:40:09 +0200
Message-ID: <20240430103053.055123422@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -271,10 +271,10 @@ depot_stack_handle_t stack_depot_save(un
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
 		page = alloc_pages(alloc_flags, STACK_ALLOC_ORDER);
 		if (page)



