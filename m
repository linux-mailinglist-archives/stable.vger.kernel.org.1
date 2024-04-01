Return-Path: <stable+bounces-35126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF489428B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C83CB20B52
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF54D59E;
	Mon,  1 Apr 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0GYdX90"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807704AED1
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990400; cv=none; b=Ug9VOrIcAIX19WLm+kZmWmNajw6tpcQyMGgJq2eLU48GaoZlBPZW8vmHbl5vLmRmNGmptn7c77u4ca9ggbToZnkwrmnc7H10pREE105KJbz3bgijBliu/u4lDZ0X5pdHy1sCOpHtiH3ryvpFBY/RBlDu3iCENno9dnitF6Qp8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990400; c=relaxed/simple;
	bh=5Vq1kHHCqqijrm/oWR1rKiaYtItP65FxKO3AvuMjpeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpBY3YYg6ysbAVTFE9iVL50rT/DmT6JowmXac/IeBoWYVSJ+95o6z2mChVM70mPGUBe9jd5Lf0u8kYrlm/nqHJxETog33ztGEDZufmTWIYD+9F/D0tkSx9vJuLkyKGZElnAvOF18e8poB9GEaDC9UnrRVewbKqIU9Rd4HDkpQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0GYdX90; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711990397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVE5b09Kwdzqio4VP47qX8sCj5tDCOLdyIB3bpOc2Kg=;
	b=R0GYdX90rIE9g3jH+b2xOKYxnI4dJ4jbx5tDW13zybfFARVHWMw8K3/MEVzqkbX9EPTPNK
	TEnK4L55xDdQJY1/EMnaVpiropC1/A+VgUUASOzco1ScGgCkCh0iTkg05gNo8he/6oU3fv
	ETOFhzLvhZE610ea5UksY1ycoVbC9mU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0spVEDZeMa25A03CcsyKjg-1; Mon, 01 Apr 2024 12:53:14 -0400
X-MC-Unique: 0spVEDZeMa25A03CcsyKjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D575E81BB3D;
	Mon,  1 Apr 2024 16:53:13 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEC833C21;
	Mon,  1 Apr 2024 16:53:12 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com,
	Reinette Chatre <reinette.chatre@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 5.10.y 5.4.y 4/6] vfio/pci: Create persistent INTx handler
Date: Mon,  1 Apr 2024 10:52:58 -0600
Message-ID: <20240401165302.3699643-5-alex.williamson@redhat.com>
In-Reply-To: <20240401165302.3699643-1-alex.williamson@redhat.com>
References: <20240401165302.3699643-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

[ Upstream commit 18c198c96a815c962adc2b9b77909eec0be7df4d ]

A vulnerability exists where the eventfd for INTx signaling can be
deconfigured, which unregisters the IRQ handler but still allows
eventfds to be signaled with a NULL context through the SET_IRQS ioctl
or through unmask irqfd if the device interrupt is pending.

Ideally this could be solved with some additional locking; the igate
mutex serializes the ioctl and config space accesses, and the interrupt
handler is unregistered relative to the trigger, but the irqfd path
runs asynchronous to those.  The igate mutex cannot be acquired from the
atomic context of the eventfd wake function.  Disabling the irqfd
relative to the eventfd registration is potentially incompatible with
existing userspace.

As a result, the solution implemented here moves configuration of the
INTx interrupt handler to track the lifetime of the INTx context object
and irq_type configuration, rather than registration of a particular
trigger eventfd.  Synchronization is added between the ioctl path and
eventfd_signal() wrapper such that the eventfd trigger can be
dynamically updated relative to in-flight interrupts or irqfd callbacks.

Cc:  <stable@vger.kernel.org>
Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20240308230557.805580-5-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 149 ++++++++++++++++--------------
 1 file changed, 82 insertions(+), 67 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index c8afb062df26..5b0b7fab3ba1 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -29,8 +29,13 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
 {
 	struct vfio_pci_device *vdev = opaque;
 
-	if (likely(is_intx(vdev) && !vdev->virq_disabled))
-		eventfd_signal(vdev->ctx[0].trigger, 1);
+	if (likely(is_intx(vdev) && !vdev->virq_disabled)) {
+		struct eventfd_ctx *trigger;
+
+		trigger = READ_ONCE(vdev->ctx[0].trigger);
+		if (likely(trigger))
+			eventfd_signal(trigger, 1);
+	}
 }
 
 static void __vfio_pci_intx_mask(struct vfio_pci_device *vdev)
@@ -157,98 +162,104 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static int vfio_intx_enable(struct vfio_pci_device *vdev)
+static int vfio_intx_enable(struct vfio_pci_device *vdev,
+			    struct eventfd_ctx *trigger)
 {
+	struct pci_dev *pdev = vdev->pdev;
+	unsigned long irqflags;
+	char *name;
+	int ret;
+
 	if (!is_irq_none(vdev))
 		return -EINVAL;
 
-	if (!vdev->pdev->irq)
+	if (!pdev->irq)
 		return -ENODEV;
 
+	name = kasprintf(GFP_KERNEL, "vfio-intx(%s)", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	vdev->ctx = kzalloc(sizeof(struct vfio_pci_irq_ctx), GFP_KERNEL);
 	if (!vdev->ctx)
 		return -ENOMEM;
 
 	vdev->num_ctx = 1;
 
+	vdev->ctx[0].name = name;
+	vdev->ctx[0].trigger = trigger;
+
 	/*
-	 * If the virtual interrupt is masked, restore it.  Devices
-	 * supporting DisINTx can be masked at the hardware level
-	 * here, non-PCI-2.3 devices will have to wait until the
-	 * interrupt is enabled.
+	 * Fill the initial masked state based on virq_disabled.  After
+	 * enable, changing the DisINTx bit in vconfig directly changes INTx
+	 * masking.  igate prevents races during setup, once running masked
+	 * is protected via irqlock.
+	 *
+	 * Devices supporting DisINTx also reflect the current mask state in
+	 * the physical DisINTx bit, which is not affected during IRQ setup.
+	 *
+	 * Devices without DisINTx support require an exclusive interrupt.
+	 * IRQ masking is performed at the IRQ chip.  Again, igate protects
+	 * against races during setup and IRQ handlers and irqfds are not
+	 * yet active, therefore masked is stable and can be used to
+	 * conditionally auto-enable the IRQ.
+	 *
+	 * irq_type must be stable while the IRQ handler is registered,
+	 * therefore it must be set before request_irq().
 	 */
 	vdev->ctx[0].masked = vdev->virq_disabled;
-	if (vdev->pci_2_3)
-		pci_intx(vdev->pdev, !vdev->ctx[0].masked);
+	if (vdev->pci_2_3) {
+		pci_intx(pdev, !vdev->ctx[0].masked);
+		irqflags = IRQF_SHARED;
+	} else {
+		irqflags = vdev->ctx[0].masked ? IRQF_NO_AUTOEN : 0;
+	}
 
 	vdev->irq_type = VFIO_PCI_INTX_IRQ_INDEX;
 
+	ret = request_irq(pdev->irq, vfio_intx_handler,
+			  irqflags, vdev->ctx[0].name, vdev);
+	if (ret) {
+		vdev->irq_type = VFIO_PCI_NUM_IRQS;
+		kfree(name);
+		vdev->num_ctx = 0;
+		kfree(vdev->ctx);
+		return ret;
+	}
+
 	return 0;
 }
 
-static int vfio_intx_set_signal(struct vfio_pci_device *vdev, int fd)
+static int vfio_intx_set_signal(struct vfio_pci_device *vdev,
+				struct eventfd_ctx *trigger)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	unsigned long irqflags = IRQF_SHARED;
-	struct eventfd_ctx *trigger;
-	unsigned long flags;
-	int ret;
+	struct eventfd_ctx *old;
 
-	if (vdev->ctx[0].trigger) {
-		free_irq(pdev->irq, vdev);
-		kfree(vdev->ctx[0].name);
-		eventfd_ctx_put(vdev->ctx[0].trigger);
-		vdev->ctx[0].trigger = NULL;
-	}
-
-	if (fd < 0) /* Disable only */
-		return 0;
+	old = vdev->ctx[0].trigger;
 
-	vdev->ctx[0].name = kasprintf(GFP_KERNEL, "vfio-intx(%s)",
-				      pci_name(pdev));
-	if (!vdev->ctx[0].name)
-		return -ENOMEM;
+	WRITE_ONCE(vdev->ctx[0].trigger, trigger);
 
-	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(vdev->ctx[0].name);
-		return PTR_ERR(trigger);
-	}
-
-	vdev->ctx[0].trigger = trigger;
-
-	/*
-	 * Devices without DisINTx support require an exclusive interrupt,
-	 * IRQ masking is performed at the IRQ chip.  The masked status is
-	 * protected by vdev->irqlock. Setup the IRQ without auto-enable and
-	 * unmask as necessary below under lock.  DisINTx is unmodified by
-	 * the IRQ configuration and may therefore use auto-enable.
-	 */
-	if (!vdev->pci_2_3)
-		irqflags = IRQF_NO_AUTOEN;
-
-	ret = request_irq(pdev->irq, vfio_intx_handler,
-			  irqflags, vdev->ctx[0].name, vdev);
-	if (ret) {
-		vdev->ctx[0].trigger = NULL;
-		kfree(vdev->ctx[0].name);
-		eventfd_ctx_put(trigger);
-		return ret;
+	/* Releasing an old ctx requires synchronizing in-flight users */
+	if (old) {
+		synchronize_irq(pdev->irq);
+		vfio_virqfd_flush_thread(&vdev->ctx[0].unmask);
+		eventfd_ctx_put(old);
 	}
 
-	spin_lock_irqsave(&vdev->irqlock, flags);
-	if (!vdev->pci_2_3 && !vdev->ctx[0].masked)
-		enable_irq(pdev->irq);
-	spin_unlock_irqrestore(&vdev->irqlock, flags);
-
 	return 0;
 }
 
 static void vfio_intx_disable(struct vfio_pci_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
+
 	vfio_virqfd_disable(&vdev->ctx[0].unmask);
 	vfio_virqfd_disable(&vdev->ctx[0].mask);
-	vfio_intx_set_signal(vdev, -1);
+	free_irq(pdev->irq, vdev);
+	if (vdev->ctx[0].trigger)
+		eventfd_ctx_put(vdev->ctx[0].trigger);
+	kfree(vdev->ctx[0].name);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	vdev->num_ctx = 0;
 	kfree(vdev->ctx);
@@ -498,19 +509,23 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+		struct eventfd_ctx *trigger = NULL;
 		int32_t fd = *(int32_t *)data;
 		int ret;
 
-		if (is_intx(vdev))
-			return vfio_intx_set_signal(vdev, fd);
+		if (fd >= 0) {
+			trigger = eventfd_ctx_fdget(fd);
+			if (IS_ERR(trigger))
+				return PTR_ERR(trigger);
+		}
 
-		ret = vfio_intx_enable(vdev);
-		if (ret)
-			return ret;
+		if (is_intx(vdev))
+			ret = vfio_intx_set_signal(vdev, trigger);
+		else
+			ret = vfio_intx_enable(vdev, trigger);
 
-		ret = vfio_intx_set_signal(vdev, fd);
-		if (ret)
-			vfio_intx_disable(vdev);
+		if (ret && trigger)
+			eventfd_ctx_put(trigger);
 
 		return ret;
 	}
-- 
2.44.0


