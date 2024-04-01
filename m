Return-Path: <stable+bounces-35389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2ED8943BA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E890128391B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3554487BE;
	Mon,  1 Apr 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LKLoM/8R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F83482E4;
	Mon,  1 Apr 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991238; cv=none; b=shFAO7SAWelKk/0kw/uGKx25Qf2Bx36/OS+8i9moO94W5/41obBcF6ClfGpGb78ygzBusg5mjnl+LwSxyJ2RHzTo3cKc5I69uk/SVJFPeyGFWQ90ISYlWnMRyfcWWETHyMdcdoBIqBejgdfliB4p0ChRSp+tFiL39X4ngQONlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991238; c=relaxed/simple;
	bh=jvbtkEDvCPcnpIoICV7DuTeKStlnsjVcyeGduY/PgF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFxb5iFXkn5k/SjAIX/e75zdD1GjsNJN6vXqGriMZ6Hr3QttvlthF55n2R6DkO9k4Rsf/xQVegqU12IedNk7R9lPE0h2J8TKb/wd/g7gOi+SUvieh8EZro2ximSarkbZUQ/Mo34EbIDvlPpgh00Qbe8mZPh2pyW87IvVw+e64L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LKLoM/8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34ABC433C7;
	Mon,  1 Apr 2024 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991238;
	bh=jvbtkEDvCPcnpIoICV7DuTeKStlnsjVcyeGduY/PgF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKLoM/8R6QQcP3karEGaYJRFAtYUD01ezL9/c5lrK36iCp4XR96UhC8N/EFTQmi5K
	 Fa3RYem4Wr0G14XTkb+6AYwpOHUdi/Jx2JSkdMkgQOMlnObNDF1O9adsqL+49rk44A
	 3zf0eDOVuZ0dfGX/o8ZtOcQKauXTsGxh9jP12VyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Diana Craciun <diana.craciun@oss.nxp.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 6.1 204/272] vfio/fsl-mc: Block calling interrupt handler without trigger
Date: Mon,  1 Apr 2024 17:46:34 +0200
Message-ID: <20240401152537.277653215@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@redhat.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -142,13 +142,14 @@ static int vfio_fsl_mc_set_irq_trigger(s
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



