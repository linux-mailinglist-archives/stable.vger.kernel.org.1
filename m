Return-Path: <stable+bounces-143256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2FAB3557
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9C517FBDA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49F267AE3;
	Mon, 12 May 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="18q0Flg5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F1255236
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047116; cv=none; b=ABcAU8mZZgvFO5wGzcu9aZuKqPTtgZwQ8BDtwpqSz6yRmLBBVw+EfHbJNdIq9y2IY3AYpfla8KOQyPLgKo91fGGVmvOMcXjZAYLVXllj+9B/3XX3FZCNJvAyVMG212LTnvE/FBogu6gPTrW/X+XfF6bPKnPrBKtSmUYSrZB8BUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047116; c=relaxed/simple;
	bh=NfgpHLXcOZyp0H1uTCzqiyd1c7eo0ksJ6pN2+6LBZS8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q2YwGt9LjniwK+Cpl6oGFGDdmywm4TTgcjJx1CVwB7ZhHU8+QBLTPIveLd3w+TGtXDHIQ6Kndfk08dC3XFuUAHu6l4bJsE5KaPdgz0UMCXzxhCu5YjLRWCBFB+zaXKSe1FVlbNeQ3dBdYbKIBEpCIMXFoSiHbiDhd13DM7Xjr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=18q0Flg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A47C4CEE7;
	Mon, 12 May 2025 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747047114;
	bh=NfgpHLXcOZyp0H1uTCzqiyd1c7eo0ksJ6pN2+6LBZS8=;
	h=Subject:To:Cc:From:Date:From;
	b=18q0Flg5Fl0wkYMtyo2s5Wudtp1ql8V2XA4SSyJZYNtEkxm6MvBjC1+JaLm45PCGA
	 GiTr6qQ3nZP4THjFWvLNJDjXTCDYEA9hTUUSVJ25sU73v+ErvS5EHcxT1sXs60Pyxy
	 yGaCoyJ/pTH9Y6v1Uqdycx4dF8hawPGE3TUBMb80=
Subject: FAILED: patch "[PATCH] virtio_net: ensure netdev_tx_reset_queue is called on bind" failed to apply to 6.12-stable tree
To: koichiro.den@canonical.com,jasowang@redhat.com,pabeni@redhat.com,xuanzhuo@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:51:51 +0200
Message-ID: <2025051251-shawl-unmarked-03e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 76a771ec4c9adfd75fe53c8505cf656a075d7101
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051251-shawl-unmarked-03e8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76a771ec4c9adfd75fe53c8505cf656a075d7101 Mon Sep 17 00:00:00 2001
From: Koichiro Den <koichiro.den@canonical.com>
Date: Fri, 6 Dec 2024 10:10:47 +0900
Subject: [PATCH] virtio_net: ensure netdev_tx_reset_queue is called on bind
 xsk for tx

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset when flushing has actually occurred, Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
to handle this.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5cf4b2b20431..7646ddd9bef7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5740,7 +5740,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf,
+			      virtnet_sq_free_unused_buf_done);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;


