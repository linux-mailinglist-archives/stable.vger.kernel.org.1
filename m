Return-Path: <stable+bounces-150601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8DBACB95B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF7218991FD
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0152224240;
	Mon,  2 Jun 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPhndRfN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE5223323
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880877; cv=none; b=tuWsyESLfRhD5eOHFdQqjKQ6Qdeh09nAOHAXz/G1XmAvecIYdWZzwAp3zKr8DeQBiE1H5GS2GoNSgBzUcFIGroxgfiJCGUEjAQ7GUOJB78+iX8kabajgiX6JKaL82bJcmu7Jmk2uEd8l2lGHAPI+P0nZKx3288kPG2kUB15ohHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880877; c=relaxed/simple;
	bh=oVB7DxziXDCVeUa2IvM7ieKhoP+KCqi23gwLzESXbNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HG+xEAUJlyj2hhWfkcqkkeNw+TP+VGhoefAJOy05jiuEqjYCOMbomUmcS+OICkSLFCs0xhnqM2G+8dhaaXpxVK9ESQDNFhLNq1ThqgCO+m58XJQuy69jcpc1sZjHmwsnCDwofcvM67B/39DP+MuKqx6x9dDMZ9A8Z2H5UXSm31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPhndRfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7A2C4CEEB;
	Mon,  2 Jun 2025 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748880876;
	bh=oVB7DxziXDCVeUa2IvM7ieKhoP+KCqi23gwLzESXbNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPhndRfN1OTCmUTMZkfQPNQByfoO1DKlC0GqHRO1ln1iH3jgQsi6jJSPChSq1AYSe
	 i37ITWnIofRd5S+wpnMWTw7XVHQKCvNIg6cJHxv/TMr1FYVlk6w8lvxSgQnqjimtdw
	 D8+TtJqW02YvZGlUdAZJyB6v/Y5cPG0Wjvz8VUENhqK8ZfZVsWS5I8IZmC0M/mMlma
	 DUrOpuyUlpYhkeVi5Pl3jnlVQKccSdPz0nZgwm2ZhG7lzAdeR2pR+7qwRRzzUQwCqB
	 y8afTFmRyoHkl3XONeBOGbFpxnQp5rQHSlTuXeCb/oLRHJWy25J3x9wuv+A0/s5dG3
	 d7WX5nctxcrzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 1/1] xen/swiotlb: relax alignment requirements
Date: Mon,  2 Jun 2025 12:14:35 -0400
Message-Id: <20250602092810-27d2e33939217c53@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250602113308.3475836-2-harshvardhan.j.jha@oracle.com>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  85fcb57c983f4 ! 1:  e8a1898ab6dcf xen/swiotlb: relax alignment requirements
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
         Signed-off-by: Juergen Gross <jgross@suse.com>
    +    Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
     
      ## drivers/xen/swiotlb-xen.c ##
    -@@ drivers/xen/swiotlb-xen.c: static inline phys_addr_t xen_dma_to_phys(struct device *dev,
    - 	return xen_bus_to_phys(dev, dma_to_phys(dev, dma_addr));
    +@@ drivers/xen/swiotlb-xen.c: static inline dma_addr_t xen_virt_to_bus(void *address)
    + 	return xen_phys_to_bus(virt_to_phys(address));
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
    + 	phys = *dma_handle;
    + 	dev_addr = xen_phys_to_bus(phys);
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
| stable/linux-5.4.y        |  Success    |  Success   |

