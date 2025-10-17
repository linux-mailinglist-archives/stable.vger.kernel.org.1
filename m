Return-Path: <stable+bounces-186319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 071FABE8AEC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F88B4F25D7
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13233033C;
	Fri, 17 Oct 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQQf+xu2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4907483
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706009; cv=none; b=PzAkmsyIgwcnUsVdbeNOwYeuk73P3/wfG1kf00oX6GdN0yQ9r+GpjoVP9+5GCsTk2h6gQyzuAxgzOovBB7rmNnK7LzivjFejaQWyLXoxx09Cd6NQWMPqZewrzSXf4PRwQ0XYCa/nZ/0bzs/3tY43pMxQZaVP3OQYZtmWcWsXLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706009; c=relaxed/simple;
	bh=0GAH+GYRagsLPlOkyUXH4NLCMtEdKFDggNuXjRvDufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9w5clFTqhvOEdZnbvD+PY773zW6zYYF4sY1KrxcjegB4sfSxp4PWKC8pJZ6aI9uxTK877z0KbNEamig3kTOaFCilOR8VKDI1zDExXjmiJvIxLr6n9kPKERqxBkLMAMovm6Lb4+9aJCZ0151Iltzf6b0e7eQGj3Y2z7nmgl9E74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQQf+xu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330C6C4CEE7;
	Fri, 17 Oct 2025 13:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760706009;
	bh=0GAH+GYRagsLPlOkyUXH4NLCMtEdKFDggNuXjRvDufo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQQf+xu2/8H8Kp+AenrSoFi16bECbjQz5IM1qG3l6Jw/Jm5gFAa/mCkCOl5GDL1Jj
	 aI7gb8TTctkCtvw1B1WNDa4Eg3fOIS3JPHAL4/sM47n5qAVHdR/4yHCverQuYzSYmC
	 HyXM0Lu020vAkZlKMZZV6u+9X3e8XhAuWmyFoHufcWg6GMxRZ1oZtyggVHjlzXPnu1
	 cuUuCtqc+PBrg0pwia5aNJ1huqTY3KU+FZ6nO7sOTeyjzKWi9HAlKb2sWuPwKbYinq
	 cGqjq8Ejzfig92v0rU4xbzkIIKrl2XptOca7HdUplTWyYn87jKnnza92A9J8Adn+xH
	 TrpoZTNVGHqkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Akihiro Tsukada <tskd08@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] media: switch from 'pci_' to 'dma_' API
Date: Fri, 17 Oct 2025 09:00:05 -0400
Message-ID: <20251017130006.3904918-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101641-clutter-scruffy-a000@gregkh>
References: <2025101641-clutter-scruffy-a000@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 887069f424550ebdcb411166733e1d05002b58e4 ]

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.

It has been compile tested.

@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
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
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Akihiro Tsukada <tskd08@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 23b53639a793 ("media: cx18: Add missing check after DMA map")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cobalt/cobalt-driver.c      |  4 ++--
 drivers/media/pci/cx18/cx18-driver.c          |  2 +-
 drivers/media/pci/cx18/cx18-queue.c           | 13 ++++++------
 drivers/media/pci/cx18/cx18-streams.c         | 16 +++++++--------
 drivers/media/pci/ddbridge/ddbridge-main.c    |  4 ++--
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c |  2 +-
 .../pci/netup_unidvb/netup_unidvb_core.c      |  2 +-
 drivers/media/pci/pluto2/pluto2.c             | 20 +++++++++----------
 drivers/media/pci/pt1/pt1.c                   |  2 +-
 drivers/media/pci/tw5864/tw5864-core.c        |  2 +-
 10 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index f9cee061517bd..6e1a0614e6d06 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -333,8 +333,8 @@ static int cobalt_setup_pci(struct cobalt *cobalt, struct pci_dev *pci_dev,
 		}
 	}
 
-	if (pci_set_dma_mask(pci_dev, DMA_BIT_MASK(64))) {
-		ret = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
+	if (dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64))) {
+		ret = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			cobalt_err("no suitable DMA available\n");
 			goto err_disable;
diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index f2440eb38820b..59497ba6bf1f1 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -804,7 +804,7 @@ static int cx18_setup_pci(struct cx18 *cx, struct pci_dev *pci_dev,
 		CX18_ERR("Can't enable device %d!\n", cx->instance);
 		return -EIO;
 	}
-	if (pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32))) {
 		CX18_ERR("No suitable DMA available, card %d\n", cx->instance);
 		return -EIO;
 	}
diff --git a/drivers/media/pci/cx18/cx18-queue.c b/drivers/media/pci/cx18/cx18-queue.c
index 2f5df471dada6..013694bfcb1c1 100644
--- a/drivers/media/pci/cx18/cx18-queue.c
+++ b/drivers/media/pci/cx18/cx18-queue.c
@@ -325,8 +325,8 @@ void _cx18_mdl_sync_for_device(struct cx18_stream *s, struct cx18_mdl *mdl)
 	struct cx18_buffer *buf;
 
 	list_for_each_entry(buf, &mdl->buf_list, list)
-		pci_dma_sync_single_for_device(pci_dev, buf->dma_handle,
-					       buf_size, dma);
+		dma_sync_single_for_device(&pci_dev->dev, buf->dma_handle,
+					   buf_size, dma);
 }
 
 int cx18_stream_alloc(struct cx18_stream *s)
@@ -385,8 +385,9 @@ int cx18_stream_alloc(struct cx18_stream *s)
 		cx18_enqueue(s, mdl, &s->q_idle);
 
 		INIT_LIST_HEAD(&buf->list);
-		buf->dma_handle = pci_map_single(s->cx->pci_dev,
-				buf->buf, s->buf_size, s->dma);
+		buf->dma_handle = dma_map_single(&s->cx->pci_dev->dev,
+						 buf->buf, s->buf_size,
+						 s->dma);
 		cx18_buf_sync_for_cpu(s, buf);
 		list_add_tail(&buf->list, &s->buf_pool);
 	}
@@ -419,8 +420,8 @@ void cx18_stream_free(struct cx18_stream *s)
 		buf = list_first_entry(&s->buf_pool, struct cx18_buffer, list);
 		list_del_init(&buf->list);
 
-		pci_unmap_single(s->cx->pci_dev, buf->dma_handle,
-				s->buf_size, s->dma);
+		dma_unmap_single(&s->cx->pci_dev->dev, buf->dma_handle,
+				 s->buf_size, s->dma);
 		kfree(buf->buf);
 		kfree(buf);
 	}
diff --git a/drivers/media/pci/cx18/cx18-streams.c b/drivers/media/pci/cx18/cx18-streams.c
index c41bae118415d..8537bcae524f3 100644
--- a/drivers/media/pci/cx18/cx18-streams.c
+++ b/drivers/media/pci/cx18/cx18-streams.c
@@ -49,44 +49,44 @@ static struct {
 	{	/* CX18_ENC_STREAM_TYPE_MPG */
 		"encoder MPEG",
 		VFL_TYPE_VIDEO, 0,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 		V4L2_CAP_AUDIO | V4L2_CAP_TUNER
 	},
 	{	/* CX18_ENC_STREAM_TYPE_TS */
 		"TS",
 		VFL_TYPE_VIDEO, -1,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_YUV */
 		"encoder YUV",
 		VFL_TYPE_VIDEO, CX18_V4L2_ENC_YUV_OFFSET,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 		V4L2_CAP_STREAMING | V4L2_CAP_AUDIO | V4L2_CAP_TUNER
 	},
 	{	/* CX18_ENC_STREAM_TYPE_VBI */
 		"encoder VBI",
 		VFL_TYPE_VBI, 0,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 		V4L2_CAP_VBI_CAPTURE | V4L2_CAP_SLICED_VBI_CAPTURE |
 		V4L2_CAP_READWRITE | V4L2_CAP_TUNER
 	},
 	{	/* CX18_ENC_STREAM_TYPE_PCM */
 		"encoder PCM audio",
 		VFL_TYPE_VIDEO, CX18_V4L2_ENC_PCM_OFFSET,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 		V4L2_CAP_TUNER | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_IDX */
 		"encoder IDX",
 		VFL_TYPE_VIDEO, -1,
-		PCI_DMA_FROMDEVICE,
+		DMA_FROM_DEVICE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_RAD */
 		"encoder radio",
 		VFL_TYPE_RADIO, 0,
-		PCI_DMA_NONE,
+		DMA_NONE,
 		V4L2_CAP_RADIO | V4L2_CAP_TUNER
 	},
 };
@@ -324,7 +324,7 @@ static int cx18_prep_dev(struct cx18 *cx, int type)
 
 	/* User explicitly selected 0 buffers for these streams, so don't
 	   create them. */
-	if (cx18_stream_info[type].dma != PCI_DMA_NONE &&
+	if (cx18_stream_info[type].dma != DMA_NONE &&
 	    cx->stream_buffers[type] == 0) {
 		CX18_INFO("Disabled %s device\n", cx18_stream_info[type].name);
 		return 0;
diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index bb7fb6402d6e5..5d9f861b9edee 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -180,8 +180,8 @@ static int ddb_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)))
-		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)))
+		if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)))
 			return -ENODEV;
 
 	dev = vzalloc(sizeof(*dev));
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index dfb2be0b9625a..5a8778030d193 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -1760,7 +1760,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	pci_set_master(pci_dev);
 
-	r = pci_set_dma_mask(pci_dev, CIO2_DMA_MASK);
+	r = dma_set_mask(&pci_dev->dev, CIO2_DMA_MASK);
 	if (r) {
 		dev_err(dev, "failed to set DMA mask (%d)\n", r);
 		return -ENODEV;
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 7c5061953ee82..d85bfbb77a250 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -846,7 +846,7 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		"%s(): board vendor 0x%x, revision 0x%x\n",
 		__func__, board_vendor, board_revision);
 	pci_set_master(pci_dev);
-	if (pci_set_dma_mask(pci_dev, 0xffffffff) < 0) {
+	if (dma_set_mask(&pci_dev->dev, 0xffffffff) < 0) {
 		dev_err(&pci_dev->dev,
 			"%s(): 32bit PCI DMA is not supported\n", __func__);
 		goto pci_detect_err;
diff --git a/drivers/media/pci/pluto2/pluto2.c b/drivers/media/pci/pluto2/pluto2.c
index f1f4793a4452d..6ac9b9bd7435a 100644
--- a/drivers/media/pci/pluto2/pluto2.c
+++ b/drivers/media/pci/pluto2/pluto2.c
@@ -228,16 +228,16 @@ static void pluto_set_dma_addr(struct pluto *pluto)
 
 static int pluto_dma_map(struct pluto *pluto)
 {
-	pluto->dma_addr = pci_map_single(pluto->pdev, pluto->dma_buf,
-			TS_DMA_BYTES, PCI_DMA_FROMDEVICE);
+	pluto->dma_addr = dma_map_single(&pluto->pdev->dev, pluto->dma_buf,
+					 TS_DMA_BYTES, DMA_FROM_DEVICE);
 
-	return pci_dma_mapping_error(pluto->pdev, pluto->dma_addr);
+	return dma_mapping_error(&pluto->pdev->dev, pluto->dma_addr);
 }
 
 static void pluto_dma_unmap(struct pluto *pluto)
 {
-	pci_unmap_single(pluto->pdev, pluto->dma_addr,
-			TS_DMA_BYTES, PCI_DMA_FROMDEVICE);
+	dma_unmap_single(&pluto->pdev->dev, pluto->dma_addr, TS_DMA_BYTES,
+			 DMA_FROM_DEVICE);
 }
 
 static int pluto_start_feed(struct dvb_demux_feed *f)
@@ -276,8 +276,8 @@ static void pluto_dma_end(struct pluto *pluto, unsigned int nbpackets)
 {
 	/* synchronize the DMA transfer with the CPU
 	 * first so that we see updated contents. */
-	pci_dma_sync_single_for_cpu(pluto->pdev, pluto->dma_addr,
-			TS_DMA_BYTES, PCI_DMA_FROMDEVICE);
+	dma_sync_single_for_cpu(&pluto->pdev->dev, pluto->dma_addr,
+				TS_DMA_BYTES, DMA_FROM_DEVICE);
 
 	/* Workaround for broken hardware:
 	 * [1] On startup NBPACKETS seems to contain an uninitialized value,
@@ -310,8 +310,8 @@ static void pluto_dma_end(struct pluto *pluto, unsigned int nbpackets)
 	pluto_set_dma_addr(pluto);
 
 	/* sync the buffer and give it back to the card */
-	pci_dma_sync_single_for_device(pluto->pdev, pluto->dma_addr,
-			TS_DMA_BYTES, PCI_DMA_FROMDEVICE);
+	dma_sync_single_for_device(&pluto->pdev->dev, pluto->dma_addr,
+				   TS_DMA_BYTES, DMA_FROM_DEVICE);
 }
 
 static irqreturn_t pluto_irq(int irq, void *dev_id)
@@ -595,7 +595,7 @@ static int pluto2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* enable interrupts */
 	pci_write_config_dword(pdev, 0x6c, 0x8000);
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret < 0)
 		goto err_pci_disable_device;
 
diff --git a/drivers/media/pci/pt1/pt1.c b/drivers/media/pci/pt1/pt1.c
index f2aa36814fbac..121a4a92ea105 100644
--- a/drivers/media/pci/pt1/pt1.c
+++ b/drivers/media/pci/pt1/pt1.c
@@ -1340,7 +1340,7 @@ static int pt1_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret < 0)
 		goto err;
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret < 0)
 		goto err_pci_disable_device;
 
diff --git a/drivers/media/pci/tw5864/tw5864-core.c b/drivers/media/pci/tw5864/tw5864-core.c
index 282f7dfb7aaff..23d3cae54a5d6 100644
--- a/drivers/media/pci/tw5864/tw5864-core.c
+++ b/drivers/media/pci/tw5864/tw5864-core.c
@@ -262,7 +262,7 @@ static int tw5864_initdev(struct pci_dev *pci_dev,
 
 	pci_set_master(pci_dev);
 
-	err = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
+	err = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32));
 	if (err) {
 		dev_err(&dev->pci->dev, "32 bit PCI DMA is not supported\n");
 		goto disable_pci;
-- 
2.51.0


