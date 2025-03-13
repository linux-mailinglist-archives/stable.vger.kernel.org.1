Return-Path: <stable+bounces-124234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B4A5EED1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B2917D095
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E380263C6A;
	Thu, 13 Mar 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAHCQttg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A526562A
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856495; cv=none; b=VX52MP2Z5Ca5sztnqeJlJYRPOp+9ZLBCmOv0jhoR/IDHVGrnKTRztMjaGWW4m3eMDWtCjMWdNpQSZjUP2kIW1lDuMWYFmko6SbYOpWQxqI0gd+17XawDtxF+v8GPlIMiXiHUhG0uKZetnudF/ssuIMxpaf8plZ7c1quTAMRpUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856495; c=relaxed/simple;
	bh=dyb3joWsIHxyAmpb6oynTAm/jbslo6fH2CKnxZbtDkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVzSr6z0XO/wUtFvIsOCVIbvgi+k12w6sYbCa/YA46o6AP/fJEKaNZqE8F5jEWon7Zuy/7UnIgjSwmMPaxnTxfrLClBKDesjNek2uIqlWad/P0suo6VWmiCTpTJrFmbEVsY6g8IMtyNTcpiRQiDNNLdADYnoKjZcm6I/EZNcsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAHCQttg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A727BC4CEEA;
	Thu, 13 Mar 2025 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856495;
	bh=dyb3joWsIHxyAmpb6oynTAm/jbslo6fH2CKnxZbtDkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAHCQttgzkyrgWUcrE5T1MvWtfSQ7o7ZCS1kpfcPhryKa4PkjeQsxPiajF7ZBGRiF
	 ZV2vRLvoJxXfMo9aMcnGp0Ary3WPdQn8HT9+24ZpHjM5fzNYVKcWd3YHZLfrhgWABe
	 k2FTxAFcNlYp7uprKrjMF7HNpcRaj3L/+XaZOq2ZOZJANYihsc+y94MZUXeWLOFkJm
	 OMvpIzzRgyHO7mRQOYgAWGGbJE+dK8cvBHcP0jqp7W5sOin5bljq0psw8gusV8gmtS
	 w/CiHKR2/iDwM385/agm6qp4otdiE6zcZJhwPbZbmBelcuCtZiBWMK1DrNzPEN/rdx
	 Gk1ZpmiqSgF+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	surenb@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm: fix kernel BUG when userfaultfd_move encounters swapcache
Date: Thu, 13 Mar 2025 05:01:33 -0400
Message-Id: <20250312204738-b4e540aab6e495cb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310185747.1238197-1-surenb@google.com>
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
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

Found matching upstream commit: c50f8e6053b0503375c2975bf47f182445aebb4c

WARNING: Author mismatch between patch and found commit:
Backport author: Suren Baghdasaryan<surenb@google.com>
Commit author: Barry Song<v-songbaohua@oppo.com>

Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c50f8e6053b05 ! 1:  8c54f12bcedaa mm: fix kernel BUG when userfaultfd_move encounters swapcache
    @@ Commit message
         Cc: Tangquan Zheng <zhengtangquan@oppo.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit c50f8e6053b0503375c2975bf47f182445aebb4c)
    +    [surenb: resolved merged conflict caused by the difference in
    +    move_swap_pte() arguments]
    +    Signed-off-by: Suren Baghdasaryan <surenb@google.com>
     
      ## mm/userfaultfd.c ##
     @@
    @@ mm/userfaultfd.c: static int move_present_pte(struct mm_struct *mm,
      			 unsigned long dst_addr, unsigned long src_addr,
      			 pte_t *dst_pte, pte_t *src_pte,
      			 pte_t orig_dst_pte, pte_t orig_src_pte,
    - 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
     -			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
     +			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
     +			 struct folio *src_folio)
    @@ mm/userfaultfd.c: static int move_present_pte(struct mm_struct *mm,
     -
      	double_pt_lock(dst_ptl, src_ptl);
      
    - 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
    + 	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
     @@ mm/userfaultfd.c: static int move_swap_pte(struct mm_struct *mm,
      		return -EAGAIN;
      	}
    @@ mm/userfaultfd.c: static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd
      	pte_t src_folio_pte;
      	spinlock_t *src_ptl, *dst_ptl;
     @@ mm/userfaultfd.c: static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
    - 				       orig_dst_pte, orig_src_pte, dst_pmd,
    - 				       dst_pmdval, dst_ptl, src_ptl, src_folio);
    + 				       orig_dst_pte, orig_src_pte,
    + 				       dst_ptl, src_ptl, src_folio);
      	} else {
     +		struct folio *folio = NULL;
     +
    @@ mm/userfaultfd.c: static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd
      			goto out;
      		}
      
    --		err = move_swap_pte(mm, dst_addr, src_addr, dst_pte, src_pte,
    --				    orig_dst_pte, orig_src_pte, dst_pmd,
    --				    dst_pmdval, dst_ptl, src_ptl);
    +-		err = move_swap_pte(mm, dst_addr, src_addr,
    +-				    dst_pte, src_pte,
    +-				    orig_dst_pte, orig_src_pte,
    +-				    dst_ptl, src_ptl);
     +		if (!pte_swp_exclusive(orig_src_pte)) {
     +			err = -EBUSY;
     +			goto out;
    @@ mm/userfaultfd.c: static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd
     +			}
     +		}
     +		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
    -+				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
    ++				orig_dst_pte, orig_src_pte,
     +				dst_ptl, src_ptl, src_folio);
      	}
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

