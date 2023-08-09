Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04B5775BD5
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjHILVd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjHILVc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:21:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607DAED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B54631EE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDBDC433C8;
        Wed,  9 Aug 2023 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580091;
        bh=6iI6/vCHSfKb+uIjXTBGyP96xUBJmqOKzHe5LVLcX+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0kFDXAj2LVS4/VfX+RbHkD5vgBB/0oL0HQKqxTrq88xHWC92X1F5V8GQMtIHsGaUz
         /2L8xMHwX1wwufe+E41W6E45nxHuFR8IWQRNlM1P0iHkX0Lyx0m0u3ou/jUWU4rtx+
         3OzQT57dAiJ4AKlD9Q8r0LizbL0ALjp/UmlTr0DE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 224/323] PCI: Rework pcie_retrain_link() wait loop
Date:   Wed,  9 Aug 2023 12:41:02 +0200
Message-ID: <20230809103708.343056806@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

[ Upstream commit 658eec837b11fbfab9082ebf8da24d94cefa47c0 ]

Transform wait code to a "do {} while (time_before())" loop as recommended
by reviewer.  No functional change intended.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: e7e39756363a ("PCI/ASPM: Avoid link retraining race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 279f9f0197b01..598e246fa70ed 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -206,7 +206,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 static bool pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
-	unsigned long start_jiffies;
+	unsigned long end_jiffies;
 	u16 reg16;
 
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
@@ -223,15 +223,13 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	}
 
 	/* Wait for link training end. Break out after waiting for timeout */
-	start_jiffies = jiffies;
-	for (;;) {
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
 		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
 		if (!(reg16 & PCI_EXP_LNKSTA_LT))
 			break;
-		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
-			break;
 		msleep(1);
-	}
+	} while (time_before(jiffies, end_jiffies));
 	return !(reg16 & PCI_EXP_LNKSTA_LT);
 }
 
-- 
2.39.2



