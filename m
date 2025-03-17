Return-Path: <stable+bounces-124712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCCA65911
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443E1883EEF
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9E20A5DC;
	Mon, 17 Mar 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyb3H7dD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6A20A5D3
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229615; cv=none; b=bJhmGlQqQrAbLQ9s6vxiYXrwe6sX0gYn+PTzXy17kUmy0/4px6MBbssM4u6f7gZbpVg+x5dHImOiXLBTv7OMHry4d7+IRvYgkiIcjNkY9jtYKYLnFoU7UrNnI6EsL54rdRVq2HnoE8DlHIhiAYe5nxgV/wwkNnOKaXRmOf1mTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229615; c=relaxed/simple;
	bh=lEEy8CbyuwR214m/O/5cFIN6P8tpaVjAgsKdy1bfic4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaAWc8alqyu1n6efPKNWxCww4T6/iJfkRR54gLwEixJjwAss+EwWV1DgjzVX497emSjweTYoBwGrcC53dTuJPH4IuT+k2n2vViVWADYU2WGH8FDk5HhJsbYjM9HIeuJyLAldFv8PZ4RPAoTLRaKQ18DGt+PLeS8NWHXSqv+srlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyb3H7dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A543FC4CEED;
	Mon, 17 Mar 2025 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229615;
	bh=lEEy8CbyuwR214m/O/5cFIN6P8tpaVjAgsKdy1bfic4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyb3H7dDLyTP3zD74OrafDlaQKxAehEvktV4m9o/7OwtTMebkUzYitrEAg4sA5R/k
	 H+zDEQC8JAx2PeQgWnvL5j7FLd2xSwNmQNCVD+2CkjGF2w+5NfFqgl8H8X38QMEKmv
	 JvWODwVKl5F3MFjia6y4k2SpLmxrAgi//CMu5bX1tA6XlfxDLhGdp9GUkQ2qok0tMP
	 8VdEit1POXFifMiomDMyMZV/uD3oIsFYtcrOXhAhofqZyecd/oTI7bkDnJ3RgWGbc2
	 axCMBgXkq/rLaGC2hMgnGKHpB7dMTCU3OovxDiPjUNcsAqS0JKf20SPPv3tZ6JXsJ0
	 uPdRpwSf5SMMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@deepin.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 v2] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 12:40:13 -0400
Message-Id: <20250317090506-5c90a17e25570f70@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <84B05ADD5527685D+20250317011604.119801-2-chenlinxuan@deepin.org>
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

The upstream commit SHA1 provided is correct: 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Linxuan<chenlinxuan@deepin.org>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc ! 1:  c4f7486bd3c69 lib/buildid: Handle memfd_secret() files in build_id_parse()
    @@
      ## Metadata ##
    -Author: Andrii Nakryiko <andrii@kernel.org>
    +Author: Chen Linxuan <chenlinxuan@deepin.org>
     
      ## Commit message ##
         lib/buildid: Handle memfd_secret() files in build_id_parse()
     
    +    [ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]
    +
         >From memfd_secret(2) manpage:
     
           The memory areas backing the file created with memfd_secret(2) are
    @@ Commit message
         Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
         Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.ibm.com
         Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@kernel.org
    +    [ Chen Linxuan: backport same logic without folio-based changes ]
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
      
    -+	/* reject secretmem folios created with memfd_secret() */
    -+	if (secretmem_mapping(r->file->f_mapping))
    ++	/* reject secretmem */
    ++	if (vma_is_secretmem(vma))
     +		return -EFAULT;
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

