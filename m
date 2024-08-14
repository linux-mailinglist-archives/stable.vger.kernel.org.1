Return-Path: <stable+bounces-67592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15D95122E
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7B91C23F2C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB714F9E6;
	Wed, 14 Aug 2024 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVJDH75k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AD14F136;
	Wed, 14 Aug 2024 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601744; cv=none; b=tmVrkdkoUHlMxkyhGWys6GbdOVbQZAo7imjzxg38+TEf6OvwyCbbFL0F/qmBRWGeFXkh7DQ0aYsuqzfjK+0qtoo2aG+j6kdCHDz1USNgnELEDPgg3/+xfc6rzOmO5Kk2Nt2M/UmK2aQz1VkYTbf0dB0e4VW1vdazvSmlF5dGv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601744; c=relaxed/simple;
	bh=Iwoks43KG0whGfNeBGW75upxTjQ83XyQDgJU9Ao1ml8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh92eMGEfba/7DJSBMwx/Hm8xG8gDfRQPRBrJMaFmPONNql4DrR2LRG7MvcEHNbOHXiK0n1Mq5V5DAi7ko7d9MYuDwwBRdML3O1ee6u2x5+qdXbzvAMzQB9Pq+GNA1QkabsSOhpwVCq81l5vNg5PO/ekN6PeFrrrhA5mJLJsaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVJDH75k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98CDC4AF0C;
	Wed, 14 Aug 2024 02:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601743;
	bh=Iwoks43KG0whGfNeBGW75upxTjQ83XyQDgJU9Ao1ml8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVJDH75k8tFvXcdbQ66E2LM4ijvaOxFoAgzTg4FPlGFSWxon/cVYrzydBIdsSqJpX
	 3z7A0jmbHA4hj5QzkkWExK8WtwbGpyCe58x6uSxEPeGej+QOg95mDFhz+H3/9vaZLr
	 DaMWnwLTMZb2gw2HgdsJrng7ALkC+fsmHZdXUA415URnN4kjkKNx3AXGuFuedepRz9
	 c1HfPRcTbpMoOPbvCk3/KH1Hd+H0Gdh3fIO1KKe2Tg9Anof0BFmBEIZDA3yVFW2BcS
	 qwX4MFv1yquZwDIIox8UtUL3rPJooR9gK0I2WVFx8+UpGqEnsx7tLv+7bF1/Y39GUQ
	 ymOQhRPv+ad1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Konstantin Ovsepian <ovs@meta.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 2/3] dma-debug: avoid deadlock between dma debug vs printk and netconsole
Date: Tue, 13 Aug 2024 22:15:39 -0400
Message-ID: <20240814021540.4130505-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021540.4130505-1-sashal@kernel.org>
References: <20240814021540.4130505-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 1f9a8cee42241..09ccb4d6bc7b6 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -447,8 +447,11 @@ void debug_dma_dump_mappings(struct device *dev)
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


