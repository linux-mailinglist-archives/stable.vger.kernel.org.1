Return-Path: <stable+bounces-142101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53058AAE634
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D13188C608
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4570528BA99;
	Wed,  7 May 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kTBuLZPv"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50228A705
	for <stable@vger.kernel.org>; Wed,  7 May 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634166; cv=none; b=paeZKYM5SQRHdiPYzAbqCn5sR84R/77sOvSZ0wa8zqEa7P0454N+D0rFlG80m1CvFpeU/w79yWQPT5TtMXDFJtnWlPuSlIiEFRm8L4XkTq58j8SlfKjj+fz/yE1airjynA2WlWh40GJFoiNnwS3URtb/TfZBRPiKABNcWJiLoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634166; c=relaxed/simple;
	bh=V4manMRescn/KgtEb6gBDLkPpqX3q13zB5rBOJfeJxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=XM0C1FdFU7HU5Ei46An2UGf0QMcY/VdiXBCDUPcP9LEQoTEvVpp1rZaAIXiLtHgiGlt31zks13hq/KxqQIuCDSreJDmLMzToKMM3GU9Z4l3LgdXphhXxojfmCRk92xi+XxioEiopS6/RrTZmmr0l+gA6VoYk8PaqC8tuLxnXMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kTBuLZPv; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250507160922euoutp013088d60c1e1435ab4a696f6ce790ef50~9SoRaVeWz2432424324euoutp01i
	for <stable@vger.kernel.org>; Wed,  7 May 2025 16:09:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250507160922euoutp013088d60c1e1435ab4a696f6ce790ef50~9SoRaVeWz2432424324euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746634162;
	bh=JYubXXRq3/aczS2Xsq721o38MMZALMPD3UE2OHjAXx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTBuLZPvkK0tDkVfmX+qKFxjoUQbg8AFYLZ8eXlnQ9TTam4OtduxKV4fWDex3XwQU
	 IU2l/Ssaf9RiCOezRz5KJ3GPvgjGpcR7uCzCtaU25FcGqQu8z/BiX5kNAT7xyoD9XP
	 yuPAflA8zwXiYZq0fCvvjWfAfXgqDcd+jD83H3Ek=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250507160922eucas1p11bd044bb458626dc0004bd2fd83605c0~9SoREASAM0253102531eucas1p1v;
	Wed,  7 May 2025 16:09:22 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250507160921eusmtip154bf3d4c5d3e49f527828d8f7ad93539~9SoQhMCF20592805928eusmtip1X;
	Wed,  7 May 2025 16:09:21 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Gerd Hoffmann
	<kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Sumit
	Semwal <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Gurchetan Singh <gurchetansingh@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Subject: [PATCH v3 2/3] udmabuf: use sgtable-based scatterlist wrappers
Date: Wed,  7 May 2025 18:09:12 +0200
Message-Id: <20250507160913.2084079-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507160913.2084079-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250507160922eucas1p11bd044bb458626dc0004bd2fd83605c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250507160922eucas1p11bd044bb458626dc0004bd2fd83605c0
X-EPHeader: CA
X-CMS-RootMailID: 20250507160922eucas1p11bd044bb458626dc0004bd2fd83605c0
References: <20250507160913.2084079-1-m.szyprowski@samsung.com>
	<CGME20250507160922eucas1p11bd044bb458626dc0004bd2fd83605c0@eucas1p1.samsung.com>

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
functions have to be called with the number of elements originally passed
to dma_map_sg_*() function, not the one returned in sgtable's nents.

Fixes: 1ffe09590121 ("udmabuf: fix dma-buf cpu access")
CC: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 drivers/dma-buf/udmabuf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 7eee3eb47a8e..c9d0c68d2fcb 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -264,8 +264,7 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 			ubuf->sg = NULL;
 		}
 	} else {
-		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
-				    direction);
+		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
 	}
 
 	return ret;
@@ -280,7 +279,7 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
 	if (!ubuf->sg)
 		return -EINVAL;
 
-	dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents, direction);
+	dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
 	return 0;
 }
 
-- 
2.34.1


