Return-Path: <stable+bounces-101393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241989EEBF6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C53283AC3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9789C215798;
	Thu, 12 Dec 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKqMDJvA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C692153DD;
	Thu, 12 Dec 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017401; cv=none; b=oPVzoPb2ojn6YyomrT0ty8D9ex1mkvAj9Nl8VM6DtPsxIr8NxZOHYU/1l7PQ0jvUrJEBn8VuM+layWf+Nb+je+ntkUf+0mqtOveA+Nv8KFjmxOJFd1RlGNxj2o8J7v4hlGI2297WytZjX4WBqdZSUFM9QnbmbqgrbGcHWA0C4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017401; c=relaxed/simple;
	bh=amWtHqHM2lKGaPsQ41u+8d2+cRARTsMS07Lt0FkUbWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcgjD1wiBmwRugC+saVA2y+7IrnjEsm0/7JUEdBYwA6YKNsym8K/DcU9K0xwILIXVizsnKSucGxk1hK1hc2Df86l7X4y0CmjYCoCuSr069YaspJA/qok7kvAg1nGvmp+IhLBSPwJQLdT1nYN8D0C0/4bO67dEad1e0ZWfGZXu3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKqMDJvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D767C4CECE;
	Thu, 12 Dec 2024 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017399;
	bh=amWtHqHM2lKGaPsQ41u+8d2+cRARTsMS07Lt0FkUbWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKqMDJvAvKeIzmDvXmcIqzLVIKvKHwth8CfOMgGPiEuEAkAGTk10am+Rddsz9EIZf
	 s7LRaKGp8vMhSOsTYWulNxZ1V8dS2fZm8nwzMwU9S8UQNNr/5n9LgmM+GcGE1WzcZY
	 +IFJrTQnCBvFkxYfmUnSNrLt7GUiLZRQc+qJ+3KA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bingbu Cao <bingbu.cao@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH 6.12 457/466] media: ipu6: use the IPU6 DMA mapping APIs to do mapping
Date: Thu, 12 Dec 2024 16:00:26 +0100
Message-ID: <20241212144324.922918471@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bingbu Cao <bingbu.cao@intel.com>

commit 1d4a000289979cc7f2887c8407b1bfe2a0918354 upstream.

dma_ops is removed from the IPU6 auxiliary device, ISYS driver
should use the IPU6 DMA mapping APIs directly instead of depending
on the device callbacks.

ISYS driver switch from the videobuf2 DMA contig memory allocator to
scatter/gather memory allocator.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
[Sakari Ailus: Rebased on recent videobuf2 wait changes.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/intel/ipu6/Kconfig           |    2 
 drivers/media/pci/intel/ipu6/ipu6-isys-queue.c |   66 ++++++++++++++++++++-----
 drivers/media/pci/intel/ipu6/ipu6-isys-queue.h |    1 
 drivers/media/pci/intel/ipu6/ipu6-isys.c       |   19 +++----
 4 files changed, 64 insertions(+), 24 deletions(-)

--- a/drivers/media/pci/intel/ipu6/Kconfig
+++ b/drivers/media/pci/intel/ipu6/Kconfig
@@ -8,7 +8,7 @@ config VIDEO_INTEL_IPU6
 	select IOMMU_IOVA
 	select VIDEO_V4L2_SUBDEV_API
 	select MEDIA_CONTROLLER
-	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_DMA_SG
 	select V4L2_FWNODE
 	help
 	  This is the 6th Gen Intel Image Processing Unit, found in Intel SoCs
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c
@@ -13,17 +13,48 @@
 
 #include <media/media-entity.h>
 #include <media/v4l2-subdev.h>
-#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-dma-sg.h>
 #include <media/videobuf2-v4l2.h>
 
 #include "ipu6-bus.h"
+#include "ipu6-dma.h"
 #include "ipu6-fw-isys.h"
 #include "ipu6-isys.h"
 #include "ipu6-isys-video.h"
 
-static int queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
-		       unsigned int *num_planes, unsigned int sizes[],
-		       struct device *alloc_devs[])
+static int ipu6_isys_buf_init(struct vb2_buffer *vb)
+{
+	struct ipu6_isys *isys = vb2_get_drv_priv(vb->vb2_queue);
+	struct sg_table *sg = vb2_dma_sg_plane_desc(vb, 0);
+	struct vb2_v4l2_buffer *vvb = to_vb2_v4l2_buffer(vb);
+	struct ipu6_isys_video_buffer *ivb =
+		vb2_buffer_to_ipu6_isys_video_buffer(vvb);
+	int ret;
+
+	ret = ipu6_dma_map_sgtable(isys->adev, sg, DMA_TO_DEVICE, 0);
+	if (ret)
+		return ret;
+
+	ivb->dma_addr = sg_dma_address(sg->sgl);
+
+	return 0;
+}
+
+static void ipu6_isys_buf_cleanup(struct vb2_buffer *vb)
+{
+	struct ipu6_isys *isys = vb2_get_drv_priv(vb->vb2_queue);
+	struct sg_table *sg = vb2_dma_sg_plane_desc(vb, 0);
+	struct vb2_v4l2_buffer *vvb = to_vb2_v4l2_buffer(vb);
+	struct ipu6_isys_video_buffer *ivb =
+		vb2_buffer_to_ipu6_isys_video_buffer(vvb);
+
+	ivb->dma_addr = 0;
+	ipu6_dma_unmap_sgtable(isys->adev, sg, DMA_TO_DEVICE, 0);
+}
+
+static int ipu6_isys_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
+				 unsigned int *num_planes, unsigned int sizes[],
+				 struct device *alloc_devs[])
 {
 	struct ipu6_isys_queue *aq = vb2_queue_to_isys_queue(q);
 	struct ipu6_isys_video *av = ipu6_isys_queue_to_video(aq);
@@ -207,9 +238,11 @@ ipu6_isys_buf_to_fw_frame_buf_pin(struct
 				  struct ipu6_fw_isys_frame_buff_set_abi *set)
 {
 	struct ipu6_isys_queue *aq = vb2_queue_to_isys_queue(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vvb = to_vb2_v4l2_buffer(vb);
+	struct ipu6_isys_video_buffer *ivb =
+		vb2_buffer_to_ipu6_isys_video_buffer(vvb);
 
-	set->output_pins[aq->fw_output].addr =
-		vb2_dma_contig_plane_dma_addr(vb, 0);
+	set->output_pins[aq->fw_output].addr = ivb->dma_addr;
 	set->output_pins[aq->fw_output].out_buf_id = vb->index + 1;
 }
 
@@ -332,7 +365,7 @@ static void buf_queue(struct vb2_buffer
 
 	dev_dbg(dev, "queue buffer %u for %s\n", vb->index, av->vdev.name);
 
-	dma = vb2_dma_contig_plane_dma_addr(vb, 0);
+	dma = ivb->dma_addr;
 	dev_dbg(dev, "iova: iova %pad\n", &dma);
 
 	spin_lock_irqsave(&aq->lock, flags);
@@ -724,10 +757,14 @@ void ipu6_isys_queue_buf_ready(struct ip
 	}
 
 	list_for_each_entry_reverse(ib, &aq->active, head) {
+		struct ipu6_isys_video_buffer *ivb;
+		struct vb2_v4l2_buffer *vvb;
 		dma_addr_t addr;
 
 		vb = ipu6_isys_buffer_to_vb2_buffer(ib);
-		addr = vb2_dma_contig_plane_dma_addr(vb, 0);
+		vvb = to_vb2_v4l2_buffer(vb);
+		ivb = vb2_buffer_to_ipu6_isys_video_buffer(vvb);
+		addr = ivb->dma_addr;
 
 		if (info->pin.addr != addr) {
 			if (first)
@@ -766,10 +803,12 @@ void ipu6_isys_queue_buf_ready(struct ip
 }
 
 static const struct vb2_ops ipu6_isys_queue_ops = {
-	.queue_setup = queue_setup,
+	.queue_setup = ipu6_isys_queue_setup,
 	.wait_prepare = vb2_ops_wait_prepare,
 	.wait_finish = vb2_ops_wait_finish,
+	.buf_init = ipu6_isys_buf_init,
 	.buf_prepare = ipu6_isys_buf_prepare,
+	.buf_cleanup = ipu6_isys_buf_cleanup,
 	.start_streaming = start_streaming,
 	.stop_streaming = stop_streaming,
 	.buf_queue = buf_queue,
@@ -779,16 +818,17 @@ int ipu6_isys_queue_init(struct ipu6_isy
 {
 	struct ipu6_isys *isys = ipu6_isys_queue_to_video(aq)->isys;
 	struct ipu6_isys_video *av = ipu6_isys_queue_to_video(aq);
+	struct ipu6_bus_device *adev = isys->adev;
 	int ret;
 
 	/* no support for userptr */
 	if (!aq->vbq.io_modes)
 		aq->vbq.io_modes = VB2_MMAP | VB2_DMABUF;
 
-	aq->vbq.drv_priv = aq;
+	aq->vbq.drv_priv = isys;
 	aq->vbq.ops = &ipu6_isys_queue_ops;
 	aq->vbq.lock = &av->mutex;
-	aq->vbq.mem_ops = &vb2_dma_contig_memops;
+	aq->vbq.mem_ops = &vb2_dma_sg_memops;
 	aq->vbq.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	aq->vbq.min_queued_buffers = 1;
 	aq->vbq.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
@@ -797,8 +837,8 @@ int ipu6_isys_queue_init(struct ipu6_isy
 	if (ret)
 		return ret;
 
-	aq->dev = &isys->adev->auxdev.dev;
-	aq->vbq.dev = &isys->adev->auxdev.dev;
+	aq->dev = &adev->auxdev.dev;
+	aq->vbq.dev = &adev->isp->pdev->dev;
 	spin_lock_init(&aq->lock);
 	INIT_LIST_HEAD(&aq->active);
 	INIT_LIST_HEAD(&aq->incoming);
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-queue.h
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-queue.h
@@ -38,6 +38,7 @@ struct ipu6_isys_buffer {
 struct ipu6_isys_video_buffer {
 	struct vb2_v4l2_buffer vb_v4l2;
 	struct ipu6_isys_buffer ib;
+	dma_addr_t dma_addr;
 };
 
 #define IPU6_ISYS_BUFFER_LIST_FL_INCOMING	BIT(0)
--- a/drivers/media/pci/intel/ipu6/ipu6-isys.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys.c
@@ -34,6 +34,7 @@
 
 #include "ipu6-bus.h"
 #include "ipu6-cpd.h"
+#include "ipu6-dma.h"
 #include "ipu6-isys.h"
 #include "ipu6-isys-csi2.h"
 #include "ipu6-mmu.h"
@@ -933,29 +934,27 @@ static const struct dev_pm_ops isys_pm_o
 
 static void free_fw_msg_bufs(struct ipu6_isys *isys)
 {
-	struct device *dev = &isys->adev->auxdev.dev;
 	struct isys_fw_msgs *fwmsg, *safe;
 
 	list_for_each_entry_safe(fwmsg, safe, &isys->framebuflist, head)
-		dma_free_attrs(dev, sizeof(struct isys_fw_msgs), fwmsg,
-			       fwmsg->dma_addr, 0);
+		ipu6_dma_free(isys->adev, sizeof(struct isys_fw_msgs), fwmsg,
+			      fwmsg->dma_addr, 0);
 
 	list_for_each_entry_safe(fwmsg, safe, &isys->framebuflist_fw, head)
-		dma_free_attrs(dev, sizeof(struct isys_fw_msgs), fwmsg,
-			       fwmsg->dma_addr, 0);
+		ipu6_dma_free(isys->adev, sizeof(struct isys_fw_msgs), fwmsg,
+			      fwmsg->dma_addr, 0);
 }
 
 static int alloc_fw_msg_bufs(struct ipu6_isys *isys, int amount)
 {
-	struct device *dev = &isys->adev->auxdev.dev;
 	struct isys_fw_msgs *addr;
 	dma_addr_t dma_addr;
 	unsigned long flags;
 	unsigned int i;
 
 	for (i = 0; i < amount; i++) {
-		addr = dma_alloc_attrs(dev, sizeof(struct isys_fw_msgs),
-				       &dma_addr, GFP_KERNEL, 0);
+		addr = ipu6_dma_alloc(isys->adev, sizeof(*addr),
+				      &dma_addr, GFP_KERNEL, 0);
 		if (!addr)
 			break;
 		addr->dma_addr = dma_addr;
@@ -974,8 +973,8 @@ static int alloc_fw_msg_bufs(struct ipu6
 					struct isys_fw_msgs, head);
 		list_del(&addr->head);
 		spin_unlock_irqrestore(&isys->listlock, flags);
-		dma_free_attrs(dev, sizeof(struct isys_fw_msgs), addr,
-			       addr->dma_addr, 0);
+		ipu6_dma_free(isys->adev, sizeof(struct isys_fw_msgs), addr,
+			      addr->dma_addr, 0);
 		spin_lock_irqsave(&isys->listlock, flags);
 	}
 	spin_unlock_irqrestore(&isys->listlock, flags);



