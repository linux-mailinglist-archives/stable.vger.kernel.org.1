Return-Path: <stable+bounces-172595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4757B328D3
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1535A2411
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78B24337D;
	Sat, 23 Aug 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUC0ZF4c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC18243399
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956629; cv=none; b=q3l1j+hzvzvJk2WZLLJ/4LAd1FVJm5TWRaPyFWdgzjzt25IB70WDs15u/9NSqoAPNoAuCZGjt2H0SyPrBOONmrcWlPZf5xMGR0pms5yZ7oMiHIvR+bBR+H7oJYWHfPs3ziP4uVyNb587/bDLRUFU3YeKGiTvELMhJdno95M+MqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956629; c=relaxed/simple;
	bh=VwEpK/xq2zu9I4I4ak0hzBqFe/CyOWEjawIpd1zMsLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWcbjGI90684Ng3BTLAH9M3GlwsyqaukZb55pymo2F53XC2MGf8+rzfCKRzm7qZ4kKpOoDZ0s9aQ5Bfs/ICQC65ADV4ygxBPkdHkrTGw8P7J4JmGOFHBEm/7/OUaKS62hm6CKzyh5GvwyvFPer8qZnkjGnqzZrG2mkzC4/sPolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUC0ZF4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75CAC4CEE7;
	Sat, 23 Aug 2025 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755956628;
	bh=VwEpK/xq2zu9I4I4ak0hzBqFe/CyOWEjawIpd1zMsLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUC0ZF4cwHN/IoH4DzWE6c4//RG/knxCeDpFXmTLvrTHwBKSnAVqWOb7YCDOXS3/n
	 3LzJfWwWtoBehVyNx03uPEMa/8jATQKKxDLejN3yC2VaDRe5OZBJMPke634D1lRLl6
	 53IqCXLjWJhe6kjSHj+LTjuveRBxdA9Rx0WEW+mJembH9bjTAZnl1UDKu+g2Fkizfu
	 V9uKPswEYkvzrTmbc7L/K+ppQYtqEdJofAbs6U/CW2pNjebu/tQUkNLmNuvC6zO8zb
	 JNXH7AfuHVype1ZtbjPrYQA1Vz2wS+68Ok97CeGRUa14KGAo04Le8VT+pGsWrf23GB
	 fAYy/WGXAnSMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Sven Peter <sven@svenpeter.dev>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] iommu: Remove ops.pgsize_bitmap from drivers that don't use it
Date: Sat, 23 Aug 2025 09:43:45 -0400
Message-ID: <20250823134346.2145572-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082258-exert-mousy-2b51@gregkh>
References: <2025082258-exert-mousy-2b51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 8901812485de1356e3757958af40fe0d3a48e986 ]

These drivers all set the domain->pgsize_bitmap in their
domain_alloc_paging() functions, so the ops value is never used. Delete
it.

Reviewed-by: Sven Peter <sven@svenpeter.dev> # for Apple DART
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com> # for RISC-V
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/3-v2-68a2e1ba507c+1fb-iommu_rm_ops_pgsize_jgg@nvidia.com
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Stable-dep-of: 72b6f7cd89ce ("iommu/virtio: Make instance lookup robust")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/apple-dart.c       | 1 -
 drivers/iommu/intel/iommu.c      | 1 -
 drivers/iommu/iommufd/selftest.c | 1 -
 drivers/iommu/riscv/iommu.c      | 1 -
 drivers/iommu/virtio-iommu.c     | 6 ++----
 5 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 757d24f67ad4..190f28d76615 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -991,7 +991,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.of_xlate = apple_dart_of_xlate,
 	.def_domain_type = apple_dart_def_domain_type,
 	.get_resv_regions = apple_dart_get_resv_regions,
-	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
 	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= apple_dart_attach_dev_paging,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ab4cd742f095..c239e280e43d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4390,7 +4390,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.device_group		= intel_iommu_device_group,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
-	.pgsize_bitmap		= SZ_4K,
 	.page_response		= intel_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 6bd0abf9a641..c52bf037a2f0 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -801,7 +801,6 @@ static const struct iommu_ops mock_ops = {
 	.default_domain = &mock_blocking_domain,
 	.blocked_domain = &mock_blocking_domain,
 	.owner = THIS_MODULE,
-	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc_paging_flags = mock_domain_alloc_paging_flags,
 	.domain_alloc_nested = mock_domain_alloc_nested,
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bb57092ca901..2d0d31ba2886 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1533,7 +1533,6 @@ static void riscv_iommu_release_device(struct device *dev)
 }
 
 static const struct iommu_ops riscv_iommu_ops = {
-	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index ecd41fb03e5a..532db1de201b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -998,7 +998,7 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static struct iommu_ops viommu_ops;
+static const struct iommu_ops viommu_ops;
 static struct virtio_driver virtio_iommu_drv;
 
 static int viommu_match_node(struct device *dev, const void *data)
@@ -1086,7 +1086,7 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
-static struct iommu_ops viommu_ops = {
+static const struct iommu_ops viommu_ops = {
 	.capable		= viommu_capable,
 	.domain_alloc_identity	= viommu_domain_alloc_identity,
 	.domain_alloc_paging	= viommu_domain_alloc_paging,
@@ -1217,8 +1217,6 @@ static int viommu_probe(struct virtio_device *vdev)
 		viommu->first_domain++;
 	}
 
-	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
-
 	virtio_device_ready(vdev);
 
 	/* Populate the event queue with buffers */
-- 
2.50.1


