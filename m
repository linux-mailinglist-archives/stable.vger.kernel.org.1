Return-Path: <stable+bounces-167236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16BB22DE7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F5C3A33FC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5F2F8BF9;
	Tue, 12 Aug 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lt/IJXef"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1A2F8BFD
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016461; cv=none; b=jxBJE2iUXC/pUEW/chUjhv9RDbYrjuTVUvWevYYkIdr/6OYo63bOyr1A1ouBaCbQpRSnuxStVEUrWobO002O1ngLUdl2u+zYuD2QIN0rrh0xplcnJkdRRCr7K+YK2RBhXYgNo8rhVWDnHFDQok46428tJJ+tjicuNm4sGC+seDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016461; c=relaxed/simple;
	bh=Un6ei/YjgIYSBJaZdGl3KusuFRZ7Xdj772dp4Xj7PNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alq0Y/eHlDEGdOTSs2ANJKtcMj117d3sk40gNg8gBGC5prd7qrkqe6y2xgqR6v3sa+/vsfG8Q9N/xzLFq9YzLDv1kDq/89w9dKjHXl0gE+dckQMhigePes/APZ/9UQLjIqtI5uc9+NtkBX95vUyfGrYRbvJSccFrfL+IrU3RIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lt/IJXef; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso2441cf.0
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755016458; x=1755621258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/bHuFKXc5UZQhxmzduX2SdSRqJAHKwN0qxnN6xSIFI=;
        b=Lt/IJXefjxkoeI/r8uGGjumsT0oYRHhsnNCyGl37alBM/933GFhf5FV+RAnMudoVBw
         6q5IjSwGADZMNw450XCeTWLvE0yrXlWoAMdFCBXxF/1jV5Pmkp7q5PxAAF5D5z2IjcRq
         +A9IixNgCLFf15cI+Py/vOCRcnAdUS24O7fP4OgQPlxngNLBoDzOaTgJ+0HMyEAQTHc0
         FkbpmyLd+wEtYXimjOxh/IM0nMuQyHTZqpi3RcvGhdIpYFLCo2n7Os8ASNBTAiXsFXTZ
         ldtSi9k9/KzJfI93HDcCYsw4r8EyiTfYGu9md/ROW1Ofwz2gN7DdRzm3IXhIHsEEvSq3
         nddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016458; x=1755621258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/bHuFKXc5UZQhxmzduX2SdSRqJAHKwN0qxnN6xSIFI=;
        b=UQdWDMhMqOuyRQVtjDRJy+0mOgTdi6YAOEe/YwCvMprqvT7FRwGWtTgVeRB0Cv7nGz
         dZwkIIJerPXk+ZkREof6fJo5SVWZqCy1+cQGWfubgox12odXGTnKM5+RzxfZZGxOGvPV
         JUfNb7TxBc/CtpTL7qDWdZtN7UsNC7z2LriivjVGzvAxvHMBFWLOs7ObnPjVIlrOnGb1
         kqoUzotNewmkNd0a0ofwph2v+9RCMSBaDX4gXHPbDumjZW2Zg/O2jTt8s/vro4lgR9ft
         W01sKmnvGOnRAue+QKUKKfUdLu1xHZCbQI78D4TeLySE5EGl2uO7gLO69R1TArzqs/tm
         z+ag==
X-Forwarded-Encrypted: i=1; AJvYcCUrbNJTP1eE4Q8imWVEzYa+SMvKM9CcQJjY/2z8n/H9zbsS5BZEkVcHS6rM/s344643d93nyWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYpZxsEToma3avvUhhh1su8VSVPX5vEo1PoYOWpx7hn01/sFI
	9WklssnJYsLg0Nm/gTPNF/ArX6T5hUUph0uJVBB8GjiUcuaKGTlzEgOpxP5AxrXGUNrwnqsGWVy
	QEbXPWMO+wfzx4b92iFOarsy3H/TKzSAa/XW9gaEF
X-Gm-Gg: ASbGnct18SYBTOiJQ6qhPOC3zUhqzdnZ/hAd6t093yDwcMAtqjjKb84lPI+w+dtj4Pt
	ebajnWjJvd2HOPXHORc3cXmjCN/oWB6zMFxtYWdl8L2QfLjPBM8LezhfehNFv521ZvrCyhHSInC
	ZsU/U1pOHtWxzUjOfwk9W1V/IKpyOmtptmnb6AEaxvik6HeF4BGjjtwdEb1K1XqXKspIyUw9hzZ
	EkWYqpVMkScs4Et5zxM9ilh+VMiI63XKwEYBnaeKNt2+w==
X-Google-Smtp-Source: AGHT+IHcHntgM0B+veMN49Hb8yC0lqnSuqioydwpM3+xrp8Gfut9C4ofcC2Gau6ify6B93p5FGhnBndRmFScholxUQM=
X-Received: by 2002:a05:622a:201:b0:4a9:a4ef:35c2 with SMTP id
 d75a77b69052e-4b0ef4d34admr4519091cf.23.1755016457875; Tue, 12 Aug 2025
 09:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025081237-buffed-scuba-d3f3@gregkh>
In-Reply-To: <2025081237-buffed-scuba-d3f3@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Aug 2025 09:34:06 -0700
X-Gm-Features: Ac12FXyRJ05le4kPcUb__7Iitn7n8_3WlfJx2d5wk-jKxuHry3V53hpZ_J8HcjI
Message-ID: <CAJuCfpE+Rj5J-RpDEnws=8qydVUGFf=QE215qtaztuTZLGB-wQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got" failed to apply to 6.16-stable tree
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, stable@vger.kernel.org, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 9:18=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.16-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Yep, that's expected because 6.6 does not have lock_next_vma()
function. I'll send a backport shortly.

>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.16.y
> git checkout FETCH_HEAD
> git cherry-pick -x 9bbffee67ffd16360179327b57f3b1245579ef08
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081237-=
buffed-scuba-d3f3@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 9bbffee67ffd16360179327b57f3b1245579ef08 Mon Sep 17 00:00:00 2001
> From: Suren Baghdasaryan <surenb@google.com>
> Date: Mon, 28 Jul 2025 10:53:55 -0700
> Subject: [PATCH] mm: fix a UAF when vma->mm is freed after vma->vm_refcnt=
 got
>  dropped
>
> By inducing delays in the right places, Jann Horn created a reproducer fo=
r
> a hard to hit UAF issue that became possible after VMAs were allowed to b=
e
> recycled by adding SLAB_TYPESAFE_BY_RCU to their cache.
>
> Race description is borrowed from Jann's discovery report:
> lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
> rcu_read_lock().  At that point, the VMA may be concurrently freed, and i=
t
> can be recycled by another process.  vma_start_read() then increments the
> vma->vm_refcnt (if it is in an acceptable range), and if this succeeds,
> vma_start_read() can return a recycled VMA.
>
> In this scenario where the VMA has been recycled, lock_vma_under_rcu()
> will then detect the mismatching ->vm_mm pointer and drop the VMA through
> vma_end_read(), which calls vma_refcount_put().  vma_refcount_put() drops
> the refcount and then calls rcuwait_wake_up() using a copy of vma->vm_mm.
> This is wrong: It implicitly assumes that the caller is keeping the VMA's
> mm alive, but in this scenario the caller has no relation to the VMA's mm=
,
> so the rcuwait_wake_up() can cause UAF.
>
> The diagram depicting the race:
> T1         T2         T3
> =3D=3D         =3D=3D         =3D=3D
> lock_vma_under_rcu
>   mas_walk
>           <VMA gets removed from mm>
>                       mmap
>                         <the same VMA is reallocated>
>   vma_start_read
>     __refcount_inc_not_zero_limited_acquire
>                       munmap
>                         __vma_enter_locked
>                           refcount_add_not_zero
>   vma_end_read
>     vma_refcount_put
>       __refcount_dec_and_test
>                           rcuwait_wait_event
>                             <finish operation>
>       rcuwait_wake_up [UAF]
>
> Note that rcuwait_wait_event() in T3 does not block because refcount was
> already dropped by T1.  At this point T3 can exit and free the mm causing
> UAF in T1.
>
> To avoid this we move vma->vm_mm verification into vma_start_read() and
> grab vma->vm_mm to stabilize it before vma_refcount_put() operation.
>
> [surenb@google.com: v3]
>   Link: https://lkml.kernel.org/r/20250729145709.2731370-1-surenb@google.=
com
> Link: https://lkml.kernel.org/r/20250728175355.2282375-1-surenb@google.co=
m
> Fixes: 3104138517fc ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/all/CAG48ez0-deFbVH=3DE3jbkWx=3DX3uVbd8nW=
eo6kbJPQ0KoUD+m2tA@mail.gmail.com/
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 1f4f44951abe..11a078de9150 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
>  #include <linux/tracepoint-defs.h>
>  #include <linux/types.h>
>  #include <linux/cleanup.h>
> +#include <linux/sched/mm.h>
>
>  #define MMAP_LOCK_INITIALIZER(name) \
>         .mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
> @@ -154,6 +155,10 @@ static inline void vma_refcount_put(struct vm_area_s=
truct *vma)
>   * reused and attached to a different mm before we lock it.
>   * Returns the vma on success, NULL on failure to lock and EAGAIN if vma=
 got
>   * detached.
> + *
> + * WARNING! The vma passed to this function cannot be used if the functi=
on
> + * fails to lock it because in certain cases RCU lock is dropped and the=
n
> + * reacquired. Once RCU lock is dropped the vma can be concurently freed=
.
>   */
>  static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm=
,
>                                                     struct vm_area_struct=
 *vma)
> @@ -183,6 +188,31 @@ static inline struct vm_area_struct *vma_start_read(=
struct mm_struct *mm,
>         }
>
>         rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> +
> +       /*
> +        * If vma got attached to another mm from under us, that mm is no=
t
> +        * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> +        * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
> +        * releasing vma->vm_refcnt.
> +        */
> +       if (unlikely(vma->vm_mm !=3D mm)) {
> +               /* Use a copy of vm_mm in case vma is freed after we drop=
 vm_refcnt */
> +               struct mm_struct *other_mm =3D vma->vm_mm;
> +
> +               /*
> +                * __mmdrop() is a heavy operation and we don't need RCU
> +                * protection here. Release RCU lock during these operati=
ons.
> +                * We reinstate the RCU read lock as the caller expects i=
t to
> +                * be held when this function returns even on error.
> +                */
> +               rcu_read_unlock();
> +               mmgrab(other_mm);
> +               vma_refcount_put(vma);
> +               mmdrop(other_mm);
> +               rcu_read_lock();
> +               return NULL;
> +       }
> +
>         /*
>          * Overflow of vm_lock_seq/mm_lock_seq might produce false locked=
 result.
>          * False unlocked result is impossible because we modify and chec=
k
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 729fb7d0dd59..b006cec8e6fe 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -164,8 +164,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_s=
truct *mm,
>          */
>
>         /* Check if the vma we locked is the right one. */
> -       if (unlikely(vma->vm_mm !=3D mm ||
> -                    address < vma->vm_start || address >=3D vma->vm_end)=
)
> +       if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
>                 goto inval_end_read;
>
>         rcu_read_unlock();
> @@ -236,11 +235,8 @@ struct vm_area_struct *lock_next_vma(struct mm_struc=
t *mm,
>                 goto fallback;
>         }
>
> -       /*
> -        * Verify the vma we locked belongs to the same address space and=
 it's
> -        * not behind of the last search position.
> -        */
> -       if (unlikely(vma->vm_mm !=3D mm || from_addr >=3D vma->vm_end))
> +       /* Verify the vma is not behind the last search position. */
> +       if (unlikely(from_addr >=3D vma->vm_end))
>                 goto fallback_unlock;
>
>         /*
>

