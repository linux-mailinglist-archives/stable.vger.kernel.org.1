Return-Path: <stable+bounces-164317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E4B0E6F9
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188D71C274B1
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50950289E0F;
	Tue, 22 Jul 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEtUgRKN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124BB278E5A
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226091; cv=none; b=nWah/wEpV8btsNA+ocxN3lm4eqQiAQBRdlvy3NAdDshqH/6UEaxvdLufl567ZUrOqr810NiHZ8PtVSHb0sRjBzUzUIksB3MDBjJeMFrk30ClVdm1b2xOMXFLMpGBI0CG4ugi1kVLSjbVW60UKLoyC8QbhDmdZo4U9ItkrDqIwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226091; c=relaxed/simple;
	bh=j2r6wd5w1SgwoXgvhP/2e0CUjaE7OSsjOL5xIvzzyRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjPCNQgijoHwDIhUbupUh7nZHMwPr7ZZkX6Mk/WJWc/GAtE7JvXoN057ATEl7GmEJYWRUy/RM9tKDjAzS1rp50czOfwgWk9gfPv+JXUmBjY+c5zRGWr9q96rYYqa5D0yVcaxn3jclMLX9NCikp4W6Z8jwV9EHD+Nzc7vJgxKBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEtUgRKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43977C4CEF5;
	Tue, 22 Jul 2025 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753226090;
	bh=j2r6wd5w1SgwoXgvhP/2e0CUjaE7OSsjOL5xIvzzyRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEtUgRKN1ImTGKHyZTEE2BFDyO5ftq+axFfyDAtqOz4dO7gayU73+MuuWZLtmyDpr
	 BfsMm464PQ2rjDxcMylFfLuo+6OtLSRcusDaSwmfc7oncWaJFmzNM97ozQr+gMooKo
	 BK3MBLxe7neWwZ2vvRgzsciZAlTR4oA2K/fkpLRqHT+Gemmu4KQtBrRWQ3tL0qgiwO
	 ELb0SDdItG0VN3LLvDZBmyfURjCPWMPSl/WWcubN+5KLX74/GY7EhRjy08yme5BZ9e
	 oaR3UAZ6yDeX6yiLQCz95RNjICGa7ALqeaOlnYKG8SJ9GWDV0rJQSLpWAdfsUVjoI7
	 oGAZGh/i9ZdBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: hub: Don't try to recover devices lost during warm reset.
Date: Tue, 22 Jul 2025 19:14:43 -0400
Message-Id: <20250722231443.999927-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722231443.999927-1-sashal@kernel.org>
References: <2025072256-verbally-zippy-bbd6@gregkh>
 <20250722231443.999927-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/usb/core/hub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3aab5fa8f8e61..1aa35e7322323 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5656,6 +5656,7 @@ static void port_event(struct usb_hub *hub, int port1)
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
 	int i = 0;
+	int err;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5748,8 +5749,11 @@ static void port_event(struct usb_hub *hub, int port1)
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
-- 
2.39.5


