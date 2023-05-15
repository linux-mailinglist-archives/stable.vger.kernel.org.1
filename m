Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE64702E85
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbjEONkS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbjEONkO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 09:40:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315112690;
        Mon, 15 May 2023 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684158013; x=1715694013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WP+yFp91mqP5IhHCOHfOiS43Cj02tZQHbOCUjxgaHRw=;
  b=nA3HG6Er6PDHP+F12Y+U35DswrBAhawpz/HK0Beoj2BBJrvaIWlQwwrz
   XqHgrfxscRSeOnZuJyXEo2VE4wUR0ZkfqKP8Ta7101D6wEImVk1WlH/z9
   pxXipLQcU0ARKYCJ4hSfc1ME9CIn2EG3kcFNS1/H7ZCUhjFjnJTTs1a2K
   r2zRTEae4I9Te8mmSbJy9spPE8xXhpggcwn1TF69vvrpndzhmFrZuRX1t
   /O7/FHYlCvl4SOsxOruxufbR7EnW17hPDNpDkTzBfOG6PvJ0YJQukyGe1
   TnGHsUhLX4r+3SRWZFHINVZRiuh8hTZUzB5nXLQXFrpNaws1Tq+mkNWh4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="414598016"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="414598016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 06:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="700964227"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="700964227"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2023 06:39:57 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     <gregkh@linuxfoundation.org>
Cc:     <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        stable@vger.kernel.org, Miller Hunter <MillerH@hearthnhome.com>
Subject: [PATCH 2/2] xhci: Fix incorrect tracking of free space on transfer rings
Date:   Mon, 15 May 2023 16:40:59 +0300
Message-Id: <20230515134059.161110-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515134059.161110-1-mathias.nyman@linux.intel.com>
References: <20230515134059.161110-1-mathias.nyman@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This incorrect tracking caused unnecessary ring expansion in some
usecases which over days of use consume a lot of memory.

xhci driver tries to keep track of free transfer blocks (TRBs) on the
ring buffer, but failed to add back some cancelled transfers that were
turned into no-op operations instead of just moving past them.

This can happen if there are several queued pending transfers which
then are cancelled in reverse order.

Solve this by counting the numer of steps we move the dequeue pointer
once we complete a transfer, and add it to the number of free trbs
instead of just adding the trb number of the current transfer.
This way we ensure we count the no-op trbs on the way as well.

Fixes: 55f6153d8cc8 ("xhci: remove extra loop in interrupt context")
Cc: stable@vger.kernel.org
Reported-by: Miller Hunter <MillerH@hearthnhome.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217242
Tested-by: Miller Hunter <MillerH@hearthnhome.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1ad12d5a4857..2bc82b3a2f98 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -276,6 +276,26 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	trace_xhci_inc_enq(ring);
 }
 
+static int xhci_num_trbs_to(struct xhci_segment *start_seg, union xhci_trb *start,
+			    struct xhci_segment *end_seg, union xhci_trb *end,
+			    unsigned int num_segs)
+{
+	union xhci_trb *last_on_seg;
+	int num = 0;
+	int i = 0;
+
+	do {
+		if (start_seg == end_seg && end >= start)
+			return num + (end - start);
+		last_on_seg = &start_seg->trbs[TRBS_PER_SEGMENT - 1];
+		num += last_on_seg - start;
+		start_seg = start_seg->next;
+		start = start_seg->trbs;
+	} while (i++ <= num_segs);
+
+	return -EINVAL;
+}
+
 /*
  * Check to see if there's room to enqueue num_trbs on the ring and make sure
  * enqueue pointer will not advance into dequeue segment. See rules above.
@@ -2140,6 +2160,7 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		     u32 trb_comp_code)
 {
 	struct xhci_ep_ctx *ep_ctx;
+	int trbs_freed;
 
 	ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
 
@@ -2209,9 +2230,15 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	}
 
 	/* Update ring dequeue pointer */
+	trbs_freed = xhci_num_trbs_to(ep_ring->deq_seg, ep_ring->dequeue,
+				      td->last_trb_seg, td->last_trb,
+				      ep_ring->num_segs);
+	if (trbs_freed < 0)
+		xhci_dbg(xhci, "Failed to count freed trbs at TD finish\n");
+	else
+		ep_ring->num_trbs_free += trbs_freed;
 	ep_ring->dequeue = td->last_trb;
 	ep_ring->deq_seg = td->last_trb_seg;
-	ep_ring->num_trbs_free += td->num_trbs - 1;
 	inc_deq(xhci, ep_ring);
 
 	return xhci_td_cleanup(xhci, td, ep_ring, td->status);
-- 
2.25.1

