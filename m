Return-Path: <stable+bounces-23422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702CD860700
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 00:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9536C1C230DD
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 23:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB1A225AF;
	Thu, 22 Feb 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leoZsO9J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70223224E0;
	Thu, 22 Feb 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644743; cv=none; b=NIVqJeAu18bleBMRkgFm8pSms47mri+3A/uFJQujz0AezJ+TGCQq7gX8mZ4vdmrH6sBU+pZC/AWznigudk1uPKPfSStehdJc4yo3UYdyz62t84RtDlIuvWAVi5A+V8inOdh5ndKBm1TOtUmcpPYc6qgx527ryqG3P1kcT2s5v0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644743; c=relaxed/simple;
	bh=CO0bRk7BiXCkxxzdXJ2RPi/v5jTeOrDQR52gxk/ci0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pQqtIoxisIvtrytG1Eh2L/vV65xNuHKAj9oscU+ARbCf/+8BtW0m37wibwP08QkGtPVUMZCFmw8hT+jTX3Y8P13HL9FKtI+GyBOdDt2uJyvJfKxs8DmcotOb7Cu83h2Cn2Bntzd7gO4B8vlCgknKKHcJ7x88VopPFri0E50q3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leoZsO9J; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708644737; x=1740180737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CO0bRk7BiXCkxxzdXJ2RPi/v5jTeOrDQR52gxk/ci0o=;
  b=leoZsO9J4m9gR1x1a6ZE0U/wQZZCEJMxgg+7hHsOMbkF5XhsAcSLctdJ
   NGBZNVKChbp8BhG/poUgNqPZGUi7VdYYcBoVTHE/cgGDFEmfCHiByO9RX
   JNPhrBqj2HWFRdGLaFJVKHBkNFTr+fwx+/8arG18wFTTRtgZWb+aoguZQ
   8iSROrhh9Qb0/YXdYQx/FfSblh/J9dn4kKxjEhGkIWRCaDAgBtlCiIxJF
   iMBl4yygmvPMfLuVey8UqPMCKsRipNqKVglDAtpyLFpG5LZ+OBHOS1ZTY
   EB4eimJ7Mic48JisI4X3Wi6LanYgNUNWyiVLeeIy/TVPUGyuRPH+qjlr1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6692147"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6692147"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 15:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="936921441"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="936921441"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 15:32:11 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	<stern@rowland.harvard.edu>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: port: Don't try to peer unused USB ports based on location
Date: Fri, 23 Feb 2024 01:33:43 +0200
Message-Id: <20240222233343.71856-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unused USB ports may have bogus location data in ACPI PLD tables.
This causes port peering failures as these unused USB2 and USB3 ports
location may match.

Due to these failures the driver prints a
"usb: port power management may be unreliable" warning, and
unnecessarily blocks port power off during runtime suspend.

This was debugged on a couple DELL systems where the unused ports
all returned zeroes in their location data.
Similar bugreports exist for other systems.

Don't try to peer or match ports that have connect type set to
USB_PORT_NOT_USED.

Fixes: 3bfd659baec8 ("usb: find internal hub tier mismatch via acpi")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218465
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218486
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://lore.kernel.org/linux-usb/5406d361-f5b7-4309-b0e6-8c94408f7d75@molgen.mpg.de
Cc: stable@vger.kernel.org # v3.16+
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
v1 -> v2
  - Improve commit message
  - Add missing Fixes, Closes and Link tags
  - send this patch separately for easier picking to usb-linus

 drivers/usb/core/port.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c628c1abc907..4d63496f98b6 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -573,7 +573,7 @@ static int match_location(struct usb_device *peer_hdev, void *p)
 	struct usb_hub *peer_hub = usb_hub_to_struct_hub(peer_hdev);
 	struct usb_device *hdev = to_usb_device(port_dev->dev.parent->parent);
 
-	if (!peer_hub)
+	if (!peer_hub || port_dev->connect_type == USB_PORT_NOT_USED)
 		return 0;
 
 	hcd = bus_to_hcd(hdev->bus);
@@ -584,7 +584,8 @@ static int match_location(struct usb_device *peer_hdev, void *p)
 
 	for (port1 = 1; port1 <= peer_hdev->maxchild; port1++) {
 		peer = peer_hub->ports[port1 - 1];
-		if (peer && peer->location == port_dev->location) {
+		if (peer && peer->connect_type != USB_PORT_NOT_USED &&
+		    peer->location == port_dev->location) {
 			link_peers_report(port_dev, peer);
 			return 1; /* done */
 		}
-- 
2.25.1


