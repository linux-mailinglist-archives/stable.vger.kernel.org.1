Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8B719DFF
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjFAN2P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjFAN2D (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C72E4C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28A79644E0
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4513BC433EF;
        Thu,  1 Jun 2023 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626058;
        bh=z7WCTmD4fDz35QUruiaMPQauvoIyXOgnvS8RGV3SJQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLPrlCVuCNm/EP7E79tXBMYVSVWqb3daeh57+Gw3HroSDtrnecVwAvak3B0nJZ+uz
         3R1AkGfnDw5PjxdJFrg2LOxoGivHiqqD164T4HCthmAZgDUjPL6G4jvwBZGw0FDdag
         BF+bkqXsjmd17G2BM+XFvcdbZoKX7leHV+R7rCgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 05/42] platform/x86/amd/pmf: Fix CnQF and auto-mode after resume
Date:   Thu,  1 Jun 2023 14:21:14 +0100
Message-Id: <20230601131939.296909185@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit b54147fa374dbeadcb01b1762db1a793e06e37de ]

After suspend/resume cycle there is an error message and auto-mode
or CnQF stops working.

[ 5741.447511] amd-pmf AMDI0100:00: SMU cmd failed. err: 0xff
[ 5741.447523] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_RESPONSE:ff
[ 5741.447527] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_ARGUMENT:7
[ 5741.447531] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_MESSAGE:16
[ 5741.447540] amd-pmf AMDI0100:00: [AUTO_MODE] avg power: 0 mW mode: QUIET

This is because the DRAM address used for accessing metrics table
needs to be refreshed after a suspend resume cycle. Add a resume
callback to reset this again.

Fixes: 1a409b35c995 ("platform/x86/amd/pmf: Get performance metrics from PMFW")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230513011408.958-1-mario.limonciello@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/core.c | 32 ++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 0acc0b6221290..dc9803e1a4b9b 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -245,24 +245,29 @@ static const struct pci_device_id pmf_pci_ids[] = {
 	{ }
 };
 
-int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
+static void amd_pmf_set_dram_addr(struct amd_pmf_dev *dev)
 {
 	u64 phys_addr;
 	u32 hi, low;
 
-	INIT_DELAYED_WORK(&dev->work_buffer, amd_pmf_get_metrics);
+	phys_addr = virt_to_phys(dev->buf);
+	hi = phys_addr >> 32;
+	low = phys_addr & GENMASK(31, 0);
+
+	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_HIGH, 0, hi, NULL);
+	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_LOW, 0, low, NULL);
+}
 
+int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
+{
 	/* Get Metrics Table Address */
 	dev->buf = kzalloc(sizeof(dev->m_table), GFP_KERNEL);
 	if (!dev->buf)
 		return -ENOMEM;
 
-	phys_addr = virt_to_phys(dev->buf);
-	hi = phys_addr >> 32;
-	low = phys_addr & GENMASK(31, 0);
+	INIT_DELAYED_WORK(&dev->work_buffer, amd_pmf_get_metrics);
 
-	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_HIGH, 0, hi, NULL);
-	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_LOW, 0, low, NULL);
+	amd_pmf_set_dram_addr(dev);
 
 	/*
 	 * Start collecting the metrics data after a small delay
@@ -273,6 +278,18 @@ int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
 	return 0;
 }
 
+static int amd_pmf_resume_handler(struct device *dev)
+{
+	struct amd_pmf_dev *pdev = dev_get_drvdata(dev);
+
+	if (pdev->buf)
+		amd_pmf_set_dram_addr(pdev);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_pmf_pm, NULL, amd_pmf_resume_handler);
+
 static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 {
 	int ret;
@@ -414,6 +431,7 @@ static struct platform_driver amd_pmf_driver = {
 		.name = "amd-pmf",
 		.acpi_match_table = amd_pmf_acpi_ids,
 		.dev_groups = amd_pmf_driver_groups,
+		.pm = pm_sleep_ptr(&amd_pmf_pm),
 	},
 	.probe = amd_pmf_probe,
 	.remove = amd_pmf_remove,
-- 
2.39.2



