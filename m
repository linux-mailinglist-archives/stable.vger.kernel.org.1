Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490D370C9C4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjEVTwG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjEVTvz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25EDE4C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B220262B0B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE36DC433EF;
        Mon, 22 May 2023 19:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785076;
        bh=wuHmmLkS8W2cfFBEZ3HsDYaIpXG2kp+BhOwGoGdxJq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3EOg7brY/5S32gmSGNEd7flJG2Td9EAIbE5MCBOPb4gWe8BySSlympKWCZfOyXP5
         jsouGkqBE0X8a750SlugckRqXxFT5iEKS0u8c+6/2HSW1jbY6EfMojd5BGX9JsvS9J
         KxgAodikcNMl9kjL8V2CwtpQr31eLA1hhJcsxmrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miller Hunter <MillerH@hearthnhome.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.3 300/364] xhci: Fix incorrect tracking of free space on transfer rings
Date:   Mon, 22 May 2023 20:10:05 +0100
Message-Id: <20230522190420.272742714@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit fe82f16aafdaf8002281d3b9524291d4a4a28460 upstream.

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
Link: https://lore.kernel.org/r/20230515134059.161110-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-ring.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -276,6 +276,26 @@ static void inc_enq(struct xhci_hcd *xhc
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
@@ -2140,6 +2160,7 @@ static int finish_td(struct xhci_hcd *xh
 		     u32 trb_comp_code)
 {
 	struct xhci_ep_ctx *ep_ctx;
+	int trbs_freed;
 
 	ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
 
@@ -2209,9 +2230,15 @@ static int finish_td(struct xhci_hcd *xh
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


