Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9967C9A95
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJOSHA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjJOSG7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:06:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD43DC1
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:06:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AEBC433C8;
        Sun, 15 Oct 2023 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697393217;
        bh=5lgCKsP6uj9dwQsuRSuCU28enF0PSrcBRQnliW/1j7k=;
        h=Subject:To:Cc:From:Date:From;
        b=Rd/Dvs9/F4iq9DEbnd1bvRnDMcEBJSwI7hShwZSFSX67N5pvOEw1DzceMHEza2pb7
         sUkirZ3xYwP5Y2OZsZC8ZiGW/gn702fEOtw7Rw7TjOvWTN/jGDHpgIYXSxxRNrkFTp
         dzODNN0DiBcWisaQX2llxeRxyCISHxR+I/vchGgk=
Subject: FAILED: patch "[PATCH] xhci: Clear EHB bit only at end of interrupt handler" failed to apply to 4.19-stable tree
To:     lukas@wunner.de, gregkh@linuxfoundation.org,
        mathias.nyman@linux.intel.com, peter.chen@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:06:42 +0200
Message-ID: <2023101542-magnolia-configure-5eae@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 15f3ef070933817fac2bcbdb9c85bff9e54e9f80
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101542-magnolia-configure-5eae@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15f3ef070933817fac2bcbdb9c85bff9e54e9f80 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 15 Sep 2023 17:31:07 +0300
Subject: [PATCH] xhci: Clear EHB bit only at end of interrupt handler

The Event Handler Busy bit shall be cleared by software when the Event
Ring is empty.  The xHC is thereby informed that it may raise another
interrupt once it has enqueued new events (sec 4.17.2).

However since commit dc0ffbea5729 ("usb: host: xhci: update event ring
dequeue pointer on purpose"), the EHB bit is already cleared after half
a segment has been processed.

As a result, spurious interrupts may occur:

- xhci_irq() processes half a segment, clears EHB, continues processing
  remaining events.
- xHC enqueues new events.  Because EHB has been cleared, xHC sets
  Interrupt Pending bit.  Interrupt moderation countdown begins.
- Meanwhile xhci_irq() continues processing events.  Interrupt
  moderation countdown reaches zero, so an MSI interrupt is signaled.
- xhci_irq() empties the Event Ring, clears EHB again and is done.
- Because an MSI interrupt has been signaled, xhci_irq() is run again.
  It discovers there's nothing to do and returns IRQ_NONE.

Avoid by clearing the EHB bit only at the end of xhci_irq().

Fixes: dc0ffbea5729 ("usb: host: xhci: update event ring dequeue pointer on purpose")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.5+
Cc: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230915143108.1532163-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 98389b568633..3e5dc0723a8f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2996,7 +2996,8 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
  */
 static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 				     struct xhci_interrupter *ir,
-				     union xhci_trb *event_ring_deq)
+				     union xhci_trb *event_ring_deq,
+				     bool clear_ehb)
 {
 	u64 temp_64;
 	dma_addr_t deq;
@@ -3017,12 +3018,13 @@ static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 			return;
 
 		/* Update HC event ring dequeue pointer */
-		temp_64 &= ERST_PTR_MASK;
+		temp_64 &= ERST_DESI_MASK;
 		temp_64 |= ((u64) deq & (u64) ~ERST_PTR_MASK);
 	}
 
 	/* Clear the event handler busy flag (RW1C) */
-	temp_64 |= ERST_EHB;
+	if (clear_ehb)
+		temp_64 |= ERST_EHB;
 	xhci_write_64(xhci, temp_64, &ir->ir_set->erst_dequeue);
 }
 
@@ -3103,7 +3105,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	while (xhci_handle_event(xhci, ir) > 0) {
 		if (event_loop++ < TRBS_PER_SEGMENT / 2)
 			continue;
-		xhci_update_erst_dequeue(xhci, ir, event_ring_deq);
+		xhci_update_erst_dequeue(xhci, ir, event_ring_deq, false);
 		event_ring_deq = ir->event_ring->dequeue;
 
 		/* ring is half-full, force isoc trbs to interrupt more often */
@@ -3113,7 +3115,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		event_loop = 0;
 	}
 
-	xhci_update_erst_dequeue(xhci, ir, event_ring_deq);
+	xhci_update_erst_dequeue(xhci, ir, event_ring_deq, true);
 	ret = IRQ_HANDLED;
 
 out:

