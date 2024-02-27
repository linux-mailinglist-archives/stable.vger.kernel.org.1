Return-Path: <stable+bounces-24791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81F8869648
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E215293911
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1BE13DBB3;
	Tue, 27 Feb 2024 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OMyjhJ0M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847C13A26F;
	Tue, 27 Feb 2024 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043000; cv=none; b=TsGSLdTMP4mryKX3M+qWWVDYYy1BL0w51oDUdgPRRoZzXu7CG+MEKX4NyTRoeLdhOGWBuyv/VDAdLcaj5dmjZaU2M7NS5uE2Qk1lH6ahdzTMFVOWnzM/LNLZza/pDFCTakVj+EvOXluZ8tgpiZZitb1S0DJ3zHylrZedCQpdV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043000; c=relaxed/simple;
	bh=v5CMJk074hO/HwWaK48TYemJof7UCtfn83aRAEEKPEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2kMSsrfZIJpBAO7nagfNAlJgYr3OGOUloJ50HAdR7xm/cK/PeQuoZ+khRet7oogr2ADMKRUN+vZNMt1IVHebxWp3gUtGVLKL/b20N1fb998La+fsZLLXj5J6VMhZhJh58EQlUam4rDVVUcIJiOIntBl7TWIixw/01p9JiTEvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OMyjhJ0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26E4C433C7;
	Tue, 27 Feb 2024 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043000;
	bh=v5CMJk074hO/HwWaK48TYemJof7UCtfn83aRAEEKPEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMyjhJ0MI62NWqTKZ9jqI8pWcy13+3Se6d8HU6t2B1c3dysnnK2/cryxKcrMlILqM
	 NnB0l0JZU5yUlpadelC/rIzMTgrQgLoOo2gQUJAmUx3sBjNbqeTdfyKJoJKug68oOl
	 MQxgfpy34E5PFURs7CBJSjmQEHLcvX2CPGyihKUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 198/245] xhci: decouple usb2 port resume and get_port_status request handling
Date: Tue, 27 Feb 2024 14:26:26 +0100
Message-ID: <20240227131621.627828937@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
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

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit b0425784b942fffbbdb804896197f1dbccda37c5 ]

The get port status hub request code in xhci-hub.c will complete usb2
port resume signalling if signalling has been going on for long enough.

The code that completes the resume signalling, and the code that returns
the port status have gotten too intertwined, so separate them a bit.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230202150505.618915-12-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: d7cdfc319b2b ("xhci: track port suspend state correctly in unsuccessful resume cases")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 47 ++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 660a7d0f79a42..56c600be272a6 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -905,7 +905,7 @@ static void xhci_del_comp_mod_timer(struct xhci_hcd *xhci, u32 status,
 }
 
 static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
-					     u32 *status, u32 portsc,
+					     u32 portsc,
 					     unsigned long *flags)
 {
 	struct xhci_bus_state *bus_state;
@@ -920,7 +920,6 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 	wIndex = port->hcd_portnum;
 
 	if ((portsc & PORT_RESET) || !(portsc & PORT_PE)) {
-		*status = 0xffffffff;
 		return -EINVAL;
 	}
 	/* did port event handler already start resume timing? */
@@ -954,6 +953,8 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 
 		port->resume_timestamp = 0;
 		clear_bit(wIndex, &bus_state->resuming_ports);
+
+		reinit_completion(&port->rexit_done);
 		port->rexit_active = true;
 
 		xhci_test_and_clear_bit(xhci, port, PORT_PLC);
@@ -970,7 +971,6 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 							    wIndex + 1);
 			if (!slot_id) {
 				xhci_dbg(xhci, "slot_id is zero\n");
-				*status = 0xffffffff;
 				return -ENODEV;
 			}
 			xhci_ring_device(xhci, slot_id);
@@ -979,22 +979,19 @@ static int xhci_handle_usb2_port_link_resume(struct xhci_port *port,
 
 			xhci_warn(xhci, "Port resume timed out, port %d-%d: 0x%x\n",
 				  hcd->self.busnum, wIndex + 1, port_status);
-			*status |= USB_PORT_STAT_SUSPEND;
-			port->rexit_active = false;
+			/*
+			 * keep rexit_active set if U0 transition failed so we
+			 * know to report PORT_STAT_SUSPEND status back to
+			 * usbcore. It will be cleared later once the port is
+			 * out of RESUME/U3 state
+			 */
 		}
 
 		usb_hcd_end_port_resume(&hcd->self, wIndex);
 		bus_state->port_c_suspend |= 1 << wIndex;
 		bus_state->suspended_ports &= ~(1 << wIndex);
-	} else {
-		/*
-		 * The resume has been signaling for less than
-		 * USB_RESUME_TIME. Report the port status as SUSPEND,
-		 * let the usbcore check port status again and clear
-		 * resume signaling later.
-		 */
-		*status |= USB_PORT_STAT_SUSPEND;
 	}
+
 	return 0;
 }
 
@@ -1071,6 +1068,7 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 	struct xhci_bus_state *bus_state;
 	u32 link_state;
 	u32 portnum;
+	int err;
 
 	bus_state = &port->rhub->bus_state;
 	link_state = portsc & PORT_PLS_MASK;
@@ -1092,8 +1090,12 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 			}
 		}
 		if (link_state == XDEV_RESUME) {
-			xhci_handle_usb2_port_link_resume(port, status, portsc,
-							  flags);
+			err = xhci_handle_usb2_port_link_resume(port, portsc,
+								flags);
+			if (err < 0)
+				*status = 0xffffffff;
+			else if (port->resume_timestamp || port->rexit_active)
+				*status |= USB_PORT_STAT_SUSPEND;
 		}
 	}
 
@@ -1102,13 +1104,14 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 	 * or resuming. Port either resumed to U0/U1/U2, disconnected, or in a
 	 * error state. Resume related variables should be cleared in all those cases.
 	 */
-	if ((link_state != XDEV_U3 &&
-	     link_state != XDEV_RESUME) &&
-	    (port->resume_timestamp ||
-	     test_bit(portnum, &bus_state->resuming_ports))) {
-		port->resume_timestamp = 0;
-		clear_bit(portnum, &bus_state->resuming_ports);
-		usb_hcd_end_port_resume(&port->rhub->hcd->self, portnum);
+	if (link_state != XDEV_U3 && link_state != XDEV_RESUME) {
+		if (port->resume_timestamp ||
+		    test_bit(portnum, &bus_state->resuming_ports)) {
+			port->resume_timestamp = 0;
+			clear_bit(portnum, &bus_state->resuming_ports);
+			usb_hcd_end_port_resume(&port->rhub->hcd->self, portnum);
+		}
+		port->rexit_active = 0;
 	}
 }
 
-- 
2.43.0




