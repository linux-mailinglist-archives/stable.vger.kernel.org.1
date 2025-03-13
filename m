Return-Path: <stable+bounces-124233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACBA5EED0
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C9A3AC21A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83E265621;
	Thu, 13 Mar 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS83JsG6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805126561C
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856493; cv=none; b=knQ/CJpuIYZN3LImc24SmGAdnmip3QwCh7a2gsw1U1Pfy2P5FqPgeAAMTwMP2Z0r3RX4ZYDxDeLdazKM7yrcvFqmRPf/AYAOIGds14Vtw6sGmQ/kEtx+yXonSPbG2euq4W7iP6Cv5M8NsrQoSa4FWXTX4l5nNEZ1gmD+9i2IwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856493; c=relaxed/simple;
	bh=SbkWpjfZf9kUPSfifYc7pwgagCB1t1lM1rT4h3xbE5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eADyUwVtIMIvnC75D1ovjiGmajt5w2WpwijULOTKtHcPiU5g7mvgz+NfYgOoECgPKWJaW3EZMDUOnnhMsyFekSLnnLb/ZxIjrlhKm8JsqaC6PcACflpqyEbZUsxCQ1YgtR7HsedHKDp7UOjdz99eBGXj5rB8sXe7iMoRBmar7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS83JsG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E5CC4CEEB;
	Thu, 13 Mar 2025 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856492;
	bh=SbkWpjfZf9kUPSfifYc7pwgagCB1t1lM1rT4h3xbE5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MS83JsG6EiaU0TfyuHAxN3qT3tNwvtBvKFdEyDdRwfqxukGz20psJO3zGKGGJQ6n5
	 WW1mFlK0rkKRKAkH1FuQXS9SDjlGdJ2iVbF/2gfNSETby0rjgG3qu/djEjVgWpkOod
	 LNDp5rHD36DMQLQAaBDbJbXnB4uSWhwBK7OSaH/otLpm+1CTAAE/NJltwMGC9cxIwy
	 2szLccHZ+ATkoPZyTaSY7s/bW5C8rLXuBgWb97mSoo7MizTxAwtOvL7HpdKXyzZc/2
	 VpJtR5Mr/9OOfCYRxP6Uce+7YeZzqtm0tA5U+TbRTLfWmgzTel84AB2SXJGXouU/pr
	 h3YM+fUSTTzYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenlinxuan@deepin.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Thu, 13 Mar 2025 05:01:31 -0400
Message-Id: <20250312203812-995fd1fd56c9a296@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <98CE17BE6E190CAE+20250311100624.310951-1-chenlinxuan@deepin.org>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc ! 1:  e898f7bad933b lib/buildid: Handle memfd_secret() files in build_id_parse()
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
| stable/linux-6.1.y        |  Success    |  Success   |

