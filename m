Return-Path: <stable+bounces-205233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11FBCFA04A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F2EE3070AB9
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C934D381;
	Tue,  6 Jan 2026 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CPhqWfTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAF34CFC9;
	Tue,  6 Jan 2026 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720018; cv=none; b=eBdQkhDETNuV1D7zBiAkVHH2zQZSEljwHUX+aXIRaXMT6sitKNs59w9K957bnt/1uVbE5q4SHC0Tqa7nyrpj01tpgJOGKsZaz0E+7EC1A5+CLSAg+Iqo+szWOFNiqTIXt5ZJ7QzKpDacRqzkym5uEUOuxaT9B6g+5n38Rao8FNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720018; c=relaxed/simple;
	bh=RoWILjF+wzYTZnJ3KBx72UAPcAk1NN+egl7/ers5zeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiiGs5oBtUAlPS7oGtVbaa9UooLg3HKBHevIsva6kdwu6gZLOsTz93zdJJ37nc1cDcFkI2f1u5NZFeMnBfWlokNED+o+wTIojzL0h30jObRopQntUjLYAurxCTo5YmF/CKj+MQxXccbZ5Ph6Wbwg7NNXXDtqBeKHCq5SyhTo/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CPhqWfTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4229BC116C6;
	Tue,  6 Jan 2026 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720017;
	bh=RoWILjF+wzYTZnJ3KBx72UAPcAk1NN+egl7/ers5zeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPhqWfTSVB3vD8sHoCCtYfGRpDHEWS6DcP8MF7Ry9gNCDohA+WKt9XYKfh7qJ5GA6
	 SXz8wPF8+urVobmb2WTrDgRIPU6/LF+1uPlh/jR0m8SVegcdRSBvEkzh2KIGE3EI5u
	 pn0T367XghMeFf75MUN+YoBDooeFjDKBmhv3epks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12 102/567] can: gs_usb: gs_can_open(): fix error handling
Date: Tue,  6 Jan 2026 17:58:04 +0100
Message-ID: <20260106170455.102659029@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 3e54d3b4a8437b6783d4145c86962a2aa51022f3 upstream.

Commit 2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
added missing error handling to the gs_can_open() function.

The driver uses 2 USB anchors to track the allocated URBs: the TX URBs in
struct gs_can::tx_submitted for each netdev and the RX URBs in struct
gs_usb::rx_submitted for the USB device. gs_can_open() allocates the RX
URBs, while TX URBs are allocated during gs_can_start_xmit().

The cleanup in gs_can_open() kills all anchored dev->tx_submitted
URBs (which is not necessary since the netdev is not yet registered), but
misses the parent->rx_submitted URBs.

Fix the problem by killing the rx_submitted instead of the tx_submitted.

Fixes: 2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251210-gs_usb-fix-error-handling-v1-1-d6a5a03f10bb@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/gs_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1071,7 +1071,7 @@ out_usb_free_urb:
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
 	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&dev->tx_submitted);
+		usb_kill_anchored_urbs(&parent->rx_submitted);
 
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(parent);



