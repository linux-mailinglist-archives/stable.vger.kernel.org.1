Return-Path: <stable+bounces-33778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC3F892757
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 00:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA1CB22EC7
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 23:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5D13E403;
	Fri, 29 Mar 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4s7n9rS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3D13E6DB
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753206; cv=none; b=kyu6tyEtXwatjLk8n5scVNKPOl1eRfVcTLj0JZbSMfSE2S2EHEmdWQsEKvRBxz4rfDGsE6NcVHmZvQ4rD4GyDuj3zFl06ir8oupf4txw/YByhaYeJShNduML5N/FGyYniaFVQdUHqbz33WGAEkLaExcuLEQmeAlZNLizqKK7OM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753206; c=relaxed/simple;
	bh=0t09vBbaRTgByZR5NcYtX3YIHsrY0gq6rVaDV/9VEG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2SYIT8wOp32TceHBz+iHI9DILBx02v7sBSE6Hab379b4jhNlQkbqkI2bPwSpRBRU4TSuYlBLi30p5uRNDsV/LA3x/OfElHo0iY9hMZAlH8huh0N2sKqO5dEXJmmb0UhhTn3VMhf+oEP7AXW/t9g6PN4BAQRZsnMLp8hNTdN/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4s7n9rS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711753203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2fvuv6hSKIleRhjpqh+naCfmakyfLLHxQIEwxu+ehw=;
	b=g4s7n9rS77HWb3wgHAjuqNQq0oXuqUGkQesWCKEvL4pEMrTXtPVIkQwdIqXeW4RJYBvevJ
	Xh6STEGzXM2wweGNMzE1gwElOZPdxLLXNX1TVhJBiq/z5lDto2K4Ui5spZH6RN8Kzy2p9y
	0GZjrwR5jYSHfV+IAO2PuNnnw4V8h9k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-Gbnvc2WxPRaI2-owZF4OWA-1; Fri,
 29 Mar 2024 19:00:01 -0400
X-MC-Unique: Gbnvc2WxPRaI2-owZF4OWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CE6C380008A;
	Fri, 29 Mar 2024 23:00:01 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60F5CC017A1;
	Fri, 29 Mar 2024 23:00:00 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com,
	Diana Craciun <diana.craciun@oss.nxp.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 5.15.y 6/6] vfio/fsl-mc: Block calling interrupt handler without trigger
Date: Fri, 29 Mar 2024 16:59:42 -0600
Message-ID: <20240329225944.3294388-7-alex.williamson@redhat.com>
In-Reply-To: <20240329225944.3294388-1-alex.williamson@redhat.com>
References: <20240329225944.3294388-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

[ Upstream commit 7447d911af699a15f8d050dfcb7c680a86f87012 ]

The eventfd_ctx trigger pointer of the vfio_fsl_mc_irq object is
initially NULL and may become NULL if the user sets the trigger
eventfd to -1.  The interrupt handler itself is guaranteed that
trigger is always valid between request_irq() and free_irq(), but
the loopback testing mechanisms to invoke the handler function
need to test the trigger.  The triggering and setting ioctl paths
both make use of igate and are therefore mutually exclusive.

The vfio-fsl-mc driver does not make use of irqfds, nor does it
support any sort of masking operations, therefore unlike vfio-pci
and vfio-platform, the flow can remain essentially unchanged.

Cc: Diana Craciun <diana.craciun@oss.nxp.com>
Cc:  <stable@vger.kernel.org>
Fixes: cc0ee20bd969 ("vfio/fsl-mc: trigger an interrupt via eventfd")
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20240308230557.805580-8-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
index 77e584093a23..50c2f82f2b68 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -142,13 +142,14 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc_device *vdev,
 	irq = &vdev->mc_irqs[index];
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_fsl_mc_irq_handler(hwirq, irq);
+		if (irq->trigger)
+			eventfd_signal(irq->trigger, 1);
 
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		u8 trigger = *(u8 *)data;
 
-		if (trigger)
-			vfio_fsl_mc_irq_handler(hwirq, irq);
+		if (trigger && irq->trigger)
+			eventfd_signal(irq->trigger, 1);
 	}
 
 	return 0;
-- 
2.44.0


