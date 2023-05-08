Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7546FAAFF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjEHLId (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjEHLIA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98342C905
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410D562ADB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D22C433D2;
        Mon,  8 May 2023 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544070;
        bh=qt0/3tTN3yauaAXAdXNKbmXSUH0lno0z/7537ylwbZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wjfcy2Ip8DuaKulAURg4oD7GMtczISCFqWBeUKNjuLJ3ioGnVlpYVT3Seb2yYb9hU
         Y5E0b/R3jhUYIp35d1ROGMgaysv8Stm1B1tSx1LS7LnXE/HE9lRL6ygU31OTz+Zz+n
         zTDyec9cMxDfak+3AaNqfLzm8C+nNoEFvvt/X1qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sanket Goswami <Sanket.Goswami@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 293/694] platform/x86/amd: pmc: Move out of BIOS SMN pair for STB init
Date:   Mon,  8 May 2023 11:42:08 +0200
Message-Id: <20230508094441.787912569@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit 8d99129eef8f42377b41c1bacee9f8ce806e9f44 ]

The current SMN index used for the driver probe seems to be meant
for the BIOS pair and there are potential concurrency problems that can
occur with an inopportune SMI.

It is been advised to use SMN_INDEX_0 instead of SMN_INDEX_6, which is
what amd_nb.c provides and this function has protections to ensure that
only one caller can use it at a time.

Fixes: 426c0ff27b83 ("platform/x86: amd-pmc: Add support for AMD Smart Trace Buffer")
Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20230409185348.556161-7-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 71fb8266133d8..69f305496643f 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -38,8 +38,6 @@
 #define AMD_PMC_SCRATCH_REG_YC		0xD14
 
 /* STB Registers */
-#define AMD_PMC_STB_INDEX_ADDRESS	0xF8
-#define AMD_PMC_STB_INDEX_DATA		0xFC
 #define AMD_PMC_STB_PMI_0		0x03E30600
 #define AMD_PMC_STB_S2IDLE_PREPARE	0xC6000001
 #define AMD_PMC_STB_S2IDLE_RESTORE	0xC6000002
@@ -923,17 +921,9 @@ static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
 {
 	int err;
 
-	err = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_ADDRESS, AMD_PMC_STB_PMI_0);
+	err = amd_smn_write(0, AMD_PMC_STB_PMI_0, data);
 	if (err) {
-		dev_err(dev->dev, "failed to write addr in stb: 0x%X\n",
-			AMD_PMC_STB_INDEX_ADDRESS);
-		return pcibios_err_to_errno(err);
-	}
-
-	err = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_DATA, data);
-	if (err) {
-		dev_err(dev->dev, "failed to write data in stb: 0x%X\n",
-			AMD_PMC_STB_INDEX_DATA);
+		dev_err(dev->dev, "failed to write data in stb: 0x%X\n", AMD_PMC_STB_PMI_0);
 		return pcibios_err_to_errno(err);
 	}
 
@@ -944,18 +934,10 @@ static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
 {
 	int i, err;
 
-	err = pci_write_config_dword(dev->rdev, AMD_PMC_STB_INDEX_ADDRESS, AMD_PMC_STB_PMI_0);
-	if (err) {
-		dev_err(dev->dev, "error writing addr to stb: 0x%X\n",
-			AMD_PMC_STB_INDEX_ADDRESS);
-		return pcibios_err_to_errno(err);
-	}
-
 	for (i = 0; i < FIFO_SIZE; i++) {
-		err = pci_read_config_dword(dev->rdev, AMD_PMC_STB_INDEX_DATA, buf++);
+		err = amd_smn_read(0, AMD_PMC_STB_PMI_0, buf++);
 		if (err) {
-			dev_err(dev->dev, "error reading data from stb: 0x%X\n",
-				AMD_PMC_STB_INDEX_DATA);
+			dev_err(dev->dev, "error reading data from stb: 0x%X\n", AMD_PMC_STB_PMI_0);
 			return pcibios_err_to_errno(err);
 		}
 	}
-- 
2.39.2



