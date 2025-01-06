Return-Path: <stable+bounces-107041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF29A029D2
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9542162513
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50918A6C1;
	Mon,  6 Jan 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zy6IRb/C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E016DEBB;
	Mon,  6 Jan 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177274; cv=none; b=OfTT18XSrZELJxOZQU3kjzsvV2PdOXNc4iF6ICl/nSG9FJJlyba3TNCUYQSY1HTczBnUSMB3HNzmZC0V/8/xb5EcQum6JBZlTnwAVYHFor4hbX4WrbWkzBdGP6E5TdldiPyBH8BlVcQMwWsJICX1WofqmZhRZy4zYRnAa3AEeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177274; c=relaxed/simple;
	bh=ElsgxJ8mucW4rAnNFgcK8l1BP0iTjf7owbSHqhpkNk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcOLyjb1VYMpz0OUvc1F5zAzbxedND1dgq9R6smey29VlWqBbx/c/MG9De15TiqB7K4RNP+vktb2qpf1wjDHH3IWIUvv1LBa0WnC5BveCZLxZeA4O0em26xSbcHa8zASycQ/Z+WVgkbNRyOp+vZh/VucBqRlOkyj4qdykQG8/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zy6IRb/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A44C4CEDF;
	Mon,  6 Jan 2025 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177273;
	bh=ElsgxJ8mucW4rAnNFgcK8l1BP0iTjf7owbSHqhpkNk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zy6IRb/C7dIok3W+IKf9fD/HbUQTTaUjmUFYTObBhU5p9gOtEK6jqMGFJ1ogSDLPO
	 1wotBCxOv/vnf8nP/8I5D3auk+4TclBSLXvy9ZWU1tfAsGcV1iOPCeK2CC1kynt/bv
	 YdZufFUtYecIutSFBxzCjtvhl4gbKa+PM9Zj8Yxw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 109/222] usb: xhci: Avoid queuing redundant Stop Endpoint commands
Date: Mon,  6 Jan 2025 16:15:13 +0100
Message-ID: <20250106151154.723051503@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 474538b8dd1cd9c666e56cfe8ef60fbb0fb513f4 ]

Stop Endpoint command on an already stopped endpoint fails and may be
misinterpreted as a known hardware bug by the completion handler. This
results in an unnecessary delay with repeated retries of the command.

Avoid queuing this command when endpoint state flags indicate that it's
stopped or halted and the command will fail. If commands are pending on
the endpoint, their completion handlers will process cancelled TDs so
it's done. In case of waiting for external operations like clearing TT
buffer, the endpoint is stopped and cancelled TDs can be processed now.

This eliminates practically all unnecessary retries because an endpoint
with pending URBs is maintained in Running state by the driver, unless
aforementioned commands or other operations are pending on it. This is
guaranteed by xhci_ring_ep_doorbell() and by the fact that it is called
every time any of those operations completes.

The only known exceptions are hardware bugs (the endpoint never starts
at all) and Stream Protocol errors not associated with any TRB, which
cause an endpoint reset not followed by restart. Sounds like a bug.

Generally, these retries are only expected to happen when the endpoint
fails to start for unknown/no reason, which is a worse problem itself,
and fixing the bug eliminates the retries too.

All cases were tested and found to work as expected. SET_DEQ_PENDING
was produced by patching uvcvideo to unlink URBs in 100us intervals,
which then runs into this case very often. EP_HALTED was produced by
restarting 'cat /dev/ttyUSB0' on a serial dongle with broken cable.
EP_CLEARING_TT by the same, with the dongle on an external hub.

Fixes: fd9d55d190c0 ("xhci: retry Stop Endpoint on buggy NEC controllers")
CC: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-34-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 13 +++++++++++++
 drivers/usb/host/xhci.c      | 19 +++++++++++++++----
 drivers/usb/host/xhci.h      |  1 +
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 729319d81753..0d628af5c3ba 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1092,6 +1092,19 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 	return 0;
 }
 
+/*
+ * Erase queued TDs from transfer ring(s) and give back those the xHC didn't
+ * stop on. If necessary, queue commands to move the xHC off cancelled TDs it
+ * stopped on. Those will be given back later when the commands complete.
+ *
+ * Call under xhci->lock on a stopped endpoint.
+ */
+void xhci_process_cancelled_tds(struct xhci_virt_ep *ep)
+{
+	xhci_invalidate_cancelled_tds(ep);
+	xhci_giveback_invalidated_tds(ep);
+}
+
 /*
  * Returns the TD the endpoint ring halted on.
  * Only call for non-running rings without streams.
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0b3688478ed3..70e6c240a540 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1738,10 +1738,21 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		}
 	}
 
-	/* Queue a stop endpoint command, but only if this is
-	 * the first cancellation to be handled.
-	 */
-	if (!(ep->ep_state & EP_STOP_CMD_PENDING)) {
+	/* These completion handlers will sort out cancelled TDs for us */
+	if (ep->ep_state & (EP_STOP_CMD_PENDING | EP_HALTED | SET_DEQ_PENDING)) {
+		xhci_dbg(xhci, "Not queuing Stop Endpoint on slot %d ep %d in state 0x%x\n",
+				urb->dev->slot_id, ep_index, ep->ep_state);
+		goto done;
+	}
+
+	/* In this case no commands are pending but the endpoint is stopped */
+	if (ep->ep_state & EP_CLEARING_TT) {
+		/* and cancelled TDs can be given back right away */
+		xhci_dbg(xhci, "Invalidating TDs instantly on slot %d ep %d in state 0x%x\n",
+				urb->dev->slot_id, ep_index, ep->ep_state);
+		xhci_process_cancelled_tds(ep);
+	} else {
+		/* Otherwise, queue a new Stop Endpoint command */
 		command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 		if (!command) {
 			ret = -ENOMEM;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index d89010ac5f8a..fddb3a90dae3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1952,6 +1952,7 @@ void xhci_ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
 void xhci_cleanup_command_queue(struct xhci_hcd *xhci);
 void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring);
 unsigned int count_trbs(u64 addr, u64 len);
+void xhci_process_cancelled_tds(struct xhci_virt_ep *ep);
 
 /* xHCI roothub code */
 void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,
-- 
2.39.5




