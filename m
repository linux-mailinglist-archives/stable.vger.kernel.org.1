Return-Path: <stable+bounces-95770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D3A9DBE88
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 03:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C10F282040
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B814B08E;
	Fri, 29 Nov 2024 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYUwkBbt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45D147C91;
	Fri, 29 Nov 2024 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732845991; cv=none; b=kXpcFpcWmomByCFv04XJ0jwFfPIUtfil9snci8HmDR3qUkjs4I/z7X0VoziU48tylg1+yES3m6eUsPMp/6NfyH4It1Nl3Dh4UtAaYNoq879MdFWsjMLcXuDOQXAngYjfkDMlZEnkufW5pk9mpmGjoCot2wd6XvNybTkvACfM2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732845991; c=relaxed/simple;
	bh=D8ja1Iw+H3kZwlQOzzmwwQPWABet3e6gMOqHAK+BdDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4942zmZwNCAn0+geZ4tLrdP94ic/18BUk1gXsPR3fs60BMOsVgFpAC9Rha03rTtzD7IdRD2+Me6QRdMA9UolPA0qtRS7aDubNHm2uonVXKfJwdTryf4LstpMlXKHA+gRLT9VDLeg9lBHYKIn+FE1oOzS949QhN/N8lxiH4mjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYUwkBbt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732845989; x=1764381989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D8ja1Iw+H3kZwlQOzzmwwQPWABet3e6gMOqHAK+BdDE=;
  b=FYUwkBbtpsm886BjaiD3BjeO1SxHTXZIXQYMkHdE0vD/uZwBGop/4PVY
   osCBgviNhibDi0tUayqQ82w+hhbhxjb/wh8skKz68oX0reTM6VuhB52vz
   Nu7ZIU5OJlEbKAP5ZD70Rz14p2qLxg1ICZwFYwahBRKsLy41MAp/ivggC
   96ysa38atOS0tFgft6MHwWGTou7arE/chSNSCBZ+vmCsa4qh5N2yvIW8C
   rNIVtc8kxnE3tBqGVa7WoiU/QAuhFjZGEQKsLxmIgpEoh8GI3nNok0nJR
   yZ3hGmjDOJCMrWiOYN597gLDJhTS/62fHJbiLQY8OzOavRU+lv01ttz+M
   Q==;
X-CSE-ConnectionGUID: h4DZTRHwSDiu49ziHYA/sg==
X-CSE-MsgGUID: a8IjqD9PRmmLSQDmqhLSTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33012092"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="33012092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 18:06:29 -0800
X-CSE-ConnectionGUID: 737VIFStTkCk91M4TPAOuQ==
X-CSE-MsgGUID: Oz9gknq7SHeyxoo0FiF+uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92746021"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa007.jf.intel.com with ESMTP; 28 Nov 2024 18:06:26 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Remove cache tags before disabling ATS
Date: Fri, 29 Nov 2024 10:05:06 +0800
Message-ID: <20241129020506.576413-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation removes cache tags after disabling ATS,
leading to potential memory leaks and kernel crashes. Specifically,
CACHE_TAG_DEVTLB type cache tags may still remain in the list even
after the domain is freed, causing a use-after-free condition.

This issue really shows up when multiple VFs from different PFs
passed through to a single user-space process via vfio-pci. In such
cases, the kernel may crash with kernel messages like:

 BUG: kernel NULL pointer dereference, address: 0000000000000014
 PGD 19036a067 P4D 1940a3067 PUD 136c9b067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 74 UID: 0 PID: 3183 Comm: testCli Not tainted 6.11.9 #2
 RIP: 0010:cache_tag_flush_range+0x9b/0x250
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x163/0x590
  ? exc_page_fault+0x72/0x190
  ? asm_exc_page_fault+0x22/0x30
  ? cache_tag_flush_range+0x9b/0x250
  ? cache_tag_flush_range+0x5d/0x250
  intel_iommu_tlb_sync+0x29/0x40
  intel_iommu_unmap_pages+0xfe/0x160
  __iommu_unmap+0xd8/0x1a0
  vfio_unmap_unpin+0x182/0x340 [vfio_iommu_type1]
  vfio_remove_dma+0x2a/0xb0 [vfio_iommu_type1]
  vfio_iommu_type1_ioctl+0xafa/0x18e0 [vfio_iommu_type1]

Move cache_tag_unassign_domain() before iommu_disable_pci_caps() to fix
it.

Fixes: 3b1d9e2b2d68 ("iommu/vt-d: Add cache tag assignment interface")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7d0acb74d5a5..79e0da9eb626 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3220,6 +3220,9 @@ void device_block_translation(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
+	if (info->domain)
+		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
+
 	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
@@ -3236,7 +3239,6 @@ void device_block_translation(struct device *dev)
 	list_del(&info->link);
 	spin_unlock_irqrestore(&info->domain->lock, flags);
 
-	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 	domain_detach_iommu(info->domain, iommu);
 	info->domain = NULL;
 }
-- 
2.43.0


