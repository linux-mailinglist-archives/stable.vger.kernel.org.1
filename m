Return-Path: <stable+bounces-164238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD49B0DE5C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C7585F8A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421732ECD3A;
	Tue, 22 Jul 2025 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LgKC8MPf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD52ECE85;
	Tue, 22 Jul 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193702; cv=none; b=TdTOeOTmx0DCaW0doK9CD0ODegOCAe5X2GRCK+gYdGZbeaO2ViQ5L38JA6oaEOn9wGRoo9Ow/PnlNvDPm6ks9ztooyrGwr7BA2KL57TKD7sHOVddi4uKND6unG4pANRCDZern4dDv68QaYE9MLXS080Lyo54k53EFSf0fjdyeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193702; c=relaxed/simple;
	bh=f/JrDxsLGTf5jtgQkLDj8OicqCp6n6aRZshhSUfhzU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzvF6CCr7ahV6cMXgNbt5p0rv/aCY3eCf+qHxrN3AjVbr1VEU20Uw70pZBpenH2iw90SISLaLD+q+b9QM84qtvYtNL9Rg1fHBUb5BRs58U0HUQSScMYG3vyGQDt/9r67phtmmw5WGYIkTBmpSLD1FaR+5sB7tm5hAvFl5rY6jtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LgKC8MPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D662C4CEF1;
	Tue, 22 Jul 2025 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193701;
	bh=f/JrDxsLGTf5jtgQkLDj8OicqCp6n6aRZshhSUfhzU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgKC8MPfoKjNrd7KfT/6DOTlka6sU/0httgvdbuP3H53kzMbVNhIP3HY6QvYNkqii
	 nQyCi4ZdX7hCi0VTuzYSM0oVKZU149gwkdmHEYDlZ/y/Iz/JGNZBve8WgGFUjNywnG
	 FOerQA/Jg/ZetJjTLz7C+S0LydhuAfCM4ZocOLZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.15 170/187] usb: hub: Dont try to recover devices lost during warm reset.
Date: Tue, 22 Jul 2025 15:45:40 +0200
Message-ID: <20250722134352.097079267@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 2521106fc732b0b75fd3555c689b1ed1d29d273c upstream.

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
---
 drivers/usb/core/hub.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5747,6 +5747,7 @@ static void port_event(struct usb_hub *h
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
 	int i = 0;
+	int err;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5843,8 +5844,11 @@ static void port_event(struct usb_hub *h
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



