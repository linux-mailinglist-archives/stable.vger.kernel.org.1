Return-Path: <stable+bounces-124697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E68A658EE
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E581898C0F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24BE1A5BA2;
	Mon, 17 Mar 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr0X9I5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF952080E9
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229590; cv=none; b=ZPXxaq8+kH5Zh+pDZIg3qmhmOI7QkffiTs2QbqQrS56FsJQlSIuxKkO5BPO6uxX/dnuxFm6lHhtNoorsKKxR1AGUkZRiGHyh4g2z+W2VRk8KxIbSHbjcM9M/V4AIXCcIxixFkmM3qKZuStWN9IN/p0yNCd7Z+q6fLNdxAnbmsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229590; c=relaxed/simple;
	bh=MicF0DeYfPx35BUCdArjk4ZNo6goKM7torN49w7vlrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=at2TRQunkdY0ev95Icor5wfXuLw/DRcWcinPsqu+S41VRjhHR2kqQURHHw5k2wv29C6u4HXrfoTM/vhXnEM2GRBwrvPOt/gtAyABwxtQBiz2VlvKYrLmwYgBeLA13PQl6TkYhqUS3EwhugEmEUB2trxxUWtecdKtlpHiPVX59Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr0X9I5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1313C4CEE3;
	Mon, 17 Mar 2025 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229590;
	bh=MicF0DeYfPx35BUCdArjk4ZNo6goKM7torN49w7vlrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wr0X9I5pT1+q0jZ+ECuiIpWEqwb+u/e0buAvwaTMI2gvD3JzY+/moEQ8dxC4nt7+L
	 xwBuHe1w761rFiIMNy+0LrpXXYlfXIMscrhyhyZjzEYVkDhIJ6P4Hnj/hHsh4LSxSU
	 a6d3BrwtXG4FhjRoCfNl7w+ODcve0xwNiHydEkdp1xXEaFiYmu+BCuYAWA3MMMO18Q
	 GZ4f2CtYiMr9dgTO50HZOqGolSics0Ua/db/b2L4bD+BeE+NTOEASO4ZNhFs/2iq4M
	 SeZudm+AWSZVF9ipTjq7j0uslo8TrWoSPt484DzkqkiWgsMoK+FTIr5McvJluqO0+O
	 Xrg8Nor1lMp1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@deepin.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1 v3] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 12:39:48 -0400
Message-Id: <20250317085620-5219e1d0fa181917@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <84211070D1A421C2+20250317052300.24146-2-chenlinxuan@deepin.org>
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
6.6.y | Present (different SHA1: 80ca7ac4aa22)

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc ! 1:  1df0ffc18d9ec lib/buildid: Handle memfd_secret() files in build_id_parse()
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
      
     +	/* reject secretmem folios created with memfd_secret() */
    -+	if (secretmem_mapping(r->file->f_mapping))
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
| stable/linux-6.1.y        |  Success    |  Success   |

