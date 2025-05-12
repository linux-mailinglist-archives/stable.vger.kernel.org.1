Return-Path: <stable+bounces-143962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03925AB432D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94E68C4032
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CEF29A9C8;
	Mon, 12 May 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x01e7O0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA429711D;
	Mon, 12 May 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073431; cv=none; b=r59IX7M4lK6x62NtgpbBrxb8hmFJ1Z9tHZFEc/GI1TYLkPSPkPNCwuZd5GdZRpkyOWZ2WSiF4ok29MrmLwSMFYX/EHltYdr9L14y2VRch0WL3rcv5BizgX8TBGw9d1Hz1lRxDtRdzbq/Gum+hvvtHvPsLJ0ElTyZMMEtoFMj8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073431; c=relaxed/simple;
	bh=EvCwamXVhsTyDZPvQ827UyH2PaHLvzRQwSvqeRZcbG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGh9bnPDIE1JvfROahdN4J31mVCQk2a8kr6Fhm3uzP3vi6mbfXQMYFr6gkEC0ZG5jSkyz3IaqYv4QmMNRHG437d/9RYtfwXLAa+MQgPP9EpwJFYPcKLp818IfQBcfxiK9IpjerfWvyNa3qHJPXT5+eLl+MvfQrmUQC/76vvI8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x01e7O0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DB7C4CEE7;
	Mon, 12 May 2025 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073431;
	bh=EvCwamXVhsTyDZPvQ827UyH2PaHLvzRQwSvqeRZcbG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x01e7O0lBA/2WzO/cGY63wB2Elf7SijkHp76HsAx8+jpp0fyVmXjJDBO8cUSJoIHd
	 LHxbFqIJ1xfr/cfx0oGEgKTYctGV4p9LLl6ufURk8os261rXXgdzFd8cm0Zod1kjYc
	 fzgy56urKyj6dDqMDiLSwvELP4vZe4GQElfsXwgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Jim Lin <jilin@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>
Subject: [PATCH 6.6 072/113] usb: host: tegra: Prevent host controller crash when OTG port is used
Date: Mon, 12 May 2025 19:46:01 +0200
Message-ID: <20250512172030.605612929@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
References: <20250512172027.691520737@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Lin <jilin@nvidia.com>

commit 732f35cf8bdfece582f6e4a9c659119036577308 upstream.

When a USB device is connected to the OTG port, the tegra_xhci_id_work()
routine transitions the PHY to host mode and calls xhci_hub_control()
with the SetPortFeature command to enable port power.

In certain cases, the XHCI controller may be in a low-power state
when this operation occurs. If xhci_hub_control() is invoked while
the controller is suspended, the PORTSC register may return 0xFFFFFFFF,
indicating a read failure. This causes xhci_hc_died() to be triggered,
leading to host controller shutdown.

Example backtrace:
[  105.445736] Workqueue: events tegra_xhci_id_work
[  105.445747]  dump_backtrace+0x0/0x1e8
[  105.445759]  xhci_hc_died.part.48+0x40/0x270
[  105.445769]  tegra_xhci_set_port_power+0xc0/0x240
[  105.445774]  tegra_xhci_id_work+0x130/0x240

To prevent this, ensure the controller is fully resumed before
interacting with hardware registers by calling pm_runtime_get_sync()
prior to the host mode transition and xhci_hub_control().

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable <stable@kernel.org>
Signed-off-by: Jim Lin <jilin@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Link: https://lore.kernel.org/r/20250422114001.126367-1-waynec@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-tegra.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1363,6 +1363,7 @@ static void tegra_xhci_id_work(struct wo
 	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(tegra->padctl,
 								    tegra->otg_usb2_port);
 
+	pm_runtime_get_sync(tegra->dev);
 	if (tegra->host_mode) {
 		/* switch to host mode */
 		if (tegra->otg_usb3_port >= 0) {
@@ -1392,6 +1393,7 @@ static void tegra_xhci_id_work(struct wo
 		}
 
 		tegra_xhci_set_port_power(tegra, true, true);
+		pm_runtime_mark_last_busy(tegra->dev);
 
 	} else {
 		if (tegra->otg_usb3_port >= 0)
@@ -1399,6 +1401,7 @@ static void tegra_xhci_id_work(struct wo
 
 		tegra_xhci_set_port_power(tegra, true, false);
 	}
+	pm_runtime_put_autosuspend(tegra->dev);
 }
 
 #if IS_ENABLED(CONFIG_PM) || IS_ENABLED(CONFIG_PM_SLEEP)



