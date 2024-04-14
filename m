Return-Path: <stable+bounces-36825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4E89C1F0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29DF1F22857
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD27C098;
	Mon,  8 Apr 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0LvPYjr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627307C08F;
	Mon,  8 Apr 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582451; cv=none; b=AekOEGC7mKgqdhr81B1l3qi5nAl7ZrpdWkSMq4fWLd0bvfs2BasjGa68EvPKRqSkebO1VO5dblkwvmvSHPku+Ke5GdZ9LJkoS6NSn16l/5kAl0LY4QkkWKvmP6QcQ33ChAo607Of3fTX/2J7HJGpVDHJ0nemBTCOscYnuab9XKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582451; c=relaxed/simple;
	bh=pUyfJKOnwtsriFbQgx90W/48ypcCYvqOrJTXrU/vqwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKoFcIvRc/xB2CjFxG5PlxelBwYhN1VrxX22NGRwZM0WF1Ws5s2RwbaFfcwEL4DPAv5auOeqXcfMcOtGvbvSpPZq09gFe6hQEsQmxkQq6otrDRYMufy8j9a9qKcxl/Neh1gBVvcobJOCKZysbiLI6zB0wKyYa0hRnHW/SrvueQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0LvPYjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C91C433C7;
	Mon,  8 Apr 2024 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582451;
	bh=pUyfJKOnwtsriFbQgx90W/48ypcCYvqOrJTXrU/vqwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0LvPYjri59t+P/n+Y/2UI8Fsn6TRMcKZOCB7C0RMLlbg0J45DLF6M1bxVoNFlMVM
	 nF2dAUGbpvFr8TfYTie1B+XAYT8BsNSlVpafzfIkPKtjr/ZouBeiVjXMFFcX73gVR9
	 oDmbtjxZwOVuTRXCbGtePvVRGmpgl3ajy2TUaVFc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Garry <john.garry@huawei.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 143/690] dma-mapping: add dma_opt_mapping_size()
Date: Mon,  8 Apr 2024 14:50:09 +0200
Message-ID: <20240408125404.695212862@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Garry <john.garry@huawei.com>

[ Upstream commit a229cc14f3395311b899e5e582b71efa8dd01df0 ]

Streaming DMA mapping involving an IOMMU may be much slower for larger
total mapping size. This is because every IOMMU DMA mapping requires an
IOVA to be allocated and freed. IOVA sizes above a certain limit are not
cached, which can have a big impact on DMA mapping performance.

Provide an API for device drivers to know this "optimal" limit, such that
they may try to produce mapping which don't exceed it.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: afc5aa46ed56 ("iommu/dma: Force swiotlb_max_mapping_size on an untrusted device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/core-api/dma-api.rst | 14 ++++++++++++++
 include/linux/dma-map-ops.h        |  1 +
 include/linux/dma-mapping.h        |  5 +++++
 kernel/dma/mapping.c               | 12 ++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 6d6d0edd2d278..829f20a193cab 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -204,6 +204,20 @@ Returns the maximum size of a mapping for the device. The size parameter
 of the mapping functions like dma_map_single(), dma_map_page() and
 others should not be larger than the returned value.
 
+::
+
+	size_t
+	dma_opt_mapping_size(struct device *dev);
+
+Returns the maximum optimal size of a mapping for the device.
+
+Mapping larger buffers may take much longer in certain scenarios. In
+addition, for high-rate short-lived streaming mappings, the upfront time
+spent on the mapping may account for an appreciable part of the total
+request lifetime. As such, if splitting larger requests incurs no
+significant performance penalty, then device drivers are advised to
+limit total DMA streaming mappings length to the returned value.
+
 ::
 
 	bool
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index bfffe494356ad..2ff55ec902f48 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -69,6 +69,7 @@ struct dma_map_ops {
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
 	size_t (*max_mapping_size)(struct device *dev);
+	size_t (*opt_mapping_size)(void);
 	unsigned long (*get_merge_boundary)(struct device *dev);
 };
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index dca2b1355bb13..fe3849434b2a2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -144,6 +144,7 @@ int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
+size_t dma_opt_mapping_size(struct device *dev);
 bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 unsigned long dma_get_merge_boundary(struct device *dev);
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
@@ -266,6 +267,10 @@ static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
 }
+static inline size_t dma_opt_mapping_size(struct device *dev)
+{
+	return 0;
+}
 static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return false;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9478eccd1c8e6..c9dbc8f5812b8 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -777,6 +777,18 @@ size_t dma_max_mapping_size(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_max_mapping_size);
 
+size_t dma_opt_mapping_size(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	size_t size = SIZE_MAX;
+
+	if (ops && ops->opt_mapping_size)
+		size = ops->opt_mapping_size();
+
+	return min(dma_max_mapping_size(dev), size);
+}
+EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
+
 bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.43.0




