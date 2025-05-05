Return-Path: <stable+bounces-140543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF83AAA9BA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19EC46590A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1119312839;
	Mon,  5 May 2025 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufwQ5oSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA029C324;
	Mon,  5 May 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485109; cv=none; b=HQ5qq8oeq4nnaAs293nEHuaW3KsoJKHsMplufsurmgOhnJ9WCWnAaR1j40Lh/8N5iXg+tCenXjO2juRzDFNjsQBZxnve2o5QT5knyEc7CdgtzAjm2AeNRnWLRaBGIKRlbZCVPaJBtRb99U9zJWeIBuL5Ssn7EnBsgksdfxfPnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485109; c=relaxed/simple;
	bh=cBQTAsnfnToP87TSZImPQRuj5zjPXF1wUmXlEY6L/5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dq5fbuZMw1Cni9f1w/6Igc6mo5gkCMlePGgAPbH0gmrI/mZV1QMPDQwQWjK9Y4nK1RvdyAiiQQU0HO35j+xVDQDrpKyY+EbgOb/TczDVm8ol1PAF4Cl/3r5hclfRp6HwSEkdICjR25VHN76eyhVIiZU/9tXLY/uDqnjKBWAQHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufwQ5oSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9492DC4CEED;
	Mon,  5 May 2025 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485107;
	bh=cBQTAsnfnToP87TSZImPQRuj5zjPXF1wUmXlEY6L/5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufwQ5oSlNQOSnhxZBowvH8QU/m+BZKMLjYaCXF5oPyTN8F4oyFX2UtNwf8351mJLv
	 9G7MOO+xlgpYYr44tp2B2qiEzo/MW/QRJrq+rxiETcdIqi4GaG2eI9JRKnUnsS3zzg
	 2CXulhPzAN5VAb4yumRO5S47OtyRfO8c1/SojcIWLRDp4D6FWASdQeSbJ5JGAkLMec
	 cEiNJXJKlbzms1xhetHvf70c2XFzJ+fXDklARatOzAcfj1iC4O6pKzo4bWDrdxyOhj
	 BIT1f40Jh9QbKxOLcA45Wk+X+Env1q/OjFJDJmOa/JH2KMzgvtSteNuMmARY9woNrG
	 abBQ4iTY62hWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 165/486] iommu/vt-d: Move scalable mode ATS enablement to probe path
Date: Mon,  5 May 2025 18:34:01 -0400
Message-Id: <20250505223922.2682012-165-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 5518f239aff1baf772c5748da3add7243c5fb5df ]

Device ATS is currently enabled when a domain is attached to the device
and disabled when the domain is detached. This creates a limitation:
when the IOMMU is operating in scalable mode and IOPF is enabled, the
device's domain cannot be changed.

The previous code enables ATS when a domain is set to a device's RID and
disables it during RID domain switch. So, if a PASID is set with a
domain requiring PRI, ATS should remain enabled until the domain is
removed. During the PASID domain's lifecycle, if the RID's domain
changes, PRI will be disrupted because it depends on ATS, which is
disabled when the blocking domain is set for the device's RID.

Remove this limitation by moving ATS enablement to the device probe path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Link: https://lore.kernel.org/r/20250228092631.3425464-5-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 51 ++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 038a66388564a..5069a628deea1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1284,32 +1284,28 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 	return true;
 }
 
-static void iommu_enable_pci_caps(struct device_domain_info *info)
+static void iommu_enable_pci_ats(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	if (!dev_is_pci(info->dev))
+	if (!info->ats_supported)
 		return;
 
 	pdev = to_pci_dev(info->dev);
-	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
+	if (!pci_ats_page_aligned(pdev))
+		return;
+
+	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
 		info->ats_enabled = 1;
 }
 
-static void iommu_disable_pci_caps(struct device_domain_info *info)
+static void iommu_disable_pci_ats(struct device_domain_info *info)
 {
-	struct pci_dev *pdev;
-
-	if (!dev_is_pci(info->dev))
+	if (!info->ats_enabled)
 		return;
 
-	pdev = to_pci_dev(info->dev);
-
-	if (info->ats_enabled) {
-		pci_disable_ats(pdev);
-		info->ats_enabled = 0;
-	}
+	pci_disable_ats(to_pci_dev(info->dev));
+	info->ats_enabled = 0;
 }
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
@@ -1722,12 +1718,19 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
+	int ret;
 
 	if (!dev_is_pci(dev))
 		return domain_context_mapping_one(domain, iommu, bus, devfn);
 
-	return pci_for_each_dma_alias(to_pci_dev(dev),
-				      domain_context_mapping_cb, domain);
+	ret = pci_for_each_dma_alias(to_pci_dev(dev),
+				     domain_context_mapping_cb, domain);
+	if (ret)
+		return ret;
+
+	iommu_enable_pci_ats(info);
+
+	return 0;
 }
 
 /* Return largest possible superpage level for a given mapping */
@@ -1987,8 +1990,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	iommu_enable_pci_caps(info);
-
 	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
 		goto out_block_translation;
@@ -3368,6 +3369,7 @@ static void domain_context_clear(struct device_domain_info *info)
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
+	iommu_disable_pci_ats(info);
 }
 
 /*
@@ -3384,7 +3386,6 @@ void device_block_translation(struct device *dev)
 	if (info->domain)
 		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 
-	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
@@ -3964,6 +3965,9 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
+	if (sm_supported(iommu))
+		iommu_enable_pci_ats(info);
+
 	return &iommu->iommu;
 free_table:
 	intel_pasid_free_table(dev);
@@ -3980,6 +3984,8 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	iommu_disable_pci_ats(info);
+
 	if (info->pasid_enabled) {
 		pci_disable_pasid(to_pci_dev(dev));
 		info->pasid_enabled = 0;
@@ -4581,13 +4587,10 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 	if (dev_is_real_dma_subdevice(dev))
 		return 0;
 
-	if (sm_supported(iommu)) {
+	if (sm_supported(iommu))
 		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
-		if (!ret)
-			iommu_enable_pci_caps(info);
-	} else {
+	else
 		ret = device_setup_pass_through(dev);
-	}
 
 	return ret;
 }
-- 
2.39.5


