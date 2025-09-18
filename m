Return-Path: <stable+bounces-176315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D8B36CAE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE1D8E83FB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262535FC2D;
	Tue, 26 Aug 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GsG5lWCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140F350843;
	Tue, 26 Aug 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219339; cv=none; b=DQeBPIHoYx8kLw7aBO9FSYZJlj8Zw3EV3hgmfjvQwsyGKJIfzMW+d6pyqZsevOn8qT4jv8u2mY4JtLfTZEe9O+ilGgEIVFhQK8tJBrEnRTYC3kGckR1ntfo+LVWFSUbov3h/Xk4VD81v8kZQNa43jrHwdr8j/lMGXaRoO/0AbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219339; c=relaxed/simple;
	bh=R9YVx94YPLQGvxBUJowVYUDLw7oeaJh7Oc+Dik4Lj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPn5itw7I9GvCPm4tNo3GCtYyQhkWXhmk12ORL1hyBMi3dEduhH0hDXtLBDpDacE+xNxT8glrtnkYF/y5WMZOYO0vHk1GBaS/ZAZHwnZ2uGGBz4ChRkm16eCcxH1s655TDJ2zk/BY/k5OgOU90eqMjYUc5KReIoda3cfFqyFiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GsG5lWCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AA4C4CEF1;
	Tue, 26 Aug 2025 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219338;
	bh=R9YVx94YPLQGvxBUJowVYUDLw7oeaJh7Oc+Dik4Lj4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsG5lWCY3kpxH+/A0F+amSf8zqeSUFIBtsEdMHiyyJX3pNlFlfG+gxekFu6qvFZd5
	 ZfZ4/SMsZOZXfCxU2X/LDRRjSgGo5NW4OT3qLDzAJDZ3ORQGqdzpCrrIpO+Ov+KgIE
	 QC5YqziNfC0MxLUKGY9IZL3U635GLn8FJLHvWwW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 343/403] usb: hub: Dont try to recover devices lost during warm reset.
Date: Tue, 26 Aug 2025 13:11:09 +0200
Message-ID: <20250826110916.336983919@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 2521106fc732b0b75fd3555c689b1ed1d29d273c ]

Hub driver warm-resets ports in SS.Inactive or Compliance mode to
recover a possible connected device. The port reset code correctly
detects if a connection is lost during reset, but hub driver
port_event() fails to take this into account in some cases.
port_event() ends up using stale values and assumes there is a
connected device, and will try all means to recover it, including
power-cycling the port.

Details:
This case was triggered when xHC host was suspended with DbC (Debug
Capability) enabled and connected. DbC turns one xHC port into a simple
usb debug device, allowing debugging a system with an A-to-A USB debug
cable.

xhci DbC code disables DbC when xHC is system suspended to D3, and
enables it back during resume.
We essentially end up with two hosts connected to each other during
suspend, and, for a short while during resume, until DbC is enabled back.
The suspended xHC host notices some activity on the roothub port, but
can't train the link due to being suspended, so xHC hardware sets a CAS
(Cold Attach Status) flag for this port to inform xhci host driver that
the port needs to be warm reset once xHC resumes.

CAS is xHCI specific, and not part of USB specification, so xhci driver
tells usb core that the port has a connection and link is in compliance
mode. Recovery from complinace mode is similar to CAS recovery.

xhci CAS driver support that fakes a compliance mode connection was added
in commit 8bea2bd37df0 ("usb: Add support for root hub port status CAS")

Once xHCI resumes and DbC is enabled back, all activity on the xHC
roothub host side port disappears. The hub driver will anyway think
port has a connection and link is in compliance mode, and hub driver
will try to recover it.

The port power-cycle during recovery seems to cause issues to the active
DbC connection.

Fix this by clearing connect_change flag if hub_port_reset() returns
-ENOTCONN, thus avoiding the whole unnecessary port recovery and
initialization attempt.

Cc: stable@vger.kernel.org
Fixes: 8bea2bd37df0 ("usb: Add support for root hub port status CAS")
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20250623133947.3144608-1-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5425,6 +5425,7 @@ static void port_event(struct usb_hub *h
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
 	int i = 0;
+	int err;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5517,8 +5518,11 @@ static void port_event(struct usb_hub *h
 		} else if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
 				|| udev->state == USB_STATE_NOTATTACHED) {
 			dev_dbg(&port_dev->dev, "do warm reset, port only\n");
-			if (hub_port_reset(hub, port1, NULL,
-					HUB_BH_RESET_TIME, true) < 0)
+			err = hub_port_reset(hub, port1, NULL,
+					     HUB_BH_RESET_TIME, true);
+			if (!udev && err == -ENOTCONN)
+				connect_change = 0;
+			else if (err < 0)
 				hub_port_disable(hub, port1, 1);
 		} else {
 			dev_dbg(&port_dev->dev, "do warm reset, full device\n");



