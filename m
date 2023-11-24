Return-Path: <stable+bounces-1125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48717F7E24
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8775AB21720
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CDB39FF7;
	Fri, 24 Nov 2023 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fh4O97wt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB93A8C3;
	Fri, 24 Nov 2023 18:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A5BC433C7;
	Fri, 24 Nov 2023 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850622;
	bh=V86Mz79jzXKpNUHj1yeyYxQzdtaHnIXJZ2w5VGA3EaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fh4O97wt/O02WYcjYKjF5EK6n1QCLavuD31HvD5SGepgmSyWukALh1F3wTj2yenbP
	 bC5QmL2qWq4cPAuuPiM+XlfRdbHcN/Kx1m9+hdQ8646Wyjw7EEmXsipd6fX60vf4Gf
	 rxKCLI2dMjUXwvxuoZPtD/l5Kjl9ZoGuRwgtBcys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 123/491] usb: host: xhci: Avoid XHCI resume delay if SSUSB device is not present
Date: Fri, 24 Nov 2023 17:45:59 +0000
Message-ID: <20231124172028.209889549@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wesley Cheng <quic_wcheng@quicinc.com>

[ Upstream commit 6add6dd345cb754ce18ff992c7264cabf31e59f6 ]

There is a 120ms delay implemented for allowing the XHCI host controller to
detect a U3 wakeup pulse.  The intention is to wait for the device to retry
the wakeup event if the USB3 PORTSC doesn't reflect the RESUME link status
by the time it is checked.  As per the USB3 specification:

  tU3WakeupRetryDelay ("Table 7-12. LTSSM State Transition Timeouts")

This would allow the XHCI resume sequence to determine if the root hub
needs to be also resumed.  However, in case there is no device connected,
or if there is only a HSUSB device connected, this delay would still affect
the overall resume timing.

Since this delay is solely for detecting U3 wake events (USB3 specific)
then ignore this delay for the disconnected case and the HSUSB connected
only case.

[skip helper function, rename usb3_connected variable -Mathias ]

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20231019102924.2797346-20-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index fae994f679d45..82aab2f9adbb8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -968,6 +968,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 	int			retval = 0;
 	bool			comp_timer_running = false;
 	bool			pending_portevent = false;
+	bool			suspended_usb3_devs = false;
 	bool			reinit_xhc = false;
 
 	if (!hcd->state)
@@ -1115,10 +1116,17 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 		/*
 		 * Resume roothubs only if there are pending events.
 		 * USB 3 devices resend U3 LFPS wake after a 100ms delay if
-		 * the first wake signalling failed, give it that chance.
+		 * the first wake signalling failed, give it that chance if
+		 * there are suspended USB 3 devices.
 		 */
+		if (xhci->usb3_rhub.bus_state.suspended_ports ||
+		    xhci->usb3_rhub.bus_state.bus_suspended)
+			suspended_usb3_devs = true;
+
 		pending_portevent = xhci_pending_portevent(xhci);
-		if (!pending_portevent && msg.event == PM_EVENT_AUTO_RESUME) {
+
+		if (suspended_usb3_devs && !pending_portevent &&
+		    msg.event == PM_EVENT_AUTO_RESUME) {
 			msleep(120);
 			pending_portevent = xhci_pending_portevent(xhci);
 		}
-- 
2.42.0




