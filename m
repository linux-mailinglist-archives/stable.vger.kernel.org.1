Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75772049A
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjFBOj2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjFBOj1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 10:39:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0BC1BC;
        Fri,  2 Jun 2023 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685716766; x=1717252766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03LuCHhFCmzwPVIBc2Q48ocGBZh0HC5gzPK8HstY9ig=;
  b=gJV6fTGrFbT6K7qH/wo1HVIMV9C0F9E+cyOiGlK4iakDVCPEM7rlmQfF
   Ra0gUWt53iIEzTI8hXMldb3vD86yma7EDDebIrSa3atikdD+haW+e/jLT
   37ZPbDFbPybU6K0PwEcJZ8NoVUk+dxKNCE7YLU8YIXkVqHA7E8lOT7BZy
   EW+zo7qOyWYs5bSlXO1BJan2sz+ZNFi1bgDuN4yLtQ4hyvYboxiDK0VaG
   lPTJjprLsce46B01DlQoCYCW/t81AbM7zsHzsNAeedsBXDIrsKWIJQDWe
   BKvgINA2T4aN24vwu1mhYeHC33To7tx4hXcZbofXhkqrxAtpKEMXXGx+9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="358311291"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="358311291"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="707877460"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="707877460"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2023 07:39:04 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     <gregkh@linuxfoundation.org>
Cc:     <linux-usb@vger.kernel.org>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 08/11] xhci: Fix resume issue of some ZHAOXIN hosts
Date:   Fri,  2 Jun 2023 17:40:06 +0300
Message-Id: <20230602144009.1225632-9-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602144009.1225632-1-mathias.nyman@linux.intel.com>
References: <20230602144009.1225632-1-mathias.nyman@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

On ZHAOXIN ZX-100 project, xHCI can't work normally after resume
from system Sx state. To fix this issue, when resume from system
Sx state, reinitialize xHCI instead of restore.
So, Add XHCI_RESET_ON_RESUME quirk for ZX-100 to fix issue of
resuming from system Sx state.

Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 611703f863e0..2103c6c0a967 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -521,6 +521,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
+	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
+		if (pdev->device == 0x9202)
+			xhci->quirks |= XHCI_RESET_ON_RESUME;
+	}
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-- 
2.25.1

