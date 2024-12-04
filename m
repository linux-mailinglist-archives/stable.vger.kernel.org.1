Return-Path: <stable+bounces-98323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E1F9E401B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D9C1675BD
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C71B87C6;
	Wed,  4 Dec 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbB8ARSk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027620C49E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331191; cv=none; b=U++z7fSVmLaNHbUs5SPN1Jt9rRSNzdzHqT+6ummBG5CGh0Q28/vzWsQc4uSTuGXyD/lDeH/dkifNIRaWCOWXBT1EPEyBVHUmKDLac3iXLjW6XWEQOJ0carPBWjyq3QI20K9qpbl0CoTRmekjzaflUY0elCMe3+CVp4Absyqjnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331191; c=relaxed/simple;
	bh=fZIVqrZFFGxqymQZnyFPFtS90nvILddWC5ln/4bTJrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoSoFl+L2+nXArHq5lsghHXwDXnTw/qfKfUeCtZyj9TKvSGZ7EoGPzZsSTx387c1opmabD0+MSmFhCArWKB2k9TmiHUJWiwuGk67YfYP/WIUPNg/B8LCfMqCYoC7jl8EO81hybA8t7FN8Ly6JbyaFiay7IcJDQz2YyiIqMUFAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbB8ARSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C418AC4CECD;
	Wed,  4 Dec 2024 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331191;
	bh=fZIVqrZFFGxqymQZnyFPFtS90nvILddWC5ln/4bTJrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbB8ARSkdR22sbIntS8f9eIxJLgJTAJwi39hnFQjqhtOnW5LEEwjlpx+DMGMqxWlR
	 8TmmeGvVlHuVMGzlhBQQ1fLo4BmsF0NEw0ba78cTXLppPjvl9WFeTHvMSnjnB0G77N
	 lqU/I8ZYmr41PLFC7wvOGDgfWIyOk/6qTyGY5JyQltarVspjUQmPwExdE4NIokrW9q
	 tbHWYWvsPneGM86KrDjQ3fKeZnxIHaXL4Zl0Ya2wzJIEDSAC7ewlwrj9819Tv0ouP6
	 fNjGpyLyWrfrm2yjXLf4HeOA/c6OgP3ap7pIHlEcTciyS73/Iky0FS9W1wLDNnV8nH
	 K25ULaa1VR4FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrey Kalachev <kalachev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4-v6.1] udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
Date: Wed,  4 Dec 2024 10:41:51 -0500
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

