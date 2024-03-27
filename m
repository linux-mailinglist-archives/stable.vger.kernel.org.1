Return-Path: <stable+bounces-33038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0D888F234
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 23:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196601F2EBC6
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB1154C14;
	Wed, 27 Mar 2024 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiTvjL67"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43D154448
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580114; cv=none; b=QVCggKY9LLwOta4E/JtQ5FEK7BaM0vy+m7j4xQoDGO259jOEZOMgZMnkXX7aRIMseUx091zehJLBG2n4H77hGOXJ5Xeq1cxJNPvOoFzdz7gQDfH+RFWhLJ4BVeFf1ZkGDcBz7A9+ECrDHCs2yW4jUpyS1GnXE1hHDl5PyGWY1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580114; c=relaxed/simple;
	bh=74Cdyn8Z4aoXdc30YtxqvDgmlTw8QSNOIUBeLv8t43o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpMqs79IGFNE544QkAb42QylDN54pDb1us+P5gpyPTDnbdCJbyVeg0b4LiQvasj7DlHkjNMTFFPDJ53KJ/4o04s1+atrFmjr+ygYkKsZaI/DijVwjLxIGLeQlqt7N72NTGkdd3K7g/DNee9J/3Ka8y9fRD1q2PYAlNw+dFNGefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aiTvjL67; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711580111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXrqPmbZO2AuejODsIBY3YAK/jfr90cYHCz/ox2iIeE=;
	b=aiTvjL67qCq+B1w6bQYZkyexZWPmCBRa77mM+6odsSDuTb6BbHN4FEV3mKMYlL2OuXZ9fw
	JX/hWHs8aS8Kz5muVJRoyX3R2GLZP/+2TWE5R1hwW8TLTE3JmGZUywjiO4/M5m8hMXal7X
	xSWuLwKlkbKBp/oPPvayDMMB+Kgr2ys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-qnxgAzdxOkCP9h5RJ0MZ6A-1; Wed, 27 Mar 2024 18:55:07 -0400
X-MC-Unique: qnxgAzdxOkCP9h5RJ0MZ6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54E9A8007A2;
	Wed, 27 Mar 2024 22:55:07 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74F0B1121306;
	Wed, 27 Mar 2024 22:55:06 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	eric.auger@redhat.com,
	sashal@kernel.org,
	Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 6.6.y 3/4] vfio/platform: Create persistent IRQ handlers
Date: Wed, 27 Mar 2024 16:54:29 -0600
Message-ID: <20240327225444.909882-4-alex.williamson@redhat.com>
In-Reply-To: <20240327225444.909882-1-alex.williamson@redhat.com>
References: <20240327225444.909882-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

[ Upstream commit 675daf435e9f8e5a5eab140a9864dfad6668b375 ]

The vfio-platform SET_IRQS ioctl currently allows loopback triggering of
an interrupt before a signaling eventfd has been configured by the user,
which thereby allows a NULL pointer dereference.

Rather than register the IRQ relative to a valid trigger, register all
IRQs in a disabled state in the device open path.  This allows mask
operations on the IRQ to nest within the overall enable state governed
by a valid eventfd signal.  This decouples @masked, protected by the
@locked spinlock from @trigger, protected via the @igate mutex.

In doing so, it's guaranteed that changes to @trigger cannot race the
IRQ handlers because the IRQ handler is synchronously disabled before
modifying the trigger, and loopback triggering of the IRQ via ioctl is
safe due to serialization with trigger changes via igate.

For compatibility, request_irq() failures are maintained to be local to
the SET_IRQS ioctl rather than a fatal error in the open device path.
This allows, for example, a userspace driver with polling mode support
to continue to work regardless of moving the request_irq() call site.
This necessarily blocks all SET_IRQS access to the failed index.

Cc: Eric Auger <eric.auger@redhat.com>
Cc:  <stable@vger.kernel.org>
Fixes: 57f972e2b341 ("vfio/platform: trigger an interrupt via eventfd")
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20240308230557.805580-7-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/platform/vfio_platform_irq.c | 100 +++++++++++++++-------
 1 file changed, 68 insertions(+), 32 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index d36c4cd0fbda..31636d1414a0 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -136,6 +136,16 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 	return 0;
 }
 
+/*
+ * The trigger eventfd is guaranteed valid in the interrupt path
+ * and protected by the igate mutex when triggered via ioctl.
+ */
+static void vfio_send_eventfd(struct vfio_platform_irq *irq_ctx)
+{
+	if (likely(irq_ctx->trigger))
+		eventfd_signal(irq_ctx->trigger, 1);
+}
+
 static irqreturn_t vfio_automasked_irq_handler(int irq, void *dev_id)
 {
 	struct vfio_platform_irq *irq_ctx = dev_id;
@@ -155,7 +165,7 @@ static irqreturn_t vfio_automasked_irq_handler(int irq, void *dev_id)
 	spin_unlock_irqrestore(&irq_ctx->lock, flags);
 
 	if (ret == IRQ_HANDLED)
-		eventfd_signal(irq_ctx->trigger, 1);
+		vfio_send_eventfd(irq_ctx);
 
 	return ret;
 }
@@ -164,52 +174,40 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
 {
 	struct vfio_platform_irq *irq_ctx = dev_id;
 
-	eventfd_signal(irq_ctx->trigger, 1);
+	vfio_send_eventfd(irq_ctx);
 
 	return IRQ_HANDLED;
 }
 
 static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
-			    int fd, irq_handler_t handler)
+			    int fd)
 {
 	struct vfio_platform_irq *irq = &vdev->irqs[index];
 	struct eventfd_ctx *trigger;
-	int ret;
 
 	if (irq->trigger) {
-		irq_clear_status_flags(irq->hwirq, IRQ_NOAUTOEN);
-		free_irq(irq->hwirq, irq);
-		kfree(irq->name);
+		disable_irq(irq->hwirq);
 		eventfd_ctx_put(irq->trigger);
 		irq->trigger = NULL;
 	}
 
 	if (fd < 0) /* Disable only */
 		return 0;
-	irq->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-irq[%d](%s)",
-			      irq->hwirq, vdev->name);
-	if (!irq->name)
-		return -ENOMEM;
 
 	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(irq->name);
+	if (IS_ERR(trigger))
 		return PTR_ERR(trigger);
-	}
 
 	irq->trigger = trigger;
 
-	irq_set_status_flags(irq->hwirq, IRQ_NOAUTOEN);
-	ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
-	if (ret) {
-		kfree(irq->name);
-		eventfd_ctx_put(trigger);
-		irq->trigger = NULL;
-		return ret;
-	}
-
-	if (!irq->masked)
-		enable_irq(irq->hwirq);
+	/*
+	 * irq->masked effectively provides nested disables within the overall
+	 * enable relative to trigger.  Specifically request_irq() is called
+	 * with NO_AUTOEN, therefore the IRQ is initially disabled.  The user
+	 * may only further disable the IRQ with a MASK operations because
+	 * irq->masked is initially false.
+	 */
+	enable_irq(irq->hwirq);
 
 	return 0;
 }
@@ -228,7 +226,7 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 		handler = vfio_irq_handler;
 
 	if (!count && (flags & VFIO_IRQ_SET_DATA_NONE))
-		return vfio_set_trigger(vdev, index, -1, handler);
+		return vfio_set_trigger(vdev, index, -1);
 
 	if (start != 0 || count != 1)
 		return -EINVAL;
@@ -236,7 +234,7 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		int32_t fd = *(int32_t *)data;
 
-		return vfio_set_trigger(vdev, index, fd, handler);
+		return vfio_set_trigger(vdev, index, fd);
 	}
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
@@ -260,6 +258,14 @@ int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 		    unsigned start, unsigned count, uint32_t flags,
 		    void *data) = NULL;
 
+	/*
+	 * For compatibility, errors from request_irq() are local to the
+	 * SET_IRQS path and reflected in the name pointer.  This allows,
+	 * for example, polling mode fallback for an exclusive IRQ failure.
+	 */
+	if (IS_ERR(vdev->irqs[index].name))
+		return PTR_ERR(vdev->irqs[index].name);
+
 	switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 	case VFIO_IRQ_SET_ACTION_MASK:
 		func = vfio_platform_set_irq_mask;
@@ -280,7 +286,7 @@ int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 
 int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 {
-	int cnt = 0, i;
+	int cnt = 0, i, ret = 0;
 
 	while (vdev->get_irq(vdev, cnt) >= 0)
 		cnt++;
@@ -292,29 +298,54 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 
 	for (i = 0; i < cnt; i++) {
 		int hwirq = vdev->get_irq(vdev, i);
+		irq_handler_t handler = vfio_irq_handler;
 
-		if (hwirq < 0)
+		if (hwirq < 0) {
+			ret = -EINVAL;
 			goto err;
+		}
 
 		spin_lock_init(&vdev->irqs[i].lock);
 
 		vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD;
 
-		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
+		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK) {
 			vdev->irqs[i].flags |= VFIO_IRQ_INFO_MASKABLE
 						| VFIO_IRQ_INFO_AUTOMASKED;
+			handler = vfio_automasked_irq_handler;
+		}
 
 		vdev->irqs[i].count = 1;
 		vdev->irqs[i].hwirq = hwirq;
 		vdev->irqs[i].masked = false;
+		vdev->irqs[i].name = kasprintf(GFP_KERNEL_ACCOUNT,
+					       "vfio-irq[%d](%s)", hwirq,
+					       vdev->name);
+		if (!vdev->irqs[i].name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = request_irq(hwirq, handler, IRQF_NO_AUTOEN,
+				  vdev->irqs[i].name, &vdev->irqs[i]);
+		if (ret) {
+			kfree(vdev->irqs[i].name);
+			vdev->irqs[i].name = ERR_PTR(ret);
+		}
 	}
 
 	vdev->num_irqs = cnt;
 
 	return 0;
 err:
+	for (--i; i >= 0; i--) {
+		if (!IS_ERR(vdev->irqs[i].name)) {
+			free_irq(vdev->irqs[i].hwirq, &vdev->irqs[i]);
+			kfree(vdev->irqs[i].name);
+		}
+	}
 	kfree(vdev->irqs);
-	return -EINVAL;
+	return ret;
 }
 
 void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
@@ -324,7 +355,12 @@ void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
 	for (i = 0; i < vdev->num_irqs; i++) {
 		vfio_virqfd_disable(&vdev->irqs[i].mask);
 		vfio_virqfd_disable(&vdev->irqs[i].unmask);
-		vfio_set_trigger(vdev, i, -1, NULL);
+		if (!IS_ERR(vdev->irqs[i].name)) {
+			free_irq(vdev->irqs[i].hwirq, &vdev->irqs[i]);
+			if (vdev->irqs[i].trigger)
+				eventfd_ctx_put(vdev->irqs[i].trigger);
+			kfree(vdev->irqs[i].name);
+		}
 	}
 
 	vdev->num_irqs = 0;
-- 
2.44.0


