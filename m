Return-Path: <stable+bounces-35397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D58943C2
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8CA283946
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A3482DF;
	Mon,  1 Apr 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrSl7b9Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253D40876;
	Mon,  1 Apr 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991263; cv=none; b=KAWwrUYM8drMGu3SST14/FJC+Ldjs9MWhGHicO05yUiDHraweD4IpL53fqr+Eo1niVN83aAzeWy/i70RmLfejImr/pI5T7HmoH9sdEYz1jNYO+oJbYaoYYv5Gvt/hBMqaNn/BKfr567/QEc8VyNHNBVjzfxPR2QtSQsITtUpKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991263; c=relaxed/simple;
	bh=+26gvznnCS3DFpzmo/2D+ZAva8V8Xlrt4HeLN/VMOCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C12wK/efuNdvN3ZVgvq7pfTv8cokkirpL+G0SbW8mrGO7hzhbVaKSkdf2fvDtQ9poxu1vIWCeOrwYdAdlp0a61L3unxSRnR5h3zdPQWGCUghVde3eAptt2bgdzAIthDYZ9H+oy+x7c5Uh0z0d17ndramTWi+9TVsChZ1deaINNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrSl7b9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F81C433F1;
	Mon,  1 Apr 2024 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991263;
	bh=+26gvznnCS3DFpzmo/2D+ZAva8V8Xlrt4HeLN/VMOCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrSl7b9QdFO7cANT3hZEJgIO8cHOdc+clvcxGQVA+qReyrsTYtkzUPm6Bl7NOdL1A
	 Gbvi1wogOd3ctgh1CTTv5G3ihVz29JhGG4KOLtZpKMk326v4akNGzuz9rdG6BXxZ2C
	 CrpFdCuJpccd0Zi3AXm1XvFYzra+Kn5DQ4IwK77A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 183/272] iommu/dma: Force swiotlb_max_mapping_size on an untrusted device
Date: Mon,  1 Apr 2024 17:46:13 +0200
Message-ID: <20240401152536.530267770@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit afc5aa46ed560f01ceda897c053c6a40c77ce5c4 ]

The swiotlb does not support a mapping size > swiotlb_max_mapping_size().
On the other hand, with a 64KB PAGE_SIZE configuration, it's observed that
an NVME device can map a size between 300KB~512KB, which certainly failed
the swiotlb mappings, though the default pool of swiotlb has many slots:
    systemd[1]: Started Journal Service.
 => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
    note: journal-offline[392] exited with irqs disabled
    note: journal-offline[392] exited with preempt_count 1

Call trace:
[    3.099918]  swiotlb_tbl_map_single+0x214/0x240
[    3.099921]  iommu_dma_map_page+0x218/0x328
[    3.099928]  dma_map_page_attrs+0x2e8/0x3a0
[    3.101985]  nvme_prep_rq.part.0+0x408/0x878 [nvme]
[    3.102308]  nvme_queue_rqs+0xc0/0x300 [nvme]
[    3.102313]  blk_mq_flush_plug_list.part.0+0x57c/0x600
[    3.102321]  blk_add_rq_to_plug+0x180/0x2a0
[    3.102323]  blk_mq_submit_bio+0x4c8/0x6b8
[    3.103463]  __submit_bio+0x44/0x220
[    3.103468]  submit_bio_noacct_nocheck+0x2b8/0x360
[    3.103470]  submit_bio_noacct+0x180/0x6c8
[    3.103471]  submit_bio+0x34/0x130
[    3.103473]  ext4_bio_write_folio+0x5a4/0x8c8
[    3.104766]  mpage_submit_folio+0xa0/0x100
[    3.104769]  mpage_map_and_submit_buffers+0x1a4/0x400
[    3.104771]  ext4_do_writepages+0x6a0/0xd78
[    3.105615]  ext4_writepages+0x80/0x118
[    3.105616]  do_writepages+0x90/0x1e8
[    3.105619]  filemap_fdatawrite_wbc+0x94/0xe0
[    3.105622]  __filemap_fdatawrite_range+0x68/0xb8
[    3.106656]  file_write_and_wait_range+0x84/0x120
[    3.106658]  ext4_sync_file+0x7c/0x4c0
[    3.106660]  vfs_fsync_range+0x3c/0xa8
[    3.106663]  do_fsync+0x44/0xc0

Since untrusted devices might go down the swiotlb pathway with dma-iommu,
these devices should not map a size larger than swiotlb_max_mapping_size.

To fix this bug, add iommu_dma_max_mapping_size() for untrusted devices to
take into account swiotlb_max_mapping_size() v.s. iova_rcache_range() from
the iommu_dma_opt_mapping_size().

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Link: https://lore.kernel.org/r/ee51a3a5c32cf885b18f6416171802669f4a718a.1707851466.git.nicolinc@nvidia.com
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
[will: Drop redundant is_swiotlb_active(dev) check]
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index aa6d62cc567ae..3fa66dba0a326 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1547,6 +1547,14 @@ static size_t iommu_dma_opt_mapping_size(void)
 	return iova_rcache_range();
 }
 
+static size_t iommu_dma_max_mapping_size(struct device *dev)
+{
+	if (dev_is_untrusted(dev))
+		return swiotlb_max_mapping_size(dev);
+
+	return SIZE_MAX;
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
@@ -1569,6 +1577,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.unmap_resource		= iommu_dma_unmap_resource,
 	.get_merge_boundary	= iommu_dma_get_merge_boundary,
 	.opt_mapping_size	= iommu_dma_opt_mapping_size,
+	.max_mapping_size       = iommu_dma_max_mapping_size,
 };
 
 /*
-- 
2.43.0




