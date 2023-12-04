Return-Path: <stable+bounces-3845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1A802F96
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 11:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733CD1C209D1
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E31EB57;
	Mon,  4 Dec 2023 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjKQRKLb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B78DF;
	Mon,  4 Dec 2023 02:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701684482; x=1733220482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F+phs8HZ/XkWka0qWXx+b0LrCOTF26PluA67cnYvAcI=;
  b=LjKQRKLb09EhfwirxsO3Wfsc9a93ovwpTWvx8piz16LlP6uCs+ex3UaV
   0DOq4/tbBOUvlsLPptLhbWB6Qbe6psdPHwCmDiBQz5E7UeMi4y2wVD9jZ
   NC86/HDuEXQ1MceVnwOPCX4RXHaEL743gvNWOBQl3ptBnR9yB5tIvuyj0
   03THP5B7fgw24ApKgRN9lKM50lkho3gBTz2jH9/IDmVThIKo6T6RWuiyf
   Vo+iOutpijiZ1pxvDHqDigsu61Go4v4I/O4AbK54IUx8pGuTJLQLPxSr/
   pO7XB6TnWqTqwAU5ltImUuf/tlizGQl+MOARxdDGEvkYaQMVDDQ1aZZ9x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="373898286"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="373898286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 02:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="888481099"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="888481099"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2023 02:07:59 -0800
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
Subject: [PATCH 2/2] Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
Date: Mon,  4 Dec 2023 12:08:59 +0200
Message-Id: <20231204100859.1332772-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
References: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
 <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
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

Revert them both and start from a clean slate.

This patch went to stable an needs to be reverted from there as well.

Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
Link: https://lore.kernel.org/linux-usb/55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index bde43cef8846..b9ae5c2a2527 100644
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


