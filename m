Return-Path: <stable+bounces-103085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93729EF651
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AF41940B52
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D7223310;
	Thu, 12 Dec 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tJDS3CrH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA14223302;
	Thu, 12 Dec 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023499; cv=none; b=g15G9r1q/3nB39GYkRsN22nvCVj9CGzN0jkJk+mcx0dXYr1p6eXVoJXdNz8D0pyQanlx8ZCCL4/7n1ky0oEcjR4LEbjBNTTyxNON344Xjkw+dWTPPi7vEPA80vvudN1aM0O6WHR9jlfxozOuNQsgqR03WLKY4Qyn3inbPZ1SMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023499; c=relaxed/simple;
	bh=/WgmLsUgFmcs9OdwcW0Ym0X1kOKrNIu5LVPq9c7i37A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTt8BS8/GOhR7AtsuUt4+WbKGPx6SGqm4lrDiOsHbYQroxLB5ODkkHuYQv+7Z3FV9outPrJHT30NWO7faL28wSGhOMIP2L5TCK1dm7H8yT+3z3yb7Dcy2gmGxO7O+fqUFPoi+fGQttqqmhxPfAi2HA8ayOS20eDtI+rfGgBn5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tJDS3CrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ADDC4CED0;
	Thu, 12 Dec 2024 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023499;
	bh=/WgmLsUgFmcs9OdwcW0Ym0X1kOKrNIu5LVPq9c7i37A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJDS3CrHoj7MJlPFQnaxI/qfyvZHefXAeQiQCjLepwHFrj3K6ZbSeBcZAyJ+Zvb7K
	 pOsvlVWAbEBu2PK3bxrJn6WNoVfcyOcBaUIorUoqsLu1TJIICuldJhHn/PpckLYz9t
	 uNDvvxzFloay5GX8jB9oATimfoZMULOZC7b360+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.15 546/565] xhci: dbc: Fix STALL transfer event handling
Date: Thu, 12 Dec 2024 16:02:21 +0100
Message-ID: <20241212144333.438596095@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 9044ad57b60b0556d42b6f8aa218a68865e810a4 upstream.

Don't flush all pending DbC data requests when an endpoint halts.

An endpoint may halt and xHC DbC triggers a STALL error event if there's
an issue with a bulk data transfer. The transfer should restart once xHC
DbC receives a ClearFeature(ENDPOINT_HALT) request from the host.

Once xHC DbC restarts it will start from the TRB pointed to by dequeue
field in the endpoint context, which might be the same TRB we got the
STALL event for. Turn the TRB to a no-op in this case to make sure xHC
DbC doesn't reuse and tries to retransmit this same TRB after we already
handled it, and gave its corresponding data request back.

Other STALL events might be completely bogus.
Lukasz Bartosik discovered that xHC DbC might issue spurious STALL events
if hosts sends a ClearFeature(ENDPOINT_HALT) request to non-halted
endpoints even without any active bulk transfers.

Assume STALL event is spurious if it reports 0 bytes transferred, and
the endpoint stopped on the STALLED TRB.
Don't give back the data request corresponding to the TRB in this case.

The halted status is per endpoint. Track it with a per endpoint flag
instead of the driver invented DbC wide DS_STALLED state.
DbC remains in DbC-Configured state even if endpoints halt. There is no
Stalled state in the DbC Port state Machine (xhci section 7.6.6)

Reported-by: Łukasz Bartosik <ukaszb@chromium.org>
Closes: https://lore.kernel.org/linux-usb/20240725074857.623299-1-ukaszb@chromium.org/
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240905143300.1959279-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-dbgcap.c |  135 ++++++++++++++++++++++++-----------------
 drivers/usb/host/xhci-dbgcap.h |    2 
 2 files changed, 83 insertions(+), 54 deletions(-)

--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -158,16 +158,18 @@ static void xhci_dbc_giveback(struct dbc
 	spin_lock(&dbc->lock);
 }
 
-static void xhci_dbc_flush_single_request(struct dbc_request *req)
+static void trb_to_noop(union xhci_trb *trb)
 {
-	union xhci_trb	*trb = req->trb;
-
 	trb->generic.field[0]	= 0;
 	trb->generic.field[1]	= 0;
 	trb->generic.field[2]	= 0;
 	trb->generic.field[3]	&= cpu_to_le32(TRB_CYCLE);
 	trb->generic.field[3]	|= cpu_to_le32(TRB_TYPE(TRB_TR_NOOP));
+}
 
+static void xhci_dbc_flush_single_request(struct dbc_request *req)
+{
+	trb_to_noop(req->trb);
 	xhci_dbc_giveback(req, -ESHUTDOWN);
 }
 
@@ -637,7 +639,6 @@ static void xhci_dbc_stop(struct xhci_db
 	case DS_DISABLED:
 		return;
 	case DS_CONFIGURED:
-	case DS_STALLED:
 		if (dbc->driver->disconnect)
 			dbc->driver->disconnect(dbc);
 		break;
@@ -658,6 +659,23 @@ static void xhci_dbc_stop(struct xhci_db
 }
 
 static void
+handle_ep_halt_changes(struct xhci_dbc *dbc, struct dbc_ep *dep, bool halted)
+{
+	if (halted) {
+		dev_info(dbc->dev, "DbC Endpoint halted\n");
+		dep->halted = 1;
+
+	} else if (dep->halted) {
+		dev_info(dbc->dev, "DbC Endpoint halt cleared\n");
+		dep->halted = 0;
+
+		if (!list_empty(&dep->list_pending))
+			writel(DBC_DOOR_BELL_TARGET(dep->direction),
+			       &dbc->regs->doorbell);
+	}
+}
+
+static void
 dbc_handle_port_status(struct xhci_dbc *dbc, union xhci_trb *event)
 {
 	u32			portsc;
@@ -685,6 +703,7 @@ static void dbc_handle_xfer_event(struct
 	struct xhci_ring	*ring;
 	int			ep_id;
 	int			status;
+	struct xhci_ep_ctx	*ep_ctx;
 	u32			comp_code;
 	size_t			remain_length;
 	struct dbc_request	*req = NULL, *r;
@@ -694,8 +713,30 @@ static void dbc_handle_xfer_event(struct
 	ep_id		= TRB_TO_EP_ID(le32_to_cpu(event->generic.field[3]));
 	dep		= (ep_id == EPID_OUT) ?
 				get_out_ep(dbc) : get_in_ep(dbc);
+	ep_ctx		= (ep_id == EPID_OUT) ?
+				dbc_bulkout_ctx(dbc) : dbc_bulkin_ctx(dbc);
 	ring		= dep->ring;
 
+	/* Match the pending request: */
+	list_for_each_entry(r, &dep->list_pending, list_pending) {
+		if (r->trb_dma == event->trans_event.buffer) {
+			req = r;
+			break;
+		}
+		if (r->status == -COMP_STALL_ERROR) {
+			dev_warn(dbc->dev, "Give back stale stalled req\n");
+			ring->num_trbs_free++;
+			xhci_dbc_giveback(r, 0);
+		}
+	}
+
+	if (!req) {
+		dev_warn(dbc->dev, "no matched request\n");
+		return;
+	}
+
+	trace_xhci_dbc_handle_transfer(ring, &req->trb->generic);
+
 	switch (comp_code) {
 	case COMP_SUCCESS:
 		remain_length = 0;
@@ -706,31 +747,49 @@ static void dbc_handle_xfer_event(struct
 	case COMP_TRB_ERROR:
 	case COMP_BABBLE_DETECTED_ERROR:
 	case COMP_USB_TRANSACTION_ERROR:
-	case COMP_STALL_ERROR:
 		dev_warn(dbc->dev, "tx error %d detected\n", comp_code);
 		status = -comp_code;
 		break;
+	case COMP_STALL_ERROR:
+		dev_warn(dbc->dev, "Stall error at bulk TRB %llx, remaining %zu, ep deq %llx\n",
+			 event->trans_event.buffer, remain_length, ep_ctx->deq);
+		status = 0;
+		dep->halted = 1;
+
+		/*
+		 * xHC DbC may trigger a STALL bulk xfer event when host sends a
+		 * ClearFeature(ENDPOINT_HALT) request even if there wasn't an
+		 * active bulk transfer.
+		 *
+		 * Don't give back this transfer request as hardware will later
+		 * start processing TRBs starting from this 'STALLED' TRB,
+		 * causing TRBs and requests to be out of sync.
+		 *
+		 * If STALL event shows some bytes were transferred then assume
+		 * it's an actual transfer issue and give back the request.
+		 * In this case mark the TRB as No-Op to avoid hw from using the
+		 * TRB again.
+		 */
+
+		if ((ep_ctx->deq & ~TRB_CYCLE) == event->trans_event.buffer) {
+			dev_dbg(dbc->dev, "Ep stopped on Stalled TRB\n");
+			if (remain_length == req->length) {
+				dev_dbg(dbc->dev, "Spurious stall event, keep req\n");
+				req->status = -COMP_STALL_ERROR;
+				req->actual = 0;
+				return;
+			}
+			dev_dbg(dbc->dev, "Give back stalled req, but turn TRB to No-op\n");
+			trb_to_noop(req->trb);
+		}
+		break;
+
 	default:
 		dev_err(dbc->dev, "unknown tx error %d\n", comp_code);
 		status = -comp_code;
 		break;
 	}
 
-	/* Match the pending request: */
-	list_for_each_entry(r, &dep->list_pending, list_pending) {
-		if (r->trb_dma == event->trans_event.buffer) {
-			req = r;
-			break;
-		}
-	}
-
-	if (!req) {
-		dev_warn(dbc->dev, "no matched request\n");
-		return;
-	}
-
-	trace_xhci_dbc_handle_transfer(ring, &req->trb->generic);
-
 	ring->num_trbs_free++;
 	req->actual = req->length - remain_length;
 	xhci_dbc_giveback(req, status);
@@ -750,7 +809,6 @@ static void inc_evt_deq(struct xhci_ring
 static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 {
 	dma_addr_t		deq;
-	struct dbc_ep		*dep;
 	union xhci_trb		*evt;
 	u32			ctrl, portsc;
 	bool			update_erdp = false;
@@ -802,43 +860,17 @@ static enum evtreturn xhci_dbc_do_handle
 			return EVT_DISC;
 		}
 
-		/* Handle endpoint stall event: */
+		/* Check and handle changes in endpoint halt status */
 		ctrl = readl(&dbc->regs->control);
-		if ((ctrl & DBC_CTRL_HALT_IN_TR) ||
-		    (ctrl & DBC_CTRL_HALT_OUT_TR)) {
-			dev_info(dbc->dev, "DbC Endpoint stall\n");
-			dbc->state = DS_STALLED;
-
-			if (ctrl & DBC_CTRL_HALT_IN_TR) {
-				dep = get_in_ep(dbc);
-				xhci_dbc_flush_endpoint_requests(dep);
-			}
-
-			if (ctrl & DBC_CTRL_HALT_OUT_TR) {
-				dep = get_out_ep(dbc);
-				xhci_dbc_flush_endpoint_requests(dep);
-			}
-
-			return EVT_DONE;
-		}
+		handle_ep_halt_changes(dbc, get_in_ep(dbc), ctrl & DBC_CTRL_HALT_IN_TR);
+		handle_ep_halt_changes(dbc, get_out_ep(dbc), ctrl & DBC_CTRL_HALT_OUT_TR);
 
 		/* Clear DbC run change bit: */
 		if (ctrl & DBC_CTRL_DBC_RUN_CHANGE) {
 			writel(ctrl, &dbc->regs->control);
 			ctrl = readl(&dbc->regs->control);
 		}
-
 		break;
-	case DS_STALLED:
-		ctrl = readl(&dbc->regs->control);
-		if (!(ctrl & DBC_CTRL_HALT_IN_TR) &&
-		    !(ctrl & DBC_CTRL_HALT_OUT_TR) &&
-		    (ctrl & DBC_CTRL_DBC_RUN)) {
-			dbc->state = DS_CONFIGURED;
-			break;
-		}
-
-		return EVT_DONE;
 	default:
 		dev_err(dbc->dev, "Unknown DbC state %d\n", dbc->state);
 		break;
@@ -941,9 +973,6 @@ static ssize_t dbc_show(struct device *d
 	case DS_CONFIGURED:
 		p = "configured";
 		break;
-	case DS_STALLED:
-		p = "stalled";
-		break;
 	default:
 		p = "unknown";
 	}
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -81,7 +81,6 @@ enum dbc_state {
 	DS_ENABLED,
 	DS_CONNECTED,
 	DS_CONFIGURED,
-	DS_STALLED,
 };
 
 struct dbc_ep {
@@ -89,6 +88,7 @@ struct dbc_ep {
 	struct list_head		list_pending;
 	struct xhci_ring		*ring;
 	unsigned int			direction:1;
+	unsigned int			halted:1;
 };
 
 #define DBC_QUEUE_SIZE			16



