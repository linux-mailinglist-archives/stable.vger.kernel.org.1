Return-Path: <stable+bounces-139954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1360CAAA2DE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF3318839FF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8EC281539;
	Mon,  5 May 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksUTTPiv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3D220F53;
	Mon,  5 May 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483766; cv=none; b=jXgQtUUo094jFx/JvVibTDoBHienREIqeSBLUBFPLIVeHhDNJyjDamxFDnkXiV4KDW5bP4yfHLM91VvxZJhnfyNihu++9jTA9eZhNLInR7v8KBS97iimzQWbB4WTfn8ruLOzl2rjX37n5pF2DjqDALuQTBvOQWyrlAiML+cm23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483766; c=relaxed/simple;
	bh=nnPyc26EbyGDnexbH8U3iaPPrWdRf8g1VgwffEBMS0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRsGceBe2zzEJpmeCEGjLxm3j8dYPsxZOrTegZ2De0nmjGg7gTPjp6LthYBadOgUZQ0bvYH/pQrcNKDqYMoNnlG2545fv4YorhMLRp7PSCKme8k9MqP5ofr2unp+SCXGqGSKwZjxy8wqgB0nDSpY0pb1vGRuxGwZgnlFxUYu0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksUTTPiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A923C4CEEE;
	Mon,  5 May 2025 22:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483766;
	bh=nnPyc26EbyGDnexbH8U3iaPPrWdRf8g1VgwffEBMS0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksUTTPivCY1mZpaQ9e+XjJAweJgPzGIobqfr8a2zTmqBRfW1hy7T7Z+V8CZjN6D5K
	 KBAiwBhCe0FI/E/SSlGd5vQ0J1N+l4vaBkWG3YXqs4g9SsztEzAG0ixUFCtGzFXxvQ
	 oN5vbFMkhQR4Zce7qA2BywMGirvvqFjw+z5UNwd2Lhj1/DMQjd2cn6AIkaMn+t27GO
	 26V9glGfdlhbnYEkhbpXglhd3cu/28IESkr7iW+75iYFc5A5WulJ1MZ6rs/8MqDliY
	 vIr4ODnBtupDI3+LOe0RlyELTmdKAVJs2vKHnCB6wvX+EDFTVYyzUkKNxgrJ81+xSQ
	 JSQ5SDuXGaTyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 207/642] iommu/vt-d: Check if SVA is supported when attaching the SVA domain
Date: Mon,  5 May 2025 18:07:03 -0400
Message-Id: <20250505221419.2672473-207-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 607ba1bb096110751f6aa4b46666e0ba024ab3c2 ]

Attach of a SVA domain should fail if SVA is not supported, move the check
for SVA support out of IOMMU_DEV_FEAT_SVA and into attach.

Also check when allocating a SVA domain to match other drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Link: https://lore.kernel.org/r/20250228092631.3425464-3-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 37 +------------------------------
 drivers/iommu/intel/svm.c   | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d24dc72d066d9..f1a8759bfa83e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3869,41 +3869,6 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
-static int intel_iommu_enable_sva(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu;
-
-	if (!info || dmar_disabled)
-		return -EINVAL;
-
-	iommu = info->iommu;
-	if (!iommu)
-		return -EINVAL;
-
-	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
-		return -ENODEV;
-
-	if (!info->pasid_enabled || !info->ats_enabled)
-		return -EINVAL;
-
-	/*
-	 * Devices having device-specific I/O fault handling should not
-	 * support PCI/PRI. The IOMMU side has no means to check the
-	 * capability of device-specific IOPF.  Therefore, IOMMU can only
-	 * default that if the device driver enables SVA on a non-PRI
-	 * device, it will handle IOPF in its own way.
-	 */
-	if (!info->pri_supported)
-		return 0;
-
-	/* Devices supporting PRI should have it enabled. */
-	if (!info->pri_enabled)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int context_flip_pri(struct device_domain_info *info, bool enable)
 {
 	struct intel_iommu *iommu = info->iommu;
@@ -4024,7 +3989,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 		return intel_iommu_enable_iopf(dev);
 
 	case IOMMU_DEV_FEAT_SVA:
-		return intel_iommu_enable_sva(dev);
+		return 0;
 
 	default:
 		return -ENODEV;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f5569347591f2..ba93123cb4eba 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -110,6 +110,41 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.free_notifier = intel_mm_free_notifier,
 };
 
+static int intel_iommu_sva_supported(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu;
+
+	if (!info || dmar_disabled)
+		return -EINVAL;
+
+	iommu = info->iommu;
+	if (!iommu)
+		return -EINVAL;
+
+	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
+		return -ENODEV;
+
+	if (!info->pasid_enabled || !info->ats_enabled)
+		return -EINVAL;
+
+	/*
+	 * Devices having device-specific I/O fault handling should not
+	 * support PCI/PRI. The IOMMU side has no means to check the
+	 * capability of device-specific IOPF.  Therefore, IOMMU can only
+	 * default that if the device driver enables SVA on a non-PRI
+	 * device, it will handle IOPF in its own way.
+	 */
+	if (!info->pri_supported)
+		return 0;
+
+	/* Devices supporting PRI should have it enabled. */
+	if (!info->pri_enabled)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid,
 				   struct iommu_domain *old)
@@ -121,6 +156,10 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long sflags;
 	int ret = 0;
 
+	ret = intel_iommu_sva_supported(dev);
+	if (ret)
+		return ret;
+
 	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
@@ -161,6 +200,10 @@ struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 	struct dmar_domain *domain;
 	int ret;
 
+	ret = intel_iommu_sva_supported(dev);
+	if (ret)
+		return ERR_PTR(ret);
+
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
-- 
2.39.5


