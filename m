Return-Path: <stable+bounces-51688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FB907120
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8335C1F22FBA
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4662566;
	Thu, 13 Jun 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KRVweqOE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C13384;
	Thu, 13 Jun 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282024; cv=none; b=a6nh5yhQ0ZXGbaqM1cKm74IfJINYvL/ys0qUFUttkTmJ0mjWdRMwMreorzAzTscoVDm3NsM0AWDWF7QZ9zt6yaBIF1dVUJ+eiQNtKnJ+eekbOrSj8D2JiumXBnJbFB2kaeOM2Tm2iuO6ZiGNuo6MWHVWIImp+6esFI0Dw3J1Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282024; c=relaxed/simple;
	bh=MNDDAYYfYXGszebkl0PPSdHRPRWiJuG5zoKHulM1OZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juc8otHvfRvv8QRsXkjW7etpde2TgZ/mCrzh98J8hEXZj8xMLedtno4dJKWWhMyH4qsvOSecgsNtB1k/yNU55IG0rvHDMHL8BZpWWm/Xg5e79fad5GCVRCZU0NiwueBaPAfxXQN7gZCecBelOg/aQVHiTC5PoKkfa5xmyJsl4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KRVweqOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE35C4AF1A;
	Thu, 13 Jun 2024 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282024;
	bh=MNDDAYYfYXGszebkl0PPSdHRPRWiJuG5zoKHulM1OZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRVweqOEJlkvdeBAENtGYedhNoj03mKwVaNj4ovukepFZqbC/LVRs5mCwH2P/a63M
	 Ptlp12IK2jCGyEdiyAdvLpLhcsaOOID70Qm+qy5p9Xi5flotk+NC78Y88gmSkfuDfF
	 6OBsuZ8GcRUX5yffdtJFnj57EwvodqpaC8EfO+dY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 136/402] media: ipu3-cio2: Use temporary storage for struct device pointer
Date: Thu, 13 Jun 2024 13:31:33 +0200
Message-ID: <20240613113307.441433906@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit cfd13612a5a70715299d2468f967334048ce52a7 ]

Use temporary storage for struct device pointer to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: a069f79bfa6e ("media: ipu3-cio2: Request IRQ earlier")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 138 +++++++++---------
 1 file changed, 67 insertions(+), 71 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 162ab089124f3..29c660fe1425b 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -102,26 +102,29 @@ static inline u32 cio2_bytesperline(const unsigned int width)
 
 static void cio2_fbpt_exit_dummy(struct cio2_device *cio2)
 {
+	struct device *dev = &cio2->pci_dev->dev;
+
 	if (cio2->dummy_lop) {
-		dma_free_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
-				  cio2->dummy_lop, cio2->dummy_lop_bus_addr);
+		dma_free_coherent(dev, PAGE_SIZE, cio2->dummy_lop,
+				  cio2->dummy_lop_bus_addr);
 		cio2->dummy_lop = NULL;
 	}
 	if (cio2->dummy_page) {
-		dma_free_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
-				  cio2->dummy_page, cio2->dummy_page_bus_addr);
+		dma_free_coherent(dev, PAGE_SIZE, cio2->dummy_page,
+				  cio2->dummy_page_bus_addr);
 		cio2->dummy_page = NULL;
 	}
 }
 
 static int cio2_fbpt_init_dummy(struct cio2_device *cio2)
 {
+	struct device *dev = &cio2->pci_dev->dev;
 	unsigned int i;
 
-	cio2->dummy_page = dma_alloc_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
+	cio2->dummy_page = dma_alloc_coherent(dev, PAGE_SIZE,
 					      &cio2->dummy_page_bus_addr,
 					      GFP_KERNEL);
-	cio2->dummy_lop = dma_alloc_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
+	cio2->dummy_lop = dma_alloc_coherent(dev, PAGE_SIZE,
 					     &cio2->dummy_lop_bus_addr,
 					     GFP_KERNEL);
 	if (!cio2->dummy_page || !cio2->dummy_lop) {
@@ -497,6 +500,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 
 static void cio2_hw_exit(struct cio2_device *cio2, struct cio2_queue *q)
 {
+	struct device *dev = &cio2->pci_dev->dev;
 	void __iomem *const base = cio2->base;
 	unsigned int i;
 	u32 value;
@@ -514,8 +518,7 @@ static void cio2_hw_exit(struct cio2_device *cio2, struct cio2_queue *q)
 				 value, value & CIO2_CDMAC0_DMA_HALTED,
 				 4000, 2000000);
 	if (ret)
-		dev_err(&cio2->pci_dev->dev,
-			"DMA %i can not be halted\n", CIO2_DMA_CHAN);
+		dev_err(dev, "DMA %i can not be halted\n", CIO2_DMA_CHAN);
 
 	for (i = 0; i < CIO2_NUM_PORTS; i++) {
 		writel(readl(base + CIO2_REG_PXM_FRF_CFG(i)) |
@@ -539,8 +542,7 @@ static void cio2_buffer_done(struct cio2_device *cio2, unsigned int dma_chan)
 
 	entry = &q->fbpt[q->bufs_first * CIO2_MAX_LOPS];
 	if (entry->first_entry.ctrl & CIO2_FBPT_CTRL_VALID) {
-		dev_warn(&cio2->pci_dev->dev,
-			 "no ready buffers found on DMA channel %u\n",
+		dev_warn(dev, "no ready buffers found on DMA channel %u\n",
 			 dma_chan);
 		return;
 	}
@@ -557,8 +559,7 @@ static void cio2_buffer_done(struct cio2_device *cio2, unsigned int dma_chan)
 
 			q->bufs[q->bufs_first] = NULL;
 			atomic_dec(&q->bufs_queued);
-			dev_dbg(&cio2->pci_dev->dev,
-				"buffer %i done\n", b->vbb.vb2_buf.index);
+			dev_dbg(dev, "buffer %i done\n", b->vbb.vb2_buf.index);
 
 			b->vbb.vb2_buf.timestamp = ns;
 			b->vbb.field = V4L2_FIELD_NONE;
@@ -624,8 +625,8 @@ static const char *const cio2_port_errs[] = {
 
 static void cio2_irq_handle_once(struct cio2_device *cio2, u32 int_status)
 {
-	void __iomem *const base = cio2->base;
 	struct device *dev = &cio2->pci_dev->dev;
+	void __iomem *const base = cio2->base;
 
 	if (int_status & CIO2_INT_IOOE) {
 		/*
@@ -795,6 +796,7 @@ static int cio2_vb2_queue_setup(struct vb2_queue *vq,
 				struct device *alloc_devs[])
 {
 	struct cio2_device *cio2 = vb2_get_drv_priv(vq);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct cio2_queue *q = vb2q_to_cio2_queue(vq);
 	unsigned int i;
 
@@ -802,7 +804,7 @@ static int cio2_vb2_queue_setup(struct vb2_queue *vq,
 
 	for (i = 0; i < *num_planes; ++i) {
 		sizes[i] = q->format.plane_fmt[i].sizeimage;
-		alloc_devs[i] = &cio2->pci_dev->dev;
+		alloc_devs[i] = dev;
 	}
 
 	*num_buffers = clamp_val(*num_buffers, 1, CIO2_MAX_BUFFERS);
@@ -879,6 +881,7 @@ static int cio2_vb2_buf_init(struct vb2_buffer *vb)
 static void cio2_vb2_buf_queue(struct vb2_buffer *vb)
 {
 	struct cio2_device *cio2 = vb2_get_drv_priv(vb->vb2_queue);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct cio2_queue *q =
 		container_of(vb->vb2_queue, struct cio2_queue, vbq);
 	struct cio2_buffer *b =
@@ -889,7 +892,7 @@ static void cio2_vb2_buf_queue(struct vb2_buffer *vb)
 	int bufs_queued = atomic_inc_return(&q->bufs_queued);
 	u32 fbpt_rp;
 
-	dev_dbg(&cio2->pci_dev->dev, "queue buffer %d\n", vb->index);
+	dev_dbg(dev, "queue buffer %d\n", vb->index);
 
 	/*
 	 * This code queues the buffer to the CIO2 DMA engine, which starts
@@ -940,12 +943,12 @@ static void cio2_vb2_buf_queue(struct vb2_buffer *vb)
 			return;
 		}
 
-		dev_dbg(&cio2->pci_dev->dev, "entry %i was full!\n", next);
+		dev_dbg(dev, "entry %i was full!\n", next);
 		next = (next + 1) % CIO2_MAX_BUFFERS;
 	}
 
 	local_irq_restore(flags);
-	dev_err(&cio2->pci_dev->dev, "error: all cio2 entries were full!\n");
+	dev_err(dev, "error: all cio2 entries were full!\n");
 	atomic_dec(&q->bufs_queued);
 	vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
 }
@@ -954,6 +957,7 @@ static void cio2_vb2_buf_queue(struct vb2_buffer *vb)
 static void cio2_vb2_buf_cleanup(struct vb2_buffer *vb)
 {
 	struct cio2_device *cio2 = vb2_get_drv_priv(vb->vb2_queue);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct cio2_buffer *b =
 		container_of(vb, struct cio2_buffer, vbb.vb2_buf);
 	unsigned int i;
@@ -961,7 +965,7 @@ static void cio2_vb2_buf_cleanup(struct vb2_buffer *vb)
 	/* Free LOP table */
 	for (i = 0; i < CIO2_MAX_LOPS; i++) {
 		if (b->lop[i])
-			dma_free_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
+			dma_free_coherent(dev, PAGE_SIZE,
 					  b->lop[i], b->lop_bus_addr[i]);
 	}
 }
@@ -970,14 +974,15 @@ static int cio2_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct cio2_queue *q = vb2q_to_cio2_queue(vq);
 	struct cio2_device *cio2 = vb2_get_drv_priv(vq);
+	struct device *dev = &cio2->pci_dev->dev;
 	int r;
 
 	cio2->cur_queue = q;
 	atomic_set(&q->frame_sequence, 0);
 
-	r = pm_runtime_resume_and_get(&cio2->pci_dev->dev);
+	r = pm_runtime_resume_and_get(dev);
 	if (r < 0) {
-		dev_info(&cio2->pci_dev->dev, "failed to set power %d\n", r);
+		dev_info(dev, "failed to set power %d\n", r);
 		return r;
 	}
 
@@ -1003,9 +1008,9 @@ static int cio2_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 fail_hw:
 	media_pipeline_stop(&q->vdev.entity);
 fail_pipeline:
-	dev_dbg(&cio2->pci_dev->dev, "failed to start streaming (%d)\n", r);
+	dev_dbg(dev, "failed to start streaming (%d)\n", r);
 	cio2_vb2_return_all_buffers(q, VB2_BUF_STATE_QUEUED);
-	pm_runtime_put(&cio2->pci_dev->dev);
+	pm_runtime_put(dev);
 
 	return r;
 }
@@ -1014,16 +1019,16 @@ static void cio2_vb2_stop_streaming(struct vb2_queue *vq)
 {
 	struct cio2_queue *q = vb2q_to_cio2_queue(vq);
 	struct cio2_device *cio2 = vb2_get_drv_priv(vq);
+	struct device *dev = &cio2->pci_dev->dev;
 
 	if (v4l2_subdev_call(q->sensor, video, s_stream, 0))
-		dev_err(&cio2->pci_dev->dev,
-			"failed to stop sensor streaming\n");
+		dev_err(dev, "failed to stop sensor streaming\n");
 
 	cio2_hw_exit(cio2, q);
 	synchronize_irq(cio2->pci_dev->irq);
 	cio2_vb2_return_all_buffers(q, VB2_BUF_STATE_ERROR);
 	media_pipeline_stop(&q->vdev.entity);
-	pm_runtime_put(&cio2->pci_dev->dev);
+	pm_runtime_put(dev);
 	cio2->streaming = false;
 }
 
@@ -1315,12 +1320,12 @@ static int cio2_video_link_validate(struct media_link *link)
 						struct video_device, entity);
 	struct cio2_queue *q = container_of(vd, struct cio2_queue, vdev);
 	struct cio2_device *cio2 = video_get_drvdata(vd);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct v4l2_subdev_format source_fmt;
 	int ret;
 
 	if (!media_entity_remote_pad(link->sink->entity->pads)) {
-		dev_info(&cio2->pci_dev->dev,
-			 "video node %s pad not connected\n", vd->name);
+		dev_info(dev, "video node %s pad not connected\n", vd->name);
 		return -ENOTCONN;
 	}
 
@@ -1330,8 +1335,7 @@ static int cio2_video_link_validate(struct media_link *link)
 
 	if (source_fmt.format.width != q->format.width ||
 	    source_fmt.format.height != q->format.height) {
-		dev_err(&cio2->pci_dev->dev,
-			"Wrong width or height %ux%u (%ux%u expected)\n",
+		dev_err(dev, "Wrong width or height %ux%u (%ux%u expected)\n",
 			q->format.width, q->format.height,
 			source_fmt.format.width, source_fmt.format.height);
 		return -EINVAL;
@@ -1412,6 +1416,7 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 {
 	struct cio2_device *cio2 = container_of(notifier, struct cio2_device,
 						notifier);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct sensor_async_subdev *s_asd;
 	struct v4l2_async_subdev *asd;
 	struct cio2_queue *q;
@@ -1428,8 +1433,7 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 				break;
 
 		if (pad == q->sensor->entity.num_pads) {
-			dev_err(&cio2->pci_dev->dev,
-				"failed to find src pad for %s\n",
+			dev_err(dev, "failed to find src pad for %s\n",
 				q->sensor->name);
 			return -ENXIO;
 		}
@@ -1439,8 +1443,7 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 				&q->subdev.entity, CIO2_PAD_SINK,
 				0);
 		if (ret) {
-			dev_err(&cio2->pci_dev->dev,
-				"failed to create link for %s\n",
+			dev_err(dev, "failed to create link for %s\n",
 				q->sensor->name);
 			return ret;
 		}
@@ -1457,6 +1460,7 @@ static const struct v4l2_async_notifier_operations cio2_async_ops = {
 
 static int cio2_parse_firmware(struct cio2_device *cio2)
 {
+	struct device *dev = &cio2->pci_dev->dev;
 	unsigned int i;
 	int ret;
 
@@ -1467,10 +1471,8 @@ static int cio2_parse_firmware(struct cio2_device *cio2)
 		struct sensor_async_subdev *s_asd;
 		struct fwnode_handle *ep;
 
-		ep = fwnode_graph_get_endpoint_by_id(
-			dev_fwnode(&cio2->pci_dev->dev), i, 0,
-			FWNODE_GRAPH_ENDPOINT_NEXT);
-
+		ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), i, 0,
+						FWNODE_GRAPH_ENDPOINT_NEXT);
 		if (!ep)
 			continue;
 
@@ -1504,8 +1506,7 @@ static int cio2_parse_firmware(struct cio2_device *cio2)
 	cio2->notifier.ops = &cio2_async_ops;
 	ret = v4l2_async_notifier_register(&cio2->v4l2_dev, &cio2->notifier);
 	if (ret)
-		dev_err(&cio2->pci_dev->dev,
-			"failed to register async notifier : %d\n", ret);
+		dev_err(dev, "failed to register async notifier : %d\n", ret);
 
 	return ret;
 }
@@ -1524,7 +1525,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	static const u32 default_width = 1936;
 	static const u32 default_height = 1096;
 	const struct ipu3_cio2_fmt dflt_fmt = formats[0];
-
+	struct device *dev = &cio2->pci_dev->dev;
 	struct video_device *vdev = &q->vdev;
 	struct vb2_queue *vbq = &q->vbq;
 	struct v4l2_subdev *subdev = &q->subdev;
@@ -1566,8 +1567,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	subdev->internal_ops = &cio2_subdev_internal_ops;
 	r = media_entity_pads_init(&subdev->entity, CIO2_PADS, q->subdev_pads);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed initialize subdev media entity (%d)\n", r);
+		dev_err(dev, "failed initialize subdev media entity (%d)\n", r);
 		goto fail_subdev_media_entity;
 	}
 
@@ -1575,8 +1575,8 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	vdev->entity.ops = &cio2_video_entity_ops;
 	r = media_entity_pads_init(&vdev->entity, 1, &q->vdev_pad);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed initialize videodev media entity (%d)\n", r);
+		dev_err(dev, "failed initialize videodev media entity (%d)\n",
+			r);
 		goto fail_vdev_media_entity;
 	}
 
@@ -1590,8 +1590,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	v4l2_set_subdevdata(subdev, cio2);
 	r = v4l2_device_register_subdev(&cio2->v4l2_dev, subdev);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed initialize subdev (%d)\n", r);
+		dev_err(dev, "failed initialize subdev (%d)\n", r);
 		goto fail_subdev;
 	}
 
@@ -1607,8 +1606,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	vbq->lock = &q->lock;
 	r = vb2_queue_init(vbq);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed to initialize videobuf2 queue (%d)\n", r);
+		dev_err(dev, "failed to initialize videobuf2 queue (%d)\n", r);
 		goto fail_subdev;
 	}
 
@@ -1625,8 +1623,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	video_set_drvdata(vdev, cio2);
 	r = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed to register video device (%d)\n", r);
+		dev_err(dev, "failed to register video device (%d)\n", r);
 		goto fail_vdev;
 	}
 
@@ -1648,7 +1645,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 fail_vdev_media_entity:
 	media_entity_cleanup(&subdev->entity);
 fail_subdev_media_entity:
-	cio2_fbpt_exit(q, &cio2->pci_dev->dev);
+	cio2_fbpt_exit(q, dev);
 fail_fbpt:
 	mutex_destroy(&q->subdev_lock);
 	mutex_destroy(&q->lock);
@@ -1715,11 +1712,12 @@ static int cio2_check_fwnode_graph(struct fwnode_handle *fwnode)
 static int cio2_pci_probe(struct pci_dev *pci_dev,
 			  const struct pci_device_id *id)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(&pci_dev->dev);
+	struct device *dev = &pci_dev->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct cio2_device *cio2;
 	int r;
 
-	cio2 = devm_kzalloc(&pci_dev->dev, sizeof(*cio2), GFP_KERNEL);
+	cio2 = devm_kzalloc(dev, sizeof(*cio2), GFP_KERNEL);
 	if (!cio2)
 		return -ENOMEM;
 	cio2->pci_dev = pci_dev;
@@ -1732,7 +1730,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 	r = cio2_check_fwnode_graph(fwnode);
 	if (r) {
 		if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary)) {
-			dev_err(&pci_dev->dev, "fwnode graph has no endpoints connected\n");
+			dev_err(dev, "fwnode graph has no endpoints connected\n");
 			return -EINVAL;
 		}
 
@@ -1743,16 +1741,16 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	r = pcim_enable_device(pci_dev);
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to enable device (%d)\n", r);
+		dev_err(dev, "failed to enable device (%d)\n", r);
 		return r;
 	}
 
-	dev_info(&pci_dev->dev, "device 0x%x (rev: 0x%x)\n",
+	dev_info(dev, "device 0x%x (rev: 0x%x)\n",
 		 pci_dev->device, pci_dev->revision);
 
 	r = pcim_iomap_regions(pci_dev, 1 << CIO2_PCI_BAR, pci_name(pci_dev));
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to remap I/O memory (%d)\n", r);
+		dev_err(dev, "failed to remap I/O memory (%d)\n", r);
 		return -ENODEV;
 	}
 
@@ -1764,13 +1762,13 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	r = pci_set_dma_mask(pci_dev, CIO2_DMA_MASK);
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to set DMA mask (%d)\n", r);
+		dev_err(dev, "failed to set DMA mask (%d)\n", r);
 		return -ENODEV;
 	}
 
 	r = pci_enable_msi(pci_dev);
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to enable MSI (%d)\n", r);
+		dev_err(dev, "failed to enable MSI (%d)\n", r);
 		return r;
 	}
 
@@ -1780,7 +1778,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	mutex_init(&cio2->lock);
 
-	cio2->media_dev.dev = &cio2->pci_dev->dev;
+	cio2->media_dev.dev = dev;
 	strscpy(cio2->media_dev.model, CIO2_DEVICE_NAME,
 		sizeof(cio2->media_dev.model));
 	snprintf(cio2->media_dev.bus_info, sizeof(cio2->media_dev.bus_info),
@@ -1793,10 +1791,9 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 		goto fail_mutex_destroy;
 
 	cio2->v4l2_dev.mdev = &cio2->media_dev;
-	r = v4l2_device_register(&pci_dev->dev, &cio2->v4l2_dev);
+	r = v4l2_device_register(dev, &cio2->v4l2_dev);
 	if (r) {
-		dev_err(&pci_dev->dev,
-			"failed to register V4L2 device (%d)\n", r);
+		dev_err(dev, "failed to register V4L2 device (%d)\n", r);
 		goto fail_media_device_unregister;
 	}
 
@@ -1811,15 +1808,15 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 	if (r)
 		goto fail_clean_notifier;
 
-	r = devm_request_irq(&pci_dev->dev, pci_dev->irq, cio2_irq,
-			     IRQF_SHARED, CIO2_NAME, cio2);
+	r = devm_request_irq(dev, pci_dev->irq, cio2_irq, IRQF_SHARED,
+			     CIO2_NAME, cio2);
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to request IRQ (%d)\n", r);
+		dev_err(dev, "failed to request IRQ (%d)\n", r);
 		goto fail_clean_notifier;
 	}
 
-	pm_runtime_put_noidle(&pci_dev->dev);
-	pm_runtime_allow(&pci_dev->dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_allow(dev);
 
 	return 0;
 
@@ -2008,10 +2005,9 @@ static int __maybe_unused cio2_resume(struct device *dev)
 	if (!cio2->streaming)
 		return 0;
 	/* Start stream */
-	r = pm_runtime_force_resume(&cio2->pci_dev->dev);
+	r = pm_runtime_force_resume(dev);
 	if (r < 0) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed to set power %d\n", r);
+		dev_err(dev, "failed to set power %d\n", r);
 		return r;
 	}
 
-- 
2.43.0




