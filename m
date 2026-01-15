Return-Path: <stable+bounces-209974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9534D2947E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 00:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D9B83089A04
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB44330D29;
	Thu, 15 Jan 2026 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDDanD02"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3B30F527;
	Thu, 15 Jan 2026 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520300; cv=none; b=I1SvcZwOId02X2hXct9iaIEy5lf4obDhhfEJ99dz+UPTDOVIR4W4azi7AXPhUEvVuDbPjad2lMvp2cgMA+VTD1QvfGrDaNd2GnsJ9tOt+f9Y+jBF8nHsGTm4U6wq3T+gbVXSCCqWA/7oc/yEZF+vn6l3/WC3SOEs57mmC2iSJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520300; c=relaxed/simple;
	bh=bw5uexDVeCOajjm+Os8eRFDxt4Zovndc6OKkwrfX5H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCGZsfCcj1ZG5YHs3WPiTXDENXSMfFNLVRXvfwke1z0QzLdiFGC3zV6y5FyvMZkrrLzfKq0QK8ND7Zay/28IEnsNCOMPfTFzIkUVliKH+metjYUH54kMjEUNDEFKJ6GqqbFNbKFP2Q8efRTwbQJEdmGPnI2dITD5DSw9sck2/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDDanD02; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768520298; x=1800056298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bw5uexDVeCOajjm+Os8eRFDxt4Zovndc6OKkwrfX5H8=;
  b=LDDanD02Rje1TrQ528AXcRw1Cm1IvHb75dAomLSAQ/5p7Zy9x90T62Mu
   f3T5zae5FDdCvJBbkEMrMKO5WymDUWrHCgQ6UsnwUas6wlOAY2zxipQEU
   lOJEUTFYGekRUCXegxm5ijYJiw0AVAXhFmTn3lenO/aeGgq+i5mypbazp
   HMYUph+8Py/Gr8A085fy5195WF1Lrsscyp5/p49MKKtdzeDyaW57b46iB
   Uj46W+KXdgBaumkc+/0UN/AsZ3DtfiNmTdNjURGhsf5z1QRElv8CRiwi5
   GW9usWEWDx42qYA1b+B+7Tx7eBwnEeKuc1Yg+cGV19tb8Dbq3FKJwJMK3
   g==;
X-CSE-ConnectionGUID: WCoo2VmBT4Of+BStQcNutQ==
X-CSE-MsgGUID: ejb8JEG4SeOPnIKkBZqzPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69891646"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69891646"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:38:18 -0800
X-CSE-ConnectionGUID: 0FceZhURSseOA7sX4i9L9A==
X-CSE-MsgGUID: LWtCRYJ2SkmZPnnc5A8eyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="236336663"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.7])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:38:17 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=E8=83=A1=E8=BF=9E=E5=8B=A4?= <hulianqin@vivo.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] xhci: sideband: don't dereference freed ring when removing sideband endpoint
Date: Fri, 16 Jan 2026 01:37:58 +0200
Message-ID: <20260115233758.364097-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115233758.364097-1-mathias.nyman@linux.intel.com>
References: <20260115233758.364097-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xhci_sideband_remove_endpoint() incorrecly assumes that the endpoint is
running and has a valid transfer ring.

Lianqin reported a crash during suspend/wake-up stress testing, and
found the cause to be dereferencing a non-existing transfer ring
'ep->ring' during xhci_sideband_remove_endpoint().

The endpoint and its ring may be in unknown state if this function
is called after xHCI was reinitialized in resume (lost power), or if
device is being re-enumerated, disconnected or endpoint already dropped.

Fix this by both removing unnecessary ring access, and by checking
ep->ring exists before dereferencing it. Also make sure endpoint is
running before attempting to stop it.

Remove the xhci_initialize_ring_info() call during sideband endpoint
removal as is it only initializes ring structure enqueue, dequeue and
cycle state values to their starting values without changing actual
hardware enqueue, dequeue and cycle state. Leaving them out of sync
is worse than leaving it as it is. The endpoint will get freed in after
this in most usecases.

If the (audio) class driver want's to reuse the endpoint after offload
then it is up to the class driver to ensure endpoint is properly set up.

Reported-by: 胡连勤 <hulianqin@vivo.com>
Closes: https://lore.kernel.org/linux-usb/TYUPR06MB6217B105B059A7730C4F6EC8D2B9A@TYUPR06MB6217.apcprd06.prod.outlook.com/
Tested-by: 胡连勤 <hulianqin@vivo.com>
Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-sideband.c |  1 -
 drivers/usb/host/xhci.c          | 15 ++++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index a85f62a73313..2bd77255032b 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -210,7 +210,6 @@ xhci_sideband_remove_endpoint(struct xhci_sideband *sb,
 		return -ENODEV;
 
 	__xhci_sideband_remove_endpoint(sb, ep);
-	xhci_initialize_ring_info(ep->ring);
 
 	return 0;
 }
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 02c9bfe21ae2..b3ba16b9718c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2898,16 +2898,25 @@ int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep, int
 			    gfp_t gfp_flags)
 {
 	struct xhci_command *command;
+	struct xhci_ep_ctx *ep_ctx;
 	unsigned long flags;
-	int ret;
+	int ret = -ENODEV;
 
 	command = xhci_alloc_command(xhci, true, gfp_flags);
 	if (!command)
 		return -ENOMEM;
 
 	spin_lock_irqsave(&xhci->lock, flags);
-	ret = xhci_queue_stop_endpoint(xhci, command, ep->vdev->slot_id,
-				       ep->ep_index, suspend);
+
+	/* make sure endpoint exists and is running before stopping it */
+	if (ep->ring) {
+		ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
+		if (GET_EP_CTX_STATE(ep_ctx) == EP_STATE_RUNNING)
+			ret = xhci_queue_stop_endpoint(xhci, command,
+						       ep->vdev->slot_id,
+						       ep->ep_index, suspend);
+	}
+
 	if (ret < 0) {
 		spin_unlock_irqrestore(&xhci->lock, flags);
 		goto out;
-- 
2.43.0


