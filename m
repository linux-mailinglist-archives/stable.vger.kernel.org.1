Return-Path: <stable+bounces-33767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7545892632
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 22:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BC0B22B0D
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5B13BC09;
	Fri, 29 Mar 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCRXBvRQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DB13B2B8
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748346; cv=none; b=Qjpn5tTyPcMH03NpYT7DviUxRiOYh/9l2LszeG8oar4g4plhA30ikWLpWtFqxxy6FUzau0TveR+N5zdYRuz05CwGeNc+tRZKtcyI85XyUIJ9EL3UyEwFaReXwAvNuS/NIoqgMpTNLC+958IAMOb0hwZsxIr0BI770CTqf0lKqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748346; c=relaxed/simple;
	bh=x07vIN5TaNW7X7D76Ul9Q0kDx6WwB6JdgJ6BvadRAIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdTXZW5XYS8JOC6W7DsevcBCkjYufBItCko6dxjhrpCISMhALABmWC2rq1CIDeplhVhMkW94m+iwlrT1lZPrWp91kzB4vEyeF5mh1tLRa0n2+dD2o6FV/tIH9K7cQAHO+vk8Qx7VyQS/qI393ghqJ/bf340UrlUeNngLvSSh7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCRXBvRQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711748343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wg1j4T6lZdHxl5g43Y5HVUftbo5z7qM00OMWVvOxL4=;
	b=KCRXBvRQ705rfQzF+1qwlOUoOgp+5AYFZCncOYGTTUr/sq3MvX+qZ9/KSnhD7ROhvaEpNz
	9P58byZLihNyziJFC93JNXs/NIkCEz5BuTdEev6TH9ULeh4Wz//ReKq2UtcCWdx/ljoW/L
	eTzoOA9HfsJvz3RindFyDrHIBIAWOdA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-QHbK1Nq0OjehpWhnnU86Rw-1; Fri, 29 Mar 2024 17:39:00 -0400
X-MC-Unique: QHbK1Nq0OjehpWhnnU86Rw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE630800269;
	Fri, 29 Mar 2024 21:38:59 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 09964492BD7;
	Fri, 29 Mar 2024 21:38:58 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com
Subject: [PATCH 6.1.y 1/7] Revert "vfio/pci: Disable auto-enable of exclusive INTx IRQ"
Date: Fri, 29 Mar 2024 15:38:48 -0600
Message-ID: <20240329213856.2550762-2-alex.williamson@redhat.com>
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

This reverts commit e31eb60c4288ecbb4cc447a8e2496ea758a3984e.

This is a bad backport, it pulls in an unnecessary dependency
in commit b8e81e269b3d ("vfio/pci: Prepare for dynamic interrupt
context storage") which turns out to be broken on it's own.

Revert and start over.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 0deb51c820d2..ef63ee441c36 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -319,15 +319,8 @@ static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev, int fd)
 
 	ctx->trigger = trigger;
 
-	/*
-	 * Devices without DisINTx support require an exclusive interrupt,
-	 * IRQ masking is performed at the IRQ chip.  The masked status is
-	 * protected by vdev->irqlock. Setup the IRQ without auto-enable and
-	 * unmask as necessary below under lock.  DisINTx is unmodified by
-	 * the IRQ configuration and may therefore use auto-enable.
-	 */
 	if (!vdev->pci_2_3)
-		irqflags = IRQF_NO_AUTOEN;
+		irqflags = 0;
 
 	ret = request_irq(pdev->irq, vfio_intx_handler,
 			  irqflags, ctx->name, vdev);
@@ -338,9 +331,13 @@ static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev, int fd)
 		return ret;
 	}
 
+	/*
+	 * INTx disable will stick across the new irq setup,
+	 * disable_irq won't.
+	 */
 	spin_lock_irqsave(&vdev->irqlock, flags);
-	if (!vdev->pci_2_3 && !ctx->masked)
-		enable_irq(pdev->irq);
+	if (!vdev->pci_2_3 && ctx->masked)
+		disable_irq_nosync(pdev->irq);
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
 
 	return 0;
-- 
2.44.0


