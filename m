Return-Path: <stable+bounces-10584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948082C1F7
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E062850FB
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F76DD05;
	Fri, 12 Jan 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDLqQUY1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21566DCF6;
	Fri, 12 Jan 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705070246; x=1736606246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HsB4HaMTsqQLPuXj053RwIoKIWGUPaIzvnowSdZxOEY=;
  b=nDLqQUY1nxb+U6OvXst9dnyudtB/hwEz84H/knhqa9wZvgnpy//YG17W
   OjOsq0eG+XGyjYRGiY9mOaLYUWzfSoXkpLZRe5DcSyfmqeB+gSPL6xvyN
   3cbkFv5FtJ4CCnOwwUba9ad6yRd0qFCJnxVx/gFXaF6iYktKO6q50+jNi
   9a5cQvXL38SVNPY/IUv7umAM9ZnY5QEeMJ4xK9WMqXqi7UMztvvefLCX6
   jX769SefxntEvDua1lfDefEZjv4JQ0kbyXbmABUDZ78PXVMcVAaQK33Mk
   jfAcrdSxLCsNg+W2CRR0Uis1gp17PG+bSM9CRgoYqXTTuPIevuz/ZoLq2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="485362718"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="485362718"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="926411259"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="926411259"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2024 06:37:23 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: dwc3: pci: add support for the Intel Arrow Lake-H
Date: Fri, 12 Jan 2024 16:37:23 +0200
Message-ID: <20240112143723.3823787-1-heikki.krogerus@linux.intel.com>
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

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable@vger.kernel.org
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


