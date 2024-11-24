Return-Path: <stable+bounces-95070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45519D75EA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DCBC5959
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251920B7E0;
	Sun, 24 Nov 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oww4n/PC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823920ADF6;
	Sun, 24 Nov 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455887; cv=none; b=fgMOp+EOoi2IXNcQWxbThWQJ8iXePwaI7l4Lj5I0gAfM8chGzxW+SCbhCaj7eWgLaXE5sIPfCIf9j3391y8s8k6ObCvOtdIQnF3hdKM7omYO+F3UFJbbgC3xsxZ0LtcLoz95E74/Ova92Cgf5kfIfXgYRI77KVNJp7RMUIa12jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455887; c=relaxed/simple;
	bh=uVOIo4cIj+9dGmsfKgijLyCuIznJYHDWuOrwvOYj2OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJIsbGBXrufwsHMXGC04Q6aL+1QXvDxoQBYA2N/QoWOg5iocvSbknMLpdU704Iw+jDTqVvquIbvl506ph7x2uSvEq3mO4FD2zHjhFri4isdsWzAGCwExlSHR34KMYxxSGo14W1HnL1KAtXdm3hRN2a/CS0xR8yiGOx1Jt9woQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oww4n/PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3259C4CED1;
	Sun, 24 Nov 2024 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455887;
	bh=uVOIo4cIj+9dGmsfKgijLyCuIznJYHDWuOrwvOYj2OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oww4n/PCt1Y5QOxS/zUZbYXNaOoq1FO4d/iK/+hoWK4tI7mh7MtLmIONccACOg7qz
	 9fYFxkyWMh74J+zUPEFLLQWHESJ+525wD/BYdV9/+EpcNBV3O9hIbIbFVloPrLPnvj
	 yuKGjCfxXCv8g8sL14LL14TO4EY2RHmxwVfks9q1fWoaQymDSykYojop9cFeGfVg/N
	 WD2hhTRlA02lj/UVh0mL9VFyDpTTIC4Wf8oPT6If3RqJAIgvhA6NmCDJdELWfylrAD
	 5E0V5Av2zJCqNvIRmZy2BVrKj6bfaeWYT8g6Uv9nQuoZnuBnHUB1nazZgoh+H+0FJ5
	 0/o3b3EvfixjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Si-Wei Liu" <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	mst@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 67/87] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Sun, 24 Nov 2024 08:38:45 -0500
Message-ID: <20241124134102.3344326-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[ Upstream commit 6aacd1484468361d1d04badfe75f264fa5314864 ]

When the frag just got a page, then may lead to regression on VM.
Specially if the sysctl net.core.high_order_alloc_disable value is 1,
then the frag always get a page when do refill.

Which could see reliable crashes or scp failure (scp a file 100M in size
to VM).

The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
of a new frag. When the frag size is larger than PAGE_SIZE,
everything is fine. However, if the frag is only one page and the
total size of the buffer and virtnet_rq_dma is larger than one page, an
overflow may occur.

The commit f9dac92ba908 ("virtio_ring: enable premapped mode whatever
use_dma_api") introduced this problem. And we reverted some commits to
fix this in last linux version. Now we try to enable it and fix this
bug directly.

Here, when the frag size is not enough, we reduce the buffer len to fix
this problem.

Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
Tested-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 53a038fcbe991..c897afef0b414 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -946,9 +946,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	void *buf, *head;
 	dma_addr_t addr;
 
-	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
-		return NULL;
-
 	head = page_address(alloc_frag->page);
 
 	if (rq->do_dma) {
@@ -2443,6 +2440,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
+	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
+		return -ENOMEM;
+
 	buf = virtnet_rq_alloc(rq, len, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
@@ -2545,6 +2545,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	 */
 	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
 
+	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
+		return -ENOMEM;
+
+	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
+		len -= sizeof(struct virtnet_rq_dma);
+
 	buf = virtnet_rq_alloc(rq, len + room, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
-- 
2.43.0


