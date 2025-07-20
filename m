Return-Path: <stable+bounces-163465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B2B0B680
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB6A18976D9
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8BA7261F;
	Sun, 20 Jul 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4uZ/BvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EA2744D
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022765; cv=none; b=H3e6z8jWdeXFovDcDqkQFHKfFKTfzf35OnS/qcUQlYFFsnCm9I6XOxzVCDZ2IuU+xmX2ikM+wmuWVbtFE63+IiWULmmFLk648sOkY6SuMouH17eo5j5jVZAHdVycn/l2SfSFYyHePTk/AoWWmu7amvT+rxZzLqDH/wsvIGVo6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022765; c=relaxed/simple;
	bh=b0GuWs9qeXc5uETWrYeJt0XBGAcTR4QBFMs2JwF6ABw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HdpakN+NXEt5zUU7eSt9UrzMYdV6BlPwbeCmo8n5yW8o6j6MGlQS+uN6Rgdo6kHpaneJ/ag4IH2iAN1qVkBdWEjqbTOrIeOC5Y6p7aTzUImOvbblKjor9EqWVDB/Nqhhvj+kwSJqELZwMgp94lU2tvEbcfHgHvyC3+VIcZKUMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4uZ/BvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647E9C4CEE7;
	Sun, 20 Jul 2025 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753022764;
	bh=b0GuWs9qeXc5uETWrYeJt0XBGAcTR4QBFMs2JwF6ABw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4uZ/BvJBHGQ1ZaS9uU2Xw0B/JCdpm0XBH9gCtrePiMj0wdS0SqOYEpLRbn+tfQED
	 j+8WUizZQYL9ksa5GsipnIPPbhhtGuRUsB2vYs0naASsB6jN7baOhwB+C/uTCpQRqu
	 g+vwmmtv39RkUFHHua3gLbuQ0joRtyg/WsRpqkOOXRGZGAD939QC+Lk18JeDZAh18e
	 q2XswrkfouF7OKdx2B710NvXbMygCk2qfbP0W2OFr+4/a8YkJ13FOmsS3jsZ9QQaOg
	 stB6zSycdj+HEwOuJh1f+UY6UX34LxefCP5q3dVAN1yKX9LnhotnO4xSFsID2y7Yx5
	 IIQhDF5QfimnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] virtio-net: ensure the received length does not exceed allocated size
Date: Sun, 20 Jul 2025 10:45:54 -0400
Message-Id: <20250720144554.542893-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070649-freezing-truce-2745@gregkh>
References: <2025070649-freezing-truce-2745@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bui Quang Minh <minhquangbui99@gmail.com>

[ Upstream commit 315dbdd7cdf6aa533829774caaf4d25f1fd20e73 ]

In xdp_linearize_page, when reading the following buffers from the ring,
we forget to check the received length with the true allocate size. This
can lead to an out-of-bound read. This commit adds that missing check.

Cc: <stable@vger.kernel.org>
Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://patch.msgid.link/20250630144212.48471-2-minhquangbui99@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ adapted virtqueue_get_buf() to virtqueue_get_buf_ctx() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 215c546bf50a9..6f82338c617e1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -394,6 +394,26 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
 }
 
+static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
+			       unsigned int len)
+{
+	unsigned int headroom, tailroom, room, truesize;
+
+	truesize = mergeable_ctx_to_truesize(mrg_ctx);
+	headroom = mergeable_ctx_to_headroom(mrg_ctx);
+	tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
+	room = SKB_DATA_ALIGN(headroom + tailroom);
+
+	if (len > truesize - room) {
+		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
+			 dev->name, len, (unsigned long)(truesize - room));
+		dev->stats.rx_length_errors++;
+		return -1;
+	}
+
+	return 0;
+}
+
 /* Called from bottom half context */
 static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 				   struct receive_queue *rq,
@@ -639,7 +659,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  * across multiple buffers (num_buf > 1), and we make sure buffers
  * have enough headroom.
  */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
+static struct page *xdp_linearize_page(struct net_device *dev,
+				       struct receive_queue *rq,
 				       u16 *num_buf,
 				       struct page *p,
 				       int offset,
@@ -659,18 +680,27 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	memcpy(page_address(page) + page_off, page_address(p) + offset, *len);
 	page_off += *len;
 
+	/* Only mergeable mode can go inside this while loop. In small mode,
+	 * *num_buf == 1, so it cannot go inside.
+	 */
 	while (--*num_buf) {
 		unsigned int buflen;
 		void *buf;
+		void *ctx;
 		int off;
 
-		buf = virtqueue_get_buf(rq->vq, &buflen);
+		buf = virtqueue_get_buf_ctx(rq->vq, &buflen, &ctx);
 		if (unlikely(!buf))
 			goto err_buf;
 
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
+		if (check_mergeable_len(dev, ctx, buflen)) {
+			put_page(p);
+			goto err_buf;
+		}
+
 		/* guard against a misconfigured or uncooperative backend that
 		 * is sending packet larger than the MTU.
 		 */
@@ -745,7 +775,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 			headroom = vi->hdr_len + header_offset;
 			buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-			xdp_page = xdp_linearize_page(rq, &num_buf, page,
+			xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
 						      offset, header_offset,
 						      &tlen);
 			if (!xdp_page)
@@ -910,7 +940,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		if (unlikely(num_buf > 1 ||
 			     headroom < virtnet_get_headroom(vi))) {
 			/* linearize data for XDP */
-			xdp_page = xdp_linearize_page(rq, &num_buf,
+			xdp_page = xdp_linearize_page(dev, rq, &num_buf,
 						      page, offset,
 						      VIRTIO_XDP_HEADROOM,
 						      &len);
-- 
2.39.5


