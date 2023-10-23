Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39967D3574
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjJWLsb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjJWLsa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:48:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47125E9
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:48:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850E2C433C7;
        Mon, 23 Oct 2023 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061707;
        bh=mLum3hX3Km0G/ygA/G+OH6CRIM+rqnFlgiFjf5l8kAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPBrAgUPy4x5hQx3rBr2D+8IQ59Eu80Eh81txd0ZzUs9lS3r5sJwTZQo/FdfzZgF5
         6STJSohPzrTOd9uYq7U85u6oTunJPAyD0G+DCIqfVJdyAEi6IhJ0dFNdY9QiDbLGwj
         uOt5Cb6R7EJFdNpyS1lWrJQIxmzbcy8jxpvWA1b8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 138/202] xhci: clear usb2 resume related variables in one place.
Date:   Mon, 23 Oct 2023 12:57:25 +0200
Message-ID: <20231023104830.576173687@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

[ Upstream commit 0e6275452ce26d7ff274a5c1b15ed581a26f7986 ]

Initially resume related USB2 variables were cleared once port
successfully resumed to U0. Later code was added to clean up
stale resume variables in case of port failed to resume to U0.

Clear the variables in one place after port is no longer resuming
or in suspended U3 state.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230202150505.618915-11-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: d7cdfc319b2b ("xhci: track port suspend state correctly in unsuccessful resume cases")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 38 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 39c58b1782d5c..0aac8fcd37798 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -985,7 +985,6 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 	struct xhci_bus_state *bus_state;
 	u32 link_state;
 	u32 portnum;
-	int ret;
 
 	bus_state = &port->rhub->bus_state;
 	link_state = portsc & PORT_PLS_MASK;
@@ -1001,23 +1000,30 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
 		if (link_state == XDEV_U2)
 			*status |= USB_PORT_STAT_L1;
 		if (link_state == XDEV_U0) {
-			if (port->resume_timestamp)
-				usb_hcd_end_port_resume(&port->rhub->hcd->self,
-							portnum);
-			port->resume_timestamp = 0;
-			clear_bit(portnum, &bus_state->resuming_ports);
 			if (bus_state->suspended_ports & (1 << portnum)) {
 				bus_state->suspended_ports &= ~(1 << portnum);
 				bus_state->port_c_suspend |= 1 << portnum;
 			}
 		}
 		if (link_state == XDEV_RESUME) {
-			ret = xhci_handle_usb2_port_link_resume(port, status,
-								portsc, flags);
-			if (ret)
-				return;
+			xhci_handle_usb2_port_link_resume(port, status, portsc,
+							  flags);
 		}
 	}
+
+	/*
+	 * Clear usb2 resume signalling variables if port is no longer suspended
+	 * or resuming. Port either resumed to U0/U1/U2, disconnected, or in a
+	 * error state. Resume related variables should be cleared in all those cases.
+	 */
+	if ((link_state != XDEV_U3 &&
+	     link_state != XDEV_RESUME) &&
+	    (port->resume_timestamp ||
+	     test_bit(portnum, &bus_state->resuming_ports))) {
+		port->resume_timestamp = 0;
+		clear_bit(portnum, &bus_state->resuming_ports);
+		usb_hcd_end_port_resume(&port->rhub->hcd->self, portnum);
+	}
 }
 
 /*
@@ -1072,18 +1078,6 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 	else
 		xhci_get_usb2_port_status(port, &status, raw_port_status,
 					  flags);
-	/*
-	 * Clear stale usb2 resume signalling variables in case port changed
-	 * state during resume signalling. For example on error
-	 */
-	if ((port->resume_timestamp ||
-	     test_bit(wIndex, &bus_state->resuming_ports)) &&
-	    (raw_port_status & PORT_PLS_MASK) != XDEV_U3 &&
-	    (raw_port_status & PORT_PLS_MASK) != XDEV_RESUME) {
-		port->resume_timestamp = 0;
-		clear_bit(wIndex, &bus_state->resuming_ports);
-		usb_hcd_end_port_resume(&hcd->self, wIndex);
-	}
 
 	if (bus_state->port_c_suspend & (1 << wIndex))
 		status |= USB_PORT_STAT_C_SUSPEND << 16;
-- 
2.40.1



