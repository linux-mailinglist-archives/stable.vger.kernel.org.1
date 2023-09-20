Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4937A7DE6
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjITMNT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjITMNS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:13:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2FCDE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:13:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDE3C433C7;
        Wed, 20 Sep 2023 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211990;
        bh=B38tqsWjTXpsEmN0ZeLcFQCBkaOEH9azjRny+bBYmBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvyoRVDnl2B+iBJ3zsGH2sDgzb9Eh4svdgimsrGQjJ5sckEVGtX5fEAH7XGhgB21V
         kjsQf8yv3ar3LaxePPxh6adJZyyTMsNk/QwH/493q6utBE0ENRN9oM9couBVRaYdXX
         dCUpNDI5TTyao63pQEOxXIaoSh/cP9x6/ng8adjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 110/273] PCI/ASPM: Use RMW accessors for changing LNKCTL
Date:   Wed, 20 Sep 2023 13:29:10 +0200
Message-ID: <20230920112849.880506137@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit e09060b3b6b4661278ff8e1b7b81a37d5ea86eae ]

Don't assume that the device is fully under the control of ASPM and use RMW
capability accessors which do proper locking to avoid losing concurrent
updates to the register values.

If configuration fails in pcie_aspm_configure_common_clock(), the
function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
than the content of the whole LNKCTL registers. It aligns better with
how pcie_lnkctl_clear_and_set() expects its parameter and makes the
code more obvious to understand.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Fixes: 2a42d9dba784 ("PCIe: ASPM: Break out of endless loop waiting for PCI config bits to switch")
Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
Link: https://lore.kernel.org/r/20230717120503.15276-5-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index eec62f7377f48..118c91586798d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -260,7 +260,7 @@ static int pcie_retrain_link(struct pcie_link_state *link)
 static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 {
 	int same_clock = 1;
-	u16 reg16, parent_reg, child_reg[8];
+	u16 reg16, ccc, parent_old_ccc, child_old_ccc[8];
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	/*
@@ -282,6 +282,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Port might be already in common clock mode */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	parent_old_ccc = reg16 & PCI_EXP_LNKCTL_CCC;
 	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
 		bool consistent = true;
 
@@ -298,34 +299,29 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		pci_warn(parent, "ASPM: current common clock configuration is broken, reconfiguring\n");
 	}
 
+	ccc = same_clock ? PCI_EXP_LNKCTL_CCC : 0;
 	/* Configure downstream component, all functions */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
-		child_reg[PCI_FUNC(child->devfn)] = reg16;
-		if (same_clock)
-			reg16 |= PCI_EXP_LNKCTL_CCC;
-		else
-			reg16 &= ~PCI_EXP_LNKCTL_CCC;
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL, reg16);
+		child_old_ccc[PCI_FUNC(child->devfn)] = reg16 & PCI_EXP_LNKCTL_CCC;
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CCC, ccc);
 	}
 
 	/* Configure upstream component */
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	parent_reg = reg16;
-	if (same_clock)
-		reg16 |= PCI_EXP_LNKCTL_CCC;
-	else
-		reg16 &= ~PCI_EXP_LNKCTL_CCC;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_CCC, ccc);
 
 	if (pcie_retrain_link(link)) {
 
 		/* Training failed. Restore common clock configurations */
 		pci_err(parent, "ASPM: Could not configure common clock\n");
 		list_for_each_entry(child, &linkbus->devices, bus_list)
-			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
-					   child_reg[PCI_FUNC(child->devfn)]);
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+			pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+							   PCI_EXP_LNKCTL_CCC,
+							   child_old_ccc[PCI_FUNC(child->devfn)]);
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CCC, parent_old_ccc);
 	}
 }
 
-- 
2.40.1



