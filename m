Return-Path: <stable+bounces-168938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F16B23756
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C3758787A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858EF2C21E0;
	Tue, 12 Aug 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sjoU4Ezn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B261A3029;
	Tue, 12 Aug 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025837; cv=none; b=A7I6+rvj92ohyyrVDdjiT6Jq4IzEe5lIJ9xX4a3568qyH7IkeIuCzBsQ2QchaZdYxzviPXTDCUnoFcFRbtReIY74JP35mo+Vu9M3jQcAIadtHy/K8d1tpmHvoOnij0IrkRRWqILYZ9BAM7I9rFSjaLVTxNo4rCxqR8cVqI622Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025837; c=relaxed/simple;
	bh=3WfLSUwdInhdIDmUgMIeH/ezzDjtR6vThPV5uZMGUrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdA/mqoUx+Wu3kxQ9JcWGr+tFRFa15BdTUSdTf0+HYTkFN0WnU78X9pS9HIc048j4wyWXUOxJy/gT7Dlh2147/gpTGwSI4zapI3F0iS43PYXQ2AKpedRVrZ74DxgR7CaNNZvQXNH7bj8J8PXBNMesQl6VDNkgEkAc8EeljJE2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sjoU4Ezn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A22C4CEF0;
	Tue, 12 Aug 2025 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025837;
	bh=3WfLSUwdInhdIDmUgMIeH/ezzDjtR6vThPV5uZMGUrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjoU4EznIKQCYbGAbeBG13YhN+Q9b/L4d4sFzT1bAVHkIELNo0iPghHGqaAK0icCL
	 hZPgVMiT9OXYn9isBLaYySbbwizNr4NvXFx6eR5eStHxXMYTLMoR7KpPqLwd/2G2AZ
	 GuFPRUTLdOzPpqyMGJwSndxPoSAYFusN4NdG6COk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Wang <wei.w.wang@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 159/480] iommu/vt-d: Do not wipe out the page table NID when devices detach
Date: Tue, 12 Aug 2025 19:46:07 +0200
Message-ID: <20250812174404.078068942@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 5c3687d5789cfff8d285a2c76bceb47f145bf01f ]

The NID is used to control which NUMA node memory for the page table is
allocated it from. It should be a permanent property of the page table
when it was allocated and not change during attach/detach of devices.

Reviewed-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/3-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Fixes: 7c204426b818 ("iommu/vt-d: Add domain_alloc_paging support")
Link: https://lore.kernel.org/r/20250714045028.958850-6-baolu.lu@linux.intel.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ff07ee2940f5..024fb7c36d88 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1440,7 +1440,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	if (--info->refcnt == 0) {
 		clear_bit(info->did, iommu->domain_ids);
 		xa_erase(&domain->iommu_array, iommu->seq_id);
-		domain->nid = NUMA_NO_NODE;
 		kfree(info);
 	}
 	spin_unlock(&iommu->lock);
-- 
2.39.5




