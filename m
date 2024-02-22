Return-Path: <stable+bounces-23332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD04A85F9F2
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 14:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2701F276DC
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B7134CC2;
	Thu, 22 Feb 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuVYFKEO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC612FF73;
	Thu, 22 Feb 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609012; cv=none; b=lPhqHrXcNylh389rAyLazcB+SdgeiBCddeI9c01UIfKFfTJSxhf7FcD1DZxiPVqask4Z2Zq+oLL5IUHyIPAUc5ZNZ0QfuHKLx+0JE41xnK64GQpJyck0kGjkwgrqVktshzZknqZAIzzNZWgWEdWeXkE+INe8WiTgAkzAVC/ERJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609012; c=relaxed/simple;
	bh=ApuaoYJpD04fg2kJMhPXRaB6P+IDzTJrxoa3yqll1l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHlA7BZ51J0ck6Wzzh0hKisYe2EoW60ilDbZnrYa1NmeAk7o7Yps9K/KUEEcsaLfHRf9WXcJ4r3QNw6cUkPGUougH5pSA2CD37xsSk1diGPmM/uUPEkqVco7dt6iq2/j+XoluapthPF6fOMuvYyMAogkOEKrE3gU3gTaggR8FyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuVYFKEO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609011; x=1740145011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ApuaoYJpD04fg2kJMhPXRaB6P+IDzTJrxoa3yqll1l8=;
  b=EuVYFKEO7M3oFkoivkdH7GShJ8ih4EZb+dDFDbblNpsHH9qozPbgm8bg
   kLIHNApjxwia0KLHfz7lLXo/knFKMH+xRXVqYq44v1U63emGczz/7hibO
   fT1RQjkdoMJqlMEgxgComdFtvNOA0TXFqGa1IHFmR8IUm8fxIlWmLiE1Q
   Va7sKDjfIOtWLCnYijlNMjvnmKAxG4dovVGP615e0LTCDxmRZdSEqlEsW
   CqfwLMYCEthEnAuPVsfZXT1to1JERyQcAmiUXxtpjlacrVRvolMC1lun8
   SSSlAA518b3L2KbmuW5i9xRQMIxHIyWg/VgwHU9iN9niqoPzpDEZ21lq1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13961800"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13961800"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936851237"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936851237"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 05:36:45 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	<stern@rowland.harvard.edu>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] usb: port: Don't try to peer unused USB ports based on location
Date: Thu, 22 Feb 2024 15:38:19 +0200
Message-Id: <20240222133819.4149388-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222133819.4149388-1-mathias.nyman@linux.intel.com>
References: <20240222133819.4149388-1-mathias.nyman@linux.intel.com>
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

This is seen on DELL systems where all unused ports return zeroed
location data.

Don't try to peer or match ports that have connect type set to
USB_PORT_NOT_USED.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
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


