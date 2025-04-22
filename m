Return-Path: <stable+bounces-135180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B0A9754C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604B73A896A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DFF297A64;
	Tue, 22 Apr 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTjFgICN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681532900BE
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349479; cv=none; b=jFz0ggj/ezJD4vjejeLuQFE16jpTsfDrkiRfHcf97RjOFNJM+eJN2kAble/MedX8i6bSUzA4E+LvQRf56jOFlxVJn0OQmNtY1XNS4TzqoNjuvAq6l8VnP+ViApZ3XuxpQGClBb7MIwN+HKUyrghmt3ySv3C9IUcQMa1nc9Jr+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349479; c=relaxed/simple;
	bh=ARlH4/D0/wFdMAuGA5p0ziwhJld/gjefff8IhPXKYDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQ+hxpNfckL308YSn6bJXqZoRKoqmZHHv2Si79qkIjdU0snG0UX3OiehK/sjuM2u79yYUz/XubS2Bs/p3XfOqXO+/TLFAnwD5J413h8/3NHBOzlxNkWHleIjfYjniSyvuf4efGhO0RAro/IvD4sjp6J+BOAoaT3LyBBac859VdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTjFgICN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B355AC4CEE9;
	Tue, 22 Apr 2025 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349478;
	bh=ARlH4/D0/wFdMAuGA5p0ziwhJld/gjefff8IhPXKYDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTjFgICNg1OMMAlJVf2xy0PD4sCBcXbr1G0zuMKZIBHLg0A0GnoUaO+7iJtTECYRG
	 dT4h2WinzFiS8tcV25TsWoT4lwIbT4BoYMqDEsD1X5gChFb/w35Wm3gjlzNGI3OWOE
	 wJ/rsEiQeGlthDZWqlU+79QmJ1RMgyYMGsHvdAegk9dj4DTvYA48yKD4B2WjZB9R4a
	 AOt3CR/AQewQdQIlpjDw8SgTMx5R36jRrzVKJDF1Xn6BAMiXBjxUjhfC1mXIFa3Aqo
	 Yz8zUEkjtHtymWyUksf+oYwmcYBmfkjTPJ1K0xhHBgpT5ZDxmKROwO8k7t8TVpy8Rf
	 h6Wf0GJxF2oQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lorenzo.stoakes@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/vma: add give_up_on_oom option on modify/merge, use in uffd release
Date: Tue, 22 Apr 2025 15:17:56 -0400
Message-Id: <20250422123659-a06f5f388320cbae@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422113216.110404-1-lorenzo.stoakes@oracle.com>
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

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  41e6ddcaa0f18 ! 1:  80c1bca5589f9 mm/vma: add give_up_on_oom option on modify/merge, use in uffd release
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
    -@@ mm/vma.c: static __must_check struct vm_area_struct *vma_merge_existing_range(
    +@@ mm/vma.c: static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
      		if (anon_dup)
      			unlink_anon_vmas(anon_dup);
      
    @@ mm/vma.c: static __must_check struct vm_area_struct *vma_merge_existing_range(
      		return NULL;
      	}
      
    -@@ mm/vma.c: static __must_check struct vm_area_struct *vma_merge_existing_range(
    +@@ mm/vma.c: static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
      abort:
      	vma_iter_set(vmg->vmi, start);
      	vma_iter_load(vmg->vmi);
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
    -@@ mm/vma.h: __must_check struct vm_area_struct
    + static inline bool vmg_nomem(struct vma_merge_struct *vmg)
    +@@ mm/vma.h: struct vm_area_struct
      		       struct vm_area_struct *vma,
      		       unsigned long start, unsigned long end,
      		       unsigned long new_flags,
    @@ mm/vma.h: __must_check struct vm_area_struct
     +		       struct vm_userfaultfd_ctx new_ctx,
     +		       bool give_up_on_oom);
      
    - __must_check struct vm_area_struct
    - *vma_merge_new_range(struct vma_merge_struct *vmg);
    + struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
    + 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

