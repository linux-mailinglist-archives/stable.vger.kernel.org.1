Return-Path: <stable+bounces-146004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39C9AC023D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B98A7B3FD2
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1E6FBF;
	Thu, 22 May 2025 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESZrhxMK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDB8BEC
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879679; cv=none; b=W9Ky1Ilv07JWIG4ap0lkvYruqvNVcHDYk+5bcDOKXFIaB0H8gXiNlyt+OGoN5fIPfKnNwebgWJOzOm99+FIXxGtpmrjc75NxOwmudfYwyvOpAqKnNQp6S0aRbzOEqMvLmsKqv3ORUmnM2iz7u0O5P38FLtJNHazPFiZQDPLYTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879679; c=relaxed/simple;
	bh=uZremmx06Jz3q/9NjmopWOw6TWbqdG6zfE9Haj2O7f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLOvDWjTZUugWWtoCJxYxkLwlEm2wE4pEO33iNKbj+iTCbjFt+NUBld8aBiZAMaA0FIgzPV90bfBjD0QJIx3WEYkU+xdiZegus2Qxnm5FEYYzhHZBVtxxcDIzQmk5Py+AtDQCub3o27ShEs0PtXZElWP1Kks/p5VUuQLvtjybsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESZrhxMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD55AC4CEE4;
	Thu, 22 May 2025 02:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879679;
	bh=uZremmx06Jz3q/9NjmopWOw6TWbqdG6zfE9Haj2O7f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESZrhxMKVy142n7tadYohVZewFaI7N7pz6aT9nebZnkZ0trJSEVSQT+6KPgjUB6GQ
	 83urqsU28ZH9NzOT7bJ3a8tXcndydb3eFQncAw+MckPPBsH4+nl3WHQkc1Yohd0ztA
	 a3mEu4TTxiR5tBkJNHWuzmL01TPQpwMsCM0S966k8Yuj8c2ubMpxbGaWbnSyI9KD7F
	 hhyNUb/YS4iD7OWzSjG0+gaYa4pwrcJPTTtBnfYU0J/5EinbTo6RpMdwTlvdOaC+2e
	 7ejPGdUuo2C4Hv9Dta+nWP9rVp6ADIMvCCHRnGbJVuFsd3cZ3DUwndIjprsFl6I7uN
	 yrNw2NIyQT/EA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y v3 1/1] xen/swiotlb: relax alignment requirements
Date: Wed, 21 May 2025 22:07:55 -0400
Message-Id: <20250521140408-80ce9f2f759085ea@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521085144.1578880-2-harshvardhan.j.jha@oracle.com>
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
6.12.y | Present (different SHA1: 5a10af375347)
6.6.y | Present (different SHA1: 461d9e8acaa4)
6.1.y | Present (different SHA1: 099606a7b2d5)

Note: The patch differs from the upstream commit:
---
1:  85fcb57c983f4 ! 1:  d8109ab010afb xen/swiotlb: relax alignment requirements
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

