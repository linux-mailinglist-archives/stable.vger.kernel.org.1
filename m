Return-Path: <stable+bounces-95136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEAA9D770B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76E8C0057E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15522CFC2;
	Sun, 24 Nov 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWyj8lc5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF981F6839;
	Sun, 24 Nov 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456112; cv=none; b=judBS2rQ3oavlGPI5+epUAYiMhJ0SvttPVtM0GVi/SAqXbt9l3M14VIN3MTy6rnZc+er3L7jZaVik4bU1lywKOq+KelEaakTNGz/+3XkxQyxp+qFdvm9h4d1YofC3cHBB9AJ9xAUW01J3pMC4kr9m/pbKzH19bnr3MTETbmfq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456112; c=relaxed/simple;
	bh=d/oaVToFaQ3XnfSkmEkiZVd5HHZp6POrGkvZQ2oeGIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guSOeUiato2gOD+ghMBGsqPrDMQDTDFOabnvnWZD7nOr/PqNLnNWtCyhdqQ8e1lKXuxLUQLhvCZ2TS4d+ma761okJSTig85jg/IUy20IsnazAQz/y3Rl6CM/Uzuh7oEwYuv+NYNFoCW9BnF7wuc8kyYS6yz9PpoFSsqlPDb/vm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWyj8lc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5D8C4CECC;
	Sun, 24 Nov 2024 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456111;
	bh=d/oaVToFaQ3XnfSkmEkiZVd5HHZp6POrGkvZQ2oeGIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWyj8lc5smi0PYHAQh7MFUUVU7A/58VMfo/RmCvMTAPwFMMNkherRItxRbx+HjCJo
	 15ynOilVBnjW2BB8cQU+EMkvwB6Rxi7yOgsbvi1eXP8DO5pbdiw+meA1O8WdADYW9X
	 ohgz+2gWI1cDmHfuoBH7cumhfL4lcIUCve8vLuaRa36KxsLoqgbD8HIkqYC6hJlBzN
	 47SX/H9/tFNnaO1Q6Uoju697JLj987hN51Wo6HTfDtqXuPdPFM/kGxhgzHaDsUqw4Y
	 6feaERKgB9dZaX++jKHVh16CQTxmdawQQpfsxTbkDxtoGp2UXBix7p/OeWyhnRxF/P
	 NUn0uwjqSIe3Q==
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
Subject: [PATCH AUTOSEL 6.6 46/61] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Sun, 24 Nov 2024 08:45:21 -0500
Message-ID: <20241124134637.3346391-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 426c05d5b1381..3bf394b24d971 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -676,9 +676,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	void *buf, *head;
 	dma_addr_t addr;
 
-	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
-		return NULL;
-
 	head = page_address(alloc_frag->page);
 
 	if (rq->do_dma) {
@@ -1860,6 +1857,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
+	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
+		return -ENOMEM;
+
 	buf = virtnet_rq_alloc(rq, len, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
@@ -1962,6 +1962,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
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


