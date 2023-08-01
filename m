Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124A976ADDC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjHAJeF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjHAJds (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9632708
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A237614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1466BC433C9;
        Tue,  1 Aug 2023 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882296;
        bh=MMpgwVfwRIr3R/7D1k6okb5eVbRSG1k7+QbWCCu0RO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qP97lNXIDQVOs4kgFmpzHeWLGIu0u6yihnuUmrnpHZQ4lNCf4PLscGSDTfgCH9L/2
         exRi3QcRogkLfceUjAWOllIWkMTajIc5GgBuONQtunpVfZvdHPqJacOSt7BBSAgZJt
         s2O0xzQtejBYUeBOeBhjB3J9c061M8QnXg35LeVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 027/228] PCI/ASPM: Return 0 or -ETIMEDOUT from pcie_retrain_link()
Date:   Tue,  1 Aug 2023 11:18:05 +0200
Message-ID: <20230801091923.858472548@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit f5297a01ee805d7fa569d288ed65fc0f9ac9b03d ]

"pcie_retrain_link" is not a question with a true/false answer, so "bool"
isn't quite the right return type.  Return 0 for success or -ETIMEDOUT if
the retrain failed.  No functional change intended.

[bhelgaas: based on Ilpo's patch below]
Link: https://lore.kernel.org/r/20230502083923.34562-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: e7e39756363a ("PCI/ASPM: Avoid link retraining race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 74b8183c305df..96e7031a3b56f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -193,7 +193,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
-static bool pcie_retrain_link(struct pcie_link_state *link)
+static int pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
 	unsigned long end_jiffies;
@@ -220,7 +220,9 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 			break;
 		msleep(1);
 	} while (time_before(jiffies, end_jiffies));
-	return !(reg16 & PCI_EXP_LNKSTA_LT);
+	if (reg16 & PCI_EXP_LNKSTA_LT)
+		return -ETIMEDOUT;
+	return 0;
 }
 
 /*
@@ -289,15 +291,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		reg16 &= ~PCI_EXP_LNKCTL_CCC;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 
-	if (pcie_retrain_link(link))
-		return;
+	if (pcie_retrain_link(link)) {
 
-	/* Training failed. Restore common clock configurations */
-	pci_err(parent, "ASPM: Could not configure common clock\n");
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
+		/* Training failed. Restore common clock configurations */
+		pci_err(parent, "ASPM: Could not configure common clock\n");
+		list_for_each_entry(child, &linkbus->devices, bus_list)
+			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
 					   child_reg[PCI_FUNC(child->devfn)]);
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+	}
 }
 
 /* Convert L0s latency encoding to ns */
-- 
2.39.2



