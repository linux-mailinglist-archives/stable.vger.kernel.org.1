Return-Path: <stable+bounces-161355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D39DAFD7C7
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09637A35A0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531451E520A;
	Tue,  8 Jul 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCJcH3Pn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C9224D7
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004918; cv=none; b=OBBH47sHdalW+4p8CCkT4XXgYeV9UsQlfoBWTZu5TyGL1jeypfOig4S+hm4V977Y35ofVcpFKQvGJJxHwzmQOAwfhGN7UQOtMf/ahsRufRxhnHub7/Oz0wskuo3nyKBI1OMkHHdH1eXmeww8fyEXsCaWs/KJ1Jq/fUtq6tDZ7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004918; c=relaxed/simple;
	bh=EitAlsk8O7ylVVgie4N3LHZPX5bIAEbIuC7yAeCXN3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiMWYZjzaRPs/oi6CX5h96Rf0W+s19zBm+ihkoTUUw/Wr+7TWPpo8XcqmY4U/qUWfGUOBqoJyq/68PiwAdU87zidRmJVA56j5IwvzJMvQQQwvGJWPj5uswUAvGawbK551Z6tum6FWf+veMTt2sz5l31Ol/iaQQH6RAzG296SB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCJcH3Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C0CC4CEED;
	Tue,  8 Jul 2025 20:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752004917;
	bh=EitAlsk8O7ylVVgie4N3LHZPX5bIAEbIuC7yAeCXN3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCJcH3Pnm6/1l1pblXdAnonXtBSPupaHishJ9+ghCXB4b5CFL6j9Z0EQbPr6DN0dt
	 QpixV6yQBL2JgEhBsqXDt3mUOzf0R7XyML7DkD1zLBn17OEgQcgLumAzacIobLMIKI
	 KipwK5/3LF1h9CJnV9vmOPNfx2glY7UThdQQIVDvDo8kf5C39Y8oJOQVmwlO3UnWeK
	 3fwg7fjvwEuUAeaWjt3OrjIy6eVp/frlJDsElLSTZzSh+4cdaoE4cNz5Wdexzye4hw
	 OKUzToyUM2n1tSDw4mXWRXxWYyWzLjWaPOEhmLJHpgmWXQ7/oYWrBTIzwJjGGbUrXO
	 oTkH+oMzZalNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lokeshgidra@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm: userfaultfd: fix race of userfaultfd_move and swap cache
Date: Tue,  8 Jul 2025 16:01:52 -0400
Message-Id: <20250708115052-a0931f57d43f3a34@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250708135802.2870878-1-lokeshgidra@google.com>
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

Found matching upstream commit: 0ea148a799198518d8ebab63ddd0bb6114a103bc

WARNING: Author mismatch between patch and found commit:
Backport author: Lokesh Gidra<lokeshgidra@google.com>
Commit author: Kairui Song<kasong@tencent.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: db2ca8074955)

Note: The patch differs from the upstream commit:
---
1:  0ea148a799198 ! 1:  f52f3e06e0bb8 mm: userfaultfd: fix race of userfaultfd_move and swap cache
    @@ Commit message
         I'm not sure if there will be any data corruption though, seems no.
         The issues above are critical already.
     
    -
         On seeing a swap entry PTE, userfaultfd_move does a lockless swap cache
         lookup, and tries to move the found folio to the faulting vma.  Currently,
         it relies on checking the PTE value to ensure that the moved folio still
    @@ Commit message
         Cc: Kairui Song <kasong@tencent.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 0ea148a799198518d8ebab63ddd0bb6114a103bc)
    +    [lokeshgidra: resolved merged conflict caused by the difference in
    +    move_swap_pte() arguments]
    +    Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
     
      ## mm/userfaultfd.c ##
     @@ mm/userfaultfd.c: static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
    + 			 pte_t *dst_pte, pte_t *src_pte,
      			 pte_t orig_dst_pte, pte_t orig_src_pte,
    - 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
      			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
     -			 struct folio *src_folio)
     +			 struct folio *src_folio,
    @@ mm/userfaultfd.c: static int move_swap_pte(struct mm_struct *mm, struct vm_area_
     +
      	double_pt_lock(dst_ptl, src_ptl);
      
    - 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
    + 	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
     @@ mm/userfaultfd.c: static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
      	if (src_folio) {
      		folio_move_anon_rmap(src_folio, dst_vma);
    @@ mm/userfaultfd.c: static int move_swap_pte(struct mm_struct *mm, struct vm_area_
     @@ mm/userfaultfd.c: static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
      		}
      		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
    - 				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
    + 				orig_dst_pte, orig_src_pte,
     -				dst_ptl, src_ptl, src_folio);
     +				dst_ptl, src_ptl, src_folio, si, entry);
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

