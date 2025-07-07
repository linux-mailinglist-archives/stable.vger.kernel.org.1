Return-Path: <stable+bounces-160368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC935AFB44B
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A477AB5FE
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6C29CB31;
	Mon,  7 Jul 2025 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlzJBavN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72529AB11
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894404; cv=none; b=bYkmkaOo73yvhYXanoWgyZA1cgx54L47E1UGsUG1f0OFSyfX6QvyMJHkkaCZgIwvKAgqC2xHUyBkVyZqG08ImoRKC93+ikiKyrkvdQq+OUJzSl8gj/nzZQ0C0DbYNHgfEoCEj+tfPqQwGFslwpyttTw/8dw/VvSdeYHUxckXsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894404; c=relaxed/simple;
	bh=tgoWUv2gu2Q7lA3ntEI4yHtLfGxqekhsrVNBv7XAbeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psEAGOWgcbZ6/Q1esU/zMMshZX67Jhtd0WhHD38PbeO5bN4jOmGhn/K4CuZ63TNhlrBFCEo99p7h7aAumJ4wuZzFeGI1xpJaTXq7oUUfpj4BpuevlR4SYt9/Ik63CF+dJg0tKKAgoUH611ouO+wkY4pIUvEQddjkJypCDlHKb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlzJBavN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6098ef283f0so39697a12.0
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751894400; x=1752499200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCxuqWCuJ4JJm0v+Q9MXGmDIyevW5a3jro9m7bKDgvk=;
        b=UlzJBavNL4jyR3EOPKmqiBAOxq97ZoKIdtOCtjGrZ00Z6JdzoXM+2AmIV3TM+M4w60
         7tTtNYgGEwlFXzuxwm3TIcRJRN3JSAF/XJlKFgW93+HU5MOwUxySCh9ubNEIQn9z9dJI
         Sm+S1n1H6jqmRwpCiH6fH52l+t5CRb9MOPk05I804uu7yIxUPVBPXA7avEtSQG5dI/3Q
         sQHxX5zhht4BhYygZSTztMyCUCEroriWg5I5lH7raOF6FiHO8Lptxj+lQcM49p/k5yfe
         nzvV+ojYPm9q30DQaFceVLKlNX4mJCteGUIfdqzyDm7GIbNOdHuAIj5aczJFnOfs5jZi
         HkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751894400; x=1752499200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCxuqWCuJ4JJm0v+Q9MXGmDIyevW5a3jro9m7bKDgvk=;
        b=jHPZcrSguY2RgaGtEYdeQcAtQaKnj78/RA/+LZyDYQV8XWvQMHsOHCImRrkFcDDtpE
         PPIOBOrcf+5BqKRqfcFiCt7ABoOcLh+8KHJqGpLSC7eowEIKKxapJhrfslM5gEPcDwYM
         1017WZ2SvHm6wBpN7pCcqGzASGXoGiKkFcDbYWgGES3W52/rNGlmr6QqWqUsGvCiUgBv
         oHuRMBErSyuVf5/8GJbstFohQCa7Jozgj7OQrroRmz7nz5/z18D3VUo1VBoSTbSSfQkf
         DYPHiqekIbY1+riSlsD4TtHykt4EYZMjhjasJph9Bsv/Cxu/z02OMAsxX1/VhYOhHa0W
         nUZg==
X-Gm-Message-State: AOJu0Yyp4vbSPjYd4cg5ZMEhboq08m3b1HGuIY/lJWUbImyaaWgsoI6O
	UQ3fOhvO6bEDXZvf776lGt9ss9NqNVKcxqalgikmoVRzGQ/9ofBaFnhng23b9SjH12HEok3p1fC
	ZLmrzETqiG15EWUenADEqReTLhPIL/aDwYCBAlOqI
X-Gm-Gg: ASbGncthPvnAeSXGdbu3alcQfb0WHICTAcOmk3tVIxl0fbvN//LlFZbNeSs0ATfD44g
	o/I1YVq1eYTZbLLhYyCNJIMB3gGDL0WBXsEv/wcOD+O4ptSVSbUuL6d0sS7hHsdzQYUteSSNo0n
	ZgVnxup0hvRsvFYC41yd1vlqTn4iuBg7Q5LH2f7nug456FrzRKp0Lweyi9XqwVSiD8gahJCdO8J
	537s4YoGFA=
X-Google-Smtp-Source: AGHT+IFIijnmLgCqgtnBp3naqYQnjARtzzL3/3Aq2YXZWZvf4HkZ9MoCb+E5T2iFrvBd2MfuoAdWlLTNrd5L/Twen6Y=
X-Received: by 2002:a50:bb0e:0:b0:606:f77b:7943 with SMTP id
 4fb4d7f45d1cf-60e70791543mr237652a12.0.1751894399669; Mon, 07 Jul 2025
 06:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620213334.158850-1-jannh@google.com> <evfvb2d7jgglzgp66hvwu7pwdzbdbbcitym5574vxkno3ff6vt@jg7nfsgded5w>
In-Reply-To: <evfvb2d7jgglzgp66hvwu7pwdzbdbbcitym5574vxkno3ff6vt@jg7nfsgded5w>
From: Jann Horn <jannh@google.com>
Date: Mon, 7 Jul 2025 15:19:23 +0200
X-Gm-Features: Ac12FXwG1aCFHqwxFq4ht3-q0UgJ21VTvOOK4OJNStbS29EfDIJBkngaEJJ5iH4
Message-ID: <CAG48ez3LqUwXxhRY56tqQCpfGJsJ-GeXFG9FCcTZEBo2bWOK8Q@mail.gmail.com>
Subject: Re: [PATCH 6.1.y 1/3] mm/hugetlb: unshare page tables during VMA
 split, not before
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, lvc-project@linuxtesting.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc relevant maintainers for the relevant upstream code so they're
aware of how I broke stable with my backports of hugetlb fixes. Looks
like I wasn't being careful enough...

On Mon, Jul 7, 2025 at 12:39=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
> On Fri, 20 Jun 2025 23:33:31 +0200, Jann Horn wrote:
> > Currently, __split_vma() triggers hugetlb page table unsharing through
> > vm_ops->may_split().  This happens before the VMA lock and rmap locks a=
re
> > taken - which is too early, it allows racing VMA-locked page faults in =
our
> > process and racing rmap walks from other processes to cause page tables=
 to
> > be shared again before we actually perform the split.
> >
> > Fix it by explicitly calling into the hugetlb unshare logic from
> > __split_vma() in the same place where THP splitting also happens.  At t=
hat
> > point, both the VMA and the rmap(s) are write-locked.
> >
> > An annoying detail is that we can now call into the helper
> > hugetlb_unshare_pmds() from two different locking contexts:
> >
> > 1. from hugetlb_split(), holding:
> >     - mmap lock (exclusively)
> >     - VMA lock
> >     - file rmap lock (exclusively)
> > 2. hugetlb_unshare_all_pmds(), which I think is designed to be able to
> >    call us with only the mmap lock held (in shared mode), but currently
> >    only runs while holding mmap lock (exclusively) and VMA lock
> >
> > Backporting note:
> > This commit fixes a racy protection that was introduced in commit
> > b30c14cd6102 ("hugetlb: unshare some PMDs when splitting VMAs"); that
> > commit claimed to fix an issue introduced in 5.13, but it should actual=
ly
> > also go all the way back.
> >
> > [jannh@google.com: v2]
> >   Link: https://lkml.kernel.org/r/20250528-hugetlb-fixes-splitrace-v2-1=
-1329349bad1a@google.com
> > Link: https://lkml.kernel.org/r/20250528-hugetlb-fixes-splitrace-v2-0-1=
329349bad1a@google.com
> > Link: https://lkml.kernel.org/r/20250527-hugetlb-fixes-splitrace-v1-1-f=
4136f5ec58a@google.com
> > Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Cc: Liam Howlett <liam.howlett@oracle.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: <stable@vger.kernel.org>  [b30c14cd6102: hugetlb: unshare some PMDs=
 when splitting VMAs]
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > [stable backport: code got moved around, VMA splitting is in
> > __vma_adjust]
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  include/linux/hugetlb.h |  3 +++
> >  mm/hugetlb.c            | 60 ++++++++++++++++++++++++++++++-----------
> >  mm/mmap.c               |  8 ++++++
> >  3 files changed, 55 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index cc555072940f..26f2947c399d 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -239,6 +239,7 @@ unsigned long hugetlb_change_protection(struct vm_a=
rea_struct *vma,
> >
> >  bool is_hugetlb_entry_migration(pte_t pte);
> >  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
> > +void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
> >
> >  #else /* !CONFIG_HUGETLB_PAGE */
> >
> > @@ -472,6 +473,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_st=
ruct *mm,
> >
> >  static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma=
) { }
> >
> > +static inline void hugetlb_split(struct vm_area_struct *vma, unsigned =
long addr) {}
> > +
> >  #endif /* !CONFIG_HUGETLB_PAGE */
> >  /*
> >   * hugepages at page global directory. If arch support
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 14b9494c58ed..fc5d3d665266 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -95,7 +95,7 @@ static void hugetlb_vma_lock_free(struct vm_area_stru=
ct *vma);
> >  static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
> >  static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma=
);
> >  static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> > -             unsigned long start, unsigned long end);
> > +             unsigned long start, unsigned long end, bool take_locks);
> >  static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
> >
> >  static inline bool subpool_is_free(struct hugepage_subpool *spool)
> > @@ -4900,26 +4900,40 @@ static int hugetlb_vm_op_split(struct vm_area_s=
truct *vma, unsigned long addr)
> >  {
> >       if (addr & ~(huge_page_mask(hstate_vma(vma))))
> >               return -EINVAL;
> > +     return 0;
> > +}
> >
> > +void hugetlb_split(struct vm_area_struct *vma, unsigned long addr)
> > +{
> >       /*
> >        * PMD sharing is only possible for PUD_SIZE-aligned address rang=
es
> >        * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to thi=
s
> >        * split, unshare PMDs in the PUD_SIZE interval surrounding addr =
now.
> > +      * This function is called in the middle of a VMA split operation=
, with
> > +      * MM, VMA and rmap all write-locked to prevent concurrent page t=
able
> > +      * walks (except hardware and gup_fast()).
> >        */
> > +     mmap_assert_write_locked(vma->vm_mm);
> > +     i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>
>
> The above i_mmap lock assertion is firing on stable kernels from 5.10 to =
6.1
> included.
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 11489 at include/linux/fs.h:503 i_mmap_assert_write_=
locked include/linux/fs.h:503 [inline]
> WARNING: CPU: 0 PID: 11489 at include/linux/fs.h:503 hugetlb_split+0x267/=
0x300 mm/hugetlb.c:4917
> Modules linked in:
> CPU: 0 PID: 11489 Comm: syz-executor.4 Not tainted 6.1.142-syzkaller-0029=
6-gfd0df5221577 #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/0=
1/2014
> RIP: 0010:i_mmap_assert_write_locked include/linux/fs.h:503 [inline]
> RIP: 0010:hugetlb_split+0x267/0x300 mm/hugetlb.c:4917
> Call Trace:
>  <TASK>
>  __vma_adjust+0xd73/0x1c10 mm/mmap.c:736
>  vma_adjust include/linux/mm.h:2745 [inline]
>  __split_vma+0x459/0x540 mm/mmap.c:2385
>  do_mas_align_munmap+0x5f2/0xf10 mm/mmap.c:2497
>  do_mas_munmap+0x26c/0x2c0 mm/mmap.c:2646
>  __mmap_region mm/mmap.c:2694 [inline]
>  mmap_region+0x19f/0x1770 mm/mmap.c:2912
>  do_mmap+0x84b/0xf20 mm/mmap.c:1432
>  vm_mmap_pgoff+0x1af/0x280 mm/util.c:520
>  ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1478
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> RIP: 0033:0x46a269
>  </TASK>
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
>
> The main reason is that those branches lack the following
>
>   commit ccf1d78d8b86e28502fa1b575a459a402177def4
>   Author: Suren Baghdasaryan <surenb@google.com>
>   Date:   Mon Feb 27 09:36:13 2023 -0800
>
>       mm/mmap: move vma_prepare before vma_adjust_trans_huge
>
>       vma_prepare() acquires all locks required before VMA modifications.=
  Move
>       vma_prepare() before vma_adjust_trans_huge() so that VMA is locked =
before
>       any modification.
>
>       Link: https://lkml.kernel.org/r/20230227173632.3292573-15-surenb@go=
ogle.com
>       Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>       Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> thus the needed lock is acquired just after vma_adjust_trans_huge() and
> the newly added hugetlb_split().

Oh, yuck. Indeed. Thanks for finding this.

> Please have a look at a straightforward write-up which comes to my mind.
> It does something like the ccf1d78d8b86 ("mm/mmap: move vma_prepare befor=
e
> vma_adjust_trans_huge"), but in context of an old stable branch.
>
> If looks okay, I'll be glad to prepare it as a formal patch and send it
> out for the 5.10-5.15, too.

Thanks, that looks good to me.

> against 6.1.y
> -------------
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0f303dc8425a..941880ed62d7 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -543,8 +543,6 @@ inline int vma_expand(struct ma_state *mas, struct vm=
_area_struct *vma,
>         if (mas_preallocate(mas, vma, GFP_KERNEL))
>                 goto nomem;
>
> -       vma_adjust_trans_huge(vma, start, end, 0);
> -
>         if (file) {
>                 mapping =3D file->f_mapping;
>                 root =3D &mapping->i_mmap;
> @@ -562,6 +560,8 @@ inline int vma_expand(struct ma_state *mas, struct vm=
_area_struct *vma,
>                 vma_interval_tree_remove(vma, root);
>         }
>
> +       vma_adjust_trans_huge(vma, start, end, 0);
> +
>         vma->vm_start =3D start;
>         vma->vm_end =3D end;
>         vma->vm_pgoff =3D pgoff;
> @@ -727,15 +727,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
>                 return -ENOMEM;
>         }
>
> -       /*
> -        * Get rid of huge pages and shared page tables straddling the sp=
lit
> -        * boundary.
> -        */
> -       vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
> -       if (is_vm_hugetlb_page(orig_vma)) {
> -               hugetlb_split(orig_vma, start);
> -               hugetlb_split(orig_vma, end);
> -       }
>         if (file) {
>                 mapping =3D file->f_mapping;
>                 root =3D &mapping->i_mmap;
> @@ -775,6 +766,16 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
>                         vma_interval_tree_remove(next, root);
>         }
>
> +       /*
> +        * Get rid of huge pages and shared page tables straddling the sp=
lit
> +        * boundary.
> +        */
> +       vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
> +       if (is_vm_hugetlb_page(orig_vma)) {
> +               hugetlb_split(orig_vma, start);
> +               hugetlb_split(orig_vma, end);
> +       }
> +
>         if (start !=3D vma->vm_start) {
>                 if ((vma->vm_start < start) &&
>                     (!insert || (insert->vm_end !=3D start))) {

