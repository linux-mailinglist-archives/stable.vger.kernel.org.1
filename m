Return-Path: <stable+bounces-134689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F59A94338
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF901899F1D
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5341C84A1;
	Sat, 19 Apr 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot4Kx21a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3818DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063243; cv=none; b=vAtJtgYMn5kKdU1YTG6I/yxNyaBBgDRUQc7SxBKGk/+Dtztvx2QPRTjalqAcxEZgB/hZv5+o8F18uZj5UCiZHJ6RlL3p09njeQluGBTD+RExSrC9FhW6VNEMI6qCN/+FJT7uSb39UClzCr/uYntT4euNvKmZhgkuuUnDb5iwYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063243; c=relaxed/simple;
	bh=OWCCvfN7A2IEJoQtDwdZhDnYVc8bBjo0/ZHL4F/i7e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF0wnanyJSpmqkvHzYunKekoP8VkfeIdU3VSCEZkQ97M35hZwFb+WMol1o44yID+UxvOtlLs/MdNpFUPrv6sJsi+RXbu5wDf+XFZWSiLuEau/cOGop8auSOScVbXI3+PfeIiUGWzcPIpZ3pPZ8bIkozyZDBX/vAtMUtrhLhqDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot4Kx21a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3EBC4CEE7;
	Sat, 19 Apr 2025 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063243;
	bh=OWCCvfN7A2IEJoQtDwdZhDnYVc8bBjo0/ZHL4F/i7e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ot4Kx21ayC475/bg5ddtIXO25puRwrTPj0ylDQV0DOYK8S50+luKjUxLnSScUPeCv
	 QVq6AnNL4eGDOak+yOTrOKtqcj2JJRyLuf4llBOX5ejCbR/maFbzstAmuTsfvj5Zk8
	 bFDCT8pMfPeOcV1Ege6tOQmrGQbPT+nYmCyHG2YlKJ+nDwACqcJlL6kGYUdRtdxwuh
	 G4yf+V2FsCz/cg4EhGeKXsKh4Kltv38D8HxUdpgMcg8CPJ2HqgzubbumfyDRzeX+47
	 zYC0axAuA2G2BCMDYUVbg2+W+XXk+zNo8QThnR7y66oiWOT2q+037YEcMi7oQxIbHD
	 b8oRWv+lbreyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y v2 1/1] xen/swiotlb: relax alignment requirements
Date: Sat, 19 Apr 2025 07:47:21 -0400
Message-Id: <20250418204904-32b5095b0129dd5f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418054726.2442674-2-harshvardhan.j.jha@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 85fcb57c983f423180ba6ec5d0034242da05cc54

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshvardhan Jha<harshvardhan.j.jha@oracle.com>
Commit author: Juergen Gross<jgross@suse.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: d8027f173a99)
6.12.y | Present (different SHA1: 5a10af375347)
6.6.y | Present (different SHA1: 461d9e8acaa4)
6.1.y | Present (different SHA1: 099606a7b2d5)

Note: The patch differs from the upstream commit:
---
1:  85fcb57c983f4 ! 1:  80548811d6af4 xen/swiotlb: relax alignment requirements
    @@
      ## Metadata ##
    -Author: Juergen Gross <jgross@suse.com>
    +Author: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
     
      ## Commit message ##
         xen/swiotlb: relax alignment requirements
     
    +    [ Upstream commit 85fcb57c983f423180ba6ec5d0034242da05cc54 ]
    +
         When mapping a buffer for DMA via .map_page or .map_sg DMA operations,
         there is no need to check the machine frames to be aligned according
         to the mapped areas size. All what is needed in these cases is that the
    @@ Commit message
         xen_swiotlb_free_coherent() directly.
     
         Fixes: 9f40ec84a797 ("xen/swiotlb: add alignment check for dma buffers")
    -    Reported-by: Jan Vejvalka <jan.vejvalka@lfmotol.cuni.cz>
    -    Tested-by: Jan Vejvalka <jan.vejvalka@lfmotol.cuni.cz>
    -    Signed-off-by: Juergen Gross <jgross@suse.com>
    -    Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
    -    Signed-off-by: Juergen Gross <jgross@suse.com>
    +    Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
     
      ## drivers/xen/swiotlb-xen.c ##
     @@ drivers/xen/swiotlb-xen.c: static inline phys_addr_t xen_dma_to_phys(struct device *dev,
    @@ drivers/xen/swiotlb-xen.c: static inline phys_addr_t xen_dma_to_phys(struct devi
      	for (i = 1; i < nr_pages; i++)
      		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
      			return 1;
    -@@ drivers/xen/swiotlb-xen.c: xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
    - 
    - 	*dma_handle = xen_phys_to_dma(dev, phys);
    - 	if (*dma_handle + size - 1 > dma_mask ||
    --	    range_straddles_page_boundary(phys, size)) {
    -+	    range_straddles_page_boundary(phys, size) ||
    -+	    range_requires_alignment(phys, size)) {
    - 		if (xen_create_contiguous_region(phys, order, fls64(dma_mask),
    - 				dma_handle) != 0)
    - 			goto out_free_pages;
    -@@ drivers/xen/swiotlb-xen.c: xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
    - 	size = ALIGN(size, XEN_PAGE_SIZE);
    +@@ drivers/xen/swiotlb-xen.c: xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
    + 	phys = dma_to_phys(hwdev, *dma_handle);
    + 	dev_addr = xen_phys_to_dma(hwdev, phys);
    + 	if (((dev_addr + size - 1 <= dma_mask)) &&
    +-	    !range_straddles_page_boundary(phys, size))
    ++	    !range_straddles_page_boundary(phys, size) &&
    ++	    !range_requires_alignment(phys, size))
    + 		*dma_handle = dev_addr;
    + 	else {
    + 		if (xen_create_contiguous_region(phys, order,
    +@@ drivers/xen/swiotlb-xen.c: xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
      
    - 	if (WARN_ON_ONCE(dma_handle + size - 1 > dev->coherent_dma_mask) ||
    --	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size)))
    -+	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size) ||
    -+			 range_requires_alignment(phys, size)))
    - 	    	return;
    + 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
    + 		     range_straddles_page_boundary(phys, size)) &&
    ++	    !range_requires_alignment(phys, size) &&
    + 	    TestClearPageXenRemapped(page))
    + 		xen_destroy_contiguous_region(phys, order);
      
    - 	if (TestClearPageXenRemapped(virt_to_page(vaddr)))
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

