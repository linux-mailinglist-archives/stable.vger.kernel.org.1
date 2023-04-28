Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8CC6F16BA
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345879AbjD1LaB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345825AbjD1L36 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216925B8C
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D7864302
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81AEC4331D;
        Fri, 28 Apr 2023 11:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681393;
        bh=uci9wIk8BpcGmFwleZlnbCm2pQBYzVE/NZFFI1xTMCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eu7sQKi4urB8dyqWiJN0ndKegALjNeu2f1C2w1zw14JWABUMCH56aqvGXp7ldTzzr
         PTUvuPPv5l2ldDHhdMtpoxMJu/pSLCJg3Ymt5rrsqzRk5Ph+hsHtPIwjRB8dw1WniP
         8itsg8G8gqZrCLHAAGieqdvTrczCJ1xyiCOOFVv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Hasemeyer <markhas@chromium.org>
Subject: [PATCH 5.15 01/13] PCI/ASPM: Remove pcie_aspm_pm_state_change()
Date:   Fri, 28 Apr 2023 13:28:05 +0200
Message-Id: <20230428112039.191223013@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
References: <20230428112039.133978540@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 08d0cc5f34265d1a1e3031f319f594bd1970976c upstream.

pcie_aspm_pm_state_change() was introduced at the inception of PCIe ASPM
code, but it can cause some issues. For instance, when ASPM config is
changed via sysfs, those changes won't persist across power state change
because pcie_aspm_pm_state_change() overwrites them.

Also, if the driver restores L1SS [1] after system resume, the restored
state will also be overwritten by pcie_aspm_pm_state_change().

Remove pcie_aspm_pm_state_change().  If there's any hardware that really
needs it to function, a quirk can be used instead.

[1] https://lore.kernel.org/linux-pci/20220201123536.12962-1-vidyas@nvidia.com/
Link: https://lore.kernel.org/r/20220509073639.2048236-1-kai.heng.feng@canonical.com
[bhelgaas: remove additional pcie_aspm_pm_state_change() call in
pci_set_low_power_state(), added by
10aa5377fc8a ("PCI/PM: Split pci_raw_set_power_state()") and moved by
7957d201456f ("PCI/PM: Relocate pci_set_low_power_state()")]
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
[manual backport: pci_set_low_power_state does not exist in v5.15]
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci.c       |    3 ---
 drivers/pci/pci.h       |    2 --
 drivers/pci/pcie/aspm.c |   19 -------------------
 3 files changed, 24 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1140,9 +1140,6 @@ static int pci_raw_set_power_state(struc
 	if (need_restore)
 		pci_restore_bars(dev);
 
-	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
-
 	return 0;
 }
 
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -595,12 +595,10 @@ bool pcie_wait_for_link(struct pci_dev *
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
-void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
-static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1020,25 +1020,6 @@ out:
 	up_read(&pci_bus_sem);
 }
 
-/* @pdev: the root port or switch downstream port */
-void pcie_aspm_pm_state_change(struct pci_dev *pdev)
-{
-	struct pcie_link_state *link = pdev->link_state;
-
-	if (aspm_disabled || !link)
-		return;
-	/*
-	 * Devices changed PM state, we should recheck if latency
-	 * meets all functions' requirement
-	 */
-	down_read(&pci_bus_sem);
-	mutex_lock(&aspm_lock);
-	pcie_update_aspm_capable(link->root);
-	pcie_config_aspm_path(link);
-	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
-}
-
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;


