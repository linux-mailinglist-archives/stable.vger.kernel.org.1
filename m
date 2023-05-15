Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA09702E83
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjEONkS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbjEONkN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 09:40:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C91FC8;
        Mon, 15 May 2023 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684158012; x=1715694012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YIKX4jDL0Bu17PUG+69eHYZuspkIjzYlHvQNZNS4jMk=;
  b=cnPlsSi8HS42mTNR274BQM1cqiusDnB1fHMf2bauAENR3jFS6K/ZL8G1
   c85AUYFf8EFyvOMncY5s8dS9PtKmE0Ajqz4Q9I0lMs9nLOLex32kRw+Ro
   GrRbMqh1DyPZCS8Ir8OYYLYTR9BWXYI1Ua6Pa4vcV8xCETYD/wMFf1YY8
   zn8E0IKzPrL0fa2Fn64q4t2VQEMwLvgf20chr8qKOX4vTuY9JGwBx/ocp
   M/K2rIV0U/3v5pjZPbp+gBuNjsJZtMGJMKLLqBvmXN0HngiJOhSNwY3MV
   uhKnwuJpVsyfD3xXRHBflYXwxnr4cbAl6jzKsTM+XMdLtacHHwrqHr4m1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="414598008"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="414598008"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 06:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="700964226"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="700964226"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2023 06:39:55 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     <gregkh@linuxfoundation.org>
Cc:     <linux-usb@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Donghun Yoon <donghun.yoon@lge.com>, stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 1/2] xhci-pci: Only run d3cold avoidance quirk for s2idle
Date:   Mon, 15 May 2023 16:40:58 +0300
Message-Id: <20230515134059.161110-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515134059.161110-1-mathias.nyman@linux.intel.com>
References: <20230515134059.161110-1-mathias.nyman@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

Donghun reports that a notebook that has an AMD Ryzen 5700U but supports
S3 has problems with USB after resuming from suspend. The issue was
bisected down to commit d1658268e439 ("usb: pci-quirks: disable D3cold on
xhci suspend for s2idle on AMD Renoir").

As this issue only happens on S3, narrow the broken D3cold quirk to only
run in s2idle.

Fixes: d1658268e439 ("usb: pci-quirks: disable D3cold on xhci suspend for s2idle on AMD Renoir")
Reported-and-tested-by: Donghun Yoon <donghun.yoon@lge.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 12 ++++++++++--
 drivers/usb/host/xhci.h     |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ddb79f23fb3b..79b3691f373f 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/reset.h>
+#include <linux/suspend.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -387,7 +388,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
 		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_XHCI)
-		xhci->quirks |= XHCI_BROKEN_D3COLD;
+		xhci->quirks |= XHCI_BROKEN_D3COLD_S2I;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
@@ -801,9 +802,16 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	 * Systems with the TI redriver that loses port status change events
 	 * need to have the registers polled during D3, so avoid D3cold.
 	 */
-	if (xhci->quirks & (XHCI_COMP_MODE_QUIRK | XHCI_BROKEN_D3COLD))
+	if (xhci->quirks & XHCI_COMP_MODE_QUIRK)
 		pci_d3cold_disable(pdev);
 
+#ifdef CONFIG_SUSPEND
+	/* d3cold is broken, but only when s2idle is used */
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
+	    xhci->quirks & (XHCI_BROKEN_D3COLD_S2I))
+		pci_d3cold_disable(pdev);
+#endif
+
 	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
 		xhci_pme_quirk(hcd);
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 08d721921b7b..6b690ec91ff3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1901,7 +1901,7 @@ struct xhci_hcd {
 #define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_BROKEN_D3COLD_S2I	BIT_ULL(41)
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-- 
2.25.1

