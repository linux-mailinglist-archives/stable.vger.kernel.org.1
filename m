Return-Path: <stable+bounces-187645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0906BEA7C5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7605A1095
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218932C928;
	Fri, 17 Oct 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKTWsuOJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00907330B2E;
	Fri, 17 Oct 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716670; cv=none; b=LUEuD7XnjrS7E9SDs+Dsb+osVAEKqK5HCKRC5B6flza8ck6GxXYWQbsTKEKayuqk/QkuvK1spDe6SBNVehpeVr3FEGDk53wzeyuMacdxHG6qaz4aSO7GyaG+sQWNYIEVgxz4phzV917omo9Fld08DtIez00nXEGdeW8biDoPiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716670; c=relaxed/simple;
	bh=CSzLmSFy+xtAfbGKhsnk39/uTSoPwWYKOE+qan/PBd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clcgoKmQMe+UGOXlGGvArLUEb9bYWJdD2+L/JkftEsXVUkBWmFOijV4ILBl31FTlaBpp5KRkooZGOYXMOBefag4Y/jWNvarfr0IFnNTwmH5Dph6O5kCtJIS8R7itod/LCfrXa+DVJsPmnQZzPr05ZDaSo43zaTWsrQ3AfZCI57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKTWsuOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0BDC4CEE7;
	Fri, 17 Oct 2025 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716669;
	bh=CSzLmSFy+xtAfbGKhsnk39/uTSoPwWYKOE+qan/PBd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKTWsuOJAHLqK/dGv7OdsSVls1xD7Mc59hfcouLKH7pw51l4vbj+cH7qcqphL/Fj8
	 po3V7rfZpl1fvduN3phJOIBziy2US3uwwTFSqEiyC33fF90hn+fMy8QBPQH/VN8QoK
	 iatelp4sxaeVxMWLmqTJMvf9Kuf7zZw0g5qTWkYg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 270/276] media: pci/ivtv: switch from pci_ to dma_ API
Date: Fri, 17 Oct 2025 16:56:03 +0200
Message-ID: <20251017145152.344764631@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 1932dc2f4cf6ac23e48e5fcc24d21adbe35691d1 ]

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.
It has been compile tested.

No memory allocation in involved in this patch, so no GFP_ tweak is needed.

@@ @@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@ @@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@ @@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@ @@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 1069a4fe637d ("media: pci: ivtv: Add missing check after DMA map")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/ivtv/ivtv-driver.c  |    2 +-
 drivers/media/pci/ivtv/ivtv-queue.c   |   18 ++++++++++--------
 drivers/media/pci/ivtv/ivtv-streams.c |   22 +++++++++++-----------
 drivers/media/pci/ivtv/ivtv-udma.c    |   19 ++++++++++++-------
 drivers/media/pci/ivtv/ivtv-yuv.c     |   10 +++++++---
 5 files changed, 41 insertions(+), 30 deletions(-)

--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -837,7 +837,7 @@ static int ivtv_setup_pci(struct ivtv *i
 		IVTV_ERR("Can't enable device!\n");
 		return -EIO;
 	}
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
 		IVTV_ERR("No suitable DMA available.\n");
 		return -EIO;
 	}
--- a/drivers/media/pci/ivtv/ivtv-queue.c
+++ b/drivers/media/pci/ivtv/ivtv-queue.c
@@ -188,7 +188,7 @@ int ivtv_stream_alloc(struct ivtv_stream
 		return 0;
 
 	IVTV_DEBUG_INFO("Allocate %s%s stream: %d x %d buffers (%dkB total)\n",
-		s->dma != PCI_DMA_NONE ? "DMA " : "",
+		s->dma != DMA_NONE ? "DMA " : "",
 		s->name, s->buffers, s->buf_size, s->buffers * s->buf_size / 1024);
 
 	s->sg_pending = kzalloc(SGsize, GFP_KERNEL|__GFP_NOWARN);
@@ -218,8 +218,9 @@ int ivtv_stream_alloc(struct ivtv_stream
 		return -ENOMEM;
 	}
 	if (ivtv_might_use_dma(s)) {
-		s->sg_handle = pci_map_single(itv->pdev, s->sg_dma,
-				sizeof(struct ivtv_sg_element), PCI_DMA_TODEVICE);
+		s->sg_handle = dma_map_single(&itv->pdev->dev, s->sg_dma,
+					      sizeof(struct ivtv_sg_element),
+					      DMA_TO_DEVICE);
 		ivtv_stream_sync_for_cpu(s);
 	}
 
@@ -237,7 +238,7 @@ int ivtv_stream_alloc(struct ivtv_stream
 		}
 		INIT_LIST_HEAD(&buf->list);
 		if (ivtv_might_use_dma(s)) {
-			buf->dma_handle = pci_map_single(s->itv->pdev,
+			buf->dma_handle = dma_map_single(&s->itv->pdev->dev,
 				buf->buf, s->buf_size + 256, s->dma);
 			ivtv_buf_sync_for_cpu(s, buf);
 		}
@@ -260,8 +261,8 @@ void ivtv_stream_free(struct ivtv_stream
 	/* empty q_free */
 	while ((buf = ivtv_dequeue(s, &s->q_free))) {
 		if (ivtv_might_use_dma(s))
-			pci_unmap_single(s->itv->pdev, buf->dma_handle,
-				s->buf_size + 256, s->dma);
+			dma_unmap_single(&s->itv->pdev->dev, buf->dma_handle,
+					 s->buf_size + 256, s->dma);
 		kfree(buf->buf);
 		kfree(buf);
 	}
@@ -269,8 +270,9 @@ void ivtv_stream_free(struct ivtv_stream
 	/* Free SG Array/Lists */
 	if (s->sg_dma != NULL) {
 		if (s->sg_handle != IVTV_DMA_UNMAPPED) {
-			pci_unmap_single(s->itv->pdev, s->sg_handle,
-				 sizeof(struct ivtv_sg_element), PCI_DMA_TODEVICE);
+			dma_unmap_single(&s->itv->pdev->dev, s->sg_handle,
+					 sizeof(struct ivtv_sg_element),
+					 DMA_TO_DEVICE);
 			s->sg_handle = IVTV_DMA_UNMAPPED;
 		}
 		kfree(s->sg_pending);
--- a/drivers/media/pci/ivtv/ivtv-streams.c
+++ b/drivers/media/pci/ivtv/ivtv-streams.c
@@ -100,7 +100,7 @@ static struct {
 	{	/* IVTV_ENC_STREAM_TYPE_MPG */
 		"encoder MPG",
 		VFL_TYPE_VIDEO, 0,
-		PCI_DMA_FROMDEVICE, 0,
+		DMA_FROM_DEVICE, 0,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
@@ -108,7 +108,7 @@ static struct {
 	{	/* IVTV_ENC_STREAM_TYPE_YUV */
 		"encoder YUV",
 		VFL_TYPE_VIDEO, IVTV_V4L2_ENC_YUV_OFFSET,
-		PCI_DMA_FROMDEVICE, 0,
+		DMA_FROM_DEVICE, 0,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
@@ -116,7 +116,7 @@ static struct {
 	{	/* IVTV_ENC_STREAM_TYPE_VBI */
 		"encoder VBI",
 		VFL_TYPE_VBI, 0,
-		PCI_DMA_FROMDEVICE, 0,
+		DMA_FROM_DEVICE, 0,
 		V4L2_CAP_VBI_CAPTURE | V4L2_CAP_SLICED_VBI_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
@@ -124,42 +124,42 @@ static struct {
 	{	/* IVTV_ENC_STREAM_TYPE_PCM */
 		"encoder PCM",
 		VFL_TYPE_VIDEO, IVTV_V4L2_ENC_PCM_OFFSET,
-		PCI_DMA_FROMDEVICE, 0,
+		DMA_FROM_DEVICE, 0,
 		V4L2_CAP_TUNER | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
 	},
 	{	/* IVTV_ENC_STREAM_TYPE_RAD */
 		"encoder radio",
 		VFL_TYPE_RADIO, 0,
-		PCI_DMA_NONE, 1,
+		DMA_NONE, 1,
 		V4L2_CAP_RADIO | V4L2_CAP_TUNER,
 		&ivtv_v4l2_radio_fops
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_MPG */
 		"decoder MPG",
 		VFL_TYPE_VIDEO, IVTV_V4L2_DEC_MPG_OFFSET,
-		PCI_DMA_TODEVICE, 0,
+		DMA_TO_DEVICE, 0,
 		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_VBI */
 		"decoder VBI",
 		VFL_TYPE_VBI, IVTV_V4L2_DEC_VBI_OFFSET,
-		PCI_DMA_NONE, 1,
+		DMA_NONE, 1,
 		V4L2_CAP_SLICED_VBI_CAPTURE | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_VOUT */
 		"decoder VOUT",
 		VFL_TYPE_VBI, IVTV_V4L2_DEC_VOUT_OFFSET,
-		PCI_DMA_NONE, 1,
+		DMA_NONE, 1,
 		V4L2_CAP_SLICED_VBI_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_YUV */
 		"decoder YUV",
 		VFL_TYPE_VIDEO, IVTV_V4L2_DEC_YUV_OFFSET,
-		PCI_DMA_TODEVICE, 0,
+		DMA_TO_DEVICE, 0,
 		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
 	}
@@ -179,7 +179,7 @@ static void ivtv_stream_init(struct ivtv
 	s->vdev.device_caps = ivtv_stream_info[type].v4l2_caps;
 
 	if (ivtv_stream_info[type].pio)
-		s->dma = PCI_DMA_NONE;
+		s->dma = DMA_NONE;
 	else
 		s->dma = ivtv_stream_info[type].dma;
 	s->buf_size = itv->stream_buf_size[type];
@@ -217,7 +217,7 @@ static int ivtv_prep_dev(struct ivtv *it
 
 	/* User explicitly selected 0 buffers for these streams, so don't
 	   create them. */
-	if (ivtv_stream_info[type].dma != PCI_DMA_NONE &&
+	if (ivtv_stream_info[type].dma != DMA_NONE &&
 	    itv->options.kilobytes[type] == 0) {
 		IVTV_INFO("Disabled %s device\n", ivtv_stream_info[type].name);
 		return 0;
--- a/drivers/media/pci/ivtv/ivtv-udma.c
+++ b/drivers/media/pci/ivtv/ivtv-udma.c
@@ -81,8 +81,10 @@ void ivtv_udma_alloc(struct ivtv *itv)
 {
 	if (itv->udma.SG_handle == 0) {
 		/* Map DMA Page Array Buffer */
-		itv->udma.SG_handle = pci_map_single(itv->pdev, itv->udma.SGarray,
-			   sizeof(itv->udma.SGarray), PCI_DMA_TODEVICE);
+		itv->udma.SG_handle = dma_map_single(&itv->pdev->dev,
+						     itv->udma.SGarray,
+						     sizeof(itv->udma.SGarray),
+						     DMA_TO_DEVICE);
 		ivtv_udma_sync_for_cpu(itv);
 	}
 }
@@ -135,7 +137,8 @@ int ivtv_udma_setup(struct ivtv *itv, un
 	}
 
 	/* Map SG List */
-	dma->SG_length = pci_map_sg(itv->pdev, dma->SGlist, dma->page_count, PCI_DMA_TODEVICE);
+	dma->SG_length = dma_map_sg(&itv->pdev->dev, dma->SGlist,
+				    dma->page_count, DMA_TO_DEVICE);
 
 	/* Fill SG Array with new values */
 	ivtv_udma_fill_sg_array (dma, ivtv_dest_addr, 0, -1);
@@ -159,7 +162,8 @@ void ivtv_udma_unmap(struct ivtv *itv)
 
 	/* Unmap Scatterlist */
 	if (dma->SG_length) {
-		pci_unmap_sg(itv->pdev, dma->SGlist, dma->page_count, PCI_DMA_TODEVICE);
+		dma_unmap_sg(&itv->pdev->dev, dma->SGlist, dma->page_count,
+			     DMA_TO_DEVICE);
 		dma->SG_length = 0;
 	}
 	/* sync DMA */
@@ -175,13 +179,14 @@ void ivtv_udma_free(struct ivtv *itv)
 
 	/* Unmap SG Array */
 	if (itv->udma.SG_handle) {
-		pci_unmap_single(itv->pdev, itv->udma.SG_handle,
-			 sizeof(itv->udma.SGarray), PCI_DMA_TODEVICE);
+		dma_unmap_single(&itv->pdev->dev, itv->udma.SG_handle,
+				 sizeof(itv->udma.SGarray), DMA_TO_DEVICE);
 	}
 
 	/* Unmap Scatterlist */
 	if (itv->udma.SG_length) {
-		pci_unmap_sg(itv->pdev, itv->udma.SGlist, itv->udma.page_count, PCI_DMA_TODEVICE);
+		dma_unmap_sg(&itv->pdev->dev, itv->udma.SGlist,
+			     itv->udma.page_count, DMA_TO_DEVICE);
 	}
 
 	for (i = 0; i < IVTV_DMA_SG_OSD_ENT; i++) {
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -113,7 +113,8 @@ static int ivtv_yuv_prep_user_dma(struct
 		dma->page_count = 0;
 		return -ENOMEM;
 	}
-	dma->SG_length = pci_map_sg(itv->pdev, dma->SGlist, dma->page_count, PCI_DMA_TODEVICE);
+	dma->SG_length = dma_map_sg(&itv->pdev->dev, dma->SGlist,
+				    dma->page_count, DMA_TO_DEVICE);
 
 	/* Fill SG Array with new values */
 	ivtv_udma_fill_sg_array(dma, y_buffer_offset, uv_buffer_offset, y_size);
@@ -920,7 +921,9 @@ static void ivtv_yuv_init(struct ivtv *i
 	/* We need a buffer for blanking when Y plane is offset - non-fatal if we can't get one */
 	yi->blanking_ptr = kzalloc(720 * 16, GFP_ATOMIC|__GFP_NOWARN);
 	if (yi->blanking_ptr) {
-		yi->blanking_dmaptr = pci_map_single(itv->pdev, yi->blanking_ptr, 720*16, PCI_DMA_TODEVICE);
+		yi->blanking_dmaptr = dma_map_single(&itv->pdev->dev,
+						     yi->blanking_ptr,
+						     720 * 16, DMA_TO_DEVICE);
 	} else {
 		yi->blanking_dmaptr = 0;
 		IVTV_DEBUG_WARN("Failed to allocate yuv blanking buffer\n");
@@ -1264,7 +1267,8 @@ void ivtv_yuv_close(struct ivtv *itv)
 	if (yi->blanking_ptr) {
 		kfree(yi->blanking_ptr);
 		yi->blanking_ptr = NULL;
-		pci_unmap_single(itv->pdev, yi->blanking_dmaptr, 720*16, PCI_DMA_TODEVICE);
+		dma_unmap_single(&itv->pdev->dev, yi->blanking_dmaptr,
+				 720 * 16, DMA_TO_DEVICE);
 	}
 
 	/* Invalidate the old dimension information */



