Return-Path: <stable+bounces-67576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3049951204
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AE1284992
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4546A6F305;
	Wed, 14 Aug 2024 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8RIo7kM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263013AA20;
	Wed, 14 Aug 2024 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601707; cv=none; b=SohaMEeUor4qZaQpSE+kXfkenr6itAoOcndxr/Tk3+Evm3LAa8yhndUt3s1JV+a309KcBsJ1ny29MutqJxPOnFM+/XgQCYxiOWuFeyOqPi+/IHGL3lehYyw9CoOh602Z9bWdpHbgsweTOmdKVt/JCYS+V7HfCJqKHWduFTPo7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601707; c=relaxed/simple;
	bh=/0wkKPkjmCrMMVqHekyvFFQWoqzLifDiTl6XKS5Zfos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOgqeaUDXOsg4We5tqHgvdIIZ1VUnhYFPnnQFh0l+d2fDbu64ynMIaBntY5YBF/4jn2TWBAbTjlaKMkHkHyxTepudGbUhX2Ejhku1KxlTUwUYTCE0+Dea/c3isNURW5IpzcMaD05r9bS9RCLmXSn6xYG5Qgn0XekcMr+eldLebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8RIo7kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8055DC4AF0F;
	Wed, 14 Aug 2024 02:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601706;
	bh=/0wkKPkjmCrMMVqHekyvFFQWoqzLifDiTl6XKS5Zfos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8RIo7kM7+5lYGjh/MG0S377qhNkR3c7+URhXnVhNjJmziQTCKI5ZrZ8fkBCnX3AC
	 rU1mdqbrW+L5l4/hAR5jpAC6QkHWuHHJQIOBROOsd5modxk8rIqKAhHXGQCI5UHeRN
	 LXzDEcabAzNXCp7HYYpKxJHDnb1ygEFShutrn3RHjl9uwLKkvrtlx6pe0VH6iL9kre
	 ap4LlavXyrKbIJG9On3fRvV/rdSqNHDxy9b1hgpp8hn4BUAmHyo9Lc1ONtbWLmnBKw
	 4rPVowC0gnkEzTKPflYdm0SVJjB7LGMYr/2bR3YxR8OGV6ITb2RLBrL6RbpFnCMEGe
	 MStYaJmQIYjLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Konstantin Ovsepian <ovs@meta.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 10/13] dma-debug: avoid deadlock between dma debug vs printk and netconsole
Date: Tue, 13 Aug 2024 22:14:41 -0400
Message-ID: <20240814021451.4129952-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

[ Upstream commit bd44ca3de49cc1badcff7a96010fa2c64f04868c ]

Currently the dma debugging code can end up indirectly calling printk
under the radix_lock. This happens when a radix tree node allocation
fails.

This is a problem because the printk code, when used together with
netconsole, can end up inside the dma debugging code while trying to
transmit a message over netcons.

This creates the possibility of either a circular deadlock on the same
CPU, with that CPU trying to grab the radix_lock twice, or an ABBA
deadlock between different CPUs, where one CPU grabs the console lock
first and then waits for the radix_lock, while the other CPU is holding
the radix_lock and is waiting for the console lock.

The trace captured by lockdep is of the ABBA variant.

-> #2 (&dma_entry_hash[i].lock){-.-.}-{2:2}:
                  _raw_spin_lock_irqsave+0x5a/0x90
                  debug_dma_map_page+0x79/0x180
                  dma_map_page_attrs+0x1d2/0x2f0
                  bnxt_start_xmit+0x8c6/0x1540
                  netpoll_start_xmit+0x13f/0x180
                  netpoll_send_skb+0x20d/0x320
                  netpoll_send_udp+0x453/0x4a0
                  write_ext_msg+0x1b9/0x460
                  console_flush_all+0x2ff/0x5a0
                  console_unlock+0x55/0x180
                  vprintk_emit+0x2e3/0x3c0
                  devkmsg_emit+0x5a/0x80
                  devkmsg_write+0xfd/0x180
                  do_iter_readv_writev+0x164/0x1b0
                  vfs_writev+0xf9/0x2b0
                  do_writev+0x6d/0x110
                  do_syscall_64+0x80/0x150
                  entry_SYSCALL_64_after_hwframe+0x4b/0x53

-> #0 (console_owner){-.-.}-{0:0}:
                  __lock_acquire+0x15d1/0x31a0
                  lock_acquire+0xe8/0x290
                  console_flush_all+0x2ea/0x5a0
                  console_unlock+0x55/0x180
                  vprintk_emit+0x2e3/0x3c0
                  _printk+0x59/0x80
                  warn_alloc+0x122/0x1b0
                  __alloc_pages_slowpath+0x1101/0x1120
                  __alloc_pages+0x1eb/0x2c0
                  alloc_slab_page+0x5f/0x150
                  new_slab+0x2dc/0x4e0
                  ___slab_alloc+0xdcb/0x1390
                  kmem_cache_alloc+0x23d/0x360
                  radix_tree_node_alloc+0x3c/0xf0
                  radix_tree_insert+0xf5/0x230
                  add_dma_entry+0xe9/0x360
                  dma_map_page_attrs+0x1d2/0x2f0
                  __bnxt_alloc_rx_frag+0x147/0x180
                  bnxt_alloc_rx_data+0x79/0x160
                  bnxt_rx_skb+0x29/0xc0
                  bnxt_rx_pkt+0xe22/0x1570
                  __bnxt_poll_work+0x101/0x390
                  bnxt_poll+0x7e/0x320
                  __napi_poll+0x29/0x160
                  net_rx_action+0x1e0/0x3e0
                  handle_softirqs+0x190/0x510
                  run_ksoftirqd+0x4e/0x90
                  smpboot_thread_fn+0x1a8/0x270
                  kthread+0x102/0x120
                  ret_from_fork+0x2f/0x40
                  ret_from_fork_asm+0x11/0x20

This bug is more likely than it seems, because when one CPU has run out
of memory, chances are the other has too.

The good news is, this bug is hidden behind the CONFIG_DMA_API_DEBUG, so
not many users are likely to trigger it.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-by: Konstantin Ovsepian <ovs@meta.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index a6e3792b15f8a..d570535342cb7 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -416,8 +416,11 @@ static unsigned long long phys_addr(struct dma_debug_entry *entry)
  * dma_active_cacheline entry to track per event.  dma_map_sg(), on the
  * other hand, consumes a single dma_debug_entry, but inserts 'nents'
  * entries into the tree.
+ *
+ * Use __GFP_NOWARN because the printk from an OOM, to netconsole, could end
+ * up right back in the DMA debugging code, leading to a deadlock.
  */
-static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC);
+static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC | __GFP_NOWARN);
 static DEFINE_SPINLOCK(radix_lock);
 #define ACTIVE_CACHELINE_MAX_OVERLAP ((1 << RADIX_TREE_MAX_TAGS) - 1)
 #define CACHELINE_PER_PAGE_SHIFT (PAGE_SHIFT - L1_CACHE_SHIFT)
-- 
2.43.0


