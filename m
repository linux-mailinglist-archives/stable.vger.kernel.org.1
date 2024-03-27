Return-Path: <stable+bounces-33036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8407988F232
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 23:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380AA29C344
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 22:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E83D154C07;
	Wed, 27 Mar 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSxKIyOg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B09154437
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580113; cv=none; b=NYdbIQ/JsOw4a/P24QYVIIPtSE6dnKcc+30kZpXvCNxjLP5AOceWFz0YBM7bW3ZJhCgQV64bCMvmy0rhh1R9kttnCzO01+9rAC7kLnXPQ1xCAF6CDLtxJPUzU1XTOkoljn6irSGcqaLaOBntUUz/2S9s1oJwO2REOXQJmZQDmok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580113; c=relaxed/simple;
	bh=tFk2WDgPQcum9GMb7IfkK53TeSOXfNcXazSFIhRsKEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwxWNE6NUB1ZeVRMQwJjpPcZ5dCJon57PZhKgCDsurSdR4TXln8Wy/YyPSnOZZuz1q1HjSFaIGOK/lZ8d61bT1ttYsps63aEEfNkl9yckCy00CK8gfp0X4fikuara2aQ0FniJSeAb4HTh2OHS5UJrTvGmzW1ZFqE1JpNjclPI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSxKIyOg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711580110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cDODoHFQAdzqju7uysEdGyC001D3/wBE/vEANKSTwk=;
	b=aSxKIyOgXH4dcOs9gl3UjsZYJedOE4qEHr1ZjTqYmu0PtSTD0s4xfms8kQoi0bidm/Uqas
	L9xUuQBnVEm0T39gJChFDydcsa0NFG+Y/v+qFmMgxQwn/are99Mx4DgV2/ZuTNXrIqJ2bp
	8UA01YzPhGhEj70GJhU1AVsJ0mClHZw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-Tot_C2N4Mu2BkgaWIg3ZsQ-1; Wed,
 27 Mar 2024 18:55:08 -0400
X-MC-Unique: Tot_C2N4Mu2BkgaWIg3ZsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 618DA1C05EBD;
	Wed, 27 Mar 2024 22:55:08 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA5B111F3C6;
	Wed, 27 Mar 2024 22:55:07 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	eric.auger@redhat.com,
	sashal@kernel.org,
	Diana Craciun <diana.craciun@oss.nxp.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 6.6.y 4/4] vfio/fsl-mc: Block calling interrupt handler without trigger
Date: Wed, 27 Mar 2024 16:54:30 -0600
Message-ID: <20240327225444.909882-5-alex.williamson@redhat.com>
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
index c51229fccbd6..1a1d0d5ec35c 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -141,13 +141,14 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc_device *vdev,
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


