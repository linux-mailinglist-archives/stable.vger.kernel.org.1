Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F770C697
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjEVTTx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjEVTTx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29700A3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CAD862808
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBFFC433D2;
        Mon, 22 May 2023 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783190;
        bh=vmAXRAibQafVFditrmBkX2E+TjCAu+N591+2Ysn0iU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNRE9q4LGasiwTHLPQ5qkM9tK6sAnKR+Nmy0Dlnn8k2BooSbV3W3l8qN2Mn9vvPLX
         MfTQKG8HhsEIMwEe7bxr9Y2L8CYICz2VlOpwv6nOL9b0wTOju5cb7iOltP9vJ6frPc
         VruaKjemj9S/xcPdmp2WgzyuegCmHfyWicy+v8Uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Donghun Yoon <donghun.yoon@lge.com>
Subject: [PATCH 5.15 168/203] xhci-pci: Only run d3cold avoidance quirk for s2idle
Date:   Mon, 22 May 2023 20:09:52 +0100
Message-Id: <20230522190359.631617923@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 2a821fc3136d5d99dcb9de152be8a052ca27d870 upstream.

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
Link: https://lore.kernel.org/r/20230515134059.161110-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-pci.c |   12 ++++++++++--
 drivers/usb/host/xhci.h     |    2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/reset.h>
+#include <linux/suspend.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -195,7 +196,7 @@ static void xhci_pci_quirks(struct devic
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
 		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_XHCI)
-		xhci->quirks |= XHCI_BROKEN_D3COLD;
+		xhci->quirks |= XHCI_BROKEN_D3COLD_S2I;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
@@ -610,9 +611,16 @@ static int xhci_pci_suspend(struct usb_h
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
 
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1902,7 +1902,7 @@ struct xhci_hcd {
 #define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_BROKEN_D3COLD_S2I	BIT_ULL(41)
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)


