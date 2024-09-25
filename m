Return-Path: <stable+bounces-77454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C674A985D73
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535751F21C89
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB61E4923;
	Wed, 25 Sep 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM9s08Sn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054D1E412A;
	Wed, 25 Sep 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265820; cv=none; b=fm3SyBDI9UWShQHWLbVEvWt2G869+5wou5G3Ovtsl7jybk7vKRMxObr2bl/DyRQplJVadQAdHu/SMysrFtNgt38hDOMC/eGS6y0Ebi8WBMtnm7LTsYQDc+Y8JNWpjb+w0G59E1B68DM/dILAPiHDrNfhFQUQFKME5/78JKtLGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265820; c=relaxed/simple;
	bh=vjYOR/vI2Zp62wupfnvhI8sJxdeIfV01ETDSandyXFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3i8VjYQ6jfF7d8clnaljLYZnXFGpzvq5RYfemfTReCnRVd7vUmi/h9D95sq38RFcxtpAjO//bUK7OC2/GbxYodwuok82lYbxnQgfEj8fCdGZAZok6MlXJ+5KDt9wj2Wt0SCx03IWppTncr8t4kE7qJCGIFbuwsvBUdqHK0l+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM9s08Sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32704C4CEC7;
	Wed, 25 Sep 2024 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265820;
	bh=vjYOR/vI2Zp62wupfnvhI8sJxdeIfV01ETDSandyXFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iM9s08Sn+PQRAipv6HSKVfdjXE8Bhe648ce9zfTSSzFK6/iv9Y+QY210s5I/RxjiR
	 ftLVUNk0ngVLk6lwWn4x3beT+Go9jZZX7ufZZKEm8ILn4EbUCprt100ngh8qmnvtFL
	 dN0sFl8+47XBXtvooGN9WJLO2mkt8iGPAzaCSgnwvsRNMMdccRMqUSxvlAyyyIUVfF
	 tnK6FD4P3fYnj5PmNJtYrjmdMhW/XZ1S/gxh9Nn3kb4a4S0K9QJ3A19n1XIBvF/7IF
	 T6aItt3B1JnsZ8z1EOz5PXSzhMQbLTIA2uWmcfjBkrH64yxSOtUcvXkybq4o7GLfpv
	 kqL1P7ZF8Cqmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 109/197] iommu/vt-d: Unconditionally flush device TLB for pasid table updates
Date: Wed, 25 Sep 2024 07:52:08 -0400
Message-ID: <20240925115823.1303019-109-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 1f5e307ca16c0c19186cbd56ac460a687e6daba0 ]

The caching mode of an IOMMU is irrelevant to the behavior of the device
TLB. Previously, commit <304b3bde24b5> ("iommu/vt-d: Remove caching mode
check before device TLB flush") removed this redundant check in the
domain unmap path.

Checking the caching mode before flushing the device TLB after a pasid
table entry is updated is unnecessary and can lead to inconsistent
behavior.

Extends this consistency by removing the caching mode check in the pasid
table update path.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20240820030208.20020-1-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/pasid.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index aabcdf7565817..57dd3530f68d4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -261,9 +261,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	else
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
 /*
@@ -490,9 +488,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 
 	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 
 	return 0;
 }
@@ -569,9 +565,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
 	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
 /**
-- 
2.43.0


