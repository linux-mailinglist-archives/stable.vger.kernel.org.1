Return-Path: <stable+bounces-156820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8493DAE5145
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC814A33C1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5B7080C;
	Mon, 23 Jun 2025 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMzah6m+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA4C2E0;
	Mon, 23 Jun 2025 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714345; cv=none; b=ZLG62W0TBQwQCxyt8JJ4fWCxCjuk9xMpYX2++Tb1WJVwag+5Xp5m58iLtPqiua7VFOdGgV2pwO1XdmlJAFLnR0ZV68Q2Sdsz/2S5K1TPXR7wVmCsRt6Hwj9j9mNBv4g/X1QGu5gfeOzRYhTTQQMHQxig7bNmft32lLzi3Zrajf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714345; c=relaxed/simple;
	bh=4lDldMA6EB+42rLwEo6jqLwiu8gjZVyQ1iiVUcL8Ex4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6D20x+6FpFvImoQDbycb2+WXayMuOBMcM/TCmbKhjlwi9gtz2PqnuHwJBGOHlpTBU87kcs2AqycQkPM2R+Dym0TCNjz2aiHGIly99O8yz6pmrtZ4krSmgjAAkPFje4HRVEy9iEMNMkDBloFpBSzImr+pltjRuKbbVcZw5g8KG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMzah6m+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC8DC4CEEA;
	Mon, 23 Jun 2025 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714345;
	bh=4lDldMA6EB+42rLwEo6jqLwiu8gjZVyQ1iiVUcL8Ex4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMzah6m+P9gN1XzrxR2JGGOyMgOdU/5jy82cynyOrDveXxK9Qde3RrjhRSYbiud7q
	 TKulOVa79rTwCIjZVt3X/B/BaU8SsTvlDWoFJOzXLLZeDOFHswIJFr09dWt/3TwcAn
	 LP6m5ukpvsrSjgnKngkk54Prew+YhRv5cySgci9E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.15 182/411] usb: Flush altsetting 0 endpoints before reinitializating them after reset.
Date: Mon, 23 Jun 2025 15:05:26 +0200
Message-ID: <20250623130638.265199417@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 89bb3dc13ac29a563f4e4c555e422882f64742bd upstream.

usb core avoids sending a Set-Interface altsetting 0 request after device
reset, and instead relies on calling usb_disable_interface() and
usb_enable_interface() to flush and reset host-side of those endpoints.

xHCI hosts allocate and set up endpoint ring buffers and host_ep->hcpriv
during usb_hcd_alloc_bandwidth() callback, which in this case is called
before flushing the endpoint in usb_disable_interface().

Call usb_disable_interface() before usb_hcd_alloc_bandwidth() to ensure
URBs are flushed before new ring buffers for the endpoints are allocated.

Otherwise host driver will attempt to find and remove old stale URBs
from a freshly allocated new ringbuffer.

Cc: stable <stable@kernel.org>
Fixes: 4fe0387afa89 ("USB: don't send Set-Interface after reset")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250514132520.225345-1-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6040,6 +6040,7 @@ static int usb_reset_and_verify_device(s
 	struct usb_hub			*parent_hub;
 	struct usb_hcd			*hcd = bus_to_hcd(udev->bus);
 	struct usb_device_descriptor	descriptor;
+	struct usb_interface		*intf;
 	struct usb_host_bos		*bos;
 	int				i, j, ret = 0;
 	int				port1 = udev->portnum;
@@ -6103,6 +6104,18 @@ static int usb_reset_and_verify_device(s
 	if (!udev->actconfig)
 		goto done;
 
+	/*
+	 * Some devices can't handle setting default altsetting 0 with a
+	 * Set-Interface request. Disable host-side endpoints of those
+	 * interfaces here. Enable and reset them back after host has set
+	 * its internal endpoint structures during usb_hcd_alloc_bandwith()
+	 */
+	for (i = 0; i < udev->actconfig->desc.bNumInterfaces; i++) {
+		intf = udev->actconfig->interface[i];
+		if (intf->cur_altsetting->desc.bAlternateSetting == 0)
+			usb_disable_interface(udev, intf, true);
+	}
+
 	mutex_lock(hcd->bandwidth_mutex);
 	ret = usb_hcd_alloc_bandwidth(udev, udev->actconfig, NULL, NULL);
 	if (ret < 0) {
@@ -6134,12 +6147,11 @@ static int usb_reset_and_verify_device(s
 	 */
 	for (i = 0; i < udev->actconfig->desc.bNumInterfaces; i++) {
 		struct usb_host_config *config = udev->actconfig;
-		struct usb_interface *intf = config->interface[i];
 		struct usb_interface_descriptor *desc;
 
+		intf = config->interface[i];
 		desc = &intf->cur_altsetting->desc;
 		if (desc->bAlternateSetting == 0) {
-			usb_disable_interface(udev, intf, true);
 			usb_enable_interface(udev, intf, true);
 			ret = 0;
 		} else {



