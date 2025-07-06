Return-Path: <stable+bounces-160294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13357AFA4E9
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63C63BACCA
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33920E00A;
	Sun,  6 Jul 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BLUMg34Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCB20CCF4
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802430; cv=none; b=fcdzkLEfWGFTGAW1RyAe8M9treUn0NMGMwhiaIZRKZouqoKCCVThvho6DyJ516It9CAd2SmyUTQOdeHjw1TomKMTHC5LCIBjWhMdQPVNtRPzsqJ9VB7bnZFl9vMEsFK/4Izs4CbNb2uKaEtvkYoek2dj3W/DwPQP8lkVb5iB+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802430; c=relaxed/simple;
	bh=YRgUtrVm6zrx8hsKB7ZuRLA2XkRnP7r/Htm7KjUoJvE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ByKk8hyBQ0701qdp6SIJWJxxnuFbhlXKlJ1uOISwj4ilu5fJtAaVLf2K/voI+AAMjdkYRsbne4Y0FlzckFvXquwAXGmL9KNPHmeZI6biScqWR2bZ8iEgRJip4RU6dITEQDlIyhqjB/KDB0v8LB70+wQSK3xXzQKQhg8BtBMvCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BLUMg34Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D11C4CEED;
	Sun,  6 Jul 2025 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802429;
	bh=YRgUtrVm6zrx8hsKB7ZuRLA2XkRnP7r/Htm7KjUoJvE=;
	h=Subject:To:Cc:From:Date:From;
	b=BLUMg34QKZLNoppGOGq3WVgnY3eve8nRLrdEBBSVdY/xFdE42bNiewg8W8aUYcdbM
	 n28WmYr2LjdQpJHzVv5ArIrJHe5Opvn5Cjkvc6JtTgNFSdaNTLT9SQEOPH9eygP3Ox
	 DJPSJaXoiJj3OY4xM1P1GpyHg372UNL9T6RC1m+k=
Subject: FAILED: patch "[PATCH] virtio-net: ensure the received length does not exceed" failed to apply to 5.4-stable tree
To: minhquangbui99@gmail.com,jasowang@redhat.com,pabeni@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:46:49 +0200
Message-ID: <2025070649-freezing-truce-2745@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 315dbdd7cdf6aa533829774caaf4d25f1fd20e73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070649-freezing-truce-2745@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 315dbdd7cdf6aa533829774caaf4d25f1fd20e73 Mon Sep 17 00:00:00 2001
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Mon, 30 Jun 2025 21:42:10 +0700
Subject: [PATCH] virtio-net: ensure the received length does not exceed
 allocated size

In xdp_linearize_page, when reading the following buffers from the ring,
we forget to check the received length with the true allocate size. This
can lead to an out-of-bound read. This commit adds that missing check.

Cc: <stable@vger.kernel.org>
Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://patch.msgid.link/20250630144212.48471-2-minhquangbui99@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..31661bcb3932 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -778,6 +778,26 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
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
+		DEV_STATS_INC(dev, rx_length_errors);
+		return -1;
+	}
+
+	return 0;
+}
+
 static struct sk_buff *virtnet_build_skb(void *buf, unsigned int buflen,
 					 unsigned int headroom,
 					 unsigned int len)
@@ -1797,7 +1817,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  * across multiple buffers (num_buf > 1), and we make sure buffers
  * have enough headroom.
  */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
+static struct page *xdp_linearize_page(struct net_device *dev,
+				       struct receive_queue *rq,
 				       int *num_buf,
 				       struct page *p,
 				       int offset,
@@ -1817,18 +1838,27 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
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
 
-		buf = virtnet_rq_get_buf(rq, &buflen, NULL);
+		buf = virtnet_rq_get_buf(rq, &buflen, &ctx);
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
@@ -1917,7 +1947,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		headroom = vi->hdr_len + header_offset;
 		buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-		xdp_page = xdp_linearize_page(rq, &num_buf, page,
+		xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
 					      offset, header_offset,
 					      &tlen);
 		if (!xdp_page)
@@ -2252,7 +2282,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 	 */
 	if (!xdp_prog->aux->xdp_has_frags) {
 		/* linearize data for XDP */
-		xdp_page = xdp_linearize_page(rq, num_buf,
+		xdp_page = xdp_linearize_page(vi->dev, rq, num_buf,
 					      *page, offset,
 					      XDP_PACKET_HEADROOM,
 					      len);


