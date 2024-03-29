Return-Path: <stable+bounces-33769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84124892635
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 22:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF650B22338
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361113B59A;
	Fri, 29 Mar 2024 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aA/4gHMl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996D13BC3E
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748350; cv=none; b=jDhl4tb5RUzjqKF6A+R9QV0giCSe9GF8Bae7y2ugdy7WXaD6NTHNnBbd3Tbfc1dGRb7e6DWWbOPX/KVvjPScsDSSlaDK3eAa/MCjFkeHWgBr4/OSjgAyaU1XRrWupU1yk+BtVej/ny3WSoXU5zNfKXX0KF0YwmyQovZ3HHcJMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748350; c=relaxed/simple;
	bh=q5aTAMpVpaU3ehLSactgkHKalRDBIt7NJM7ta3uFpjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZTumjDPDmcCrQk0AeQVdnJh4k8wr+kHVEBbTWtsIH5bseio97xI32K0Zntg5LtQsmQD77KXyJJYKO21YQTgsbuAULtEZD15twikoDAmIZVUSvWqeknNWEE5Lr7F/UZ+FutNhLu1wgk3MJAl30p/H2kBTTlJ/Wm3nNAZJWpLxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aA/4gHMl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711748347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBkfUmD0tAfZ4dZneCgBfOO0O7Q5Sg8j/wOQa5tU320=;
	b=aA/4gHMlOMDBfG525X9lT6SPmg5MPD98B/YiHkp1+9txz9pK5NjtmTJ+EIJtOUCWRskLjm
	4wWcYImDb8VceViEtFwLvmVwiPm9c/T0aD/SU3HmhqHTkGccTeteHFODqyBSo9uyV8Ezia
	DwcyT4EhGDoU9XlVZd23h5u0e2fP2Gk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-RNvJnK9pMAOxPaXF2w58jg-1; Fri,
 29 Mar 2024 17:39:04 -0400
X-MC-Unique: RNvJnK9pMAOxPaXF2w58jg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C9FE29AA397;
	Fri, 29 Mar 2024 21:39:04 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 135AB492BD0;
	Fri, 29 Mar 2024 21:39:03 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com,
	Reinette Chatre <reinette.chatre@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 6.1.y 5/7] vfio/pci: Create persistent INTx handler
Date: Fri, 29 Mar 2024 15:38:52 -0600
Message-ID: <20240329213856.2550762-6-alex.williamson@redhat.com>
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
index 4f0699215f12..03246a59b553 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -55,8 +55,13 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
 {
 	struct vfio_pci_core_device *vdev = opaque;
 
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
 
 /* Returns true if the INTx vfio_pci_irq_ctx.masked value is changed. */
@@ -191,98 +196,104 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
+static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
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
 
+	name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	vdev->ctx = kzalloc(sizeof(struct vfio_pci_irq_ctx), GFP_KERNEL_ACCOUNT);
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
 
-static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev, int fd)
+static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev,
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
 
-	vdev->ctx[0].name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)",
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
 
 static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
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
@@ -534,19 +545,23 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
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


