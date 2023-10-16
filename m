Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900967CAC2A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjJPOud (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjJPOuc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:50:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB43D9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:50:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8873FC433C7;
        Mon, 16 Oct 2023 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467829;
        bh=1jaL4/e4QJL6AzHtR5V0/L1qeqwHKMfYlzb0rQnvJOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6pkuOobK+6DNLJ8IE5S4+8WoH77vzyLeOB0bxRvJBdgFNR00C+If516imzSW3j9W
         QvRfzjlVDobJh1qWmgPvRLJc5o0DOiGtp7L1ujzCzTKjNTWFzkuZ5/EgpUpPCL5PJE
         mLIYiN1WdMedHQJpGhCdk+JmDN2RM7AI4fQ60ma4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.5 100/191] xhci: track port suspend state correctly in unsuccessful resume cases
Date:   Mon, 16 Oct 2023 10:41:25 +0200
Message-ID: <20231016084017.724199548@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit d7cdfc319b2bcf6899ab0a05eec0958bc802a9a1 upstream.

xhci-hub.c tracks suspended ports in a suspended_port bitfield.
This is checked when responding to a Get_Status(PORT) request to see if a
port in running U0 state was recently resumed, and adds the required
USB_PORT_STAT_C_SUSPEND change bit in those cases.

The suspended_port bit was left uncleared if a device is disconnected
during suspend. The bit remained set even when a new device was connected
and enumerated. The set bit resulted in a incorrect Get_Status(PORT)
response with a bogus USB_PORT_STAT_C_SUSPEND change
bit set once the new device reached U0 link state.

USB_PORT_STAT_C_SUSPEND change bit is only used for USB2 ports, but
xhci-hub keeps track of both USB2 and USB3 suspended ports.

Cc: stable@vger.kernel.org
Reported-by: Wesley Cheng <quic_wcheng@quicinc.com>
Closes: https://lore.kernel.org/linux-usb/d68aa806-b26a-0e43-42fb-b8067325e967@quicinc.com/
Fixes: 1d5810b6923c ("xhci: Rework port suspend structures for limited ports.")
Tested-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230915143108.1532163-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-hub.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1062,19 +1062,19 @@ static void xhci_get_usb3_port_status(st
 		*status |= USB_PORT_STAT_C_CONFIG_ERROR << 16;
 
 	/* USB3 specific wPortStatus bits */
-	if (portsc & PORT_POWER) {
+	if (portsc & PORT_POWER)
 		*status |= USB_SS_PORT_STAT_POWER;
-		/* link state handling */
-		if (link_state == XDEV_U0)
-			bus_state->suspended_ports &= ~(1 << portnum);
-	}
 
-	/* remote wake resume signaling complete */
-	if (bus_state->port_remote_wakeup & (1 << portnum) &&
+	/* no longer suspended or resuming */
+	if (link_state != XDEV_U3 &&
 	    link_state != XDEV_RESUME &&
 	    link_state != XDEV_RECOVERY) {
-		bus_state->port_remote_wakeup &= ~(1 << portnum);
-		usb_hcd_end_port_resume(&hcd->self, portnum);
+		/* remote wake resume signaling complete */
+		if (bus_state->port_remote_wakeup & (1 << portnum)) {
+			bus_state->port_remote_wakeup &= ~(1 << portnum);
+			usb_hcd_end_port_resume(&hcd->self, portnum);
+		}
+		bus_state->suspended_ports &= ~(1 << portnum);
 	}
 
 	xhci_hub_report_usb3_link_state(xhci, status, portsc);
@@ -1131,6 +1131,7 @@ static void xhci_get_usb2_port_status(st
 			usb_hcd_end_port_resume(&port->rhub->hcd->self, portnum);
 		}
 		port->rexit_active = 0;
+		bus_state->suspended_ports &= ~(1 << portnum);
 	}
 }
 


