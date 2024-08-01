Return-Path: <stable+bounces-65021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36152943D9A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94631F21422
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E41CC440;
	Thu,  1 Aug 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzD7XwaG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD7130AC8;
	Thu,  1 Aug 2024 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471959; cv=none; b=Bic50nx78kqtKiuE2WD/YzT+HEFfk95a2doZ/Kt4h9VN4fpHw1OxXbPIvUziXw3HCW648gTtxnUhrDQWM1n/nsJjxZEo6qtSPj8+x4hyVjGACrVKzXW27PFzc8nSWsXTdJQZyVh+stpKaBK7harxlQFJPUwxk/34CaDW0+BNaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471959; c=relaxed/simple;
	bh=EDYZzjC771Qx559qsRLXwCDDw+Gia+YTMRMYJxjam9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+lkudQFQtVsaHeziq1bUb4ZHHA3pOEJGpFXikrktS2ivBWUWeqvJk3eDZgEUOEaK0qucUzNQWtl2ihXCIljb+Y+4YGfVEl0UaV/su+iMpzmxaRJqIWIaeGb140UeEeoYd4o4m/buchrgILz/3g0hrUV621Za4e645bZN0W7dWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzD7XwaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831ABC4AF0E;
	Thu,  1 Aug 2024 00:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471958;
	bh=EDYZzjC771Qx559qsRLXwCDDw+Gia+YTMRMYJxjam9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzD7XwaGTAHE0D1Hqy2i/S7DpPOFpu9sgs+K203/yekX7Cbe8NGVEC5Ua1Jw23NS5
	 VP9YP44HpSO5S+StYUmv6rfItu+FLVEeYdeIJrf38MBM4CIsOnIfWFSU3N6e9lY7Gy
	 lwSvc9dswr7/u2+EMkZ/W7Q+RYLU523CTADqoLXVm6Tn+9WsmemN8d7hVgA92XZvn+
	 RLH66LN6X30PrXrD7rVBE1xI9Cjghv5LwzlumxIpiwBy7qYa9PYjkVGuJ5l00hdThf
	 YxyI7CEoft3pPsHOXeGoKcnMZkypcE2EjWTc8KxvFL4dxFwQqbKolNC2BbGqzPaHNO
	 P156oYuDzxWXg==
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
Subject: [PATCH AUTOSEL 6.6 75/83] virtio_ring: fix KMSAN error for premapped mode
Date: Wed, 31 Jul 2024 20:18:30 -0400
Message-ID: <20240801002107.3934037-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 6f7e5010a6735..80669e05bf0ee 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3126,8 +3126,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
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


