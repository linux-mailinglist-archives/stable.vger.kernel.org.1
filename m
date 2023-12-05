Return-Path: <stable+bounces-4643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCC5804D27
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 10:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB2D1F214D8
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7783D983;
	Tue,  5 Dec 2023 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7tG/LKK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871A111F;
	Tue,  5 Dec 2023 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701767083; x=1733303083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VCYXjHvj6vQAnVMBfKsjYdOGUml5t+S2AlaIXferjKU=;
  b=m7tG/LKK+kicsfluRVH9dfjJe/Y65QCipF42e0cfZWlJeM8JEtfiakI9
   x16tRaweZ1L5l5yZN1LJq3IXc1w8U2XPSwR/UMQzmErral9aMb8UGfjDX
   a99oj04tqkD89kjydWElnnS4xItjJAVadyndLk7QAwAK62JjWVhDa1KFg
   FJ8BBVv9XiLsjoLHm6DNqfMOJWGoUv3nnUTml6UMfSd0wf1Gm69uFcAfe
   5ZwPNgXXPSweGq3sRch8vY3akdBgK/Gye/TV90IIj1fkjf0Jup0F8agRC
   vS/7kNk9G6SKpwpRWy5ZK3rPdPVTvx2HFF9W2DPtj9B25zPu56iYpZ3oM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378891874"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="378891874"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1102386629"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1102386629"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 05 Dec 2023 01:04:38 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org,
	mario.limonciello@amd.com,
	regressions@lists.linux.dev,
	regressions@leemhuis.info,
	Basavaraj.Natikar@amd.com,
	pmenzel@molgen.mpg.de,
	bugs-a21@moonlit-rail.com,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
Date: Tue,  5 Dec 2023 11:05:48 +0200
Message-Id: <20231205090548.1377667-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023120521-dusk-handwrite-cea3@gregkh>
References: <2023120521-dusk-handwrite-cea3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4baf1218150985ee3ab0a27220456a1f027ea0ac.

Enabling runtime pm as default for all AMD xHC 1.1 controllers caused
regression. An initial attempt to fix those was done in commit a5d6264b638e
("xhci: Enable RPM on controllers that support low-power states") but new
issues are still seen.

Revert this to get those AMD xHC 1.1 systems working

This patch went to stable an needs to be reverted from there as well.

Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
Link: https://lore.kernel.org/linux-usb/55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
v1 -> v2
Revert only one patch, keep commit a5d6264b638
Minor commit message changes

 drivers/usb/host/xhci-pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 95ed9404f6f8..d6fc08e5db8f 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -535,8 +535,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-	else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
-		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
-- 
2.25.1


