Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5367BE08F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377356AbjJINlc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377354AbjJINlb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:41:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C89C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:41:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A489C433C7;
        Mon,  9 Oct 2023 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858889;
        bh=bO+nvJHTMAxeiIv3+7W69+N4co15SDvqMfHC8XkvcFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cS7zkRHWMPaUt20PGDafDV0Cs2RU5i6WUsR+36wHb/9Yu1gkbbnGNsSj3CqATf/8x
         99Pg2syoFQ18zQPFSBzvxWb1e84++SDCtR/GzhZ+6Pvnv4X6zjKe44VBXyThc/lOB1
         th22kLC+s8+fr0OaRcVONXDM6S80JExRlgYD7svU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Prike Liang <prike.liang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 133/226] ACPI: Check StorageD3Enable _DSD property in ACPI code
Date:   Mon,  9 Oct 2023 15:01:34 +0200
Message-ID: <20231009130130.233069496@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 2744d7a0733503931b71c00d156119ced002f22c ]

Although first implemented for NVME, this check may be usable by
other drivers as well. Microsoft's specification explicitly mentions
that is may be usable by SATA and AHCI devices.  Google also indicates
that they have used this with SDHCI in a downstream kernel tree that
a user can plug a storage device into.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Suggested-by: Keith Busch <kbusch@kernel.org>
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Prike Liang <prike.liang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: dad651b2a44e ("nvme-pci: do not set the NUMA node of device if it has none")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/device_pm.c | 29 +++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 28 +---------------------------
 include/linux/acpi.h     |  5 +++++
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index ecd2ddc2215f5..66e53df758655 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1326,4 +1326,33 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_storage_d3 - Check if D3 should be used in the suspend path
+ * @dev: Device to check
+ *
+ * Return %true if the platform firmware wants @dev to be programmed
+ * into D3hot or D3cold (if supported) in the suspend path, or %false
+ * when there is no specific preference. On some platforms, if this
+ * hint is ignored, @dev may remain unresponsive after suspending the
+ * platform as a whole.
+ *
+ * Although the property has storage in the name it actually is
+ * applied to the PCIe slot and plugging in a non-storage device the
+ * same platform restrictions will likely apply.
+ */
+bool acpi_storage_d3(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	u8 val;
+
+	if (!adev)
+		return false;
+	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
+			&val))
+		return false;
+	return val == 1;
+}
+EXPORT_SYMBOL_GPL(acpi_storage_d3);
+
 #endif /* CONFIG_PM */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aaead9b3a570..e384ade6c2cd2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2840,32 +2840,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	u8 val;
-
-	/*
-	 * Look for _DSD property specifying that the storage device on the port
-	 * must use D3 to support deep platform power savings during
-	 * suspend-to-idle.
-	 */
-
-	if (!adev)
-		return false;
-	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
-			&val))
-		return false;
-	return val == 1;
-}
-#else
-static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	return false;
-}
-#endif /* CONFIG_ACPI */
-
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2915,7 +2889,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
-	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
+	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 96d69404a54ff..9c184dbceba47 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1001,6 +1001,7 @@ int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
+bool acpi_storage_d3(struct device *dev);
 #else
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
@@ -1008,6 +1009,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline bool acpi_storage_d3(struct device *dev)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
-- 
2.40.1



