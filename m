Return-Path: <stable+bounces-34592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ACB893FFA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12CA1F21DAD
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735247A57;
	Mon,  1 Apr 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W2ZD50Zg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D3C129;
	Mon,  1 Apr 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988638; cv=none; b=JjjFc8evUOm73PNnMcqTvEk0GJLqtHt8DTjlxnUNBaHUkpxB2YOaBMa9EMdhwA3wrDaojpCgT4eSH99m5JCMS3EvxD7CuJozQqjk3+or587cKCCIMuI9vcSNfxJXI+wXrgygcHZDKlSi6VQ6zuGaG90xrGq+XBVYRWJ2Tqeru8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988638; c=relaxed/simple;
	bh=8KHOoip/n9n70SInr/IMLn70tyDvSZB/pACycJmU3po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsETaGqQIeZgpxNONkeapW+XFOUA3VoJKdVfa0R+0htHC8+6Cayy1p/EkN8e5Ky+8XPkf4EUrOl2l6AoOxopkxvQ5Yn/9EKeCgFxyoiBH43bQz6doNL1Js3bbWOnFOCg6BCsO/QB91WF22kcPJSbMv818QtlQBntQzJI2umxLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W2ZD50Zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EBFC433C7;
	Mon,  1 Apr 2024 16:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988637;
	bh=8KHOoip/n9n70SInr/IMLn70tyDvSZB/pACycJmU3po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2ZD50ZgwwoU3hDtG5vDheV/nT70ys6B+ej7N0SD3qzmhwGq+yLvoM0ekLsjXkxcr
	 h3vbFFgOeqTyzq8npnZCf8HgIUdBWjPfgW4OY1Uc1QUs+BKAizmWu0hlQHRPY9zgXb
	 nQzMr29wWtL3AOVeyMAFohAJAuDYjGwatUeZ4mKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Reinette Chatre <reinette.chatre@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 227/432] vfio/pci: Create persistent INTx handler
Date: Mon,  1 Apr 2024 17:43:34 +0200
Message-ID: <20240401152559.906487911@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@redhat.com>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 145 ++++++++++++++++--------------
 1 file changed, 78 insertions(+), 67 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 75c85eec21b3c..fb5392b749fff 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -90,11 +90,15 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
 
 	if (likely(is_intx(vdev) && !vdev->virq_disabled)) {
 		struct vfio_pci_irq_ctx *ctx;
+		struct eventfd_ctx *trigger;
 
 		ctx = vfio_irq_ctx_get(vdev, 0);
 		if (WARN_ON_ONCE(!ctx))
 			return;
-		eventfd_signal(ctx->trigger);
+
+		trigger = READ_ONCE(ctx->trigger);
+		if (likely(trigger))
+			eventfd_signal(trigger);
 	}
 }
 
@@ -253,100 +257,100 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
+static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
+			    struct eventfd_ctx *trigger)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
+	unsigned long irqflags;
+	char *name;
+	int ret;
 
 	if (!is_irq_none(vdev))
 		return -EINVAL;
 
-	if (!vdev->pdev->irq)
+	if (!pdev->irq)
 		return -ENODEV;
 
+	name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ctx = vfio_irq_ctx_alloc(vdev, 0);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->name = name;
+	ctx->trigger = trigger;
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
 	ctx->masked = vdev->virq_disabled;
-	if (vdev->pci_2_3)
-		pci_intx(vdev->pdev, !ctx->masked);
+	if (vdev->pci_2_3) {
+		pci_intx(pdev, !ctx->masked);
+		irqflags = IRQF_SHARED;
+	} else {
+		irqflags = ctx->masked ? IRQF_NO_AUTOEN : 0;
+	}
 
 	vdev->irq_type = VFIO_PCI_INTX_IRQ_INDEX;
 
+	ret = request_irq(pdev->irq, vfio_intx_handler,
+			  irqflags, ctx->name, vdev);
+	if (ret) {
+		vdev->irq_type = VFIO_PCI_NUM_IRQS;
+		kfree(name);
+		vfio_irq_ctx_free(vdev, ctx, 0);
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
 	struct vfio_pci_irq_ctx *ctx;
-	struct eventfd_ctx *trigger;
-	unsigned long flags;
-	int ret;
+	struct eventfd_ctx *old;
 
 	ctx = vfio_irq_ctx_get(vdev, 0);
 	if (WARN_ON_ONCE(!ctx))
 		return -EINVAL;
 
-	if (ctx->trigger) {
-		free_irq(pdev->irq, vdev);
-		kfree(ctx->name);
-		eventfd_ctx_put(ctx->trigger);
-		ctx->trigger = NULL;
-	}
-
-	if (fd < 0) /* Disable only */
-		return 0;
-
-	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)",
-			      pci_name(pdev));
-	if (!ctx->name)
-		return -ENOMEM;
-
-	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(ctx->name);
-		return PTR_ERR(trigger);
-	}
+	old = ctx->trigger;
 
-	ctx->trigger = trigger;
+	WRITE_ONCE(ctx->trigger, trigger);
 
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
-			  irqflags, ctx->name, vdev);
-	if (ret) {
-		ctx->trigger = NULL;
-		kfree(ctx->name);
-		eventfd_ctx_put(trigger);
-		return ret;
+	/* Releasing an old ctx requires synchronizing in-flight users */
+	if (old) {
+		synchronize_irq(pdev->irq);
+		vfio_virqfd_flush_thread(&ctx->unmask);
+		eventfd_ctx_put(old);
 	}
 
-	spin_lock_irqsave(&vdev->irqlock, flags);
-	if (!vdev->pci_2_3 && !ctx->masked)
-		enable_irq(pdev->irq);
-	spin_unlock_irqrestore(&vdev->irqlock, flags);
-
 	return 0;
 }
 
 static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
 
 	ctx = vfio_irq_ctx_get(vdev, 0);
@@ -354,10 +358,13 @@ static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
 	if (ctx) {
 		vfio_virqfd_disable(&ctx->unmask);
 		vfio_virqfd_disable(&ctx->mask);
+		free_irq(pdev->irq, vdev);
+		if (ctx->trigger)
+			eventfd_ctx_put(ctx->trigger);
+		kfree(ctx->name);
+		vfio_irq_ctx_free(vdev, ctx, 0);
 	}
-	vfio_intx_set_signal(vdev, -1);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
-	vfio_irq_ctx_free(vdev, ctx, 0);
 }
 
 /*
@@ -641,19 +648,23 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
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
2.43.0




