Return-Path: <stable+bounces-100393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593EC9EAD8C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EF8188D6E4
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685E123DEA5;
	Tue, 10 Dec 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NS9x+ot1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622E23DEA7
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824947; cv=none; b=ABS5v6VjqIK8yOl4CD+2GtGHzfVV+MS7lW+NEzBTG7CsHj4Zqf2mAvMangMCaRdPkhAvS8DP7vA0eheJGYhb+D7Zyy0rVvuS6Y1ePxWCLaM0ctkuumr7LS5CvP+Hhu4HMWd6suxry56fETOTQVUeuq60edqlGKiWGMQPG3eqxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824947; c=relaxed/simple;
	bh=finQZwOQ1FncqnID3l2DeuXWmOL2OycJDvy4ccAB0JI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c5cagrInYrVjRY1c2nNss6Hzj6XtDVfyS/ywXV1umVe0qcPNRpIQyXU1VvgosY9BIwBqn1vlXTS+1vhwpQJxJjgLXjvTkP730RJHZys/qReQtofJPYSr3dEmok1ZXkGQ1Hyq5/1jjYbFn8futFC2s4tyefRYJTQjj8N0wo+lJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NS9x+ot1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733824945; x=1765360945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=finQZwOQ1FncqnID3l2DeuXWmOL2OycJDvy4ccAB0JI=;
  b=NS9x+ot1po34g50QAJmdO6dsBVC6MvWnTJkQL9icei23qE4dF3YHBcjb
   NoL0iHS1flUa8DMvwOvPCr3Y+i4W7fI/moi3TbWp9CNJYY1EU9uXVzcb+
   hvFbrNn19M0sFaIw5Utqg0lOSZPrP4c0Q/g80c+9ldIj6VeEguMQL15Rg
   ka6gXqwV9qIo1m/0E5LWEJ85kMiUtcxO9iYTCFZg4r0ha3RnKnKhCmNhs
   ERjgYCxD8CwkTYYWp/pZnCvBrrH4l5q/jhRCzpijLkTk5Du8jD92Ly8fT
   Y8zRExmPmr5/djfwAetKPFX3H9UElB49YUIbZQ1bjTEqWS4HXi0PzeWM3
   A==;
X-CSE-ConnectionGUID: BGSLYwdnRhm+m1efT/3NFA==
X-CSE-MsgGUID: wIWinyfNRf2T8kJ18IXHgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="56640817"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="56640817"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 02:02:25 -0800
X-CSE-ConnectionGUID: Xo75gImjQ8OGbNWuFDg3Hg==
X-CSE-MsgGUID: gJ3+YzP3T2apZ/kMjalJFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100397876"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orviesa003.jf.intel.com with ESMTP; 10 Dec 2024 02:02:23 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: stable@vger.kernel.org
Cc: hadrosaur@google.com,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
Subject: [PATCH v2] xhci: dbc: Fix STALL transfer event handling
Date: Tue, 10 Dec 2024 12:04:40 +0200
Message-Id: <20241210100440.3449803-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 9044ad57b60b0556d42b6f8aa218a68865e810a4 upstream
Backport targeted specifically for linux-6.6.y stable kernel.
Resolve minor conflict due to 10-patch dbc cleanup series in 6.8

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
---
v2: Remove DS_STALLED case when showing dbc status in sysfs.
    Re-tested by Lukasz on 6.6 stable kernel.

 drivers/usb/host/xhci-dbgcap.c | 135 ++++++++++++++++++++-------------
 drivers/usb/host/xhci-dbgcap.h |   2 +-
 2 files changed, 83 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index b40d9238d447..fab9e6be4e27 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -158,16 +158,18 @@ static void xhci_dbc_giveback(struct dbc_request *req, int status)
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
 
@@ -637,7 +639,6 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
 	case DS_DISABLED:
 		return;
 	case DS_CONFIGURED:
-	case DS_STALLED:
 		if (dbc->driver->disconnect)
 			dbc->driver->disconnect(dbc);
 		break;
@@ -657,6 +658,23 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
 	}
 }
 
+static void
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
 static void
 dbc_handle_port_status(struct xhci_dbc *dbc, union xhci_trb *event)
 {
@@ -685,6 +703,7 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
 	struct xhci_ring	*ring;
 	int			ep_id;
 	int			status;
+	struct xhci_ep_ctx	*ep_ctx;
 	u32			comp_code;
 	size_t			remain_length;
 	struct dbc_request	*req = NULL, *r;
@@ -694,8 +713,30 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
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
@@ -706,31 +747,49 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
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
@@ -750,7 +809,6 @@ static void inc_evt_deq(struct xhci_ring *ring)
 static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 {
 	dma_addr_t		deq;
-	struct dbc_ep		*dep;
 	union xhci_trb		*evt;
 	u32			ctrl, portsc;
 	bool			update_erdp = false;
@@ -802,43 +860,17 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
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
@@ -941,9 +973,6 @@ static ssize_t dbc_show(struct device *dev,
 	case DS_CONFIGURED:
 		p = "configured";
 		break;
-	case DS_STALLED:
-		p = "stalled";
-		break;
 	default:
 		p = "unknown";
 	}
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 76170d7a7e7c..2de0dc49a3e9 100644
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
-- 
2.25.1


