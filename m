Return-Path: <stable+bounces-83117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7FA995BEB
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 01:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42689286436
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CC217332;
	Tue,  8 Oct 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EEPYVHFc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C871D0B8B
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431903; cv=none; b=RT8QVXKWeQF9CI3VEvBz++BhaGIR3SDiCbCkjdFwHdnUEGPwZuCthUDIw4ZcreOHUg0//Q7Gh4KuyFYOTYoWQyGAxMH5Ujl22+fX7AmvoSZHZ9fs+LHiGt1tZV7B4pmFrpFLYFi5BcGsWCS9e3v14CE7GphphbRaMx0LDuNV8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431903; c=relaxed/simple;
	bh=O6Bg274G8NJsc/gYr/xwjfQ0Cwo6y3A3Gl+v8zT4ii0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/RfEhPyihHBI75fn05M3wbtmVt/BLTGJnNKtGEZb0oTh1mTHG1PF5VuBdG6lzoRHi+UUKFHzoB175Xq8mhq5C1//SsWLakrq5Cq8v65ELvO44rjv8LTspHHOValls4Ey78v1PupH53xnTBOrHQPc9UO3JRxx5KXhiKdEXHEuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=EEPYVHFc; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so5569337276.3
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1728431900; x=1729036700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31IFgPjCDKr2yN/1uXsCZ+3MaYecDU0kdN0PY7CCTI4=;
        b=EEPYVHFcZiUhmew9trVXgkM5rPX/njmqyNkB6rLELaaq6veta0by6Ji7xIzfl51qxp
         dFjbzqA6Id2BjPv4l538M8aoGXk4vSZ0Jicwkgef1bY3aGfPrHv1uL1Mb+rszCSo1kX9
         /VjCFBvL/ZA1Tc7U8aHwjIeJ9yGI6BBoQtgMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728431900; x=1729036700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31IFgPjCDKr2yN/1uXsCZ+3MaYecDU0kdN0PY7CCTI4=;
        b=N8ZVfrfUQg3ftETI/rRfZ1AizfO9zISUNXsNtz7YzDsEeCI/AynbFTKJVo1vU7XPXg
         9HF/9TZedFYxkxcmOcd09U3yLFu8lQLFNBZkvc2n7ZCqeCbH+CTK/PJE8WEIXKwYAnLt
         aqYr89J+CClW7ftGWcTuA8cW40849Hls1zs3QkHpuInJyoH0TTg3HZZicAyyV0hI9+0c
         rw4qa2r7VVEHxQ/n569I45gdRXqfGKIImeHOFo1OR2oes8SfiPEoQ2m58scP5rJeQvsL
         nnWhd/CnFk2nkt6BJZtw76rQ7ITqeXP5Ks4BSsF9lSwlbLOv+LriIXjpacZuWYxz1wh2
         3MxA==
X-Forwarded-Encrypted: i=1; AJvYcCXH6x0mJJ/WC+evhq7OuSKbUAT5m+bN/rTk0CyMG7hIYFnlUzmxYxJrj4kzCfIfOcZw7Vor8MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUXbtJBJ1QfOiznr0m908vVnrH/MMXtTEHc3LuNGoIeywAZ74
	qpf/sR/LsqXBtiPtLr9nPVzVxjMX8VUIbxUTaBU/PiOm9IK+S1J4umqGpF2r5s786XsPXNjONG6
	vRIAhBEKTsQK3HaDGKpEFcyOqLsz4QgP8JdzuAg==
X-Google-Smtp-Source: AGHT+IG+0d7vkbx25LOXKc8z9LG8Yqk2gSSRR5Ousyz0X7YZdecXwOYW1eOpBeMCnlUi7PhXf7bW2NYfGzG8cae91Tc=
X-Received: by 2002:a05:6902:c03:b0:e1d:44e9:a8fa with SMTP id
 3f1490d57ef6-e28fe40ff41mr738530276.46.1728431899868; Tue, 08 Oct 2024
 16:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
In-Reply-To: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 8 Oct 2024 19:58:08 -0400
Message-ID: <CAEXW_YSxcPJG8SrsrgXGQVOYOMwHRHMrEcB7Rp2ya0Zsn9ED1g@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	willy@infradead.org, hughd@google.com, lorenzo.stoakes@oracle.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:42=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> In mremap(), move_page_tables() looks at the type of the PMD entry and th=
e
> specified address range to figure out by which method the next chunk of
> page table entries should be moved.
> At that point, the mmap_lock is held in write mode, but no rmap locks are
> held yet. For PMD entries that point to page tables and are fully covered
> by the source address range, move_pgt_entry(NORMAL_PMD, ...) is called,
> which first takes rmap locks, then does move_normal_pmd().
> move_normal_pmd() takes the necessary page table locks at source and
> destination, then moves an entire page table from the source to the
> destination.
>
> The problem is: The rmap locks, which protect against concurrent page tab=
le
> removal by retract_page_tables() in the THP code, are only taken after th=
e
> PMD entry has been read and it has been decided how to move it.
> So we can race as follows (with two processes that have mappings of the
> same tmpfs file that is stored on a tmpfs mount with huge=3Dadvise); note
> that process A accesses page tables through the MM while process B does i=
t
> through the file rmap:
>
>
> process A                      process B
> =3D=3D=3D=3D=3D=3D=3D=3D=3D                      =3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> mremap
>   mremap_to
>     move_vma
>       move_page_tables
>         get_old_pmd
>         alloc_new_pmd
>                       *** PREEMPT ***
>                                madvise(MADV_COLLAPSE)
>                                  do_madvise
>                                    madvise_walk_vmas
>                                      madvise_vma_behavior
>                                        madvise_collapse
>                                          hpage_collapse_scan_file
>                                            collapse_file
>                                              retract_page_tables
>                                                i_mmap_lock_read(mapping)
>                                                pmdp_collapse_flush
>                                                i_mmap_unlock_read(mapping=
)
>         move_pgt_entry(NORMAL_PMD, ...)
>           take_rmap_locks
>           move_normal_pmd
>           drop_rmap_locks
>
> When this happens, move_normal_pmd() can end up creating bogus PMD entrie=
s
> in the line `pmd_populate(mm, new_pmd, pmd_pgtable(pmd))`.
> The effect depends on arch-specific and machine-specific details; on x86,
> you can end up with physical page 0 mapped as a page table, which is like=
ly
> exploitable for user->kernel privilege escalation.
>
>
> Fix the race by letting process B recheck that the PMD still points to a
> page table after the rmap locks have been taken. Otherwise, we bail and l=
et
> the caller fall back to the PTE-level copying path, which will then bail
> immediately at the pmd_none() check.
>
> Bug reachability: Reaching this bug requires that you can create shmem/fi=
le
> THP mappings - anonymous THP uses different code that doesn't zap stuff
> under rmap locks. File THP is gated on an experimental config flag
> (CONFIG_READ_ONLY_THP_FOR_FS), so on normal distro kernels you need shmem
> THP to hit this bug. As far as I know, getting shmem THP normally require=
s
> that you can mount your own tmpfs with the right mount flags, which would
> require creating your own user+mount namespace; though I don't know if so=
me
> distros maybe enable shmem THP by default or something like that.

Not to overthink it, but do you have any insight into why copy_vma()
only requires the rmap lock under this condition?

*need_rmap_locks =3D (new_vma->vm_pgoff <=3D vma->vm_pgoff);

Could a collapse still occur when need_rmap_locks is false,
potentially triggering the bug you described? My assumption is no, but
I wanted to double-check.

The patch looks good to me overall. I was also curious if
move_normal_pud() would require a similar change, though I=E2=80=99m inclin=
ed
to think that path doesn't lead to a bug.

thanks,

- Joel


>
> Bug impact: This issue can likely be used for user->kernel privilege
> escalation when it is reachable.
>
> Cc: stable@vger.kernel.org
> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap o=
r vma lock")
> Closes: https://project-zero.issues.chromium.org/371047675
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> @David: please confirm we can add your Signed-off-by to this patch after
> the Co-developed-by.
> (Context: David basically wrote the entire patch except for the commit
> message.)
>
> @akpm: This replaces the previous "[PATCH] mm/mremap: Prevent racing
> change of old pmd type".
> ---
>  mm/mremap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 24712f8dbb6b..dda09e957a5d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct *vm=
a, unsigned long old_addr,
>  {
>         spinlock_t *old_ptl, *new_ptl;
>         struct mm_struct *mm =3D vma->vm_mm;
> +       bool res =3D false;
>         pmd_t pmd;
>
>         if (!arch_supports_page_table_move())
> @@ -277,19 +278,25 @@ static bool move_normal_pmd(struct vm_area_struct *=
vma, unsigned long old_addr,
>         if (new_ptl !=3D old_ptl)
>                 spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>
> -       /* Clear the pmd */
>         pmd =3D *old_pmd;
> +
> +       /* Racing with collapse? */
> +       if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))
> +               goto out_unlock;
> +       /* Clear the pmd */
>         pmd_clear(old_pmd);
> +       res =3D true;
>
>         VM_BUG_ON(!pmd_none(*new_pmd));
>
>         pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
>         flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> +out_unlock:
>         if (new_ptl !=3D old_ptl)
>                 spin_unlock(new_ptl);
>         spin_unlock(old_ptl);
>
> -       return true;
> +       return res;
>  }
>  #else
>  static inline bool move_normal_pmd(struct vm_area_struct *vma,
>
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241007-move_normal_pmd-vs-collapse-fix-2-387e9a68c7d6
> --
> Jann Horn <jannh@google.com>
>

