Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5244F6FA4A4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjEHKBj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjEHKBf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F582E051
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3E52622C6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F034FC433D2;
        Mon,  8 May 2023 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540089;
        bh=NN+y6O8IajfjOcSalIZBOb2or+PXqa+pqr8O28XTn+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLXqGAObUrCKjIgMuEt0rwX0F+6tsyRQSdaCgI3yt79p1zOnSuK3J/Yklg76vTDUZ
         yxmZnKFz81tXjizg89cN/apderG8vEB+WTLue2v3X/n0pDr4NTR9wHU0vQ1kMUCDgv
         kfVKUOwA1miSLT4gmFE+IIC5Sjc8iiR1EbgLFp38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Patil Rajesh Reddy <Patil.Reddy@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 235/611] platform/x86/amd/pmf: Move out of BIOS SMN pair for driver probe
Date:   Mon,  8 May 2023 11:41:17 +0200
Message-Id: <20230508094430.038665811@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit aec8298c093f052fc8a86f9411b69b23953b0edb ]

The current SMN index used for the driver probe seems to be meant
for the BIOS pair and there are potential concurrency problems that can
occur with an inopportune SMI.

It is been advised to use SMN_INDEX_0 instead of SMN_INDEX_2, which is
what amd_nb.c provides and this function has protections to ensure that
only one caller can use it at a time.

Fixes: da5ce22df5fe ("platform/x86/amd/pmf: Add support for PMF core layer")
Co-developed-by: Patil Rajesh Reddy <Patil.Reddy@amd.com>
Signed-off-by: Patil Rajesh Reddy <Patil.Reddy@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20230406164807.50969-4-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/Kconfig |  1 +
 drivers/platform/x86/amd/pmf/core.c  | 22 +++++-----------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/Kconfig b/drivers/platform/x86/amd/pmf/Kconfig
index 6d89528c31779..d87986adf91e1 100644
--- a/drivers/platform/x86/amd/pmf/Kconfig
+++ b/drivers/platform/x86/amd/pmf/Kconfig
@@ -7,6 +7,7 @@ config AMD_PMF
 	tristate "AMD Platform Management Framework"
 	depends on ACPI && PCI
 	depends on POWER_SUPPLY
+	depends on AMD_NB
 	select ACPI_PLATFORM_PROFILE
 	help
 	  This driver provides support for the AMD Platform Management Framework.
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index da23639071d79..0acc0b6221290 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -8,6 +8,7 @@
  * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
  */
 
+#include <asm/amd_nb.h>
 #include <linux/debugfs.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -22,8 +23,6 @@
 #define AMD_PMF_REGISTER_ARGUMENT	0xA58
 
 /* Base address of SMU for mapping physical address to virtual address */
-#define AMD_PMF_SMU_INDEX_ADDRESS	0xB8
-#define AMD_PMF_SMU_INDEX_DATA		0xBC
 #define AMD_PMF_MAPPING_SIZE		0x01000
 #define AMD_PMF_BASE_ADDR_OFFSET	0x10000
 #define AMD_PMF_BASE_ADDR_LO		0x13B102E8
@@ -348,30 +347,19 @@ static int amd_pmf_probe(struct platform_device *pdev)
 	}
 
 	dev->cpu_id = rdev->device;
-	err = pci_write_config_dword(rdev, AMD_PMF_SMU_INDEX_ADDRESS, AMD_PMF_BASE_ADDR_LO);
-	if (err) {
-		dev_err(dev->dev, "error writing to 0x%x\n", AMD_PMF_SMU_INDEX_ADDRESS);
-		pci_dev_put(rdev);
-		return pcibios_err_to_errno(err);
-	}
 
-	err = pci_read_config_dword(rdev, AMD_PMF_SMU_INDEX_DATA, &val);
+	err = amd_smn_read(0, AMD_PMF_BASE_ADDR_LO, &val);
 	if (err) {
+		dev_err(dev->dev, "error in reading from 0x%x\n", AMD_PMF_BASE_ADDR_LO);
 		pci_dev_put(rdev);
 		return pcibios_err_to_errno(err);
 	}
 
 	base_addr_lo = val & AMD_PMF_BASE_ADDR_HI_MASK;
 
-	err = pci_write_config_dword(rdev, AMD_PMF_SMU_INDEX_ADDRESS, AMD_PMF_BASE_ADDR_HI);
-	if (err) {
-		dev_err(dev->dev, "error writing to 0x%x\n", AMD_PMF_SMU_INDEX_ADDRESS);
-		pci_dev_put(rdev);
-		return pcibios_err_to_errno(err);
-	}
-
-	err = pci_read_config_dword(rdev, AMD_PMF_SMU_INDEX_DATA, &val);
+	err = amd_smn_read(0, AMD_PMF_BASE_ADDR_HI, &val);
 	if (err) {
+		dev_err(dev->dev, "error in reading from 0x%x\n", AMD_PMF_BASE_ADDR_HI);
 		pci_dev_put(rdev);
 		return pcibios_err_to_errno(err);
 	}
-- 
2.39.2



