Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CDF7D3571
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjJWLsX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjJWLsW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:48:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C7AFD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:48:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD14BC433C8;
        Mon, 23 Oct 2023 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061699;
        bh=Cd5eNCygJW5AoRSbz9/nZWRGlSnbL9T3xfkhKy6aqKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kc/bDVbeopkoMCyKGRFvHfC/RB+ZF5ZwD8GmkDCVXex57TMGkmln7fzOkKsUBw1E7
         e+qlspS3RD1A3yKf5gO+wBRRuPT1WhEdBTFsOF1Lhlw9qOMv9WYHkgIUtmeRFfgTrZ
         Cu43Tk2vvIZLeJM4hkDmjaywBGioO9DRHyuPaGwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 135/202] xhci: cleanup xhci_hub_control port references
Date:   Mon, 23 Oct 2023 12:57:22 +0200
Message-ID: <20231023104830.479558881@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit faaae0190dcd1e230616c85bbc3b339f27ba5b81 ]

Both port number and port structure of a port are referred to several
times when handing hub requests in xhci.

Use more suitable data types and readable names for these.
Cleanup only, no functional changes

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230202150505.618915-6-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: d7cdfc319b2b ("xhci: track port suspend state correctly in unsuccessful resume cases")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 123 ++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 7bb3067418076..c2a8d455eeace 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1108,11 +1108,14 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	u16 test_mode = 0;
 	struct xhci_hub *rhub;
 	struct xhci_port **ports;
+	struct xhci_port *port;
+	int portnum1;
 
 	rhub = xhci_get_rhub(hcd);
 	ports = rhub->ports;
 	max_ports = rhub->num_ports;
 	bus_state = &rhub->bus_state;
+	portnum1 = wIndex & 0xff;
 
 	spin_lock_irqsave(&xhci->lock, flags);
 	switch (typeReq) {
@@ -1146,10 +1149,12 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		spin_unlock_irqrestore(&xhci->lock, flags);
 		return retval;
 	case GetPortStatus:
-		if (!wIndex || wIndex > max_ports)
+		if (!portnum1 || portnum1 > max_ports)
 			goto error;
+
 		wIndex--;
-		temp = readl(ports[wIndex]->addr);
+		port = ports[portnum1 - 1];
+		temp = readl(port->addr);
 		if (temp == ~(u32)0) {
 			xhci_hc_died(xhci);
 			retval = -ENODEV;
@@ -1162,7 +1167,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			goto error;
 
 		xhci_dbg(xhci, "Get port status %d-%d read: 0x%x, return 0x%x",
-			 hcd->self.busnum, wIndex + 1, temp, status);
+			 hcd->self.busnum, portnum1, temp, status);
 
 		put_unaligned(cpu_to_le32(status), (__le32 *) buf);
 		/* if USB 3.1 extended port status return additional 4 bytes */
@@ -1174,7 +1179,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				retval = -EINVAL;
 				break;
 			}
-			port_li = readl(ports[wIndex]->addr + PORTLI);
+			port_li = readl(port->addr + PORTLI);
 			status = xhci_get_ext_port_status(temp, port_li);
 			put_unaligned_le32(status, &buf[4]);
 		}
@@ -1188,11 +1193,14 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			test_mode = (wIndex & 0xff00) >> 8;
 		/* The MSB of wIndex is the U1/U2 timeout */
 		timeout = (wIndex & 0xff00) >> 8;
+
 		wIndex &= 0xff;
-		if (!wIndex || wIndex > max_ports)
+		if (!portnum1 || portnum1 > max_ports)
 			goto error;
+
+		port = ports[portnum1 - 1];
 		wIndex--;
-		temp = readl(ports[wIndex]->addr);
+		temp = readl(port->addr);
 		if (temp == ~(u32)0) {
 			xhci_hc_died(xhci);
 			retval = -ENODEV;
@@ -1202,11 +1210,10 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		/* FIXME: What new port features do we need to support? */
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			if ((temp & PORT_PLS_MASK) != XDEV_U0) {
 				/* Resume the port to U0 first */
-				xhci_set_link_state(xhci, ports[wIndex],
-							XDEV_U0);
+				xhci_set_link_state(xhci, port, XDEV_U0);
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				msleep(10);
 				spin_lock_irqsave(&xhci->lock, flags);
@@ -1215,16 +1222,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			 * a port unless the port reports that it is in the
 			 * enabled (PED = ‘1’,PLS < ‘3’) state.
 			 */
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			if ((temp & PORT_PE) == 0 || (temp & PORT_RESET)
 				|| (temp & PORT_PLS_MASK) >= XDEV_U3) {
 				xhci_warn(xhci, "USB core suspending port %d-%d not in U0/U1/U2\n",
-					  hcd->self.busnum, wIndex + 1);
+					  hcd->self.busnum, portnum1);
 				goto error;
 			}
 
 			slot_id = xhci_find_slot_id_by_port(hcd, xhci,
-					wIndex + 1);
+							    portnum1);
 			if (!slot_id) {
 				xhci_warn(xhci, "slot_id is zero\n");
 				goto error;
@@ -1234,21 +1241,21 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			xhci_stop_device(xhci, slot_id, 1);
 			spin_lock_irqsave(&xhci->lock, flags);
 
-			xhci_set_link_state(xhci, ports[wIndex], XDEV_U3);
+			xhci_set_link_state(xhci, port, XDEV_U3);
 
 			spin_unlock_irqrestore(&xhci->lock, flags);
 			msleep(10); /* wait device to enter */
 			spin_lock_irqsave(&xhci->lock, flags);
 
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			bus_state->suspended_ports |= 1 << wIndex;
 			break;
 		case USB_PORT_FEAT_LINK_STATE:
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			/* Disable port */
 			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
 				xhci_dbg(xhci, "Disable port %d-%d\n",
-					 hcd->self.busnum, wIndex + 1);
+					 hcd->self.busnum, portnum1);
 				temp = xhci_port_state_to_neutral(temp);
 				/*
 				 * Clear all change bits, so that we get a new
@@ -1257,18 +1264,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				temp |= PORT_CSC | PORT_PEC | PORT_WRC |
 					PORT_OCC | PORT_RC | PORT_PLC |
 					PORT_CEC;
-				writel(temp | PORT_PE, ports[wIndex]->addr);
-				temp = readl(ports[wIndex]->addr);
+				writel(temp | PORT_PE, port->addr);
+				temp = readl(port->addr);
 				break;
 			}
 
 			/* Put link in RxDetect (enable port) */
 			if (link_state == USB_SS_PORT_LS_RX_DETECT) {
 				xhci_dbg(xhci, "Enable port %d-%d\n",
-					 hcd->self.busnum, wIndex + 1);
-				xhci_set_link_state(xhci, ports[wIndex],
-							link_state);
-				temp = readl(ports[wIndex]->addr);
+					 hcd->self.busnum, portnum1);
+				xhci_set_link_state(xhci, port,	link_state);
+				temp = readl(port->addr);
 				break;
 			}
 
@@ -1298,11 +1304,10 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				}
 
 				xhci_dbg(xhci, "Enable compliance mode transition for port %d-%d\n",
-					 hcd->self.busnum, wIndex + 1);
-				xhci_set_link_state(xhci, ports[wIndex],
-						link_state);
+					 hcd->self.busnum, portnum1);
+				xhci_set_link_state(xhci, port, link_state);
 
-				temp = readl(ports[wIndex]->addr);
+				temp = readl(port->addr);
 				break;
 			}
 			/* Port must be enabled */
@@ -1313,8 +1318,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			/* Can't set port link state above '3' (U3) */
 			if (link_state > USB_SS_PORT_LS_U3) {
 				xhci_warn(xhci, "Cannot set port %d-%d link state %d\n",
-					  hcd->self.busnum, wIndex + 1,
-					  link_state);
+					  hcd->self.busnum, portnum1, link_state);
 				goto error;
 			}
 
@@ -1339,8 +1343,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					reinit_completion(&bus_state->u3exit_done[wIndex]);
 				}
 				if (pls <= XDEV_U3) /* U1, U2, U3 */
-					xhci_set_link_state(xhci, ports[wIndex],
-							    USB_SS_PORT_LS_U0);
+					xhci_set_link_state(xhci, port, USB_SS_PORT_LS_U0);
 				if (!wait_u0) {
 					if (pls > XDEV_U3)
 						goto error;
@@ -1350,16 +1353,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				if (!wait_for_completion_timeout(&bus_state->u3exit_done[wIndex],
 								 msecs_to_jiffies(500)))
 					xhci_dbg(xhci, "missing U0 port change event for port %d-%d\n",
-						 hcd->self.busnum, wIndex + 1);
+						 hcd->self.busnum, portnum1);
 				spin_lock_irqsave(&xhci->lock, flags);
-				temp = readl(ports[wIndex]->addr);
+				temp = readl(port->addr);
 				break;
 			}
 
 			if (link_state == USB_SS_PORT_LS_U3) {
 				int retries = 16;
 				slot_id = xhci_find_slot_id_by_port(hcd, xhci,
-						wIndex + 1);
+								    portnum1);
 				if (slot_id) {
 					/* unlock to execute stop endpoint
 					 * commands */
@@ -1368,16 +1371,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					xhci_stop_device(xhci, slot_id, 1);
 					spin_lock_irqsave(&xhci->lock, flags);
 				}
-				xhci_set_link_state(xhci, ports[wIndex], USB_SS_PORT_LS_U3);
+				xhci_set_link_state(xhci, port, USB_SS_PORT_LS_U3);
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				while (retries--) {
 					usleep_range(4000, 8000);
-					temp = readl(ports[wIndex]->addr);
+					temp = readl(port->addr);
 					if ((temp & PORT_PLS_MASK) == XDEV_U3)
 						break;
 				}
 				spin_lock_irqsave(&xhci->lock, flags);
-				temp = readl(ports[wIndex]->addr);
+				temp = readl(port->addr);
 				bus_state->suspended_ports |= 1 << wIndex;
 			}
 			break;
@@ -1392,39 +1395,38 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			break;
 		case USB_PORT_FEAT_RESET:
 			temp = (temp | PORT_RESET);
-			writel(temp, ports[wIndex]->addr);
+			writel(temp, port->addr);
 
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			xhci_dbg(xhci, "set port reset, actual port %d-%d status  = 0x%x\n",
-				 hcd->self.busnum, wIndex + 1, temp);
+				 hcd->self.busnum, portnum1, temp);
 			break;
 		case USB_PORT_FEAT_REMOTE_WAKE_MASK:
-			xhci_set_remote_wake_mask(xhci, ports[wIndex],
-						  wake_mask);
-			temp = readl(ports[wIndex]->addr);
+			xhci_set_remote_wake_mask(xhci, port, wake_mask);
+			temp = readl(port->addr);
 			xhci_dbg(xhci, "set port remote wake mask, actual port %d-%d status  = 0x%x\n",
-				 hcd->self.busnum, wIndex + 1, temp);
+				 hcd->self.busnum, portnum1, temp);
 			break;
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			temp |= PORT_WR;
-			writel(temp, ports[wIndex]->addr);
-			temp = readl(ports[wIndex]->addr);
+			writel(temp, port->addr);
+			temp = readl(port->addr);
 			break;
 		case USB_PORT_FEAT_U1_TIMEOUT:
 			if (hcd->speed < HCD_USB3)
 				goto error;
-			temp = readl(ports[wIndex]->addr + PORTPMSC);
+			temp = readl(port->addr + PORTPMSC);
 			temp &= ~PORT_U1_TIMEOUT_MASK;
 			temp |= PORT_U1_TIMEOUT(timeout);
-			writel(temp, ports[wIndex]->addr + PORTPMSC);
+			writel(temp, port->addr + PORTPMSC);
 			break;
 		case USB_PORT_FEAT_U2_TIMEOUT:
 			if (hcd->speed < HCD_USB3)
 				goto error;
-			temp = readl(ports[wIndex]->addr + PORTPMSC);
+			temp = readl(port->addr + PORTPMSC);
 			temp &= ~PORT_U2_TIMEOUT_MASK;
 			temp |= PORT_U2_TIMEOUT(timeout);
-			writel(temp, ports[wIndex]->addr + PORTPMSC);
+			writel(temp, port->addr + PORTPMSC);
 			break;
 		case USB_PORT_FEAT_TEST:
 			/* 4.19.6 Port Test Modes (USB2 Test Mode) */
@@ -1440,13 +1442,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			goto error;
 		}
 		/* unblock any posted writes */
-		temp = readl(ports[wIndex]->addr);
+		temp = readl(port->addr);
 		break;
 	case ClearPortFeature:
-		if (!wIndex || wIndex > max_ports)
+		if (!portnum1 || portnum1 > max_ports)
 			goto error;
+
+		port = ports[portnum1 - 1];
+
 		wIndex--;
-		temp = readl(ports[wIndex]->addr);
+		temp = readl(port->addr);
 		if (temp == ~(u32)0) {
 			xhci_hc_died(xhci);
 			retval = -ENODEV;
@@ -1456,7 +1461,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = xhci_port_state_to_neutral(temp);
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			temp = readl(ports[wIndex]->addr);
+			temp = readl(port->addr);
 			xhci_dbg(xhci, "clear USB_PORT_FEAT_SUSPEND\n");
 			xhci_dbg(xhci, "PORTSC %04x\n", temp);
 			if (temp & PORT_RESET)
@@ -1467,20 +1472,18 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 				set_bit(wIndex, &bus_state->resuming_ports);
 				usb_hcd_start_port_resume(&hcd->self, wIndex);
-				xhci_set_link_state(xhci, ports[wIndex],
-						    XDEV_RESUME);
+				xhci_set_link_state(xhci, port, XDEV_RESUME);
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				msleep(USB_RESUME_TIMEOUT);
 				spin_lock_irqsave(&xhci->lock, flags);
-				xhci_set_link_state(xhci, ports[wIndex],
-							XDEV_U0);
+				xhci_set_link_state(xhci, port, XDEV_U0);
 				clear_bit(wIndex, &bus_state->resuming_ports);
 				usb_hcd_end_port_resume(&hcd->self, wIndex);
 			}
 			bus_state->port_c_suspend |= 1 << wIndex;
 
 			slot_id = xhci_find_slot_id_by_port(hcd, xhci,
-					wIndex + 1);
+					portnum1);
 			if (!slot_id) {
 				xhci_dbg(xhci, "slot_id is zero\n");
 				goto error;
@@ -1498,11 +1501,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_C_PORT_LINK_STATE:
 		case USB_PORT_FEAT_C_PORT_CONFIG_ERROR:
 			xhci_clear_port_change_bit(xhci, wValue, wIndex,
-					ports[wIndex]->addr, temp);
+					port->addr, temp);
 			break;
 		case USB_PORT_FEAT_ENABLE:
 			xhci_disable_port(hcd, xhci, wIndex,
-					ports[wIndex]->addr, temp);
+					port->addr, temp);
 			break;
 		case USB_PORT_FEAT_POWER:
 			xhci_set_port_power(xhci, hcd, wIndex, false, &flags);
-- 
2.40.1



