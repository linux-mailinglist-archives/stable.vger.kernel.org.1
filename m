Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A5375BEA2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjGUGSp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGUGR6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19B4690
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0EDD6112C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5239AC433C8;
        Fri, 21 Jul 2023 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689920100;
        bh=OT8RHjaeXN73sGBEHVzCl9231rsPA6rpN7WcO2Xl2lM=;
        h=Subject:To:Cc:From:Date:From;
        b=AQTIjVhjyhQjlnPORVazejg4JB5L7rCPKXm9JG6QihTAPpRZ1IxvzaibpwIWd/Np4
         gx3aCAh7R/Mq4PcT6mm28zni8sEHEmxX3gLJypQbMwT99EUWaGcOnhiXdqxy6wEQ4A
         RY3rl68KhDZyEGiT2q7QEu7Q5i5qflFmsitaRsSI=
Subject: FAILED: patch "[PATCH] PCI: rockchip: Set address alignment for endpoint mode" failed to apply to 4.19-stable tree
To:     dlemoal@kernel.org, lpieralisi@kernel.org,
        rick.wertenbroek@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:14:57 +0200
Message-ID: <2023072157-acclaim-backlog-a3d3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 7e6689b34a815bd379dfdbe9855d36f395ef056c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072157-acclaim-backlog-a3d3@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

7e6689b34a81 ("PCI: rockchip: Set address alignment for endpoint mode")
146221768c74 ("PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e6689b34a815bd379dfdbe9855d36f395ef056c Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Tue, 18 Apr 2023 09:46:58 +0200
Subject: [PATCH] PCI: rockchip: Set address alignment for endpoint mode

The address translation unit of the rockchip EP controller does not use
the lower 8 bits of a PCIe-space address to map local memory. Thus we
must set the align feature field to 256 to let the user know about this
constraint.

Link: https://lore.kernel.org/r/20230418074700.1083505-12-rick.wertenbroek@gmail.com
Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index edfced311a9f..0af0e965fb57 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -442,6 +442,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.align = 256,
 };
 
 static const struct pci_epc_features*

