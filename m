Return-Path: <stable+bounces-124699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8BDA658CF
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04944176AD1
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5B1208970;
	Mon, 17 Mar 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzDtkr19"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549020896B
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229594; cv=none; b=Pkbp7Z9/bSZ/zjOMUhnfp67c//vHj9G0plcIVJCTG1mQcI+Qyu08NyITeSBM4zLYNsqeNhaR3GLxtglVaiH4M4Jlr4s21zGcuqh8Ycgd0f7MvhPEkLdb82eyOHqzZZXwxqYREhG77jw59GlH1S8SY9j86JsPn9lxkQNYdxYDgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229594; c=relaxed/simple;
	bh=Vz68pLxDECw8kUXLUr5TBoK/O9jKyOm+uZf1K6dDM+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvhF1fmIoV0AAVeNPQWNRYj1GOMXpkNdArsyyM30nhJDxTpYTLeuVXJ/hNIec7aRSU5sAZpg3Na0ut7iieXKdJ3iRQUWlN9SzKosWFTZ82BGj2JOrs7XyMvXGcfRgTSasTcegTxFs3iGA0ddeMhqkxnizw4gHa76zB5NOuDoTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzDtkr19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31770C4CEE3;
	Mon, 17 Mar 2025 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229592;
	bh=Vz68pLxDECw8kUXLUr5TBoK/O9jKyOm+uZf1K6dDM+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzDtkr19QFJOTCCVvQUhWg9e51//xgWZz8IHYVbM7qecqIdtTLxIHqLCqy60VMlJ9
	 hDEsSWx9Hw0h+1FKVa3+FGG+0xJ9s9hJjH9HX3Tre77jTgtq3K/uQg9PHFifaD+RIl
	 HDcKMGBO7fVT3O4NbW5mUJu6oEgO1zgYS+AXMK0f+FB4eRMJ+CdSPGBx2Ivkyir182
	 ON2LfNT8RunzPa8Lf/lxEmLgqLlRXRDdNyDjd41QxpPhA56F+d9tNC48yygj+KwdVW
	 grrpjUeQzfNoGlHSJwItmBOrURY3sqFT0B0YtM2rBpiGQGVoDfsCaweOrwrX6Bp20l
	 CzlYcK/JBFHxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@deepin.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1 v2] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 12:39:50 -0400
Message-Id: <20250317092710-f8328206c72a587e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <16124577164D1373+20250317011540.119614-2-chenlinxuan@deepin.org>
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
6.6.y | Present (different SHA1: a230a1bf75ae)

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc ! 1:  6ad30ec95efa4 lib/buildid: Handle memfd_secret() files in build_id_parse()
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
| stable/linux-6.1.y        |  Success    |  Success   |

