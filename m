Return-Path: <stable+bounces-50126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9B902DDF
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 03:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904B6B211A0
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA19A5661;
	Tue, 11 Jun 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFbqqVcT"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A16FB9;
	Tue, 11 Jun 2024 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068096; cv=none; b=jO7ho6Fgofeo6I82WoypJQQ6pp6S+7B64LjWtB98RovDk6Mt5OmuitaB3EQLC0nnNJecOYnIDEqWqxXiHM9II2dC87z+3ZcM2H8ETXbJN2gr/kgNwaYHKL4nOhQld3130YAdgzu4WWiR85n1KRiwnBoITp1v/9L1/wJvMTeJ/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068096; c=relaxed/simple;
	bh=zLqhRcjyGboY5WOmM02nId+w+4xplqxuggbLViLF8Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh21DaUtQhs0BlSoU8D0PeJ0w2vEfCPe6Bz4ObjOap7aZaR7W/lsqKF0SqSuEPDthVpwTCBn1HIXo9Ug+E3rwbKXdjg3i04h39ZVeXIk0FQALF14fC+Sch0JGC3qteM6BUM7iLX50jNxAFteV12cPXdLR1+esk49QcLiGPeJtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFbqqVcT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c8973ff29so625792e87.0;
        Mon, 10 Jun 2024 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718068093; x=1718672893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+ZWn0gn7fJB3UcfcfpvLfhaBIj+uVErC4f5zELzVp0=;
        b=MFbqqVcT8xJTAu7m4nof2zjnF/tbQH5/eCl9dRi6QqyK3pY215mtPupULnbU7GKvJc
         dp6WLtXzjibG+SWQ88Z4iL9sDlIPyy2SiYo8sn70uaZeb90p+iSiIEQAsao89sDZqNtw
         GLvTOTTHLbgXMhBhY2nIAWllFA0pGeTht5GQwIYKqDgUhvx269qeG343Me9YAnGIpf1W
         RKvcwwQazWFJdddLbIxjBB7cYS+SYdJBeREGP0GjyzRnPVfh5DN70R94XqiZfQjjIMtz
         B6QvwcgIEokJSejZaJu2528w6qr8QTTKOD4SHXwmdCsplIqtSt7ayYmhygSuelROehLN
         lA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718068093; x=1718672893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+ZWn0gn7fJB3UcfcfpvLfhaBIj+uVErC4f5zELzVp0=;
        b=v1xOa0zg9Uy1bwAQGYhAVBLvgeL3OmxjxWYkMDYC9ya85L4pU5DI3dLHszKGc4DNC5
         mKGa1NKUMzF5SxMTbHg/GTDUK1Z3kw6QrOoMnug0ykg075gX764V4vYv0+/a1gKNYQvH
         e+LaKk75cgEXBqa3ShQXQyEb7+/s6VO5tOJg5lLBsQ0JvUvWuRo8yawqmKxXD3cbCPPy
         Y6uBNDS/i1jlrz6g0pxPyxboewTuC1lU81K4RoUt81m/PQOSBG6uCOQ+E6LQO7cVusnX
         gFyFtahp/9Q4thGrfTFcbAhVZ/ZDUWvCZam9WSwUxDIQs9/lijxvOam++Is15I3gJZHB
         WxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8QDnNL1O3req+uXYMvv/oIYYwFq8qNHhPx2anUpI3OI9/p7v/ytuqjiy5BNHIx1sRhfm3y2hF6ytcHAozpkxJ6nbLCD4UqSPvW+8FrpNzcucnofj47L3u0/5OQIdU1ThlluKt
X-Gm-Message-State: AOJu0YyqPry+VlZw78JV4kA8ZVYz9PQooSdAkT0p+neH0FBNnjDFa9QP
	3mLUagERH8w1kt5WRrBy547AxhZ61r16HH4rMHgRkKBFAZ4X97m4zm1AgUfdrkQmSgnSKl+9xCn
	bgZBsl2hu2wCY7Xtj5v4Ls181zmY=
X-Google-Smtp-Source: AGHT+IFSdaKppOajPUvijdsxgqezBJxzNWurRI85dJT3RFbYwJ/g3YYKeIYsUOajnfgxQb6JE4/eTnmUgK5kJS7jo+M=
X-Received: by 2002:a19:5e44:0:b0:52b:796e:66a5 with SMTP id
 2adb3069b0e04-52bb9fd281cmr5789338e87.66.1718068092645; Mon, 10 Jun 2024
 18:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com> <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
In-Reply-To: <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 11 Jun 2024 09:08:01 +0800
Message-ID: <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry to bother you again. Are there any other comments or new patch
on this which block some test cases of ANDROID that only accept ACKed
one on its tree.

On Fri, Jun 7, 2024 at 4:30=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail.=
com> wrote:
>
> Patchv4 was updated based on Hailong and Uladzislau's comments, where
> vbq is obtained from vb->cpu, thus avoiding disabling preemption.
> Furthermore, Baoquan's suggestion was not adopted because it made vbq
> accesses completely interleaved across all CPUs, which defeats the
> goal of per_cpu.
>
> On Fri, Jun 7, 2024 at 10:31=E2=80=AFAM zhaoyang.huang
> <zhaoyang.huang@unisoc.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > vmalloc area runs out in our ARM64 system during an erofs test as
> > vm_map_ram failed[1]. By following the debug log, we find that
> > vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> > to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> > when vbq->free->next points to vbq->free. That is to say, 65536 times
> > of page fault after the list's broken will run out of the whole
> > vmalloc area. This should be introduced by one vbq->free->next point to
> > vbq->free which makes list_for_each_entry_rcu can not iterate the list
> > and find the BUG.
> >
> > [1]
> > PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
> >  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
> >  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
> >  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
> >  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
> >  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
> >  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
> >  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
> >  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
> >  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
> >  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> >
> > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized =
blocks")
> >
> > For detailed reason of broken list, please refer to below URL
> > https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/
> >
> > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v2: introduce cpu in vmap_block to record the right CPU number
> > v3: use get_cpu/put_cpu to prevent schedule between core
> > v4: replace get_cpu/put_cpu by another API to avoid disabling preemptio=
n
> > ---
> > ---
> >  mm/vmalloc.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..89eb034f4ac6 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2458,6 +2458,7 @@ struct vmap_block {
> >         struct list_head free_list;
> >         struct rcu_head rcu_head;
> >         struct list_head purge;
> > +       unsigned int cpu;
> >  };
> >
> >  /* Queue of free and dirty vmap blocks, for allocation and flushing pu=
rposes */
> > @@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order, =
gfp_t gfp_mask)
> >                 free_vmap_area(va);
> >                 return ERR_PTR(err);
> >         }
> > -
> > -       vbq =3D raw_cpu_ptr(&vmap_block_queue);
> > +       /*
> > +        * list_add_tail_rcu could happened in another core
> > +        * rather than vb->cpu due to task migration, which
> > +        * is safe as list_add_tail_rcu will ensure the list's
> > +        * integrity together with list_for_each_rcu from read
> > +        * side.
> > +        */
> > +       vb->cpu =3D raw_smp_processor_id();
> > +       vbq =3D per_cpu_ptr(&vmap_block_queue, vb->cpu);
> >         spin_lock(&vbq->lock);
> >         list_add_tail_rcu(&vb->free_list, &vbq->free);
> >         spin_unlock(&vbq->lock);
> > @@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block *v=
b)
> >  }
> >
> >  static bool purge_fragmented_block(struct vmap_block *vb,
> > -               struct vmap_block_queue *vbq, struct list_head *purge_l=
ist,
> > -               bool force_purge)
> > +               struct list_head *purge_list, bool force_purge)
> >  {
> > +       struct vmap_block_queue *vbq =3D &per_cpu(vmap_block_queue, vb-=
>cpu);
> > +
> >         if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
> >             vb->dirty =3D=3D VMAP_BBMAP_BITS)
> >                 return false;
> > @@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
> >                         continue;
> >
> >                 spin_lock(&vb->lock);
> > -               purge_fragmented_block(vb, vbq, &purge, true);
> > +               purge_fragmented_block(vb, &purge, true);
> >                 spin_unlock(&vb->lock);
> >         }
> >         rcu_read_unlock();
> > @@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long start=
, unsigned long end, int flush)
> >                          * not purgeable, check whether there is dirty
> >                          * space to be flushed.
> >                          */
> > -                       if (!purge_fragmented_block(vb, vbq, &purge_lis=
t, false) &&
> > +                       if (!purge_fragmented_block(vb, &purge_list, fa=
lse) &&
> >                             vb->dirty_max && vb->dirty !=3D VMAP_BBMAP_=
BITS) {
> >                                 unsigned long va_start =3D vb->va->va_s=
tart;
> >                                 unsigned long s, e;
> > --
> > 2.25.1
> >

