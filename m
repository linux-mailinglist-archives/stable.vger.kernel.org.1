Return-Path: <stable+bounces-76074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B2B978036
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F51C20B1E
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C4E1D7997;
	Fri, 13 Sep 2024 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gc5281Wq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB901187849
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231119; cv=none; b=bE6kSWg+iJKi43c4SePDw/feQZJpAcJDj85gjvWhdG88qbuPnYA5T7hPi8hvfuwOBLe6r5DPmRWhGtpWImxcYmZie041u9T1OLUlsJg+hFdvXrpx/0Wa4M9qR69AREbnm68Qq8OymbQ1KgQ4WRyzart9ofJzLU2xF88c9kg+DwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231119; c=relaxed/simple;
	bh=ZIpJyVRr4ULELy2QsHgendgBnzO2MQxDvawwggtBFwM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PXLJvCyqYVER2//I2NIlLJudIB7QEbppAjzmid1M4fzMvqMUZ5ywaLmXN4JcUNI0OgglrPo4heisQP61jpI/c0fLsRV7/nARc34qeWfKZYmMsMX3DfewNZxjEUCe8KPmbjD93IbYLsAcMS5U8u9gzMnEa9FKPfkDmdQqple8jAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gc5281Wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC55FC4CEC0;
	Fri, 13 Sep 2024 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726231119;
	bh=ZIpJyVRr4ULELy2QsHgendgBnzO2MQxDvawwggtBFwM=;
	h=Subject:To:Cc:From:Date:From;
	b=Gc5281WqWj5eB6a+IFuIsvmegx18Xf/hP64flMEIG8k3kD4CmeJwkl3FNkDjMi1j+
	 0Jgs70gQL6swRn3qhzYsV4w6BWvUi0AaGzGRY9IcU5P66QCvwherFSSpnpp6xiGBhB
	 j0h3kQFblvcmuzLJuaOGX8D/JvvJlqRRDLnf6Pn8=
Subject: FAILED: patch "[PATCH] virtio_net: disable premapped mode by default" failed to apply to 6.10-stable tree
To: xuanzhuo@linux.alibaba.com,flintglass@gmail.com,kuba@kernel.org,mst@redhat.com,si-wei.liu@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:38:36 +0200
Message-ID: <2024091336-family-daffodil-541d@gregkh>
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
git cherry-pick -x 111fc9f517cb293c4213673733b980123c3b0209
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091336-family-daffodil-541d@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

111fc9f517cb ("virtio_net: disable premapped mode by default")
dc4547fbba87 ("Revert "virtio_net: rx remove premapped failover code"")
e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
19a5a7710ee1 ("virtio_net: xsk: support wakeup")
09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 111fc9f517cb293c4213673733b980123c3b0209 Mon Sep 17 00:00:00 2001
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Fri, 6 Sep 2024 20:31:37 +0800
Subject: [PATCH] virtio_net: disable premapped mode by default

Now, the premapped mode encounters some problem.

    http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

So we disable the premapped mode by default.
We can re-enable it in the future.

Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Takero Funaki <flintglass@gmail.com>
Link: https://patch.msgid.link/20240906123137.108741-4-xuanzhuo@linux.alibaba.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1cf80648f82a..5a1c1ec5a64b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -977,22 +977,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	return buf;
 }
 
-static void virtnet_rq_set_premapped(struct virtnet_info *vi)
-{
-	int i;
-
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
-
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
-
-		vi->rq[i].do_dma = true;
-	}
-}
-
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -6105,8 +6089,6 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	virtnet_rq_set_premapped(vi);
-
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();


