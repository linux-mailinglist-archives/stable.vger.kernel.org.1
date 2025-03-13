Return-Path: <stable+bounces-124252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25841A5EF34
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B143F17D079
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC81FA14E;
	Thu, 13 Mar 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMFkIIbT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873D43159
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857102; cv=none; b=e6E+mO3TMIIUeYB2XwTr2qS1b4duihHBkISB983sYrqfyWuS5D2ZS5JVqOAVy/Pq1s33/sWy3o/YwaUVB1iui44MxE+Jpi5wKa0VuqA194D9+WrywMBErB/kcLazylkzwruTw1jQULfwmipQcXhX3JAEVHuglip9zrd0ONx1QFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857102; c=relaxed/simple;
	bh=WG5wTdDDsMhaiCTof5pN+dUFzudDMJOIgkNFqBCY4D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuEJT4+4Cey4Be4YJLueu1DDr8v3DDhVwIMVM17lefuUALMwOWv0X1eD+pArGI/dBlTwdepOOd898lHFryEZpu2o4H1AIDbXvw53Xfb3DjMxq8MQydFT7mT/dHfIrXRiiieWXgVFNtD+mSGMo0/VZ8aOkMFDAKAqLnaAbaf9cV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMFkIIbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8DDC4CEE3;
	Thu, 13 Mar 2025 09:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857101;
	bh=WG5wTdDDsMhaiCTof5pN+dUFzudDMJOIgkNFqBCY4D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMFkIIbTpwhKcpw0kNcPRQTe3KStO41lIQxa+T3wasjAmDPZX1wOv3lpvyEQ2EIxo
	 iUTie7rRcTv19/JwW23Qv3/WUPN4j85cTMxUnxhbncxgGPOKt0/tDQzsOMCOYvGCyb
	 nrd2IqYkAgC9GkS9B2/h4F9N1QI7NCW5JXQPOjmj8YhyafX3VdkeTo6OagrJTiIYc9
	 Zp3ohHl4H6RbhKSBMJE7esJdZhQtoOLvIrCHSDqao4zb2XsVjKKZPQIQsv287lFoSm
	 yWjJPN97mxbooFkZAhYyUPFjJ9p0g0DTe6ZR5ujG66XKaqh33s+8bSKugX/xCxVaHD
	 1PzstM8J36Wcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	surenb@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] mm: fix kernel BUG when userfaultfd_move encounters swapcache
Date: Thu, 13 Mar 2025 05:11:40 -0400
Message-Id: <20250312202148-3e8bae0d982b55ab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310184033.1205075-1-surenb@google.com>
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

Found matching upstream commit: c50f8e6053b0503375c2975bf47f182445aebb4c

WARNING: Author mismatch between patch and found commit:
Backport author: Suren Baghdasaryan<surenb@google.com>
Commit author: Barry Song<v-songbaohua@oppo.com>

Note: The patch differs from the upstream commit:
---
1:  c50f8e6053b05 ! 1:  21842a7c36d00 mm: fix kernel BUG when userfaultfd_move encounters swapcache
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
| stable/linux-6.13.y       |  Success    |  Success   |

