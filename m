Return-Path: <stable+bounces-9597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB3823314
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6521F24F71
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EFF1C291;
	Wed,  3 Jan 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJyRjxce"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5911BDFB;
	Wed,  3 Jan 2024 17:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E87C433C7;
	Wed,  3 Jan 2024 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704302122;
	bh=bpqQfnmxazga1GUKzHqmkPqZmznYAqGvR15KEQbShcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJyRjxcekGlxVZTTInZkQb8Dq4I8VelVdzYCeca9zl89sAE/xdlIM4GtvRfgiOa0y
	 FC2XytSUMCTlKKZKwhFGPR6YJvzWnhMAT35xDGXcW2ocwidqSwf3IfdtocFyTdox9O
	 gAIGdtvG9rFlUE7yaeLhXRoohZ5ghsreqTMlqnZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ning, Hongyu" <hongyu.ning@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 23/49] virtio_ring: fix syncs DMA memory with different direction
Date: Wed,  3 Jan 2024 17:55:43 +0100
Message-ID: <20240103164838.556172903@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
References: <20240103164834.970234661@linuxfoundation.org>
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

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[ Upstream commit 1f475cd572ea77ae6474a17e693a96bca927efe9 ]

Now the APIs virtqueue_dma_sync_single_range_for_{cpu,device} ignore
the parameter 'dir', that is a mistake.

[    6.101666] ------------[ cut here ]------------
[    6.102079] DMA-API: virtio-pci 0000:00:04.0: device driver syncs DMA memory with different direction [device address=0x00000000ae010000] [size=32752 bytes] [mapped with DMA_FROM_DEVICE] [synced with DMA_BIDIRECTIONAL]
[    6.103630] WARNING: CPU: 6 PID: 0 at kernel/dma/debug.c:1125 check_sync+0x53e/0x6c0
[    6.107420] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G            E      6.6.0+ #290
[    6.108030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    6.108936] RIP: 0010:check_sync+0x53e/0x6c0
[    6.109289] Code: 24 10 e8 f5 d9 74 00 4c 8b 4c 24 10 4c 8b 44 24 18 48 8b 4c 24 20 48 89 c6 41 56 4c 89 ea 48 c7 c7 b0 f1 50 82 e8 32 fc f3 ff <0f> 0b 48 c7 c7 48 4b 4a 82 e8 74 d9 fc ff 8b 73 4c 48 8d 7b 50 31
[    6.110750] RSP: 0018:ffffc90000180cd8 EFLAGS: 00010092
[    6.111178] RAX: 00000000000000ce RBX: ffff888100aa5900 RCX: 0000000000000000
[    6.111744] RDX: 0000000000000104 RSI: ffffffff824c3208 RDI: 00000000ffffffff
[    6.112316] RBP: ffffc90000180d40 R08: 0000000000000000 R09: 00000000fffeffff
[    6.112893] R10: ffffc90000180b98 R11: ffffffff82f63308 R12: ffffffff83d5af00
[    6.113460] R13: ffff888100998200 R14: ffffffff824a4b5f R15: 0000000000000286
[    6.114027] FS:  0000000000000000(0000) GS:ffff88842fd80000(0000) knlGS:0000000000000000
[    6.114665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.115128] CR2: 00007f10f1e03030 CR3: 0000000108272004 CR4: 0000000000770ee0
[    6.115701] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.116272] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.116842] PKRU: 55555554
[    6.117069] Call Trace:
[    6.117275]  <IRQ>
[    6.117452]  ? __warn+0x84/0x140
[    6.117727]  ? check_sync+0x53e/0x6c0
[    6.118034]  ? __report_bug+0xea/0x100
[    6.118353]  ? check_sync+0x53e/0x6c0
[    6.118653]  ? report_bug+0x41/0xc0
[    6.118944]  ? handle_bug+0x3c/0x70
[    6.119237]  ? exc_invalid_op+0x18/0x70
[    6.119551]  ? asm_exc_invalid_op+0x1a/0x20
[    6.119900]  ? check_sync+0x53e/0x6c0
[    6.120199]  ? check_sync+0x53e/0x6c0
[    6.120499]  debug_dma_sync_single_for_cpu+0x5c/0x70
[    6.120906]  ? dma_sync_single_for_cpu+0xb7/0x100
[    6.121291]  virtnet_rq_unmap+0x158/0x170 [virtio_net]
[    6.121716]  virtnet_receive+0x196/0x220 [virtio_net]
[    6.122135]  virtnet_poll+0x48/0x1b0 [virtio_net]
[    6.122524]  __napi_poll+0x29/0x1b0
[    6.123083]  net_rx_action+0x282/0x360
[    6.123612]  __do_softirq+0xf3/0x2fb
[    6.124138]  __irq_exit_rcu+0x8e/0xf0
[    6.124663]  common_interrupt+0xbc/0xe0
[    6.125202]  </IRQ>

We need to enable CONFIG_DMA_API_DEBUG and work with need sync mode(such
as swiotlb) to reproduce this warn.

Fixes: 8bd2f71054bd ("virtio_ring: introduce dma sync api for virtqueue")
Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Closes: https://lore.kernel.org/all/f37cb55a-6fc8-4e21-8789-46d468325eea@linux.intel.com/
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-Id: <20231201033303.25141-1-xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d8f3299c105..49299b1f9ec74 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3219,8 +3219,7 @@ void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
 	if (!vq->use_dma_api)
 		return;
 
-	dma_sync_single_range_for_cpu(dev, addr, offset, size,
-				      DMA_BIDIRECTIONAL);
+	dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
 
@@ -3246,8 +3245,7 @@ void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
 	if (!vq->use_dma_api)
 		return;
 
-	dma_sync_single_range_for_device(dev, addr, offset, size,
-					 DMA_BIDIRECTIONAL);
+	dma_sync_single_range_for_device(dev, addr, offset, size, dir);
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
 
-- 
2.43.0




