Return-Path: <stable+bounces-49951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6258FFE08
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71C61C2313D
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91121581E3;
	Fri,  7 Jun 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKUJHCJi"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5547A6B;
	Fri,  7 Jun 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749056; cv=none; b=X6DZdZE5MzEDUHdZmkhdAueAkLM/PNq0VIxlSitQh7KxUIaEk6LF3Y9jF/t4sJQfeRnVThdP1AafXNdnitSjBjfEZOYfWbmeKwMQUj3jRrjLQM9kA3OljKnTDZidmdBc25Ng07WYzQRBRenLSIA9SOe2EqUoLAcql7nPafgAPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749056; c=relaxed/simple;
	bh=osMbtlCLTJ6wfZ4j4RQaxrO7OBDeztbeYgKUN9jLSUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0cKivMJNLow5610nzSxXh2W5wx5zsKJH/lsrQ26YJ0r62Y2QORKThLbChcnx/KxdLBywdHoimaEPV/l6HcppD8xIbZtyBh5T2CyovOejsTYVT8xcUidWRaAhsv6l+oA6E7bGy14mHIWQguu5LYQvuioM5jP5qqbPaOrTAPGhEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKUJHCJi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaccc097e2so20037941fa.0;
        Fri, 07 Jun 2024 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717749053; x=1718353853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUpGLGGxaYw2Ek3Ee9MLtP7lMr2pFc4xNVQS95pA+9c=;
        b=YKUJHCJiJfA8k23YVVWkb3vKaaZNY0z1CkDm8G3PPV/ihPZukYffMIeHFbr/kBphRw
         0YzPY1Ze2ZJyqyYnbs7kx4YmrMBuXxyDIeEZyoNkisITWlnLDFZsd9MLdkPIScrMcASC
         dy0aQIABvFt8U99j/NPfF83QwpQMh6pK+Wb+ft9a/uUU7hBKYLVwBu8rbtVZre5Ah9qz
         RcDBLlOxDS7xyHxQ3laj6vJVgjkCj4BD70mFapx5r4Ga0lOwR/DkL4GuuIN5L/o9cYK+
         v+kWsKn40aXcq7S/BXqfzg2OD5oht/EPloGd+ilHCCqXFrWh7le+B7UAYaujk+UfospD
         Dc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749053; x=1718353853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUpGLGGxaYw2Ek3Ee9MLtP7lMr2pFc4xNVQS95pA+9c=;
        b=Z925acUI1rTAd3JInrsNEKjosj00TdBHEG3261eyl31VPB+JvvAyhMnO9lIlNi3CoI
         rMJZEVqJ+prDGlKFGp5ryrb3fP8r+TXLZ7kYd7QG5hZpkpb6SmN1sV+Zz7jS1Xa5TpQC
         Qlgco6wxcAsxTD+jAHg0YhbJrdaG1f4IL24DnDQL7Z8OpbGuvhJPRnc77svf57WeNNtm
         0nDQRwT0a06CDZ9MVdYcx/9Y4mn0ov7/rIrGO/QOhJowJZFy3doHUQBxvvoszp4z/GrZ
         BwbyYz52b2mVFw/PyEZidU0AYqqylFhuYtDvzzaz097LGc2yThC/tpeMMCNvzm1F4EDQ
         5TwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHNlLPsynfgGFspmUVAf7p8OapyUEG/B73pLvD3WWn/XX5gbFV6MzPRqOQYieBdLm/wvOHwFwHnkbMNhOjLA15/33r6l/k+Otm5x/OdC23Atnzee1TTKTHnV6IDIVwz0POPqZm
X-Gm-Message-State: AOJu0YxwQKgRsVspfrCldMuClp/WBkd9nzG6xE6ngEAxVlZsaemEXUNm
	epG4XWcCE//YT3qa/U4cmOZNe8WFkE5ZCC3lTP4fuBrIqnrb7LlGEjx/flNWzO6QCym3zVRDo1d
	PKnS6R+KGYOiB7j0/VsTTx0OHK89VSFxx
X-Google-Smtp-Source: AGHT+IFWo17li4pFi28uwfmGQsv6ThzDk83pRMhuQAVFZrZTDL96s0gNi1p1JzxXhJUyK9KWSk6QTFaAyM/Hc5+0sQM=
X-Received: by 2002:a2e:a601:0:b0:2ea:8174:231b with SMTP id
 38308e7fff4ca-2eadce1609cmr11881771fa.2.1717749052688; Fri, 07 Jun 2024
 01:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 7 Jun 2024 16:30:41 +0800
Message-ID: <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patchv4 was updated based on Hailong and Uladzislau's comments, where
vbq is obtained from vb->cpu, thus avoiding disabling preemption.
Furthermore, Baoquan's suggestion was not adopted because it made vbq
accesses completely interleaved across all CPUs, which defeats the
goal of per_cpu.

On Fri, Jun 7, 2024 at 10:31=E2=80=AFAM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> vmalloc area runs out in our ARM64 system during an erofs test as
> vm_map_ram failed[1]. By following the debug log, we find that
> vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> when vbq->free->next points to vbq->free. That is to say, 65536 times
> of page fault after the list's broken will run out of the whole
> vmalloc area. This should be introduced by one vbq->free->next point to
> vbq->free which makes list_for_each_entry_rcu can not iterate the list
> and find the BUG.
>
> [1]
> PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
>  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
>  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
>  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
>  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
>  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
>  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
>  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
>  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
>  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
>  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
>
> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized bl=
ocks")
>
> For detailed reason of broken list, please refer to below URL
> https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/
>
> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> v3: use get_cpu/put_cpu to prevent schedule between core
> v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
> ---
> ---
>  mm/vmalloc.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..89eb034f4ac6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2458,6 +2458,7 @@ struct vmap_block {
>         struct list_head free_list;
>         struct rcu_head rcu_head;
>         struct list_head purge;
> +       unsigned int cpu;
>  };
>
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purp=
oses */
> @@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order, gf=
p_t gfp_mask)
>                 free_vmap_area(va);
>                 return ERR_PTR(err);
>         }
> -
> -       vbq =3D raw_cpu_ptr(&vmap_block_queue);
> +       /*
> +        * list_add_tail_rcu could happened in another core
> +        * rather than vb->cpu due to task migration, which
> +        * is safe as list_add_tail_rcu will ensure the list's
> +        * integrity together with list_for_each_rcu from read
> +        * side.
> +        */
> +       vb->cpu =3D raw_smp_processor_id();
> +       vbq =3D per_cpu_ptr(&vmap_block_queue, vb->cpu);
>         spin_lock(&vbq->lock);
>         list_add_tail_rcu(&vb->free_list, &vbq->free);
>         spin_unlock(&vbq->lock);
> @@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  }
>
>  static bool purge_fragmented_block(struct vmap_block *vb,
> -               struct vmap_block_queue *vbq, struct list_head *purge_lis=
t,
> -               bool force_purge)
> +               struct list_head *purge_list, bool force_purge)
>  {
> +       struct vmap_block_queue *vbq =3D &per_cpu(vmap_block_queue, vb->c=
pu);
> +
>         if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
>             vb->dirty =3D=3D VMAP_BBMAP_BITS)
>                 return false;
> @@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
>                         continue;
>
>                 spin_lock(&vb->lock);
> -               purge_fragmented_block(vb, vbq, &purge, true);
> +               purge_fragmented_block(vb, &purge, true);
>                 spin_unlock(&vb->lock);
>         }
>         rcu_read_unlock();
> @@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long start, =
unsigned long end, int flush)
>                          * not purgeable, check whether there is dirty
>                          * space to be flushed.
>                          */
> -                       if (!purge_fragmented_block(vb, vbq, &purge_list,=
 false) &&
> +                       if (!purge_fragmented_block(vb, &purge_list, fals=
e) &&
>                             vb->dirty_max && vb->dirty !=3D VMAP_BBMAP_BI=
TS) {
>                                 unsigned long va_start =3D vb->va->va_sta=
rt;
>                                 unsigned long s, e;
> --
> 2.25.1
>

