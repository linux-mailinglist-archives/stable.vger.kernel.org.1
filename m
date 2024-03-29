Return-Path: <stable+bounces-33766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D66892631
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 22:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6826B2190E
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6F13BC04;
	Fri, 29 Mar 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJrOvC0O"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AB29D06
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748346; cv=none; b=eNhqc6FS8Brl+WcgaI3sjzeZ8FYiV7iYM76tiqObtR+IUerUG0hfswNxyf0jcc3ujTg6p/1mIx5CBozKPdKakwGggoOTmKoDQMMLmBNN0/4UyRiO+iFKJGAQT6yalj0tBkFP9Yoe/gvf0mGB62U6I0RjS3eQk2UMVKe3CXf7Q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748346; c=relaxed/simple;
	bh=H2YUIscsga2f4Jg3x/2j4Bh3m6kurmuc6SOI72nPI4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPx2gXvTRkL3j2grVVSL4lQbuin+ctLx380xXsGUlfd8h7X3jxRfm3oAnihUdEWptN2MV+xSFbdtX2z/4KY/+GH4JR4f0qkgJivoYru1AQQJ3OikCq0MelEc1Hi3RcBJnAb2gpIrq1bD81m+1wQ+53ck+in1mfyfVbfpNyMZ5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJrOvC0O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711748342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+yUes4znFL6Fq26R8wR+Ryr/JSsJr2sgt3b9+V4n0E=;
	b=GJrOvC0OCoe6UwgwSeWYSUUoLxRxON3n8pIEUGVPmJzDwU71xBrQTuncADeuWse9M4/VKa
	FHsCQ7ajmtJaJUiuVxrZcvmO54J0jDVoxlp3S0GHACibiw7MmVOAhQip7xWJMQlDA0qzuu
	7AK+WDfhWh9gGcpNEhksv6JKwj5zc1U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-B8nGsDesPJW7zg0JS4S1Yg-1; Fri,
 29 Mar 2024 17:39:01 -0400
X-MC-Unique: B8nGsDesPJW7zg0JS4S1Yg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D20FF3C02474;
	Fri, 29 Mar 2024 21:39:00 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7D78492BD0;
	Fri, 29 Mar 2024 21:38:59 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com
Subject: [PATCH 6.1.y 2/7] Revert "vfio/pci: Prepare for dynamic interrupt context storage"
Date: Fri, 29 Mar 2024 15:38:49 -0600
Message-ID: <20240329213856.2550762-3-alex.williamson@redhat.com>
In-Reply-To: <20240329213856.2550762-1-alex.williamson@redhat.com>
References: <20240329213856.2550762-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This reverts commit b8e81e269b3d97fe53cd9819aa4a29e1aaf26731.

This commit does not stand alone, vfio_intx_enable() adds a call
to vfio_irq_ctx_alloc_num() followed by vfio_irq_ctx_get(), and
finally setting vdev->num_ctx in the existing code.
vfio_irq_ctx_get() relies on a valid num_ctx value, therefore this
function will always return -EINVAL.  This was fixed without being
noticed later in the usptream series.

A better solution is to start over and adjust commit fe9a7082684e
("vfio/pci: Disable auto-enable of exclusive INTx IRQ") to remove
this dependency.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 215 +++++++++---------------------
 1 file changed, 66 insertions(+), 149 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index ef63ee441c36..8c8b04d85845 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -48,31 +48,6 @@ static bool is_irq_none(struct vfio_pci_core_device *vdev)
 		 vdev->irq_type == VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
-static
-struct vfio_pci_irq_ctx *vfio_irq_ctx_get(struct vfio_pci_core_device *vdev,
-					  unsigned long index)
-{
-	if (index >= vdev->num_ctx)
-		return NULL;
-	return &vdev->ctx[index];
-}
-
-static void vfio_irq_ctx_free_all(struct vfio_pci_core_device *vdev)
-{
-	kfree(vdev->ctx);
-}
-
-static int vfio_irq_ctx_alloc_num(struct vfio_pci_core_device *vdev,
-				  unsigned long num)
-{
-	vdev->ctx = kcalloc(num, sizeof(struct vfio_pci_irq_ctx),
-			    GFP_KERNEL_ACCOUNT);
-	if (!vdev->ctx)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * INTx
  */
@@ -80,21 +55,14 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
 {
 	struct vfio_pci_core_device *vdev = opaque;
 
-	if (likely(is_intx(vdev) && !vdev->virq_disabled)) {
-		struct vfio_pci_irq_ctx *ctx;
-
-		ctx = vfio_irq_ctx_get(vdev, 0);
-		if (WARN_ON_ONCE(!ctx))
-			return;
-		eventfd_signal(ctx->trigger, 1);
-	}
+	if (likely(is_intx(vdev) && !vdev->virq_disabled))
+		eventfd_signal(vdev->ctx[0].trigger, 1);
 }
 
 /* Returns true if the INTx vfio_pci_irq_ctx.masked value is changed. */
 static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	struct vfio_pci_irq_ctx *ctx;
 	unsigned long flags;
 	bool masked_changed = false;
 
@@ -111,14 +79,7 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 	if (unlikely(!is_intx(vdev))) {
 		if (vdev->pci_2_3)
 			pci_intx(pdev, 0);
-		goto out_unlock;
-	}
-
-	ctx = vfio_irq_ctx_get(vdev, 0);
-	if (WARN_ON_ONCE(!ctx))
-		goto out_unlock;
-
-	if (!ctx->masked) {
+	} else if (!vdev->ctx[0].masked) {
 		/*
 		 * Can't use check_and_mask here because we always want to
 		 * mask, not just when something is pending.
@@ -128,11 +89,10 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 		else
 			disable_irq_nosync(pdev->irq);
 
-		ctx->masked = true;
+		vdev->ctx[0].masked = true;
 		masked_changed = true;
 	}
 
-out_unlock:
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
 	return masked_changed;
 }
@@ -158,7 +118,6 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *unused)
 {
 	struct vfio_pci_core_device *vdev = opaque;
 	struct pci_dev *pdev = vdev->pdev;
-	struct vfio_pci_irq_ctx *ctx;
 	unsigned long flags;
 	int ret = 0;
 
@@ -171,14 +130,7 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *unused)
 	if (unlikely(!is_intx(vdev))) {
 		if (vdev->pci_2_3)
 			pci_intx(pdev, 1);
-		goto out_unlock;
-	}
-
-	ctx = vfio_irq_ctx_get(vdev, 0);
-	if (WARN_ON_ONCE(!ctx))
-		goto out_unlock;
-
-	if (ctx->masked && !vdev->virq_disabled) {
+	} else if (vdev->ctx[0].masked && !vdev->virq_disabled) {
 		/*
 		 * A pending interrupt here would immediately trigger,
 		 * but we can avoid that overhead by just re-sending
@@ -190,10 +142,9 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *unused)
 		} else
 			enable_irq(pdev->irq);
 
-		ctx->masked = (ret > 0);
+		vdev->ctx[0].masked = (ret > 0);
 	}
 
-out_unlock:
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
 
 	return ret;
@@ -217,23 +168,18 @@ void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 {
 	struct vfio_pci_core_device *vdev = dev_id;
-	struct vfio_pci_irq_ctx *ctx;
 	unsigned long flags;
 	int ret = IRQ_NONE;
 
-	ctx = vfio_irq_ctx_get(vdev, 0);
-	if (WARN_ON_ONCE(!ctx))
-		return ret;
-
 	spin_lock_irqsave(&vdev->irqlock, flags);
 
 	if (!vdev->pci_2_3) {
 		disable_irq_nosync(vdev->pdev->irq);
-		ctx->masked = true;
+		vdev->ctx[0].masked = true;
 		ret = IRQ_HANDLED;
-	} else if (!ctx->masked &&  /* may be shared */
+	} else if (!vdev->ctx[0].masked &&  /* may be shared */
 		   pci_check_and_mask_intx(vdev->pdev)) {
-		ctx->masked = true;
+		vdev->ctx[0].masked = true;
 		ret = IRQ_HANDLED;
 	}
 
@@ -247,24 +193,15 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 
 static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_pci_irq_ctx *ctx;
-	int ret;
-
 	if (!is_irq_none(vdev))
 		return -EINVAL;
 
 	if (!vdev->pdev->irq)
 		return -ENODEV;
 
-	ret = vfio_irq_ctx_alloc_num(vdev, 1);
-	if (ret)
-		return ret;
-
-	ctx = vfio_irq_ctx_get(vdev, 0);
-	if (!ctx) {
-		vfio_irq_ctx_free_all(vdev);
-		return -EINVAL;
-	}
+	vdev->ctx = kzalloc(sizeof(struct vfio_pci_irq_ctx), GFP_KERNEL_ACCOUNT);
+	if (!vdev->ctx)
+		return -ENOMEM;
 
 	vdev->num_ctx = 1;
 
@@ -274,9 +211,9 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
 	 * here, non-PCI-2.3 devices will have to wait until the
 	 * interrupt is enabled.
 	 */
-	ctx->masked = vdev->virq_disabled;
+	vdev->ctx[0].masked = vdev->virq_disabled;
 	if (vdev->pci_2_3)
-		pci_intx(vdev->pdev, !ctx->masked);
+		pci_intx(vdev->pdev, !vdev->ctx[0].masked);
 
 	vdev->irq_type = VFIO_PCI_INTX_IRQ_INDEX;
 
@@ -287,46 +224,41 @@ static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev, int fd)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	unsigned long irqflags = IRQF_SHARED;
-	struct vfio_pci_irq_ctx *ctx;
 	struct eventfd_ctx *trigger;
 	unsigned long flags;
 	int ret;
 
-	ctx = vfio_irq_ctx_get(vdev, 0);
-	if (WARN_ON_ONCE(!ctx))
-		return -EINVAL;
-
-	if (ctx->trigger) {
+	if (vdev->ctx[0].trigger) {
 		free_irq(pdev->irq, vdev);
-		kfree(ctx->name);
-		eventfd_ctx_put(ctx->trigger);
-		ctx->trigger = NULL;
+		kfree(vdev->ctx[0].name);
+		eventfd_ctx_put(vdev->ctx[0].trigger);
+		vdev->ctx[0].trigger = NULL;
 	}
 
 	if (fd < 0) /* Disable only */
 		return 0;
 
-	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)",
-			      pci_name(pdev));
-	if (!ctx->name)
+	vdev->ctx[0].name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)",
+				      pci_name(pdev));
+	if (!vdev->ctx[0].name)
 		return -ENOMEM;
 
 	trigger = eventfd_ctx_fdget(fd);
 	if (IS_ERR(trigger)) {
-		kfree(ctx->name);
+		kfree(vdev->ctx[0].name);
 		return PTR_ERR(trigger);
 	}
 
-	ctx->trigger = trigger;
+	vdev->ctx[0].trigger = trigger;
 
 	if (!vdev->pci_2_3)
 		irqflags = 0;
 
 	ret = request_irq(pdev->irq, vfio_intx_handler,
-			  irqflags, ctx->name, vdev);
+			  irqflags, vdev->ctx[0].name, vdev);
 	if (ret) {
-		ctx->trigger = NULL;
-		kfree(ctx->name);
+		vdev->ctx[0].trigger = NULL;
+		kfree(vdev->ctx[0].name);
 		eventfd_ctx_put(trigger);
 		return ret;
 	}
@@ -336,7 +268,7 @@ static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev, int fd)
 	 * disable_irq won't.
 	 */
 	spin_lock_irqsave(&vdev->irqlock, flags);
-	if (!vdev->pci_2_3 && ctx->masked)
+	if (!vdev->pci_2_3 && vdev->ctx[0].masked)
 		disable_irq_nosync(pdev->irq);
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
 
@@ -345,18 +277,12 @@ static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev, int fd)
 
 static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_pci_irq_ctx *ctx;
-
-	ctx = vfio_irq_ctx_get(vdev, 0);
-	WARN_ON_ONCE(!ctx);
-	if (ctx) {
-		vfio_virqfd_disable(&ctx->unmask);
-		vfio_virqfd_disable(&ctx->mask);
-	}
+	vfio_virqfd_disable(&vdev->ctx[0].unmask);
+	vfio_virqfd_disable(&vdev->ctx[0].mask);
 	vfio_intx_set_signal(vdev, -1);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	vdev->num_ctx = 0;
-	vfio_irq_ctx_free_all(vdev);
+	kfree(vdev->ctx);
 }
 
 /*
@@ -380,9 +306,10 @@ static int vfio_msi_enable(struct vfio_pci_core_device *vdev, int nvec, bool msi
 	if (!is_irq_none(vdev))
 		return -EINVAL;
 
-	ret = vfio_irq_ctx_alloc_num(vdev, nvec);
-	if (ret)
-		return ret;
+	vdev->ctx = kcalloc(nvec, sizeof(struct vfio_pci_irq_ctx),
+			    GFP_KERNEL_ACCOUNT);
+	if (!vdev->ctx)
+		return -ENOMEM;
 
 	/* return the number of supported vectors if we can't get all: */
 	cmd = vfio_pci_memory_lock_and_enable(vdev);
@@ -391,7 +318,7 @@ static int vfio_msi_enable(struct vfio_pci_core_device *vdev, int nvec, bool msi
 		if (ret > 0)
 			pci_free_irq_vectors(pdev);
 		vfio_pci_memory_unlock_and_restore(vdev, cmd);
-		vfio_irq_ctx_free_all(vdev);
+		kfree(vdev->ctx);
 		return ret;
 	}
 	vfio_pci_memory_unlock_and_restore(vdev, cmd);
@@ -415,7 +342,6 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
 				      unsigned int vector, int fd, bool msix)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	struct vfio_pci_irq_ctx *ctx;
 	struct eventfd_ctx *trigger;
 	int irq, ret;
 	u16 cmd;
@@ -423,33 +349,33 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
 	if (vector >= vdev->num_ctx)
 		return -EINVAL;
 
-	ctx = vfio_irq_ctx_get(vdev, vector);
-	if (!ctx)
-		return -EINVAL;
 	irq = pci_irq_vector(pdev, vector);
 
-	if (ctx->trigger) {
-		irq_bypass_unregister_producer(&ctx->producer);
+	if (vdev->ctx[vector].trigger) {
+		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
 
 		cmd = vfio_pci_memory_lock_and_enable(vdev);
-		free_irq(irq, ctx->trigger);
+		free_irq(irq, vdev->ctx[vector].trigger);
 		vfio_pci_memory_unlock_and_restore(vdev, cmd);
-		kfree(ctx->name);
-		eventfd_ctx_put(ctx->trigger);
-		ctx->trigger = NULL;
+
+		kfree(vdev->ctx[vector].name);
+		eventfd_ctx_put(vdev->ctx[vector].trigger);
+		vdev->ctx[vector].trigger = NULL;
 	}
 
 	if (fd < 0)
 		return 0;
 
-	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-msi%s[%d](%s)",
-			      msix ? "x" : "", vector, pci_name(pdev));
-	if (!ctx->name)
+	vdev->ctx[vector].name = kasprintf(GFP_KERNEL_ACCOUNT,
+					   "vfio-msi%s[%d](%s)",
+					   msix ? "x" : "", vector,
+					   pci_name(pdev));
+	if (!vdev->ctx[vector].name)
 		return -ENOMEM;
 
 	trigger = eventfd_ctx_fdget(fd);
 	if (IS_ERR(trigger)) {
-		kfree(ctx->name);
+		kfree(vdev->ctx[vector].name);
 		return PTR_ERR(trigger);
 	}
 
@@ -468,25 +394,26 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
 		pci_write_msi_msg(irq, &msg);
 	}
 
-	ret = request_irq(irq, vfio_msihandler, 0, ctx->name, trigger);
+	ret = request_irq(irq, vfio_msihandler, 0,
+			  vdev->ctx[vector].name, trigger);
 	vfio_pci_memory_unlock_and_restore(vdev, cmd);
 	if (ret) {
-		kfree(ctx->name);
+		kfree(vdev->ctx[vector].name);
 		eventfd_ctx_put(trigger);
 		return ret;
 	}
 
-	ctx->producer.token = trigger;
-	ctx->producer.irq = irq;
-	ret = irq_bypass_register_producer(&ctx->producer);
+	vdev->ctx[vector].producer.token = trigger;
+	vdev->ctx[vector].producer.irq = irq;
+	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
 	if (unlikely(ret)) {
 		dev_info(&pdev->dev,
 		"irq bypass producer (token %p) registration fails: %d\n",
-		ctx->producer.token, ret);
+		vdev->ctx[vector].producer.token, ret);
 
-		ctx->producer.token = NULL;
+		vdev->ctx[vector].producer.token = NULL;
 	}
-	ctx->trigger = trigger;
+	vdev->ctx[vector].trigger = trigger;
 
 	return 0;
 }
@@ -516,17 +443,13 @@ static int vfio_msi_set_block(struct vfio_pci_core_device *vdev, unsigned start,
 static void vfio_msi_disable(struct vfio_pci_core_device *vdev, bool msix)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	struct vfio_pci_irq_ctx *ctx;
 	unsigned int i;
 	u16 cmd;
 
 	for (i = 0; i < vdev->num_ctx; i++) {
-		ctx = vfio_irq_ctx_get(vdev, i);
-		if (ctx) {
-			vfio_virqfd_disable(&ctx->unmask);
-			vfio_virqfd_disable(&ctx->mask);
-			vfio_msi_set_vector_signal(vdev, i, -1, msix);
-		}
+		vfio_virqfd_disable(&vdev->ctx[i].unmask);
+		vfio_virqfd_disable(&vdev->ctx[i].mask);
+		vfio_msi_set_vector_signal(vdev, i, -1, msix);
 	}
 
 	cmd = vfio_pci_memory_lock_and_enable(vdev);
@@ -542,7 +465,7 @@ static void vfio_msi_disable(struct vfio_pci_core_device *vdev, bool msix)
 
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	vdev->num_ctx = 0;
-	vfio_irq_ctx_free_all(vdev);
+	kfree(vdev->ctx);
 }
 
 /*
@@ -562,18 +485,14 @@ static int vfio_pci_set_intx_unmask(struct vfio_pci_core_device *vdev,
 		if (unmask)
 			__vfio_pci_intx_unmask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
-		struct vfio_pci_irq_ctx *ctx = vfio_irq_ctx_get(vdev, 0);
 		int32_t fd = *(int32_t *)data;
-
-		if (WARN_ON_ONCE(!ctx))
-			return -EINVAL;
 		if (fd >= 0)
 			return vfio_virqfd_enable((void *) vdev,
 						  vfio_pci_intx_unmask_handler,
 						  vfio_send_intx_eventfd, NULL,
-						  &ctx->unmask, fd);
+						  &vdev->ctx[0].unmask, fd);
 
-		vfio_virqfd_disable(&ctx->unmask);
+		vfio_virqfd_disable(&vdev->ctx[0].unmask);
 	}
 
 	return 0;
@@ -646,7 +565,6 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
 				    unsigned index, unsigned start,
 				    unsigned count, uint32_t flags, void *data)
 {
-	struct vfio_pci_irq_ctx *ctx;
 	unsigned int i;
 	bool msix = (index == VFIO_PCI_MSIX_IRQ_INDEX) ? true : false;
 
@@ -681,15 +599,14 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
 		return -EINVAL;
 
 	for (i = start; i < start + count; i++) {
-		ctx = vfio_irq_ctx_get(vdev, i);
-		if (!ctx || !ctx->trigger)
+		if (!vdev->ctx[i].trigger)
 			continue;
 		if (flags & VFIO_IRQ_SET_DATA_NONE) {
-			eventfd_signal(ctx->trigger, 1);
+			eventfd_signal(vdev->ctx[i].trigger, 1);
 		} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 			uint8_t *bools = data;
 			if (bools[i - start])
-				eventfd_signal(ctx->trigger, 1);
+				eventfd_signal(vdev->ctx[i].trigger, 1);
 		}
 	}
 	return 0;
-- 
2.44.0


