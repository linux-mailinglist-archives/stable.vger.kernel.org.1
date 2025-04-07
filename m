Return-Path: <stable+bounces-128611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42855A7E9CF
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045E217E6A7
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F82561D0;
	Mon,  7 Apr 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp06p4jN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FB2561C0;
	Mon,  7 Apr 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049492; cv=none; b=dlIERHvZHs2wK6UjkLwPqZoSXq3/hi2VhTGaLCT4f9hVG8igh8ntQQ6RIwoLKwTFe2D3yKEgSAXUJGyYVF1EEOUdSpB18hXQceugpx353UX6IwtfNdX0B9OmLQ+FfW7RdLAqnzStamORaxVw7IsE+BKQkeq6uat3qi4FzqOzYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049492; c=relaxed/simple;
	bh=KV5fVkL6r8uDgaIwysP/7dNjx9CnZ3dEMHo3Wz0WUoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a1g1qSKLLPsu6XlHOtwDOVN6CqePz7MiIXZysEZj6yZ7SVDw85xPG9nU9qVULIvRxU4jbu6PhEXQiPk5APNdXf+h0phgxYTsVSR1Af9s6Kqr9ot/DDPU6sw1O3+0FNeJXZC4hUh4k9u7sXscuU7Sz4z0H5Xdc/00xFxNmmHC4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp06p4jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8237FC4CEEA;
	Mon,  7 Apr 2025 18:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049492;
	bh=KV5fVkL6r8uDgaIwysP/7dNjx9CnZ3dEMHo3Wz0WUoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kp06p4jNvXgMgDrig/Hf/T3eaf+l9OQCQxKrrSxTp+++OjwXWgPwLli708rF6ZHXU
	 aanp6bX5L2PGVChlbVPiN4+JYYuWTq3P+rJX9EIIaO7ZuaHUH907rDFrtdy4XGG+WF
	 4NsOeLU5YUGtq69QCcyn75AZwQ8CQNnMxSaQan8V37U6GWHggfUSijROU8VNR9q7I0
	 /2OwBxYmvSYpJYCc6rsxRFQeysFiRR9K6zFKpNLzyRvigjpVuR8wfshSFkjYy3PXNm
	 IpWznSnTxYUWFa5DlZfPvypYxGZkzLPG2aBHgZR3Z79ScDGQZfRw4bHThbzQ3b9Xmx
	 jEoIhx7E/9TBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 14/31] usb: xhci: Fix isochronous Ring Underrun/Overrun event handling
Date: Mon,  7 Apr 2025 14:10:30 -0400
Message-Id: <20250407181054.3177479-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 906dec15b9b321b546fd31a3c99ffc13724c7af4 ]

The TRB pointer of these events points at enqueue at the time of error
occurrence on xHCI 1.1+ HCs or it's NULL on older ones. By the time we
are handling the event, a new TD may be queued at this ring position.

I can trigger this race by rising interrupt moderation to increase IRQ
handling delay. Similar delay may occur naturally due to system load.

If this ever happens after a Missed Service Error, missed TDs will be
skipped and the new TD processed as if it matched the event. It could
be given back prematurely, risking data loss or buffer UAF by the xHC.

Don't complete TDs on xrun events and don't warn if queued TDs don't
match the event's TRB pointer, which can be NULL or a link/no-op TRB.
Don't warn if there are no queued TDs at all.

Now that it's safe, also handle xrun events if the skip flag is clear.
This ensures completion of any TD stuck in 'error mid TD' state right
before the xrun event, which could happen if a driver submits a finite
number of URBs to a buggy HC and then an error occurs on the last TD.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250306144954.3507700-6-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index af6c4c4cbe1cc..26d95d3c80b0a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2664,6 +2664,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	int status = -EINPROGRESS;
 	struct xhci_ep_ctx *ep_ctx;
 	u32 trb_comp_code;
+	bool ring_xrun_event = false;
 
 	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
 	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
@@ -2770,14 +2771,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 * Underrun Event for OUT Isoch endpoint.
 		 */
 		xhci_dbg(xhci, "Underrun event on slot %u ep %u\n", slot_id, ep_index);
-		if (ep->skip)
-			break;
-		return 0;
+		ring_xrun_event = true;
+		break;
 	case COMP_RING_OVERRUN:
 		xhci_dbg(xhci, "Overrun event on slot %u ep %u\n", slot_id, ep_index);
-		if (ep->skip)
-			break;
-		return 0;
+		ring_xrun_event = true;
+		break;
 	case COMP_MISSED_SERVICE_ERROR:
 		/*
 		 * When encounter missed service error, one or more isoc tds
@@ -2850,6 +2849,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 */
 		if (trb_comp_code != COMP_STOPPED &&
 		    trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
+		    !ring_xrun_event &&
 		    !ep_ring->last_td_was_short) {
 			xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
 				  slot_id, ep_index);
@@ -2880,6 +2880,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 				goto check_endpoint_halted;
 			}
 
+			/* TD was queued after xrun, maybe xrun was on a link, don't panic yet */
+			if (ring_xrun_event)
+				return 0;
+
 			/*
 			 * Skip the Force Stopped Event. The 'ep_trb' of FSE is not in the current
 			 * TD pointed by 'ep_ring->dequeue' because that the hardware dequeue
@@ -2926,6 +2930,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 */
 	} while (ep->skip);
 
+	/* Get out if a TD was queued at enqueue after the xrun occurred */
+	if (ring_xrun_event)
+		return 0;
+
 	if (trb_comp_code == COMP_SHORT_PACKET)
 		ep_ring->last_td_was_short = true;
 	else
-- 
2.39.5


