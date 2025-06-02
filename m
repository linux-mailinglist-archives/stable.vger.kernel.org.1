Return-Path: <stable+bounces-150600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5016AACB95A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7638118990A6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A2224228;
	Mon,  2 Jun 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swBuh40/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFD1D6DB6
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880875; cv=none; b=FjB5EF/NOt9HUA6TkQcUBVP5Ps332OF0sU58tSCt3v3YN5d0hOTLlELLKYaYXB7U013EQadJzEELubdRuU76u7lH8i40z4rt7CfSC4Gzvf65ln+4ztFJvQJR4+nnGlWCeMkK5yOffJR1NQYUesL+1r04ijo+SalauP6UnE2Ml8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880875; c=relaxed/simple;
	bh=/6WzksVyAX6jRF9APOJmKvmdzi3pqVHCWbCrLNNUWP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqwJbQ0sJijFh5PBgXWacPi5A37Hb8p1YTEunvZK+0dY2ncwhWicEKkZ0S63w8eQwQzmxlKEKJXk1dZgwFUfj8/Zk/wGd92J+8ndWAC3JqGu+L3clepPcQqx5wBTGmuaoMrGZVj47LDZlYetXMIF+GFWnaoRbAOst4rTnntwV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swBuh40/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B29C4CEEB;
	Mon,  2 Jun 2025 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748880875;
	bh=/6WzksVyAX6jRF9APOJmKvmdzi3pqVHCWbCrLNNUWP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swBuh40/qGxj2IxYrr9b2UfwB/bYr9R0cV+Fsr4da5MCDQcsrgk6sz4HX7LMmos4p
	 zjSqFBuJtZcDzZsC6UTxMPKXO0IecP4KUPNIgsI3Qq/uCZTksgFuAQSbelqvABgYGq
	 zVwTGgOBAhEWKEE0b/vRkOCSogHtJlCbJ/g/7TbIwaETyf8ANUHqKYU2UXWXov2cgz
	 laOGfNpWzSzivrBC93Rmf1lQqoqoX4h9pT7B1MlJHPSkU7lOb4kTgD01KAJomIeCmZ
	 ViWxTvEVyMefAzLX+PbWQoXFAoADsCE9JGhSilqgVTSGxE7b6lGDFaYmr/9XkUdXNi
	 qbWaklsB82qDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/1] xen/swiotlb: relax alignment requirements
Date: Mon,  2 Jun 2025 12:14:33 -0400
Message-Id: <20250602093143-43d78c125dfd17b0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250602113301.3475805-2-harshvardhan.j.jha@oracle.com>
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
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 5a10af375347)
6.6.y | Present (different SHA1: 461d9e8acaa4)
6.1.y | Present (different SHA1: 099606a7b2d5)
5.15.y | Present (different SHA1: 688cc08c2cb0)

Note: The patch differs from the upstream commit:
---
1:  85fcb57c983f4 ! 1:  d274de5e155e1 xen/swiotlb: relax alignment requirements
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
    +
         Signed-off-by: Juergen Gross <jgross@suse.com>
    +    Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
     
      ## drivers/xen/swiotlb-xen.c ##
    -@@ drivers/xen/swiotlb-xen.c: static inline phys_addr_t xen_dma_to_phys(struct device *dev,
    - 	return xen_bus_to_phys(dev, dma_to_phys(dev, dma_addr));
    +@@ drivers/xen/swiotlb-xen.c: static inline dma_addr_t xen_virt_to_bus(struct device *dev, void *address)
    + 	return xen_phys_to_dma(dev, virt_to_phys(address));
      }
      
     +static inline bool range_requires_alignment(phys_addr_t p, size_t size)
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
| stable/linux-5.10.y       |  Success    |  Success   |

