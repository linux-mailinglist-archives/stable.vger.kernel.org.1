Return-Path: <stable+bounces-164315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F3B0E6C8
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AB5567DF5
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002C288C87;
	Tue, 22 Jul 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUoqWaUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A4283680
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225126; cv=none; b=dJOiVuswDBQahyp9j+CNoC5Wxk9ZZgtapueLMlC/Vs9FWYxd8/ns87ZiCzW/jwVxviNYpdVk7zJB3jDnCZ/pax5ZDUEKbh8ad+HapbtuZwQYu20S+WfioxMHiQWJ7ug0yRf3Qu/1YjDbPIng4iIqYkWAIm+0be1QPNSlz9Y4p5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225126; c=relaxed/simple;
	bh=mSDneD3jEvBH3AJ1mmt+FsY14SajC0mzItNNTQNPdgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDcRL1iHWtcqY6+Goi6oUSxD/oKrCwZR68rex44Kb5GqQn1ogAk1c4W24Q28StUzT7dOjXLWc/WN7rAE6dX6riBBOU5PXZgUPCNYGuEufhgnfjpnvgABIojUK7UO75t9WAc3LIOlJmnBm1A8+S9CdEBgPNwVxaaY9WSjdT+mPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUoqWaUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2221AC4CEF5;
	Tue, 22 Jul 2025 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753225125;
	bh=mSDneD3jEvBH3AJ1mmt+FsY14SajC0mzItNNTQNPdgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUoqWaUmEvQ1ATsfGR+GUd3FwtmZ/U1kjkGqJeXueZgx0O5HT2FJh0wpZ/9DiNk3V
	 AKTzE2SHWleKZnO0h+gmDe3oWwuxAoOZT8ckhFVDPpyDfqYvTbYJFr0+Icx50165Ej
	 lzR5klgEGk4sB9gzsWNaj6dAhIJM62/a0DFdPf99jQwVAnJZ6U6yXJShD1mqEEluRH
	 cvHObhiHpz4ryVitGUf1mGG/QIkBTaiPkQw8oZIZIzxo1k8OJb+GXZYR87p+LbePgR
	 tJsArq0LRbNsy5V/M9OHX+T+nxK6CnHoWwchNO694wbJkn3+xXzZs7nRXgLU2dc43V
	 sbc1iUzWuGnlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] usb: hub: Don't try to recover devices lost during warm reset.
Date: Tue, 22 Jul 2025 18:58:39 -0400
Message-Id: <20250722225839.999383-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722225839.999383-1-sashal@kernel.org>
References: <2025072258-fervor-reabsorb-1b7a@gregkh>
 <20250722225839.999383-1-sashal@kernel.org>
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
index f00c666a28bfd..f3e0703ed459b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5392,6 +5392,7 @@ static void port_event(struct usb_hub *hub, int port1)
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
 	int i = 0;
+	int err;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5484,8 +5485,11 @@ static void port_event(struct usb_hub *hub, int port1)
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


