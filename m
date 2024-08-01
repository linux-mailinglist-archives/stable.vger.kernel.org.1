Return-Path: <stable+bounces-64936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F66943CC6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B91A1C21849
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF5B1D47D6;
	Thu,  1 Aug 2024 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izesAVkA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619891D47CE;
	Thu,  1 Aug 2024 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471496; cv=none; b=Ov6bEOmW4ZRqtMvzEj2wogUCU6zkf4ZUOIY9v5V9czPbWXv1wRYnU51IZHIq4dLHCDRY6J78gbCK2HTXze08EvrRWZmcIGPVc9P64VJ3qmUDWO3kNUqOC7Ahuy/ZdbLxehAn7AP5apiKi10F6+XKQm90xNLO3MB/18UheAc/B9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471496; c=relaxed/simple;
	bh=wag2EdHIZdxEG4+gqnKzwVyymOV8FPNUDb/+SD0UuTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7Q7zRv3gJr5e9sROLDol5mhkIakk7tKa6RC5wwuJmeCWtNQsXutzea3+2RCcSZHw9O6VmLW49bmR+pqY7iqBfCV2rp9obzHu69+LPLBGOl9gKNtXcl3Q5EMXJ5+3Elqr70/VGimw52pjcBM8EUqV6F7L+cWCzwD8wGnJxk7p/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izesAVkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8535C4AF0C;
	Thu,  1 Aug 2024 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471495;
	bh=wag2EdHIZdxEG4+gqnKzwVyymOV8FPNUDb/+SD0UuTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izesAVkAes6BIGw9ZXxDxoMRjo+2qhH9gE/OlVcBj6RAoNHc0+/9GNpd09/JqZnLX
	 skaiUKYhyKV4Xb9To7MO4lE2BeBQppShGrp3EEh//uB6p3EBCNVO/iI24xGXVMGt5U
	 euws2T/ss6YEbCbifbNgsP3W9eoL28SxRK33LE6Gd88/o0dXgTWwvEx2fbduu6MyWa
	 S+keZm0BKzbR5yoaXhjLBj13oDmRyUtXV/nRrJvS30lvxNQMUCDa1PdI1OO7jVc+aC
	 DKBvQSxo6F1p7ieUGTktJCLmr1RxBn9eb3TuWn3M59FIhH9GIjQ5OqEe0kriRwGMUq
	 xT8RdpABx/M5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexander Potapenko <glider@google.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 111/121] virtio_ring: fix KMSAN error for premapped mode
Date: Wed, 31 Jul 2024 20:00:49 -0400
Message-ID: <20240801000834.3930818-111-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[ Upstream commit 840b2d39a2dc1b96deb3f5c7fef76c9b24f08f51 ]

Add kmsan for virtqueue_dma_map_single_attrs to fix:

BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
 receive_buf+0x45ca/0x6990
 virtnet_poll+0x17e0/0x3130
 net_rx_action+0x832/0x26e0
 handle_softirqs+0x330/0x10f0
 [...]

Uninit was created at:
 __alloc_pages_noprof+0x62a/0xe60
 alloc_pages_noprof+0x392/0x830
 skb_page_frag_refill+0x21a/0x5c0
 virtnet_rq_alloc+0x50/0x1500
 try_fill_recv+0x372/0x54c0
 virtnet_open+0x210/0xbe0
 __dev_open+0x56e/0x920
 __dev_change_flags+0x39c/0x2000
 dev_change_flags+0xaa/0x200
 do_setlink+0x197a/0x7420
 rtnl_setlink+0x77c/0x860
 [...]

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Tested-by: Alexander Potapenko <glider@google.com>
Message-Id: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # s390x
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2a972752ff1bc..9d3a9942c8c82 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3121,8 +3121,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!vq->use_dma_api)
+	if (!vq->use_dma_api) {
+		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
 		return (dma_addr_t)virt_to_phys(ptr);
+	}
 
 	return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
 }
-- 
2.43.0


