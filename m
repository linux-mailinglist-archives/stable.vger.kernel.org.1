Return-Path: <stable+bounces-3844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCD802F93
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 11:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37351F2111B
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE311EB42;
	Mon,  4 Dec 2023 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSGELP0I"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB080B6;
	Mon,  4 Dec 2023 02:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701684479; x=1733220479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LB2msYuHbVBbT2sen68LQlC3A1iL6Pk3GW17gEzOLH0=;
  b=JSGELP0IcQVi5WmsTT0w+2vhHTpPdPHSCLZLmqDmoG1G5i5ucgzERHAs
   jcBTGkyNGTm6eF+JoK8eku2kNeTIHIKaw43A+HKevLte5hpvv22jHNHbH
   rljO6fSiH6xFMkWWmtvlUi/m+tWjygHI7zTFDjeoqgSk0ETnGnvq5uWib
   dW/ktoZ9WgOmc8MId00YWRzVNGutIujl0fpE6CPTF486od04+JyfhftOq
   7GhXNO4Zv4GnGTjAT1gGobxr2i8mxN/NAM974ozN9TkMF+FYMa6oKb1rk
   kQJSf9cWff53F5j3YR+Z30TpnI0cEHoFO/1vtis/41b4EahIO5ZUVqNY5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="373898273"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="373898273"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 02:07:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="888481091"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="888481091"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2023 02:07:56 -0800
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
Subject: [PATCH 1/2] Revert "xhci: Enable RPM on controllers that support low-power states"
Date: Mon,  4 Dec 2023 12:08:58 +0200
Message-Id: <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
References: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a5d6264b638efeca35eff72177fd28d149e0764b.

This patch was an attempt to solve issues seen when enabling runtime PM
as default for all AMD 1.1 xHC hosts. see commit 4baf12181509
("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")

This was not enough, regressions are still seen, so start from a clean
slate and revert both of them.

This patch went to stable and should be reverted from there as well

Fixes: a5d6264b638e ("xhci: Enable RPM on controllers that support low-power states")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 95ed9404f6f8..bde43cef8846 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -695,9 +695,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
 	pm_runtime_put_noidle(&dev->dev);
 
-	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
-		pm_runtime_forbid(&dev->dev);
-	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
+	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
-- 
2.25.1


