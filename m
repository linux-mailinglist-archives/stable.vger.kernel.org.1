Return-Path: <stable+bounces-164314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478F7B0E6C7
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057181C275D8
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A832877DB;
	Tue, 22 Jul 2025 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgUgpdWB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45282283680
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225125; cv=none; b=VrwaFfLTPRN5EtqIcxbP4Ac5Ivzbow7z0PRhAgAiqkaavN3ln+t7oSVCPIpT5QVkVVX28gYjw9KZM0O4RYpqQth9Kt0TpAgXoy7tDi8Mwhb1aKcczWc6TsI+th34aiGqQ9ENrKt8m2YEpPWErESBclgjXW7r/b2N642mk9VUbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225125; c=relaxed/simple;
	bh=LW5+JYxI0TIJ72ynRp7bZ6zXZh7UGjYHH4/JJlx6Fcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNYs4M4F86eMTCIl1iNEuOI4Yhzsgk9HTu1A9IrZz53pkzGxHzyiKi8H5go1gQuqt3/WV6hWrkyOehcRG9t4h6VPWavcSFm49Ld/Wq258T9nmfiIyTY+d/bcSId4Rm4jQRpOgEmMMTwP1kRgnJlDvOTw0SVETErSFrDYQDLmLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgUgpdWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13A5C4CEEB;
	Tue, 22 Jul 2025 22:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753225123;
	bh=LW5+JYxI0TIJ72ynRp7bZ6zXZh7UGjYHH4/JJlx6Fcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgUgpdWB+kVnwINRAr6GQnXCA92zE2Ym2D4rz3KQvdRsgR0RJfzn4rrG3pW5CtO4V
	 5gtU5K3BJjXOpfOG8oikd68J24wb2Yyyx/txlvLK764Z8L2X83O7oEeY0/OXuCzAWJ
	 tSiC/NqrM6PR0v+GTcqU9zc9Pf/3x1sESn3cRXq5IjIaeXIEWa295N1Ck7sKhOdIkU
	 YPQabQ/HlcBkolXH68CxHriEGX3wp1VuTmFJy0OlQsoPDNlSbOb9V8VOA7BeO9qaw9
	 d2yo7FTL01/pf97drbgVEnDXWEVuzq3N+0fU/mRHqVR18qs2VhlHPrr9cSOGTthPHa
	 M07vhAZlK07CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mark Pearson <markpearson@lenovo.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] usb: hub: avoid warm port reset during USB3 disconnect
Date: Tue, 22 Jul 2025 18:58:38 -0400
Message-Id: <20250722225839.999383-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072258-fervor-reabsorb-1b7a@gregkh>
References: <2025072258-fervor-reabsorb-1b7a@gregkh>
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
index 585375817f5ed..f00c666a28bfd 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2755,6 +2755,8 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define SET_CONFIG_TRIES	(2 * (use_both_schemes + 1))
 #define USE_NEW_SCHEME(i, scheme)	((i) / 2 == (int)(scheme))
 
+#define DETECT_DISCONNECT_TRIES 5
+
 #define HUB_ROOT_RESET_TIME	60	/* times are in msec */
 #define HUB_SHORT_RESET_TIME	10
 #define HUB_BH_RESET_TIME	50
@@ -5389,6 +5391,7 @@ static void port_event(struct usb_hub *hub, int port1)
 	struct usb_device *udev = port_dev->child;
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
+	int i = 0;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5465,17 +5468,27 @@ static void port_event(struct usb_hub *hub, int port1)
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
@@ -5483,6 +5496,7 @@ static void port_event(struct usb_hub *hub, int port1)
 			usb_lock_port(port_dev);
 			connect_change = 0;
 		}
+		break;
 	}
 
 	if (connect_change)
-- 
2.39.5


