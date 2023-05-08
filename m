Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117A26FAAFE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjEHLIY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjEHLH6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:07:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C458B2FA07
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F25662ADB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F10DC4339B;
        Mon,  8 May 2023 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544067;
        bh=9LWk6N3EAyvOfFnC2pphn2LjfN+9AGm/U9+pT9gj7kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNjdAqThtSx1n1cUSN5nNOM6qHHrY3dl5E+q7Qq+EkqU8mBZbCHXbToFnf1h1rULU
         vrZA4OMELi78gG5Izojhe0GKtGG33mg9UnrnSDl9g77MwJCPlHsHhZBov4AWr4p6A6
         e+VcNv/9fQRM8z6QDTOrfHmWqp49x3UcjeheUWg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sanket Goswami <Sanket.Goswami@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 292/694] platform/x86/amd: pmc: Utilize SMN index 0 for driver probe
Date:   Mon,  8 May 2023 11:42:07 +0200
Message-Id: <20230508094441.759032451@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit 310e782a99c7f16fb533a45d8f9c16defefa5aab ]

The current SMN index used for the driver probe seems to be meant
for the BIOS pair and there are potential concurrency problems that can
occur with an inopportune SMI.

It is been advised to use SMN_INDEX_0 instead of SMN_INDEX_2, which is
what amd_nb.c provides and this function has protections to ensure that
only one caller can use it at a time.

Fixes: 156ec4731cb2 ("platform/x86: amd-pmc: Add AMD platform support for S2Idle")
Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20230409185348.556161-6-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/Kconfig |  2 +-
 drivers/platform/x86/amd/pmc.c   | 23 +++++------------------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index 2ce8cb2170dfc..d9685aef0887d 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -7,7 +7,7 @@ source "drivers/platform/x86/amd/pmf/Kconfig"
 
 config AMD_PMC
 	tristate "AMD SoC PMC driver"
-	depends on ACPI && PCI && RTC_CLASS
+	depends on ACPI && PCI && RTC_CLASS && AMD_NB
 	select SERIO
 	help
 	  The driver provides support for AMD Power Management Controller
diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index f7acb66556987..71fb8266133d8 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <asm/amd_nb.h>
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
@@ -56,8 +57,6 @@
 #define S2D_TELEMETRY_DRAMBYTES_MAX	0x1000000
 
 /* Base address of SMU for mapping physical address to virtual address */
-#define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
-#define AMD_PMC_SMU_INDEX_DATA		0xBC
 #define AMD_PMC_MAPPING_SIZE		0x01000
 #define AMD_PMC_BASE_ADDR_OFFSET	0x10000
 #define AMD_PMC_BASE_ADDR_LO		0x13B102E8
@@ -983,30 +982,18 @@ static int amd_pmc_probe(struct platform_device *pdev)
 
 	dev->cpu_id = rdev->device;
 	dev->rdev = rdev;
-	err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_LO);
-	if (err) {
-		dev_err(dev->dev, "error writing to 0x%x\n", AMD_PMC_SMU_INDEX_ADDRESS);
-		err = pcibios_err_to_errno(err);
-		goto err_pci_dev_put;
-	}
-
-	err = pci_read_config_dword(rdev, AMD_PMC_SMU_INDEX_DATA, &val);
+	err = amd_smn_read(0, AMD_PMC_BASE_ADDR_LO, &val);
 	if (err) {
+		dev_err(dev->dev, "error reading 0x%x\n", AMD_PMC_BASE_ADDR_LO);
 		err = pcibios_err_to_errno(err);
 		goto err_pci_dev_put;
 	}
 
 	base_addr_lo = val & AMD_PMC_BASE_ADDR_HI_MASK;
 
-	err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_HI);
-	if (err) {
-		dev_err(dev->dev, "error writing to 0x%x\n", AMD_PMC_SMU_INDEX_ADDRESS);
-		err = pcibios_err_to_errno(err);
-		goto err_pci_dev_put;
-	}
-
-	err = pci_read_config_dword(rdev, AMD_PMC_SMU_INDEX_DATA, &val);
+	err = amd_smn_read(0, AMD_PMC_BASE_ADDR_HI, &val);
 	if (err) {
+		dev_err(dev->dev, "error reading 0x%x\n", AMD_PMC_BASE_ADDR_HI);
 		err = pcibios_err_to_errno(err);
 		goto err_pci_dev_put;
 	}
-- 
2.39.2



