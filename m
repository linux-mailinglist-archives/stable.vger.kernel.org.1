Return-Path: <stable+bounces-124225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70121A5EEBD
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AE819C0A47
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308CC262D27;
	Thu, 13 Mar 2025 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXpVaJMx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB630155C96
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856478; cv=none; b=tej/u1OQ1Os8kI5fH8JXFiss4bjQAt9gsqmG3tcCKJn8vOm0jtyZ7xi3QgNp4EGzqGStPTlQKdw67hvi9+1favoA4oUdLfqCq/6oRWs9mEC81rMYfutyz9FQrLRMymEHCCM97kjSo59MVVn3T/cj/uBWHJG8wTarEPrXIptin2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856478; c=relaxed/simple;
	bh=AkCj/VZesoBCCX2zLdviQ+5R4ycUJ5Ug3uHgQzhbBLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7MiZygK5eKYF/H8GVGnzM4DtjvGkKGAPKZLC/zr3B1fFlxCB6z+7/Ybsb/YdwB4ND7RAJqcmM+u9ipqZWnIjbgEWs0sSpiLRlFzib78UKSO7Wuhwa8LQ9fOFLuoaYzHqL6pWTUiJ+jMPIpGxw3rP07JUgoHBPZ7tRVErnkzDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXpVaJMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5860C4CEDD;
	Thu, 13 Mar 2025 09:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856477;
	bh=AkCj/VZesoBCCX2zLdviQ+5R4ycUJ5Ug3uHgQzhbBLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXpVaJMxlUXIMMhHP/X8UmNxSQ+W9D8faea05Wx8ANuJpdQYK31WD8pIRDD5RyBkM
	 YLOT7hbmbs4+w0FpdxCSPhUQrPzGXZEBiUO0zpkYe4iy0baxXQDGXF89OBHKYQaauE
	 vUDsbX9uS1xmBbpEjlKy1OjWobtTdh5r1L9WsnHHurAkJ5+mSUQ5YDNZk6Eo0l6l8g
	 q1qiHtL4wLYsW9uGGPhYMcWZHNfA5QbWCTUGxm+GZHpxhXlwljkdy2eqSaBNpvKbQh
	 0AUQtvmwTpDPwMx+dbOE3pyliaVCR+tXA9JH1qAxajjtjF2bOgP0pWuiPCp2iOaiwo
	 3rk67h3FsMJiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenlinxuan@deepin.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Thu, 13 Mar 2025 05:01:15 -0400
Message-Id: <20250312205209-b20fd2c367e55db9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f

WARNING: Author mismatch between patch and found commit:
Backport author: Chen Linxuan<chenlinxuan@deepin.org>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc ! 1:  9a5818b460ee4 lib/buildid: Handle memfd_secret() files in build_id_parse()
    @@
      ## Metadata ##
    -Author: Andrii Nakryiko <andrii@kernel.org>
    +Author: Chen Linxuan <chenlinxuan@deepin.org>
     
      ## Commit message ##
         lib/buildid: Handle memfd_secret() files in build_id_parse()
     
    -    >From memfd_secret(2) manpage:
    +    Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
    +    Handle memfd_secret() files in build_id_parse()") to address an issue
    +    where accessing secret memfd contents through build_id_parse() would
    +    trigger faults.
     
    -      The memory areas backing the file created with memfd_secret(2) are
    -      visible only to the processes that have access to the file descriptor.
    -      The memory region is removed from the kernel page tables and only the
    -      page tables of the processes holding the file descriptor map the
    -      corresponding physical memory. (Thus, the pages in the region can't be
    -      accessed by the kernel itself, so that, for example, pointers to the
    -      region can't be passed to system calls.)
    -
    -    We need to handle this special case gracefully in build ID fetching
    -    code. Return -EFAULT whenever secretmem file is passed to build_id_parse()
    -    family of APIs. Original report and repro can be found in [0].
    +    Original report and repro can be found in [0].
     
           [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
     
    -    Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
    -    Reported-by: Yi Lai <yi1.lai@intel.com>
    -    Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
    -    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
    -    Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
    -    Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
    -    Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.ibm.com
    -    Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@kernel.org
    +    This repro will cause BUG: unable to handle kernel paging request in
    +    build_id_parse in 5.15/6.1/6.6.
    +
    +    Some other discussions can be found in [1].
    +
    +      [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kernel.org/T/#u
    +
    +    Cc: stable@vger.kernel.org
    +    Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
    +    Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
     
      ## lib/buildid.c ##
     @@
    @@ lib/buildid.c
      
      #define BUILD_ID 3
      
    -@@ lib/buildid.c: static int freader_get_folio(struct freader *r, loff_t file_off)
    - 
    - 	freader_put_folio(r);
    +@@ lib/buildid.c: int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
    + 	if (!vma->vm_file)
    + 		return -EINVAL;
      
    ++#ifdef CONFIG_SECRETMEM
     +	/* reject secretmem folios created with memfd_secret() */
    -+	if (secretmem_mapping(r->file->f_mapping))
    ++	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
     +		return -EFAULT;
    ++#endif
     +
    - 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
    - 
    - 	/* if sleeping is allowed, wait for the page, if necessary */
    + 	page = find_get_page(vma->vm_file->f_mapping, 0);
    + 	if (!page)
    + 		return -EFAULT;	/* page not mapped */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

