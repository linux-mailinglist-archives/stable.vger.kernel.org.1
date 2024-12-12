Return-Path: <stable+bounces-100839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77719EE039
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A44D18851FB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88320B1E5;
	Thu, 12 Dec 2024 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPI2P2U2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08F20ADF3;
	Thu, 12 Dec 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733988459; cv=none; b=h6faeUmWIYRWdUsUInLtU0DQy9PimgbS9NFrIu2szLiUBcALAuw8tuPNV9NkOq25EEnceZ/e4wD5UHd0i7dcsmeEbpVN5hgLPcRMz3ZHQVm0BRT6wBgsAihFhGZXZkgPI5r0ZxS8+XLJlwt5AYWJWnwc5Rm6RoIHV9hsFxL2VJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733988459; c=relaxed/simple;
	bh=71Thxi+2QZl9+TBoyxQvwBW6qPedKeqqc/D5nTlfe9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8XL+Nr75henYlv9AqeIqZORJuAxcB7q4O4x14uPCiPCsQIwPEVMyUs5q+g+ErGpFZvunpCH+dhAp0dCcddxZ9s65xLC2qPKxjwzNjmNJ5sP1SSMo+GrrY8vi3YSVCGb6/mAOXO5uJIpI8gvVP1eX4ii/1dH4ZkHY1Np3qyPNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPI2P2U2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733988458; x=1765524458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=71Thxi+2QZl9+TBoyxQvwBW6qPedKeqqc/D5nTlfe9A=;
  b=gPI2P2U2Ss0ZA5daixOxUtSd93DE26H/m36BR2I6xT2FCMXNcKoT+ELn
   pkfNyOf2eM+xjsfikG9NFxrEKyVopMLmTLdaDxHHBseNgePZjGUZ4d4ie
   ODLDWRzfEzYZvEpwQYR8EUN685o/NsxF05rnSlhKosq0T5GfV5V+RpnQk
   MYfJQrtlvnnkJaaug+JW0ZFa4hvITTwOv0Qmt2bIv36yy1k9UINChx0Ig
   NwpaUjiZo7Smwh8sRckpe9jILh4eF+vh0rnbHSbclJQrBqJsVtZf9zZPV
   bcerPjE1o1jKXujuGdORKwa/3FHo41BODL3Fqv3CgIWLEQfOympGcdivK
   w==;
X-CSE-ConnectionGUID: D8KRv9X6Q5uzOCsrmWabow==
X-CSE-MsgGUID: RVACqo0GRB+c8nch9mK1TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="38080512"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="38080512"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 23:27:37 -0800
X-CSE-ConnectionGUID: kChr0LB9Tcm+4Q12brRszQ==
X-CSE-MsgGUID: ZnkQx/6mQL6t4eBkcnKYbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96032624"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 23:27:35 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	chao.p.peng@intel.com,
	zhenzhong.duan@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in cache_tag_flush_range_np()
Date: Thu, 12 Dec 2024 15:24:19 +0800
Message-Id: <20241212072419.480967-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setup mapping on an paging domain before the domain is attached to any
device, a NULL pointer dereference triggers as below:

 BUG: kernel NULL pointer dereference, address: 0000000000000200
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 RIP: 0010:cache_tag_flush_range_np+0x114/0x1f0
 ...
 Call Trace:
  <TASK>
  ? __die+0x20/0x70
  ? page_fault_oops+0x80/0x150
  ? do_user_addr_fault+0x5f/0x670
  ? pfn_to_dma_pte+0xca/0x280
  ? exc_page_fault+0x78/0x170
  ? asm_exc_page_fault+0x22/0x30
  ? cache_tag_flush_range_np+0x114/0x1f0
  intel_iommu_iotlb_sync_map+0x16/0x20
  iommu_map+0x59/0xd0
  batch_to_domain+0x154/0x1e0
  iopt_area_fill_domains+0x106/0x300
  iopt_map_pages+0x1bc/0x290
  iopt_map_user_pages+0xe8/0x1e0
  ? xas_load+0x9/0xb0
  iommufd_ioas_map+0xc9/0x1c0
  iommufd_fops_ioctl+0xff/0x1b0
  __x64_sys_ioctl+0x87/0xc0
  do_syscall_64+0x50/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

qi_batch structure is allocated when domain is attached to a device for the
first time, when a mapping is setup before that, qi_batch is referenced to
do batched flush and trigger above issue.

Fix it by checking qi_batch pointer and bypass batched flushing if no
device is attached.

Cc: stable@vger.kernel.org
Fixes: 705c1cdf1e73 ("iommu/vt-d: Introduce batched cache invalidation")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e5b89f728ad3..bb9dae9a7fba 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -264,7 +264,7 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 
 static void qi_batch_flush_descs(struct intel_iommu *iommu, struct qi_batch *batch)
 {
-	if (!iommu || !batch->index)
+	if (!iommu || !batch || !batch->index)
 		return;
 
 	qi_submit_sync(iommu, batch->descs, batch->index, 0);
-- 
2.34.1


