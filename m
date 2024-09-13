Return-Path: <stable+bounces-76073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834A978035
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18D71C20C5D
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A021D7E2D;
	Fri, 13 Sep 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyDXTYrc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A628187849
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231091; cv=none; b=hGKPDjWP/iMALj9zz5grJdFAt1tu89n3E1VXqd3F4G03aEAd479/JUKHKf56ShO2mTaIDIOamjVkySGrqqP8MhORDd8YjcCEhn8R7+/Qmc1daPZ+W9e2dEb4/Updldql7AsN93M384A1K4Di4rwJVqLs1qjHAlIGLtpybdlt/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231091; c=relaxed/simple;
	bh=VvdRMFu+ThCqMiizOlCbq4aLi890WsUd633flsu9QCA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IRyOdajTY54O2m5QCcYdJhyFrx98rjk5qAr1JoNL1Wn4Gh8iQyDXD/KIvxik1SrHQ0GDrGYgr2BpREIhBYJyRLZ7lEVkP25LZv/RKtD0+E+ffQoSRrfOFG/inIvjuCYPebNzZC1FD4DbJ+Gs/rMH8oIoKM9Eqz8QWEZUMFFMhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyDXTYrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E33CC4CEC0;
	Fri, 13 Sep 2024 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726231090;
	bh=VvdRMFu+ThCqMiizOlCbq4aLi890WsUd633flsu9QCA=;
	h=Subject:To:Cc:From:Date:From;
	b=zyDXTYrcIEt7QMd42WSdFflsrwRgcOWdnU99sJxbN5MvNBlIVadetK0SNCrCi15wx
	 +xH+cVMDn68EuPAYI9S45wZPijQICi9O2l+vfoMvl9zAkFmzsT9J49uTlO0GbjPy98
	 sHYpbekAjsa7bWI2Nlw9hOilvEA0PbI215VG6+Xs=
Subject: FAILED: patch "[PATCH] Revert "virtio_net: big mode skip the unmap check"" failed to apply to 6.10-stable tree
To: xuanzhuo@linux.alibaba.com,flintglass@gmail.com,kuba@kernel.org,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:38:08 +0200
Message-ID: <2024091308-deceit-dingy-d575@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 38eef112a8e547b8c207b2a521ad4b077d792100
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091308-deceit-dingy-d575@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

38eef112a8e5 ("Revert "virtio_net: big mode skip the unmap check"")
99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
a4e7ba702701 ("virtio_net: xsk: rx: support recv small mode")
e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
19a5a7710ee1 ("virtio_net: xsk: support wakeup")
09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38eef112a8e547b8c207b2a521ad4b077d792100 Mon Sep 17 00:00:00 2001
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Fri, 6 Sep 2024 20:31:36 +0800
Subject: [PATCH] Revert "virtio_net: big mode skip the unmap check"

This reverts commit a377ae542d8d0a20a3173da3bbba72e045bea7a9.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Takero Funaki <flintglass@gmail.com>
Link: https://patch.msgid.link/20240906123137.108741-3-xuanzhuo@linux.alibaba.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6fa8aab18484..1cf80648f82a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1006,7 +1006,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 		return;
 	}
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
+	if (rq->do_dma)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2716,7 +2716,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
+		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, stats);
 			packets++;
 		}


