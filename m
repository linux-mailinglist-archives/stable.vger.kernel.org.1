Return-Path: <stable+bounces-124720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE760A658F7
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEEC165DDC
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A621A8F84;
	Mon, 17 Mar 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccteKLRi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE81A9B53
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229632; cv=none; b=n2H1B87fv0npq7hIu1cWBoukRQvztBM561QGfUFzHNCkQ8j0P8tydX0vCPJYJLd77mEy6rVzapOlo54L2un1SeICXc6eUWYqygzOxGWuqPHci/zSUFoW3IzJlduTMQMD7m1+u/atgnb6qq8l42PZwOrGAR0UOtIQ9V0kJOfpHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229632; c=relaxed/simple;
	bh=v6zsUwSu1YJfKkfyFhCNv/3Akl+TpybF4LERhjqtw5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxkHA0DqdJDTtdgRtUUJFwX/BCCoNjt/LQtYHRqtTVk5LMhZh+SUi56CASqVvclCbIMs35qf1I1HayXeepf0+7BXX7DVoJvpF5UEU+lsKfEgmGZvVEEy4uOov4ZVZeFXYDoGFCZyYM5h1AVbVBUsDqEIIn5y6Ib0hiBTqD0HOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccteKLRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EFEC4CEE3;
	Mon, 17 Mar 2025 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229632;
	bh=v6zsUwSu1YJfKkfyFhCNv/3Akl+TpybF4LERhjqtw5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccteKLRicO0vKYxHmIB5GScckDoSgSXANVBvRmOuY2rFsCgDMsIoHBFHVVyOI5d+m
	 saHPHTdYyIIIJkrm/I9/Fh9T3BudGNKebdx9mj/mdQdALrY8TUkCSp5wnVWA8pqPb6
	 oFg/uO/3FPnNsSJqAnWBYsIiJ7t4Uo04nEOAUHpbZTRbJtmCX97gRSsGK7Zz7SaLgc
	 QfADKby6kmhKlRvbOtv79YERjrKQMM8FXz9vy7HPRlDwlaapVfWwUvpLCkICqQWsfF
	 S9Q0np/u04y6/Huj1dsr5GZJV1t17xV8r+66MAFjW3jInsBXVFCAki36Y5S/I1K/31
	 DuKZRlm7NDROw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@deepin.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 v3] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 12:40:26 -0400
Message-Id: <20250317084100-14b40fd9574c782a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <485715E6BEC61FE5+20250317052325.24365-2-chenlinxuan@deepin.org>
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
1:  5ac9b4e935dfc ! 1:  690f6606d399c lib/buildid: Handle memfd_secret() files in build_id_parse()
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
| stable/linux-6.6.y        |  Success    |  Success   |

