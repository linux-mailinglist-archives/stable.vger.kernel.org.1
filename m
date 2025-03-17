Return-Path: <stable+bounces-124700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4470A658D1
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E2178406
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D1208979;
	Mon, 17 Mar 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZu2pfbO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2617208974
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229595; cv=none; b=K9Zz43ETeXacuf6tYRhDqhCk6eNhEaTXmEDFfM1YSAVUf/Ba198SFf2mayFFz5zI+dKnPze4VSrmqWfCI+bh3Z71zRIfuLo1KfVPwkafElOEKhZWQ2mIW+Y8ILgvSk2U3hkPDVmhVCRzCDqwnN9JKRTMpEDTbrc6hIvAVcWieyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229595; c=relaxed/simple;
	bh=kMQ0HRwiw1dmsUxw16Bf7+UGDY7JTeV8V26gV2LvUuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pi4telQ6vWLjZ77fryL18N9uFEaxXQuE5pSJZ1vU9qIzfDMQCAkMSmiCMQDp3vLY+IL0bq+NXqndx1TuKmN5TzT1I6Gq217IE+rMUsnbgKpnC+C5US8fsJME2BRY7kRwzF86matv0Li+jw+t9pHOrduqDUN6LSxb8oAB2jCl4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZu2pfbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5495CC4CEEF;
	Mon, 17 Mar 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229594;
	bh=kMQ0HRwiw1dmsUxw16Bf7+UGDY7JTeV8V26gV2LvUuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZu2pfbOw7fVdWXTPqMBI65BXaTru9PbfbcC5OwXVgF0SjeByst/racf3jQW8RlgS
	 MtowzxI2AjRzcO9So8VJoO3oWQRn2GugghyLidTnYypTNtzLVk8zrBT02S8Sh+pYge
	 JrfRPHeqcHk3RJTBBBfMT37/dj10wyw6IUnPO3ONdB3bNCMFzJoFhtosJVLW2b5zK2
	 PqswSjG3ySIIKslAYGsDAeQgAoz0g2r/EpJUojEXJRLvjk/6mb6TyJcHrWK48lVYkX
	 Et/z22PHyC/lNCgvgf1iHIwEdl8AWZh2T68X0sG6uAO1fQYYrqlmTMOPY8RDk7njwT
	 DR4eh3+tJYoOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@deepin.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15 v3] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 12:39:53 -0400
Message-Id: <20250317084713-a5cb069f8513d270@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <DC5F0190D52D7B57+20250317052132.23783-2-chenlinxuan@deepin.org>
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
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc ! 1:  dbfb55637bbbe lib/buildid: Handle memfd_secret() files in build_id_parse()
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
| stable/linux-5.15.y       |  Success    |  Success   |

