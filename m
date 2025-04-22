Return-Path: <stable+bounces-135188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D7BA975E3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A25E3BB753
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD6285414;
	Tue, 22 Apr 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up7aEj2b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0F1F09A1
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351165; cv=none; b=YJxXAeoqinqbPjH5/W2Fp6+Lkiyh1wXYQrbw3Ab4nrOxjsSeOy6zpUFAiGkOaMg9YaqKJB2EPK3niGf1N6znffwlzEk97cNU5nryls0AYli9MP7iqYxv49r0gM8fxUBpZzLY5xu9DxTXnRBC/eHWulLKLHIRKfy5o8Yby80NvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351165; c=relaxed/simple;
	bh=RnE2xgExnmfNRzWPFcF+cFpugaflomoOx+YIPy3cOK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9PgAAl6tba0usT88v8l6YzcK8TtxBJZETm5xce3it/eLrSQXiHPenesqYzwUEbNGvCEPbkamKrqXiCxJ2JCMCG56CHD1E/RF2h4O3D3gQCpWH6F5Dw0iP5vfmT2nYpIy9UE9Tvy5qg/HTJFdHkMkgWlx4bSOcI67JGMpX/Os4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up7aEj2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5EAC4CEEB;
	Tue, 22 Apr 2025 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351165;
	bh=RnE2xgExnmfNRzWPFcF+cFpugaflomoOx+YIPy3cOK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Up7aEj2bdCitvson0cF3WfIMKoH6aJLqgrXC/GjMa6jUQuDVga/vJmY1Do573XI0I
	 Ay4ro/LVyAZ9x+zNEOGaQwhmLWEBLVkE64vUpGG8TSHh1Gyhu8RPRMQe90/dzCFbDl
	 hkYb/FGpuO/J4dAUQ5X8ur05ltaLXiULxBU1XFjAfQsrp13KpPmTA+QqtgZoIMvVHd
	 VuxoazCZ95tTWlK0LYSvfjVwVs181VtgRK9yzcBekeBHzBBo8LqCCGuAGqL9PakrfC
	 uNkY5j5n+IhxlHgRl823UrfGIbLcEUXRabg0R6ptSqoCeAuQH2fohlwFBpE/yrdIrd
	 2lryhzcZlKwdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lorenzo.stoakes@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] mm/vma: add give_up_on_oom option on modify/merge, use in uffd release
Date: Tue, 22 Apr 2025 15:46:03 -0400
Message-Id: <20250422121243-f2c1c735f50ee56f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422115226.149137-1-lorenzo.stoakes@oracle.com>
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

Found matching upstream commit: 41e6ddcaa0f18dda4c3fadf22533775a30d6f72f

Note: The patch differs from the upstream commit:
---
1:  41e6ddcaa0f18 ! 1:  8030ce55b9d25 mm/vma: add give_up_on_oom option on modify/merge, use in uffd release
    @@ Commit message
         Suggested-by: Jann Horn <jannh@google.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 41e6ddcaa0f18dda4c3fadf22533775a30d6f72f)
     
      ## mm/userfaultfd.c ##
     @@ mm/userfaultfd.c: struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
    @@ mm/userfaultfd.c: int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
      
     
      ## mm/vma.c ##
    -@@ mm/vma.c: static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
    - /*
    -  * Actually perform the VMA merge operation.
    -  *
    -+ * IMPORTANT: We guarantee that, should vmg->give_up_on_oom is set, to not
    -+ * modify any VMAs or cause inconsistent state should an OOM condition arise.
    -+ *
    -  * Returns 0 on success, or an error value on failure.
    -  */
    - static int commit_merge(struct vma_merge_struct *vmg)
    -@@ mm/vma.c: static int commit_merge(struct vma_merge_struct *vmg)
    - 
    - 	init_multi_vma_prep(&vp, vma, vmg);
    - 
    -+	/*
    -+	 * If vmg->give_up_on_oom is set, we're safe, because we don't actually
    -+	 * manipulate any VMAs until we succeed at preallocation.
    -+	 *
    -+	 * Past this point, we will not return an error.
    -+	 */
    - 	if (vma_iter_prealloc(vmg->vmi, vma))
    - 		return -ENOMEM;
    - 
     @@ mm/vma.c: static __must_check struct vm_area_struct *vma_merge_existing_range(
      		if (anon_dup)
      			unlink_anon_vmas(anon_dup);
    @@ mm/vma.c: static __must_check struct vm_area_struct *vma_merge_existing_range(
      	return NULL;
      }
      
    -@@ mm/vma.c: int vma_expand(struct vma_merge_struct *vmg)
    - 		/* This should already have been checked by this point. */
    - 		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
    - 		vma_start_write(next);
    -+		/*
    -+		 * In this case we don't report OOM, so vmg->give_up_on_mm is
    -+		 * safe.
    -+		 */
    - 		ret = dup_anon_vma(middle, next, &anon_dup);
    - 		if (ret)
    - 			return ret;
     @@ mm/vma.c: int vma_expand(struct vma_merge_struct *vmg)
      	return 0;
      
    @@ mm/vma.c: struct vm_area_struct
     
      ## mm/vma.h ##
     @@ mm/vma.h: struct vma_merge_struct {
    - 	 */
    - 	bool just_expand :1;
    - 
    + 	struct anon_vma_name *anon_name;
    + 	enum vma_merge_flags merge_flags;
    + 	enum vma_merge_state state;
    ++
     +	/*
     +	 * If a merge is possible, but an OOM error occurs, give up and don't
     +	 * execute the merge, returning NULL.
     +	 */
     +	bool give_up_on_oom :1;
    -+
    - 	/* Internal flags set during merge process: */
    + };
      
    - 	/*
    + static inline bool vmg_nomem(struct vma_merge_struct *vmg)
     @@ mm/vma.h: __must_check struct vm_area_struct
      		       struct vm_area_struct *vma,
      		       unsigned long start, unsigned long end,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

