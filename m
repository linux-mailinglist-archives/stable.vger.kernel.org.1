Return-Path: <stable+bounces-10863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1382D5ED
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 10:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BDF1F21D32
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEC5C2CE;
	Mon, 15 Jan 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg2J2Wcm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1C440A;
	Mon, 15 Jan 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705310903; x=1736846903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hArAJBivRDywIhpNEAo1PV7Hc5uBLnwJRLgIkzytAb0=;
  b=Qg2J2WcmXuXc6MadO8v4Y295YMA9/ZC3igKbYje2ChwU4IdZy9+9Kujp
   fBrYsKZ3Xh2ZlvXIs7db5GZzfJXaZdNgjmDwc52A+1a2Cx4TBK2zVgQir
   kEq/LxRwAXwkQezaZRR5wApfXdPw8WsOkKfbBJ3M0IuACgdpjlCjGGqpI
   ah8o7DlZq4VSPi2vsVOA/iKT0fzhYPrElS2aPKuGJallcJZIiyh9Ekkqw
   /VXR56/ZcPp7RcNRERrcvkq0oMox6LES3PHbb+fRCDZ6bRi7xdHMHzArp
   xPuXAXWTyPbFJpqZlbFZiHfLLLUJExgl3CTIAgAvKQmHFVMB52XDAMaqe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398438141"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="398438141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 01:28:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="927068416"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="927068416"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2024 01:28:21 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: pci: add support for the Intel Arrow Lake-H
Date: Mon, 15 Jan 2024 11:28:20 +0200
Message-ID: <20240115092820.1454492-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the necessary PCI ID for Intel Arrow Lake-H
devices.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable@vger.kernel.org
---
Changed since v2: Including changelog.
Changed since v1: CCd stable.
---
 drivers/usb/dwc3/dwc3-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 6604845c397c..39564e17f3b0 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -51,6 +51,8 @@
 #define PCI_DEVICE_ID_INTEL_MTLP		0x7ec1
 #define PCI_DEVICE_ID_INTEL_MTLS		0x7f6f
 #define PCI_DEVICE_ID_INTEL_MTL			0x7e7e
+#define PCI_DEVICE_ID_INTEL_ARLH		0x7ec1
+#define PCI_DEVICE_ID_INTEL_ARLH_PCH		0x777e
 #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
 #define PCI_DEVICE_ID_AMD_MR			0x163a
 
@@ -421,6 +423,8 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, MTLP, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTLS, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ARLH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ARLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, TGL, &dwc3_pci_intel_swnode) },
 
 	{ PCI_DEVICE_DATA(AMD, NL_USB, &dwc3_pci_amd_swnode) },
-- 
2.43.0


