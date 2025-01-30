Return-Path: <stable+bounces-111519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620ECA22F8B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C6D1886953
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BDC1E9B28;
	Thu, 30 Jan 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l1J9WSrJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5581E9901;
	Thu, 30 Jan 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246972; cv=none; b=AZBEjHFPO0stkNcSpkZSPYLelco6F7CqhlEchE8hJ768F5sDbuwPKjRM9iS61OvuCQaE6GJqLbdNLUZu1yG90BsWmL5c9aXrlf5mK6TLUHNDeMe+8ZIUX3OWuz7Y2Jhjj4StWWGW2DMP34xqu7nbsYKOwvqDjBXu//h4JuaVZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246972; c=relaxed/simple;
	bh=wbrM/Y7CuYfeJXX9+ih5fOfvl2WZH7/xPxnGS5m0Qn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKXrt8JGNniyNFF8FhtXiRr4g2MvZPHEa3Nj8M4T5htWzE9Lvk9koR1QIej+q5IWR2o2FRRqxnTuQl0ilrNqzmxlw3rafN27mDvXDettxObro9ImL1dxd2J8mk2ay9rw4Sk593k4d0e7DBVKvYUJpD4qdWr3if9R2UIJTblPHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l1J9WSrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0815C4CED2;
	Thu, 30 Jan 2025 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246972;
	bh=wbrM/Y7CuYfeJXX9+ih5fOfvl2WZH7/xPxnGS5m0Qn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1J9WSrJiiJTamf1bfHEYa4VT6YV/kMiekgrikOsJf7rVVACL/XIuWysHWRSxQC1N
	 JwiH4u03Gud0mBGx77ZnS5T60IZXAqc2HhGgxkY5dxQXrldSW39z/HwntYEVCyqW1w
	 23MeET5v+lP4sAG3RcOtOPXIcS9xhatFk6QaqRCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Chang <waynec@nvidia.com>,
	stable <stable@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 5.10 039/133] USB: core: Disable LPM only for non-suspended ports
Date: Thu, 30 Jan 2025 15:00:28 +0100
Message-ID: <20250130140144.086638030@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kaihengf@nvidia.com>

commit 59bfeaf5454b7e764288d84802577f4a99bf0819 upstream.

There's USB error when tegra board is shutting down:
[  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
[  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
[  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
[  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
[  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
[  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command

The issue is caused by disabling LPM on already suspended ports.

For USB2 LPM, the LPM is already disabled during port suspend. For USB3
LPM, port won't transit to U1/U2 when it's already suspended in U3,
hence disabling LPM is only needed for ports that are not suspended.

Cc: Wayne Chang <waynec@nvidia.com>
Cc: stable <stable@kernel.org>
Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20241206074817.89189-1-kaihengf@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/port.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -294,10 +294,11 @@ static int usb_port_runtime_suspend(stru
 static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
+	struct usb_device *udev = port_dev->child;
 
-	if (port_dev->child) {
-		usb_disable_usb2_hardware_lpm(port_dev->child);
-		usb_unlocked_disable_lpm(port_dev->child);
+	if (udev && !udev->port_is_suspended) {
+		usb_disable_usb2_hardware_lpm(udev);
+		usb_unlocked_disable_lpm(udev);
 	}
 }
 



