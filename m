Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C427A3C00
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbjIQUZJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbjIQUY4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:24:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B510B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:24:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655BBC433C8;
        Sun, 17 Sep 2023 20:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982291;
        bh=diRXC18a4RuoOrcjo2ljd5ZE8NRY3NktJKub1m0eeI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GROTGEtMrFbZq5gKiCoS/r9umqf1rdXGBEz0SM0gKQPgZzVE+zM0mZi91gUUIF8VE
         2bSp4T6n5uWEb+yXkHWfXNvh3TYe7J9nrGUmceMBfBZvOn3QDC8N0op+iE4wP/ICGK
         cCNUMaQkrqZ6u08G0VkH5HOcwEElEgDOk4SF30sQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 207/511] PCI: pciehp: Use RMW accessors for changing LNKCTL
Date:   Sun, 17 Sep 2023 21:10:34 +0200
Message-ID: <20230917191118.820672937@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 5f75f96c61039151c193775d776fde42477eace1 ]

As hotplug is not the only driver touching LNKCTL, use the RMW capability
accessor which handles concurrent changes correctly.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Fixes: 7f822999e12a ("PCI: pciehp: Add Disable/enable link functions")
Link: https://lore.kernel.org/r/20230717120503.15276-4-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 60098a701e83a..7773009b8b32e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -332,17 +332,11 @@ int pciehp_check_link_status(struct controller *ctrl)
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_ctrl;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_LD,
+					   enable ? 0 : PCI_EXP_LNKCTL_LD);
 
-	if (enable)
-		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
-	else
-		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
-
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
-	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
 	return 0;
 }
 
-- 
2.40.1



