Return-Path: <stable+bounces-121305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B8A5563A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8199B1896BDE
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3D26D5C5;
	Thu,  6 Mar 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJEr6qAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0DB26D5A7
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288278; cv=none; b=S3TLzg+JBvZ/K4DK2im0m1mGG5N9utR7U02AeE6sQ4Wbh1gYQm9dtlM2HuCV1PSqBi1ZrTLIszOuE9sCk8SQ70HhbeQS1/BBV8ENucMhznwks5PKZfEggHujLd6Ja421LPE1arfZtCepbhw0sA2eq+V78q3WTAjgcjJKyUk2yC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288278; c=relaxed/simple;
	bh=kyseAzWxuxudheFOR5RCsS7pxDa8jb4AJ/db2mc3qn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mo/fU37hIqFXbxy0x4PoiXqQMtz7sppy1vVvRgjWqUwijpfSxg7v2YQ9dso/U1T6XeZ/Q/I3paRpzTUz2GextY2mDAgHC86Z7OCZX/MWTwQj2IxEpmQfjh4oXuvc0zBtKH7e0bU3uhvWPWwkXGV7TjpevFTsZtUqCaALnewkXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJEr6qAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9058BC4CEE0;
	Thu,  6 Mar 2025 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288278;
	bh=kyseAzWxuxudheFOR5RCsS7pxDa8jb4AJ/db2mc3qn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJEr6qAsJAEB2mht/d8i7ZJoTfwK07aZjncxkFLswdAOaV0PH6OtHZlRHRzJE1aSQ
	 R02r5Vd/EMLLn1tyfAEyHz5OgAqNjoOZkBRGZP4VBtzuSbMCbOwsB5xjX7AUfXrfGV
	 JNfXzQm7JpUw5XVEn0+IWnoeBVxBbLzBC36CLfAboHdZL30+i3qoATmm6BAkbJ+Act
	 FxqT7AAQJD3uxSKk/E6scKXMyqzgn9g5NvALBEGoJh6IAyEsc/ViABERsuim9UoEzD
	 dYm0nCUGpD5PvpUaUJXYaBD/wyG9G86LWY4K/GpG8J40x+q+VpMe4HYiitpvHj/nFo
	 q9Cbcfkl4kHDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ryan.roberts@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
Date: Thu,  6 Mar 2025 14:11:16 -0500
Message-Id: <20250306120703-d2316e4be6b8a37f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250306150250.154641-1-ryan.roberts@arm.com>
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
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 49c87f7677746f3c5bd16c81b23700bb6b88bfd4

Note: The patch differs from the upstream commit:
---
1:  49c87f7677746 ! 1:  180bfe1de8d8a arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
    @@ Commit message
         Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
         Link: https://lore.kernel.org/r/20250226120656.2400136-3-ryan.roberts@arm.com
         Signed-off-by: Will Deacon <will@kernel.org>
    +    (cherry picked from commit 49c87f7677746f3c5bd16c81b23700bb6b88bfd4)
    +    Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
     
      ## arch/arm64/mm/hugetlbpage.c ##
     @@ arch/arm64/mm/hugetlbpage.c: static int find_num_contig(struct mm_struct *mm, unsigned long addr,
    @@ arch/arm64/mm/hugetlbpage.c: static pte_t get_clear_contig(struct mm_struct *mm,
      			     unsigned long pgsize,
      			     unsigned long ncontig)
      {
    --	pte_t orig_pte = __ptep_get(ptep);
    +-	pte_t orig_pte = ptep_get(ptep);
     -	unsigned long i;
     -
     -	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
    --		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
    +-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
     -
     -		/*
     -		 * If HW_AFDBM is enabled, then the HW could turn on
    @@ arch/arm64/mm/hugetlbpage.c: static pte_t get_clear_contig(struct mm_struct *mm,
     +	pte_t pte, tmp_pte;
     +	bool present;
     +
    -+	pte = __ptep_get_and_clear(mm, addr, ptep);
    ++	pte = ptep_get_and_clear(mm, addr, ptep);
     +	present = pte_present(pte);
     +	while (--ncontig) {
     +		ptep++;
     +		addr += pgsize;
    -+		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
    ++		tmp_pte = ptep_get_and_clear(mm, addr, ptep);
     +		if (present) {
     +			if (pte_dirty(tmp_pte))
     +				pte = pte_mkdirty(pte);
    @@ arch/arm64/mm/hugetlbpage.c: static pte_t get_clear_contig(struct mm_struct *mm,
      }
      
      static pte_t get_clear_contig_flush(struct mm_struct *mm,
    -@@ arch/arm64/mm/hugetlbpage.c: pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
    +@@ arch/arm64/mm/hugetlbpage.c: pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
      {
      	int ncontig;
      	size_t pgsize;
    --	pte_t orig_pte = __ptep_get(ptep);
    +-	pte_t orig_pte = ptep_get(ptep);
     -
     -	if (!pte_cont(orig_pte))
    --		return __ptep_get_and_clear(mm, addr, ptep);
    +-		return ptep_get_and_clear(mm, addr, ptep);
     -
     -	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_get_and_clear':
    arch/arm64/mm/hugetlbpage.c:404:35: error: 'sz' undeclared (first use in this function); did you mean 's8'?
      404 |         ncontig = num_contig_ptes(sz, &pgsize);
          |                                   ^~
          |                                   s8
    arch/arm64/mm/hugetlbpage.c:404:35: note: each undeclared identifier is reported only once for each function it appears in
    make[4]: *** [scripts/Makefile.build:243: arch/arm64/mm/hugetlbpage.o] Error 1
    make[4]: Target 'arch/arm64/mm/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:480: arch/arm64/mm] Error 2
    make[3]: Target 'arch/arm64/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:480: arch/arm64] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1916: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:234: __sub-make] Error 2
    make: Target '__all' not remade because of errors.

