Return-Path: <stable+bounces-37636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D1889C5C9
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F7A2834A7
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F47FBDA;
	Mon,  8 Apr 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uksuKn4W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD267F489;
	Mon,  8 Apr 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584815; cv=none; b=lpEaYfuciBZhB7EThJF4g/Yk13PrCiuFDhdTw17CIA/47/eBD8ThzuopkoHpbbFHjVSk2wGMc5w3rd6wkXbA8Ec3gyInF3o+2ZjyqwNGj9KkHyOsJ34et8/5hMGPMXVuiTpo2GyB8cXa4nQ90PrP540fS+vCyhZUPIJFX61YMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584815; c=relaxed/simple;
	bh=vn8yOyBKDYc/Y0fTt773/ADeZDP2n4NBjdSXrgnx7uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0pc0WhUJm6fGuXlC3uyjlo7aOFsgjx5FK42iPreXWA0LcCcG1MDAUT0kUPmPP8Bi9tqQ1tsf+SNu4Kpz5Yl7aQX7LFLZopS7doaedCyohQQhuQg2ijBl4QKChUI12g8CfJ2DQf6EzeQf4u9SL/Jpy929J84Rmp/pMEG1+9JclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uksuKn4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C26C433C7;
	Mon,  8 Apr 2024 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584815;
	bh=vn8yOyBKDYc/Y0fTt773/ADeZDP2n4NBjdSXrgnx7uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uksuKn4W0d0O+KpB3Ar/gyTcso3u6IhLIpRdqws69HXK465RnHO+i9LqLFCMolJ8C
	 32Lq9f/Zp79P4Ub6vvYF/ZSeX3qpny8sPyeEXMVyx4OAYt33ouZDHeBPH781NwOVNd
	 ZpZWCCnfuK5sBQuUNcOZ25oPv5eFTwjivVFx2P2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Diana Craciun <diana.craciun@oss.nxp.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 5.15 566/690] vfio/fsl-mc: Block calling interrupt handler without trigger
Date: Mon,  8 Apr 2024 14:57:12 +0200
Message-ID: <20240408125420.134933245@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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



