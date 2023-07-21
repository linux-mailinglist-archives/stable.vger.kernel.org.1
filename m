Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B556C75D3D8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjGUTPG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjGUTPG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE17189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C024A61D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0674C433C8;
        Fri, 21 Jul 2023 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966904;
        bh=Q+4CUHWm3BDzlDzpnZB5TLvS1iSe+P0JFkyz3HJb230=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0pbwNW3L25r8QBuZS/FUK38itArC5PKD6iOCmq0aaYW9c0f7H4aS2hMOy4POxA7QE
         MlFA5DVwv0W9Y0Gt9lMmTxMxNUnWG49C6TILquFWbH38OuV+TW0s3mQ1hqORPshTNt
         KZzX33dFUzOZr8K3UULf6ctv6QRWL/HHys7Yorw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.15 501/532] xhci: Fix resume issue of some ZHAOXIN hosts
Date:   Fri, 21 Jul 2023 18:06:45 +0200
Message-ID: <20230721160641.770903213@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
@@ -336,6 +336,11 @@ static void xhci_pci_quirks(struct devic
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


