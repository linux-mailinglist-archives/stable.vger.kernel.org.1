Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465CB75D29E
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGUTBr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjGUTBp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9927B30CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2089761D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335E0C433C8;
        Fri, 21 Jul 2023 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966103;
        bh=ospjIXQgJxhs57aVXGQxwqvZZ1RjCjl6TblAJFXTzpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FS5ireRkx6nNsDU/klFcEcAIvPEmnmA82TREP44k4d0T3N1jrv7vUckHm2MtLJLfj
         COjG/3Vz3QXY/NC+mOVRnLargmZLgB2Pw2wpRzLwiMJ7hkeXpSn/DpxhFKQpvYSftD
         Ns/WTfToQ+D3Q2PyvmjFHz+8dOJai0iUKWTL1EII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Sasha Levin <sashal@kernel.org>,
        Zongquan Qin <qinzongquan@sangfor.com.cn>
Subject: [PATCH 5.15 197/532] PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free
Date:   Fri, 21 Jul 2023 18:01:41 +0200
Message-ID: <20230721160625.097063058@linuxfoundation.org>
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

From: Ding Hui <dinghui@sangfor.com.cn>

[ Upstream commit 456d8aa37d0f56fc9e985e812496e861dcd6f2f2 ]

Struct pcie_link_state->downstream is a pointer to the pci_dev of function
0.  Previously we retained that pointer when removing function 0, and
subsequent ASPM policy changes dereferenced it, resulting in a
use-after-free warning from KASAN, e.g.:

  # echo 1 > /sys/bus/pci/devices/0000:03:00.0/remove
  # echo powersave > /sys/module/pcie_aspm/parameters/policy

  BUG: KASAN: slab-use-after-free in pcie_config_aspm_link+0x42d/0x500
  Call Trace:
   kasan_report+0xae/0xe0
   pcie_config_aspm_link+0x42d/0x500
   pcie_aspm_set_policy+0x8e/0x1a0
   param_attr_store+0x162/0x2c0
   module_attr_store+0x3e/0x80

PCIe spec r6.0, sec 7.5.3.7, recommends that software program the same ASPM
Control value in all functions of multi-function devices.

Disable ASPM and free the pcie_link_state when any child function is
removed so we can discard the dangling pcie_link_state->downstream pointer
and maintain the same ASPM Control configuration for all functions.

[bhelgaas: commit log and comment]
Debugged-by: Zongquan Qin <qinzongquan@sangfor.com.cn>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Fixes: b5a0a9b59c81 ("PCI/ASPM: Read and set up L1 substate capabilities")
Link: https://lore.kernel.org/r/20230507034057.20970-1-dinghui@sangfor.com.cn
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b3ad316418f1c..c58294f53fcd1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -993,21 +993,24 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	/*
-	 * All PCIe functions are in one slot, remove one function will remove
-	 * the whole slot, so just wait until we are the last function left.
-	 */
-	if (!list_empty(&parent->subordinate->devices))
-		goto out;
 
 	link = parent->link_state;
 	root = link->root;
 	parent_link = link->parent;
 
-	/* All functions are removed, so just disable ASPM for the link */
+	/*
+	 * link->downstream is a pointer to the pci_dev of function 0.  If
+	 * we remove that function, the pci_dev is about to be deallocated,
+	 * so we can't use link->downstream again.  Free the link state to
+	 * avoid this.
+	 *
+	 * If we're removing a non-0 function, it's possible we could
+	 * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
+	 * programming the same ASPM Control value for all functions of
+	 * multi-function devices, so disable ASPM for all of them.
+	 */
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
-	/* Clock PM is for endpoint device */
 	free_link_state(link);
 
 	/* Recheck latencies and configure upstream links */
@@ -1015,7 +1018,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_update_aspm_capable(root);
 		pcie_config_aspm_path(parent_link);
 	}
-out:
+
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
-- 
2.39.2



