Return-Path: <stable+bounces-93241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1069CD81F
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1BE28155A
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3162187848;
	Fri, 15 Nov 2024 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HdiJ+tlZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9E153800;
	Fri, 15 Nov 2024 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653262; cv=none; b=PX6wdT0gw+RXdEmtlG7Lg/Fp245BZu4F3Ce6IvjGSyfq6UyDRle/ZqULa1TS3obx8qiDmpWJaR+vORmMVM0osrg6RBtmADVCUM20qxWv35gpe9B2iP6rmWRT/VasSKqovpoOxqFLAqY7s8eG2/rFiQ//J6GXDjIMWiMl07yD300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653262; c=relaxed/simple;
	bh=dskR0iBkRtKpzOYGMaWAtQ+nOLVw738Z9467d1FIWeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyhyJY2k6jV9DQm04mCr7U6l2e3DHXA03YypigNLLAd3u0qdqlzCyWWc5oZxlT33QNyEkI6DaYqL1sQCGRGpaVYPfYHONBgpfmuQ2pSSqnhAqoS7DbxgNpRTa1qenlytyPHsd7DGbFMxAv4VCtvP7GxuWOkVJ/T/z2cZglT8ACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HdiJ+tlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BEAC4CECF;
	Fri, 15 Nov 2024 06:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653262;
	bh=dskR0iBkRtKpzOYGMaWAtQ+nOLVw738Z9467d1FIWeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdiJ+tlZKDb0LZd6yTA05745/8/W1BRuYJ5CtjY9kdxU69p2QXb4RVw9pOaDsKmQ6
	 9wdMezOM/WngEUah8fLvlEVVgxnEueql8NFSddGEVbkBuap2OzXVVFg35Hk/gnLZoR
	 JTC3qY+3V+2fowUNizynYNL0ZtY6aQJutFidIm28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Feng Liu <feliu@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 35/63] virtio_pci: Fix admin vq cleanup by using correct info pointer
Date: Fri, 15 Nov 2024 07:37:58 +0100
Message-ID: <20241115063727.184350674@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
References: <20241115063725.892410236@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Feng Liu <feliu@nvidia.com>

[ Upstream commit 97ee04feb682c906a1fa973ebe586fe91567d165 ]

vp_modern_avq_cleanup() and vp_del_vqs() clean up admin vq
resources by virtio_pci_vq_info pointer. The info pointer of admin
vq is stored in vp_dev->admin_vq.info instead of vp_dev->vqs[].
Using the info pointer from vp_dev->vqs[] for admin vq causes a
kernel NULL pointer dereference bug.
In vp_modern_avq_cleanup() and vp_del_vqs(), get the info pointer
from vp_dev->admin_vq.info for admin vq to clean up the resources.
Also make info ptr as argument of vp_del_vq() to be symmetric with
vp_setup_vq().

vp_reset calls vp_modern_avq_cleanup, and causes the Call Trace:
==================================================================
BUG: kernel NULL pointer dereference, address:0000000000000000
...
CPU: 49 UID: 0 PID: 4439 Comm: modprobe Not tainted 6.11.0-rc5 #1
RIP: 0010:vp_reset+0x57/0x90 [virtio_pci]
Call Trace:
 <TASK>
...
 ? vp_reset+0x57/0x90 [virtio_pci]
 ? vp_reset+0x38/0x90 [virtio_pci]
 virtio_reset_device+0x1d/0x30
 remove_vq_common+0x1c/0x1a0 [virtio_net]
 virtnet_remove+0xa1/0xc0 [virtio_net]
 virtio_dev_remove+0x46/0xa0
...
 virtio_pci_driver_exit+0x14/0x810 [virtio_pci]
==================================================================

Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Message-Id: <20241024135406.81388-1-feliu@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h |  1 +
 drivers/virtio/virtio_pci_modern.c | 12 +-----------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c44d8ba00c02c..88074451dd615 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -24,6 +24,16 @@ MODULE_PARM_DESC(force_legacy,
 		 "Force legacy mode for transitional virtio 1 devices");
 #endif
 
+bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
+		return false;
+
+	return index == vp_dev->admin_vq.vq_index;
+}
+
 /* wait for pending irq handlers */
 void vp_synchronize_vectors(struct virtio_device *vdev)
 {
@@ -234,10 +244,9 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
 	return vq;
 }
 
-static void vp_del_vq(struct virtqueue *vq)
+static void vp_del_vq(struct virtqueue *vq, struct virtio_pci_vq_info *info)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
 	unsigned long flags;
 
 	/*
@@ -258,13 +267,16 @@ static void vp_del_vq(struct virtqueue *vq)
 void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq, *n;
 	int i;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		if (vp_dev->per_vq_vectors) {
-			int v = vp_dev->vqs[vq->index]->msix_vector;
+		info = vp_is_avq(vdev, vq->index) ? vp_dev->admin_vq.info :
+						    vp_dev->vqs[vq->index];
 
+		if (vp_dev->per_vq_vectors) {
+			int v = info->msix_vector;
 			if (v != VIRTIO_MSI_NO_VECTOR &&
 			    !vp_is_slow_path_vector(v)) {
 				int irq = pci_irq_vector(vp_dev->pci_dev, v);
@@ -273,7 +285,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 				free_irq(irq, vq);
 			}
 		}
-		vp_del_vq(vq);
+		vp_del_vq(vq, info);
 	}
 	vp_dev->per_vq_vectors = false;
 
@@ -354,7 +366,7 @@ vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
 			  vring_interrupt, 0,
 			  vp_dev->msix_names[msix_vec], vq);
 	if (err) {
-		vp_del_vq(vq);
+		vp_del_vq(vq, *p_info);
 		return ERR_PTR(err);
 	}
 
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 1d9c49947f52d..8beecf23ec85e 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -178,6 +178,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
 #define VIRTIO_ADMIN_CMD_BITMAP 0
 #endif
 
+bool vp_is_avq(struct virtio_device *vdev, unsigned int index);
 void vp_modern_avq_done(struct virtqueue *vq);
 int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 			     struct virtio_admin_cmd *cmd);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 9193c30d640ae..4fbcbc7a9ae1c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -43,16 +43,6 @@ static int vp_avq_index(struct virtio_device *vdev, u16 *index, u16 *num)
 	return 0;
 }
 
-static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-
-	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
-		return false;
-
-	return index == vp_dev->admin_vq.vq_index;
-}
-
 void vp_modern_avq_done(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
@@ -245,7 +235,7 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
 	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
 		return;
 
-	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
+	vq = vp_dev->admin_vq.info->vq;
 	if (!vq)
 		return;
 
-- 
2.43.0




