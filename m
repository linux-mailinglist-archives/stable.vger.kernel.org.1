Return-Path: <stable+bounces-164316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A41B0E6F8
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1E11C26BF2
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457227FD46;
	Tue, 22 Jul 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW/aqAOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241F278E5A
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226089; cv=none; b=UJn3/cC7NumjwerNI7UzkvteT+AuWCJwh+Ban6K6XWtOKLOomEUU1F+zNRmrSudRyLJJc19ht3KINMOjZH0F5clfVGgNZDCCQXEAPUdabA1cOyNdmZUlb8znDz1S6GnPojHppr4I8JWBJOCZavWJQnYm/G5rZq7msQJqY+xtiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226089; c=relaxed/simple;
	bh=hyG99X5DpP1kX7otdWV8fvjDijlSvd/LkW3RMlPBE24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucbOxLYi+N4Ze4qk3sjyRUaatYnVxhnXaNFAXHyTGIi0n21VdXRezcgXmuJmNo17KUg7vXP0OpYSU+kHVgOKxOCBlznzh2OKnWPQeKDUkqjGVKUo9kdogsvFzHZUghs2jt9/nNLxHgSWMtGBzELUdGVwvqszcmoMlHyVbP1Vs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW/aqAOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD073C4CEEB;
	Tue, 22 Jul 2025 23:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753226088;
	bh=hyG99X5DpP1kX7otdWV8fvjDijlSvd/LkW3RMlPBE24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oW/aqAOylIc9EXT9ciD74MBDkr2SOq4jn8z2Gg8bXUof9amtyyuhb1pW7nI5nz706
	 yg+1oN1MsGwknBSMuYymT9Vjc2qQql9Ypy9bMmO+R8WbColAZ6N3lNz0R09ZefSS2v
	 R7DQBlEKRJZTdeINsufKzcHPiPV3NIS73KehvRzBCOPoE4fEKjcZcG+36Q6KmGrF99
	 2wExKpPYo6ItzqR7xt2JhescU/IDT5KFtd2EThKakaakDjbXrihb6ISAQpPScJjsAC
	 h2hPIYwRm9SxvMpre0VjgfyzPYCre0inOhHY7F4iwS2WLWpDYbsmmVCfsX9GcZWbdF
	 aDUWUeUjzcExw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mark Pearson <markpearson@lenovo.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: hub: avoid warm port reset during USB3 disconnect
Date: Tue, 22 Jul 2025 19:14:42 -0400
Message-Id: <20250722231443.999927-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072256-verbally-zippy-bbd6@gregkh>
References: <2025072256-verbally-zippy-bbd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit f59f93cd1d720809466c7fd5aa16a236156c672b ]

During disconnect USB-3 ports often go via SS.Inactive link error state
before the missing terminations are noticed, and link finally goes to
RxDetect state

Avoid immediately warm-resetting ports in SS.Inactive state.
Let ports settle for a while and re-read the link status a few times 20ms
apart to see if the ports transitions out of SS.Inactive.

According to USB 3.x spec 7.5.2, a port in SS.Inactive should
automatically check for missing far-end receiver termination every
12 ms (SSInactiveQuietTimeout)

The futile multiple warm reset retries of a disconnected device takes
a lot of time, also the resetting of a removed devices has caused cases
where the reset bit got stuck for a long time on xHCI roothub.
This lead to issues in detecting new devices connected to the same port
shortly after.

Tested-by: Mark Pearson <markpearson@lenovo.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20211210111653.1378381-1-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2521106fc732 ("usb: hub: Don't try to recover devices lost during warm reset.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f0739bc9e25ac..3aab5fa8f8e61 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2829,6 +2829,8 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define PORT_INIT_TRIES		4
 #endif	/* CONFIG_USB_FEW_INIT_RETRIES */
 
+#define DETECT_DISCONNECT_TRIES 5
+
 #define HUB_ROOT_RESET_TIME	60	/* times are in msec */
 #define HUB_SHORT_RESET_TIME	10
 #define HUB_BH_RESET_TIME	50
@@ -5653,6 +5655,7 @@ static void port_event(struct usb_hub *hub, int port1)
 	struct usb_device *udev = port_dev->child;
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
+	int i = 0;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5729,17 +5732,27 @@ static void port_event(struct usb_hub *hub, int port1)
 		connect_change = 1;
 
 	/*
-	 * Warm reset a USB3 protocol port if it's in
-	 * SS.Inactive state.
+	 * Avoid trying to recover a USB3 SS.Inactive port with a warm reset if
+	 * the device was disconnected. A 12ms disconnect detect timer in
+	 * SS.Inactive state transitions the port to RxDetect automatically.
+	 * SS.Inactive link error state is common during device disconnect.
 	 */
-	if (hub_port_warm_reset_required(hub, port1, portstatus)) {
-		dev_dbg(&port_dev->dev, "do warm reset\n");
-		if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
+	while (hub_port_warm_reset_required(hub, port1, portstatus)) {
+		if ((i++ < DETECT_DISCONNECT_TRIES) && udev) {
+			u16 unused;
+
+			msleep(20);
+			hub_port_status(hub, port1, &portstatus, &unused);
+			dev_dbg(&port_dev->dev, "Wait for inactive link disconnect detect\n");
+			continue;
+		} else if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
 				|| udev->state == USB_STATE_NOTATTACHED) {
+			dev_dbg(&port_dev->dev, "do warm reset, port only\n");
 			if (hub_port_reset(hub, port1, NULL,
 					HUB_BH_RESET_TIME, true) < 0)
 				hub_port_disable(hub, port1, 1);
 		} else {
+			dev_dbg(&port_dev->dev, "do warm reset, full device\n");
 			usb_unlock_port(port_dev);
 			usb_lock_device(udev);
 			usb_reset_device(udev);
@@ -5747,6 +5760,7 @@ static void port_event(struct usb_hub *hub, int port1)
 			usb_lock_port(port_dev);
 			connect_change = 0;
 		}
+		break;
 	}
 
 	if (connect_change)
-- 
2.39.5


