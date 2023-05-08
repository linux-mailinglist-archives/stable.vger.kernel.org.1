Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C601D6FA4D6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjEHKDr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjEHKDp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:03:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABFF2EB21
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F29361EF7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A40C433EF;
        Mon,  8 May 2023 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540221;
        bh=9bnz+Vq1Lxg90s6NpnkIMPrGy0eVwjlgYdDFZ6YKs0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1ZXNcs2Uppn2i/yZgI4OOMtk4ocROKjbu2i0WI8A9ik+1StLabSZEeuO5FlpfBQE
         vqE+t6dNVpr9bdXKeUyXJxOMxEy9VnegKNFDEx4TksyKXyL95gw+BTFCBHT7LI9c3k
         wf4KtuUn2+rTMJXVIxzqwQHY0o7VbzlDpM3dPcJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sanket Goswami <Sanket.Goswami@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 240/611] platform/x86/amd: pmc: Utilize SMN index 0 for driver probe
Date:   Mon,  8 May 2023 11:41:22 +0200
Message-Id: <20230508094430.202499347@linuxfoundation.org>
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
index 752015ca507f9..2ecee810c960a 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <asm/amd_nb.h>
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
@@ -55,8 +56,6 @@
 #define S2D_TELEMETRY_DRAMBYTES_MAX	0x1000000
 
 /* Base address of SMU for mapping physical address to virtual address */
-#define AMD_PMC_SMU_INDEX_ADDRESS	0xB8
-#define AMD_PMC_SMU_INDEX_DATA		0xBC
 #define AMD_PMC_MAPPING_SIZE		0x01000
 #define AMD_PMC_BASE_ADDR_OFFSET	0x10000
 #define AMD_PMC_BASE_ADDR_LO		0x13B102E8
@@ -958,30 +957,18 @@ static int amd_pmc_probe(struct platform_device *pdev)
 
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



