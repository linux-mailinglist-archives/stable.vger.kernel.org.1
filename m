Return-Path: <stable+bounces-98571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ACC9E48A6
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973BC18804DF
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147E1AE876;
	Wed,  4 Dec 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR06ktCa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4119DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354572; cv=none; b=IEXSvC0xO1OJjugcR57vMBHXt+jkLOebyTWsJ8v47z507ANXU3lnFQbxb8BqsudTwIMkBxqRX7o+2KbG228NZbkd5BlYIi+DRxqPcNT3s2rY1rd36Z6aLKUUf1ZLfn2i2ucDnHZstKJMpQMrUfwOzKGkH31FuL0maOyebVciu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354572; c=relaxed/simple;
	bh=fZIVqrZFFGxqymQZnyFPFtS90nvILddWC5ln/4bTJrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4S2NqtZ/r3Hve9HSuG9H0OVpeKjriUG/d6SxyA13MXSI2iW46luTwLk68oZjHFwwRsNJBUpyHUFku+z93iRX6qgIwn6M+3RGtj//+5lYh1+N4NsXrNN8R+U4BFd+lIv0nGsoS/ANT9zImOaSFtiOxeap7hbyu9T+UPxmVndhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR06ktCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C381C4CECD;
	Wed,  4 Dec 2024 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354571;
	bh=fZIVqrZFFGxqymQZnyFPFtS90nvILddWC5ln/4bTJrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qR06ktCapC/+iXnHfREUnaF15xSAFoBVgYNkbYOswjotHvJUpRMCIYNd1/2OF3vcE
	 IyHSYfELFXkwSRpjg4vM7ha9wHFmENHSI44Jd+BGTzDFqKDkfDlZPoTG+kMIhwrVHp
	 fn5vymGV4xLWEy0q/MXgMuDG8OH/fvNXbaiFKWsDdSoenlrgVsAGjVuwt1xkOjOXTw
	 8AuRhWsATYJoqBAz1BplMoIm72UTo3Y5N7GPRVu4GofdMAOi3CiZOILLRwt11XEqaw
	 DkMkmD1N7N029HsX1+kLG+BHyK5C34WqP5YGQAz5pFcu0iOroBTIxPJ9QTL5njlAzp
	 g4+D6Skavu1cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrey Kalachev <kalachev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4-v6.1] udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
Date: Wed,  4 Dec 2024 17:11:32 -0500
Message-ID: <20241204102728-fdfe0de6777432df@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204151735.141277-3-kalachev@swemel.ru>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 7d79cd784470395539bda91bf0b3505ff5b2ab6d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Andrey Kalachev <kalachev@swemel.ru>
Commit author: Vivek Kasireddy <vivek.kasireddy@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7d79cd7844703 ! 1:  14a0c0b74cf0d udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
    @@ Metadata
      ## Commit message ##
         udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
     
    +    [ Upstream commit 7d79cd784470395539bda91bf0b3505ff5b2ab6d ]
    +
         Add VM_PFNMAP to vm_flags in the mmap handler to ensure that the mappings
         would be managed without using struct page.
     
    @@ Commit message
         Cc: Oscar Salvador <osalvador@suse.de>
         Cc: Shuah Khan <shuah@kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Reported-by: syzbot+3d218f7b6c5511a83a79@syzkaller.appspotmail.com
    +    [ Andrey: Backport required minor change: replace call
    +    to vm_flags_set() in mmap_udmabuf() by direct
    +    modification of the vma->vm_flags, because the set
    +    of vm_flags_*() functions is not in this versions. ]
    +    Signed-off-by: Andrey Kalachev <kalachev@swemel.ru>
     
      ## drivers/dma-buf/udmabuf.c ##
     @@ drivers/dma-buf/udmabuf.c: static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
    @@ drivers/dma-buf/udmabuf.c: static int mmap_udmabuf(struct dma_buf *buf, struct v
      
      	vma->vm_ops = &udmabuf_vm_ops;
      	vma->vm_private_data = ubuf;
    -+	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
    ++	vma->vm_flags |= VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
      	return 0;
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

