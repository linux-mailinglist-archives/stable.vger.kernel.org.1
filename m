Return-Path: <stable+bounces-119618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71225A454ED
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 06:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E17189B54D
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 05:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531A254AE7;
	Wed, 26 Feb 2025 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhvF9A2E"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579AC191499;
	Wed, 26 Feb 2025 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548273; cv=none; b=ZKFCHxO3fykpGwkEGHdY5IkbyYBzVcj5pqrvl0OnpBRG9elPoq/xKVi+Lj8YWAE5SDpDttQ78rjVUjS1ZW3xpJ1q+IfJ/KqOjzxrjGdB3ORS2ehEt8YKcCrW635spzItgQg4KiZGD8dNgAVLU/74GeEBLsc5RozXwjJzWOeT57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548273; c=relaxed/simple;
	bh=iIIzRFSdkX6sxEgiLb11iU5KsBtpaJ1Xf/mkzL+MI/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uznPyAbZdwHd4efuKnoKp+FmzVvn1UURbpZxb+Aqef4bQrA6FqkeyC+T0yh8mZYcIxyTeQL2ORY9GZcsSHBW5g2m78RbS+JMsM16vPjf0J0xdNap1bV13WZkGiUT0k7kB4szzWDbxVaUvOxXo0416I7jOMB6YzQ4XbFlYR0rDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhvF9A2E; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4bd3a8b88f3so3442045137.0;
        Tue, 25 Feb 2025 21:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740548270; x=1741153070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rva348BcHgLB5uMkGMZXZRRj+2pUfOtqtrulMF8LioE=;
        b=XhvF9A2Ep771r5tAlQcNbf6rt3ksjfq9ckzmKeT1qflukRorVIYM5kL0aJ67ITwFqf
         PtsZ4dAaL0Iat+aFFhrNFXKAvkxsZkAIGl5eVIbRppRIb7oo57loOiK+YE06IyB3d40/
         3dk6svEdWDIhCniI46WKvVLjNFQOnL/MXjuMGR/gZv+nRvVHhuJg7wIjdMHBbyNZ7LgP
         V7EmRPfINsWNQsoESd7WA7Cf4UW5PRPIV4J+D+6lGiC3Z4GnRf3d7U5xeucG5qCysTwp
         IZPkV98dzVXI8hq0l5BxYOnHIJd++gcVUcwM3LtfRoofF/P1C1uIqZ5dy3aNyo+dIuWd
         UZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548270; x=1741153070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rva348BcHgLB5uMkGMZXZRRj+2pUfOtqtrulMF8LioE=;
        b=lHWgZzlBNvMQ0WOEeLkjprb+lbxXZ9aYODQ0Ktgb9/qeSkANkx/wvit+m0hSHI5saQ
         9ExfRp6CRTjjMNSgU7uMYzZvzNwNh1n9Jn2E8DJuAPdKQDsl5HzFVefpXn2GKCf/UZXp
         9ilBK1qsbQjAdmFyCRzSniiSlXuCf76iaLN7z4Q2GOQ84u7Emg0/qQFHi1W746bOyA2T
         d3MPKYazO5KrOL61RqoKF4LyvwtqiagxrzmJEi/xvHYlzAVSeMkaNsYdbZxaJQvX4/+p
         mL02KsOzeyV8brxLJFRtnWBDp4fwyAJWp0AH7LvfoGPNWjBm5/+uZ2XIlhZbC7jsiquq
         Y7nw==
X-Forwarded-Encrypted: i=1; AJvYcCVGp8RtWbyX+CbVqX+VvyrWNyu050YlaRTqwMGm+ixM/HheGM4+j0S246ZIcf0UKWhAlZ5I+/Pq@vger.kernel.org, AJvYcCWdhoohPk4323caO/GGgoO/oxtU+2qfoVcPjwvQnHyjLC5W4VSdlfpIh/vVwyMfqTjIPX8T/foPQcUR0X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJPSh9O74lhrKQf+aMmfka4zJYyjJFU/rUm1qxkYYV+or5P/G
	SyhF4ziGj8LEnPM44e3cAb+r8X3Awn70x9mhNSVakiakiYjgazDUFN4RrTRXItZ8M2CW+R+detG
	VzA5PQKCh4s1E7OI5uOm28rVlJDE=
X-Gm-Gg: ASbGncstAQ2UKhjK5X6LLs4ZeLUSuVUEMnG+ACXqEuo+BwdUtOwcuJ/47ntrkcgrcey
	MI3tutighNejjjjGdD0vWqzBj40NdUkZha0eJiI2e8PFSDwkMAxxfq2tNnv4StYl/a+JqTzwSfN
	mxTEx5IkY=
X-Google-Smtp-Source: AGHT+IHQFkIKiUHIUxEB2lVTJjxedvEbm9F3ys8fW3r69+IfXcro6uRKQ+aBJYROP1hdgz0AQBn2IIVhpcjM7WYcTOw=
X-Received: by 2002:a05:6102:3047:b0:4bb:e8c5:b162 with SMTP id
 ada2fe7eead31-4c01e1ef478mr1304696137.10.1740548270042; Tue, 25 Feb 2025
 21:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com> <02f14ee1-923f-47e3-a994-4950afb9afcc@redhat.com>
In-Reply-To: <02f14ee1-923f-47e3-a994-4950afb9afcc@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 26 Feb 2025 18:37:38 +1300
X-Gm-Features: AQ5f1JqGJo3XkDARYkb97I0CjDFeXGkKxOdLuDL13q26aFGPeSu3TIseJtfuba4
Message-ID: <CAGsJ_4yzOXE1KS7J927QSjPRUEyCdgs4VKH7fi_7kQ72a5XtUA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: David Hildenbrand <david@redhat.com>
Cc: Liam.Howlett@oracle.com, aarcange@redhat.com, akpm@linux-foundation.org, 
	axelrasmussen@google.com, bgeffon@google.com, brauner@kernel.org, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, 
	mhocko@suse.com, ngeoffray@google.com, peterx@redhat.com, rppt@kernel.org, 
	ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com, 
	v-songbaohua@oppo.com, viro@zeniv.linux.org.uk, willy@infradead.org, 
	zhangpeng362@huawei.com, zhengtangquan@oppo.com, yuzhao@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:24=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 20.02.25 10:21, Barry Song wrote:
> > On Thu, Feb 20, 2025 at 9:40=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 19.02.25 19:58, Suren Baghdasaryan wrote:
> >>> On Wed, Feb 19, 2025 at 10:30=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>
> >>>> On 19.02.25 19:26, Suren Baghdasaryan wrote:
> >>>>> On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.c=
om> wrote:
> >>>>>>
> >>>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>>
> >>>>>> userfaultfd_move() checks whether the PTE entry is present or a
> >>>>>> swap entry.
> >>>>>>
> >>>>>> - If the PTE entry is present, move_present_pte() handles folio
> >>>>>>      migration by setting:
> >>>>>>
> >>>>>>      src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> >>>>>>
> >>>>>> - If the PTE entry is a swap entry, move_swap_pte() simply copies
> >>>>>>      the PTE to the new dst_addr.
> >>>>>>
> >>>>>> This approach is incorrect because even if the PTE is a swap
> >>>>>> entry, it can still reference a folio that remains in the swap
> >>>>>> cache.
> >>>>>>
> >>>>>> If do_swap_page() is triggered, it may locate the folio in the
> >>>>>> swap cache. However, during add_rmap operations, a kernel panic
> >>>>>> can occur due to:
> >>>>>>     page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> >>>>>
> >>>>> Thanks for the report and reproducer!
> >>>>>
> >>>>>>
> >>>>>> $./a.out > /dev/null
> >>>>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19=
c index:0xffffaf150 pfn:0x4667c
> >>>>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages=
_mapped:1 pincount:0
> >>>>>> [   13.337716] memcg:ffff00000405f000
> >>>>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty=
|owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> >>>>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507=
b538 ffff000006260361
> >>>>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 000000060000=
0000 ffff00000405f000
> >>>>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff8000850=
7b538 ffff000006260361
> >>>>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 00000006000=
00000 ffff00000405f000
> >>>>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff000=
00000 0000000000000001
> >>>>>> [   13.339546] head: 0000000000000004 0000000000000000 00000000fff=
fffff 0000000000000000
> >>>>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(foli=
o, page) !=3D linear_page_index(vma, address))
> >>>>>> [   13.340190] ------------[ cut here ]------------
> >>>>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
> >>>>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] P=
REEMPT SMP
> >>>>>> [   13.340969] Modules linked in:
> >>>>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14=
.0-rc3-gcf42737e247a-dirty #299
> >>>>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
> >>>>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SS=
BS BTYPE=3D--)
> >>>>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> >>>>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> >>>>>> [   13.342018] sp : ffff80008752bb20
> >>>>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 00=
00000000000001
> >>>>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 00=
00000000000001
> >>>>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: ff=
fffdffc0199f00
> >>>>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00=
000000ffffffff
> >>>>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 66=
2866666f67705f
> >>>>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ff=
ff800083728ab0
> >>>>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ff=
ff80008011bc40
> >>>>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ff=
ff8000829eebf8
> >>>>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 00=
00000000000000
> >>>>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 00=
0000000000005f
> >>>>>> [   13.343876] Call trace:
> >>>>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> >>>>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> >>>>>> [   13.344333]  do_swap_page+0x1060/0x1400
> >>>>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> >>>>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
> >>>>>> [   13.344586]  do_page_fault+0x20c/0x770
> >>>>>> [   13.344673]  do_translation_fault+0xb4/0xf0
> >>>>>> [   13.344759]  do_mem_abort+0x48/0xa0
> >>>>>> [   13.344842]  el0_da+0x58/0x130
> >>>>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> >>>>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> >>>>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000=
)
> >>>>>> [   13.345504] ---[ end trace 0000000000000000 ]---
> >>>>>> [   13.345715] note: a.out[107] exited with irqs disabled
> >>>>>> [   13.345954] note: a.out[107] exited with preempt_count 2
> >>>>>>
> >>>>>> Fully fixing it would be quite complex, requiring similar handling
> >>>>>> of folios as done in move_present_pte.
> >>>>>
> >>>>> How complex would that be? Is it a matter of adding
> >>>>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> >>>>> folio->index =3D linear_page_index like in move_present_pte() or
> >>>>> something more?
> >>>>
> >>>> If the entry is pte_swp_exclusive(), and the folio is order-0, it ca=
nnot
> >>>> be pinned and we may be able to move it I think.
> >>>>
> >>>> So all that's required is to check pte_swp_exclusive() and the folio=
 size.
> >>>>
> >>>> ... in theory :) Not sure about the swap details.
> >>>
> >>> Looking some more into it, I think we would have to perform all the
> >>> folio and anon_vma locking and pinning that we do for present pages i=
n
> >>> move_pages_pte(). If that's correct then maybe treating swapcache
> >>> pages like a present page inside move_pages_pte() would be simpler?
> >>
> >> I'd be more in favor of not doing that. Maybe there are parts we can
> >> move out into helper functions instead, so we can reuse them?
> >
> > I actually have a v2 ready. Maybe we can discuss if some of the code ca=
n be
> > extracted as a helper based on the below before I send it formally?
> >
> > I=E2=80=99d say there are many parts that can be shared with present PT=
E, but there
> > are two major differences:
> >
> > 1. Page exclusivity =E2=80=93 swapcache doesn=E2=80=99t require it (try=
_to_unmap_one has remove
> > Exclusive flag;)
> > 2. src_anon_vma and its lock =E2=80=93 swapcache doesn=E2=80=99t requir=
e it=EF=BC=88folio is not mapped=EF=BC=89
> >
>
> That's a lot of complicated code you have there (not your fault, it's
> complicated stuff ... ) :)
>
> Some of it might be compressed/simplified by the use of "else if".
>
> I'll try to take a closer look later (will have to apply it to see the
> context better). Just one independent comment because I stumbled over
> this recently:
>
> [...]
>
> > @@ -1062,10 +1063,13 @@ static int move_present_pte(struct mm_struct *m=
m,
> >       folio_move_anon_rmap(src_folio, dst_vma);
> >       src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> >
> > -     orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_page_prot);
> > -     /* Follow mremap() behavior and treat the entry dirty after the m=
ove */
> > -     orig_dst_pte =3D pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
> > -
> > +     if (pte_present(orig_src_pte)) {
> > +             orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_pag=
e_prot);
> > +             /* Follow mremap() behavior and treat the entry dirty aft=
er the move */
> > +             orig_dst_pte =3D pte_mkwrite(pte_mkdirty(orig_dst_pte), d=
st_vma);
>
> I'll note that the comment and mkdirty is misleading/wrong. It's
> softdirty that we care about only. But that is something independent of
> this change.
>
> For swp PTEs, we maybe also would want to set softdirty.
>
> See move_soft_dirty_pte() on what is actually done on the mremap path.

I actually don't quite understand the changelog in  commit 0f8975ec4db2
(" mm: soft-dirty bits for user memory changes tracking").

"    Another thing to note, is that when mremap moves PTEs they are marked
    with soft-dirty as well, since from the user perspective mremap modifie=
s
    the virtual memory at mremap's new address."

Why is the hardware-dirty bit not relevant? From the user's perspective,
the memory at the destination virtual address of mremap/userfaultfd_move
has changed.

For systems where CONFIG_HAVE_ARCH_SOFT_DIRTY is false, how can the dirty s=
tatus
be determined?

Or is the answer that we only care about soft-dirty changes?

For the hardware-dirty bit, do we only care about actual modifications to t=
he
physical page content rather than changes at the virtual address level?

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

