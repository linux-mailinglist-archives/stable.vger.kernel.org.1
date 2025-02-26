Return-Path: <stable+bounces-119610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA431A45412
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 04:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDECD3A47DE
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 03:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4325A34C;
	Wed, 26 Feb 2025 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0Dri8A0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E925A343
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541110; cv=none; b=Ah3hm6LtlGLIrRu2qVvTTGNHhWZHvm5+isALL62WyTSy93oxkXTEn0/XcSAa8+ERkU8jUTJUVBJTHSYqP9Cqo6URq33JImEQENgfo70SLFqXwlnAFVuxXHpfBGkJC9NXQH6+0USWLhsZOeR1S3+tNbxHMKIXxZBidqlNAqULKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541110; c=relaxed/simple;
	bh=LnIZPYQ+a3MjyqHIBhvT1JL42T7dbCJp68sK4dUK8Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZ0MFYU2sbjJzirT1QpCBASPZYkeLhKMpdnMpFEyVYzJTBCYQeYMiP/z3vHA+BqXRhvqvpPkycD8Ghw+kiNfO28AQVndZT8dEVOAsJHUKwmplxUWLAkxkkMSzDUkiTYeLKOJtbLOSXoAzheVMtiH3Rts+H1IxJZuswT/po58Yvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0Dri8A0; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-472098e6e75so115661cf.1
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 19:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740541107; x=1741145907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIjFTs8XaVhd/5sHwJKhguYA1os9aCgi4nK7ADGd+ew=;
        b=n0Dri8A0JUU9eWCVbdB+AyCNlHlRNIuSPUFuAzKQrun67Q3UOdA1td8obIS1ZrMrZR
         5rRM8mryl9XUpoLXne5w0psH/AnPqi2nt0nj9xWJzPYZylpovQd+GGy+MKiP2uJvNLT0
         RcewWLjeCqbcGNvGSC3vqrzoSH0VRbA7C14B+xgoqRP7zD6XGwJK3mF1G9sn1GY9ge6W
         VNX3XUIvuinbUBYMQU3LZesjBO1R9X0KpLPcLq830mZyhyI93VGxTgANW3JUdkVE1kfM
         j2pIN5WAXAxbfVvXVocMkQTmQW0a8uAMOZBAkdq3xE0Rr73t7GcR5r6EHthi2qz5XnI2
         Si5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740541107; x=1741145907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIjFTs8XaVhd/5sHwJKhguYA1os9aCgi4nK7ADGd+ew=;
        b=IBNbHza3c4pnR9sxAMpSDQ6irVZr/fBQSSkRlVQIisvHd52cgh3Os8CPd+SCse5nk4
         W8p/Prl56xFezwXEET+ulWwbLGm4/8zLe9Ik1i+q/Xw7GmMMTuOv8Cb0RSFTiPgQzzQ8
         mfM42qb77cOMYAImLrkutlFs0GhrNp2WvG0ad/6Slr4zxgN4NL2QPrsqAEJU0Vo/H1Il
         wIID7yKRM/Sw69iw+bPXkJVF63FFqsjRxz/ttTySDDet90rHFWXMJGxJf124dtoSRd4V
         Bl1qXgwTyvpLlv4a7+ozy+a8KRWDQLyMmaCPAVNHzTjs4URxU4TbFUlwyzBsg5XufDrx
         dx6A==
X-Forwarded-Encrypted: i=1; AJvYcCWj8qSdcQ0MoweFkH8eH3ONHC51AOlx9whhTq1BpUvO8Qlm6xHy0rftRKgRVEr2rdTTISNyE28=@vger.kernel.org
X-Gm-Message-State: AOJu0YznmCJWmMl+bDrfapAheTxjxmqg6w4Ogbj05ZJUA3OzDtzVtxyq
	j1FV7SmiYEz4Uvm0ApbhgYoMtzLA1qTLO726hiaEwq27AOrpEBB4GS64QAbgEYi3FlXp9qh+wCt
	tfy2H7RoRSSm0epwyCTIBckRguxugK40vzoH8
X-Gm-Gg: ASbGncvP9p+WnCNUL5A+B3zHg/UmH+EuHbHhM40QIvOJ4W9kg8O+2QrZL4I3oMpecQv
	gtleRtvYpQvmQfkw0fUslwVvVGsuMOliC+87vViz3py4z3NkjF+C2ynJ7Gs027GFd31ed8iEa7g
	Uo1PDzS50=
X-Google-Smtp-Source: AGHT+IF/QvaqsRSMVSCz6PAVAXCNN4lg2WeWrhIDLcOH5mZ+gaYtyv9Dcg0xYSSEEbvk8/e3LQPjmGC4iEVC30PW2Fg=
X-Received: by 2002:ac8:58c2:0:b0:471:e982:c73d with SMTP id
 d75a77b69052e-47376e6f26amr7297951cf.11.1740541107210; Tue, 25 Feb 2025
 19:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226001400.9129-1-21cnbao@gmail.com> <Z75nokRl5Bp0ywiX@x1.local>
In-Reply-To: <Z75nokRl5Bp0ywiX@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 25 Feb 2025 19:38:15 -0800
X-Gm-Features: AWEUYZk_cLD-qefIHA6n47oBNOgE_qb3rukF4ShR7mhbPbxyd6C35f7Uwi5jMkk
Message-ID: <CAJuCfpFfvZy5M57FY8RDDd08Jx1Ym1va54i3nTgQ9DiHL192yg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Peter Xu <peterx@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Axel Rasmussen <axelrasmussen@google.com>, Brian Geffon <bgeffon@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Shuah Khan <shuah@kernel.org>, ZhangPeng <zhangpeng362@huawei.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:00=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 26, 2025 at 01:14:00PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > userfaultfd_move() checks whether the PTE entry is present or a
> > swap entry.
> >
> > - If the PTE entry is present, move_present_pte() handles folio
> >   migration by setting:
> >
> >   src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> >
> > - If the PTE entry is a swap entry, move_swap_pte() simply copies
> >   the PTE to the new dst_addr.
> >
> > This approach is incorrect because, even if the PTE is a swap entry,
> > it can still reference a folio that remains in the swap cache.
> >
> > This creates a race window between steps 2 and 4.
> >  1. add_to_swap: The folio is added to the swapcache.
> >  2. try_to_unmap: PTEs are converted to swap entries.
> >  3. pageout: The folio is written back.
> >  4. Swapcache is cleared.
> > If userfaultfd_move() occurs in the window between steps 2 and 4,
> > after the swap PTE has been moved to the destination, accessing the
> > destination triggers do_swap_page(), which may locate the folio in
> > the swapcache. However, since the folio's index has not been updated
> > to match the destination VMA, do_swap_page() will detect a mismatch.
> >
> > This can result in two critical issues depending on the system
> > configuration.
> >
> > If KSM is disabled, both small and large folios can trigger a BUG
> > during the add_rmap operation due to:
> >
> >  page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> >
> > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c ind=
ex:0xffffaf150 pfn:0x4667c
> > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapp=
ed:1 pincount:0
> > [   13.337716] memcg:ffff00000405f000
> > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owne=
r_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 =
ffff000006260361
> > [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 =
ffff00000405f000
> > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538=
 ffff000006260361
> > [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000=
 ffff00000405f000
> > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000=
 0000000000000001
> > [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff=
 0000000000000000
> > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, pa=
ge) !=3D linear_page_index(vma, address))
> > [   13.340190] ------------[ cut here ]------------
> > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMP=
T SMP
> > [   13.340969] Modules linked in:
> > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc=
3-gcf42737e247a-dirty #299
> > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > [   13.342018] sp : ffff80008752bb20
> > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000=
000000001
> > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000=
000000001
> > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdf=
fc0199f00
> > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 0000000=
0ffffffff
> > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 6628666=
66f67705f
> > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800=
083728ab0
> > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff800=
08011bc40
> > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff800=
0829eebf8
> > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 0000000=
00000005f
> > [   13.343876] Call trace:
> > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > [   13.344333]  do_swap_page+0x1060/0x1400
> > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > [   13.344586]  do_page_fault+0x20c/0x770
> > [   13.344673]  do_translation_fault+0xb4/0xf0
> > [   13.344759]  do_mem_abort+0x48/0xa0
> > [   13.344842]  el0_da+0x58/0x130
> > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> > [   13.345504] ---[ end trace 0000000000000000 ]---
> > [   13.345715] note: a.out[107] exited with irqs disabled
> > [   13.345954] note: a.out[107] exited with preempt_count 2
> >
> > If KSM is enabled, Peter Xu also discovered that do_swap_page() may
> > trigger an unexpected CoW operation for small folios because
> > ksm_might_need_to_copy() allocates a new folio when the folio index
> > does not match linear_page_index(vma, addr).
> >
> > This patch also checks the swapcache when handling swap entries. If a
> > match is found in the swapcache, it processes it similarly to a present
> > PTE.
> > However, there are some differences. For example, the folio is no longe=
r
> > exclusive because folio_try_share_anon_rmap_pte() is performed during
> > unmapping.
> > Furthermore, in the case of swapcache, the folio has already been
> > unmapped, eliminating the risk of concurrent rmap walks and removing th=
e
> > need to acquire src_folio's anon_vma or lock.
> >
> > Note that for large folios, in the swapcache handling path, we directly
> > return -EBUSY since split_folio() will return -EBUSY regardless if
> > the folio is under writeback or unmapped. This is not an urgent issue,
> > so a follow-up patch may address it separately.
> >
> > Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > Cc: Brian Geffon <bgeffon@google.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Cc: Lokesh Gidra <lokeshgidra@google.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > Cc: Nicolas Geoffray <ngeoffray@google.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: ZhangPeng <zhangpeng362@huawei.com>
> > Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> Some nitpicks below, maybe no worth for a repost..

With Peter's nits addressed,

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  mm/userfaultfd.c | 76 ++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 67 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 867898c4e30b..2df5d100e76d 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -18,6 +18,7 @@
> >  #include <asm/tlbflush.h>
> >  #include <asm/tlb.h>
> >  #include "internal.h"
> > +#include "swap.h"
> >
> >  static __always_inline
> >  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long ds=
t_end)
> > @@ -1072,16 +1073,14 @@ static int move_present_pte(struct mm_struct *m=
m,
> >       return err;
> >  }
> >
> > -static int move_swap_pte(struct mm_struct *mm,
> > +static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *=
dst_vma,
> >                        unsigned long dst_addr, unsigned long src_addr,
> >                        pte_t *dst_pte, pte_t *src_pte,
> >                        pte_t orig_dst_pte, pte_t orig_src_pte,
> >                        pmd_t *dst_pmd, pmd_t dst_pmdval,
> > -                      spinlock_t *dst_ptl, spinlock_t *src_ptl)
> > +                      spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                      struct folio *src_folio)
> >  {
> > -     if (!pte_swp_exclusive(orig_src_pte))
> > -             return -EBUSY;
> > -
> >       double_pt_lock(dst_ptl, src_ptl);
> >
> >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> > @@ -1090,10 +1089,20 @@ static int move_swap_pte(struct mm_struct *mm,
> >               return -EAGAIN;
> >       }
> >
> > +     /*
> > +      * The src_folio resides in the swapcache, requiring an update to=
 its
> > +      * index and mapping to align with the dst_vma, where a swap-in m=
ay
> > +      * occur and hit the swapcache after moving the PTE.
> > +      */
> > +     if (src_folio) {
> > +             folio_move_anon_rmap(src_folio, dst_vma);
> > +             src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> > +     }
> > +
> >       orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> >       set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
> > -     double_pt_unlock(dst_ptl, src_ptl);
> >
> > +     double_pt_unlock(dst_ptl, src_ptl);
>
> Unnecessary line move.
>
> >       return 0;
> >  }
> >
> > @@ -1137,6 +1146,7 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >                         __u64 mode)
> >  {
> >       swp_entry_t entry;
> > +     struct swap_info_struct *si =3D NULL;
> >       pte_t orig_src_pte, orig_dst_pte;
> >       pte_t src_folio_pte;
> >       spinlock_t *src_ptl, *dst_ptl;
> > @@ -1318,6 +1328,8 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >                                      orig_dst_pte, orig_src_pte, dst_pm=
d,
> >                                      dst_pmdval, dst_ptl, src_ptl, src_=
folio);
> >       } else {
> > +             struct folio *folio =3D NULL;
> > +
> >               entry =3D pte_to_swp_entry(orig_src_pte);
> >               if (non_swap_entry(entry)) {
> >                       if (is_migration_entry(entry)) {
> > @@ -1331,9 +1343,53 @@ static int move_pages_pte(struct mm_struct *mm, =
pmd_t *dst_pmd, pmd_t *src_pmd,
> >                       goto out;
> >               }
> >
> > -             err =3D move_swap_pte(mm, dst_addr, src_addr, dst_pte, sr=
c_pte,
> > -                                 orig_dst_pte, orig_src_pte, dst_pmd,
> > -                                 dst_pmdval, dst_ptl, src_ptl);
> > +             if (!pte_swp_exclusive(orig_src_pte)) {
> > +                     err =3D -EBUSY;
> > +                     goto out;
> > +             }
> > +
> > +             si =3D get_swap_device(entry);
> > +             if (unlikely(!si)) {
> > +                     err =3D -EAGAIN;
> > +                     goto out;
> > +             }
> > +             /*
> > +              * Verify the existence of the swapcache. If present, the=
 folio's
> > +              * index and mapping must be updated even when the PTE is=
 a swap
> > +              * entry. The anon_vma lock is not taken during this proc=
ess since
> > +              * the folio has already been unmapped, and the swap entr=
y is
> > +              * exclusive, preventing rmap walks.
> > +              *
> > +              * For large folios, return -EBUSY immediately, as split_=
folio()
> > +              * also returns -EBUSY when attempting to split unmapped =
large
> > +              * folios in the swapcache. This issue needs to be resolv=
ed
> > +              * separately to allow proper handling.
> > +              */
> > +             if (!src_folio)
> > +                     folio =3D filemap_get_folio(swap_address_space(en=
try),
> > +                                     swap_cache_index(entry));
> > +             if (!IS_ERR_OR_NULL(folio)) {
> > +                     if (folio && folio_test_large(folio)) {
>
> Can drop this folio check as it just did check "!IS_ERR_OR_NULL(folio)"..
>
> > +                             err =3D -EBUSY;
> > +                             folio_put(folio);
> > +                             goto out;
> > +                     }
> > +                     src_folio =3D folio;
> > +                     src_folio_pte =3D orig_src_pte;
> > +                     if (!folio_trylock(src_folio)) {
> > +                             pte_unmap(&orig_src_pte);
> > +                             pte_unmap(&orig_dst_pte);
> > +                             src_pte =3D dst_pte =3D NULL;
> > +                             /* now we can block and wait */
> > +                             folio_lock(src_folio);
> > +                             put_swap_device(si);
> > +                             si =3D NULL;
>
> Not sure if it can do any harm, but maybe still nicer to put swap before
> locking folio.
>
> Thanks,
>
> > +                             goto retry;
> > +                     }
> > +             }
> > +             err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, ds=
t_pte, src_pte,
> > +                             orig_dst_pte, orig_src_pte, dst_pmd, dst_=
pmdval,
> > +                             dst_ptl, src_ptl, src_folio);
> >       }
> >
> >  out:
> > @@ -1350,6 +1406,8 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >       if (src_pte)
> >               pte_unmap(src_pte);
> >       mmu_notifier_invalidate_range_end(&range);
> > +     if (si)
> > +             put_swap_device(si);
> >
> >       return err;
> >  }
> > --
> > 2.39.3 (Apple Git-146)
> >
>
> --
> Peter Xu
>

