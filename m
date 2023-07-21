Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091E575CF2C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGUQ2g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjGUQ1j (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3544EC2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F2D61D49
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ADDC433C8;
        Fri, 21 Jul 2023 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956655;
        bh=3HUdi+1ovrPciw8dHaJR0Sam/5o+g6dszQ14JgDCFIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDc2rRDlWQW34mPDM0EKUSQSwwjQv/blUPVIMQUfh9vLvg9kXXR3mvRlnOEfOCmeX
         ltglw4Jrio5AH1HCbW808Vcgm1RvsR8pJQhgO6CBc+6+2pdjchHD6/DOi37vY4uy6d
         rDKbPU+OmznQ82Ou5jhiy+WR8RKU1C0itiSUCrRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.4 226/292] xhci: Fix resume issue of some ZHAOXIN hosts
Date:   Fri, 21 Jul 2023 18:05:35 +0200
Message-ID: <20230721160538.575694350@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

commit f927728186f0de1167262d6a632f9f7e96433d1a upstream.

On ZHAOXIN ZX-100 project, xHCI can't work normally after resume
from system Sx state. To fix this issue, when resume from system
Sx state, reinitialize xHCI instead of restore.
So, Add XHCI_RESET_ON_RESUME quirk for ZX-100 to fix issue of
resuming from system Sx state.

Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <20230602144009.1225632-9-mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -528,6 +528,11 @@ static void xhci_pci_quirks(struct devic
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


