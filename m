Return-Path: <stable+bounces-141101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348EAAB119
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9531BC15EA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19DB28FFE5;
	Tue,  6 May 2025 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlDEh4gv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D630812F
	for <stable@vger.kernel.org>; Mon,  5 May 2025 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488272; cv=none; b=Q0wigfpXhqIGSWdAtIz55HzojWdVCYwnyyKeAigbe5ap3+VQz+2UL1gj5FqAM7bWca7yky0U4bXfp1WvPgB8Hpqly9He0d5xqczp8Er/vG3gYPDKJLN/cTomjX6vZfdt0tOKJrtuBSo9jSZDqNseb7iVLoXje6+WnklhwBQaAiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488272; c=relaxed/simple;
	bh=cMo/N1YJQwwS3G9EKa84K4qqhc/5JFz3QTXfURVubVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU+1H+BAnsyqX76NK22DIaXXo82+rugI+Uq7BLYE2+rmiFu19JjAFnfMzBrh9bHvktXOaY+4h8xLkqbHdhz8A07xNV6eTH20iHSDyA6TwC+tbapnGdOTnllWElPkTImsCEhwL8+/lOIRjQJtg0evlYmdgDIZtViZbRSgxG7eLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlDEh4gv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47e9fea29easo58351cf.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746488267; x=1747093067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjMyp4mBCu5u/Y/aXldwK0jA40xv5fb/aCK38lYHD98=;
        b=DlDEh4gvMU7ux0RRaIavfX8ERffxi5bQm18sn/YRrc3iMZYwxjAcgH6cU0YnUaWjYv
         1u9z9RC0tGPDM48rLYGmkRp4P5yRjqMhTdpUz60rqwKj50DIp0b3R0yf53sFRKh4YstZ
         gBThAWt42LnEozUspwkauITqP51ifv1LVFi66Ynt82zMn7aaKnPDoPdD5QKGW7gkxXsw
         Th9tD09M0EBEmS1ROFoatuNcCpYqZWusaO7v3aZVRSH+nXKLbtz5P9RMcNqyIMox8LUG
         GMusDk5nRsmQMLuGxBzHYOPVsdHHdZFHkyXe8uxgwnkOgOD4fCytQPCi2paiQ9xTLjmr
         yj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746488267; x=1747093067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjMyp4mBCu5u/Y/aXldwK0jA40xv5fb/aCK38lYHD98=;
        b=kxwRMm2zT0zWteCTobi+MnQOAwWCxZq5GVZXN+eQBYo1WSrIFvnVt7YAPdcZbZyJbo
         K5Gh+timQDYvL4CzEaXrFl2XYiW33iAlH9fKP7aeO88jo64ITwT5MCdVmD1voYEVc/x3
         qGhX3kgX4h9VQgh3e0h+uoOnzFOjOx+mqyUj36kDhmRXKc5SZUFb5IknZP+ut+SijLHt
         8VXFvXwQRcFXPJMbbE+pUQRqos41JrV80rVpvkq9iK33Ib8PgtsUsaAEzXosKped404b
         gKCuTMeEVUZrCXiXD9e1KQeCUhBMSRC6+p1nLJ4tmtIyjxgEYvUd4j+ICVp+EVSZ6avO
         v9mw==
X-Forwarded-Encrypted: i=1; AJvYcCWplwbWR8oYEWM5ScFC/PkYt24qM+lMpj3y8OhUnUIPT0q/gndccw7wB4InMaMjPOlXxzwAOGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3BIenufmBYWbbJFZQ0erAv2o5dGUgp6rL0jaacMEV5RedSTQ
	FFZTH9NzGTsuswejWvsYnuPIUnyVPUIwtX3M3MBZmgXDlapw0JtpZKee4uBHEc6UFUOpmyueILh
	oOO2Gk4SwALFNt8b7xmN0foUGuRuQP9/YPs2A
X-Gm-Gg: ASbGncsCQ5SDD6T92zDOnOP9zhg5+uXBuSn6rE5Hxa7sPxhoyaE1+QezazGVOYnsEId
	X+soumliUlVTKs16+XiKQzJ578QVaVrORmZR8lzWBZsuJdg3J/f64V+fi70zU7yxa1YQ4hLkSxm
	hlgh8rvtrRF3xoMlMCoIMbKOec/WCAXnbBsi+mi14MNwdr0sGG+Yh1
X-Google-Smtp-Source: AGHT+IFcDOBWYVlR3divkat4OjTj2uKa0Ras8zwn26i54HahNCJVl63KWUuzmxW+Z53F+JV4XA+IblaDNCKhSxeipJM=
X-Received: by 2002:ac8:7d43:0:b0:48a:7cd7:7e02 with SMTP id
 d75a77b69052e-490f5ec9ad9mr1516391cf.18.1746488267391; Mon, 05 May 2025
 16:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025050521-provable-extent-4108@gregkh> <CAJuCfpE-ZQwm7SxKVT49wgw=2Tko9xCVvCraacbQxp8inTG_RQ@mail.gmail.com>
In-Reply-To: <CAJuCfpE-ZQwm7SxKVT49wgw=2Tko9xCVvCraacbQxp8inTG_RQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 5 May 2025 16:37:36 -0700
X-Gm-Features: ATxdqUEpjZLpoKTBem-xdGX5zvV6DajdVzwM7v7KpBzqN8wGQNu7NPPwoiM-DLY
Message-ID: <CAJuCfpFYm4FespFH6t4Q5c0NWYaq3HJCPEdDa2AvpoSqPG4Ltw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] mm, slab: clean up slab->obj_exts always"
 failed to apply to 6.14-stable tree
To: gregkh@linuxfoundation.org
Cc: quic_zhenhuah@quicinc.com, harry.yoo@oracle.com, rientjes@google.com, 
	vbabka@suse.cz, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:30=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, May 5, 2025 at 12:55=E2=80=AFAM <gregkh@linuxfoundation.org> wrot=
e:
> >
> >
> > The patch below does not apply to the 6.14-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
>
> I'll work on the backport. Thanks!

Posted both 6.12 and 6.14 backports.

>
> >
> > To reproduce the conflict and resubmit, you may use the following comma=
nds:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-6.14.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x be8250786ca94952a19ce87f98ad9906448bc9ef
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202505052=
1-provable-extent-4108@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
> >
> > Possible dependencies:
> >
> >
> >
> > thanks,
> >
> > greg k-h
> >
> > ------------------ original commit in Linus's tree ------------------
> >
> > From be8250786ca94952a19ce87f98ad9906448bc9ef Mon Sep 17 00:00:00 2001
> > From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > Date: Mon, 21 Apr 2025 15:52:32 +0800
> > Subject: [PATCH] mm, slab: clean up slab->obj_exts always
> >
> > When memory allocation profiling is disabled at runtime or due to an
> > error, shutdown_mem_profiling() is called: slab->obj_exts which
> > previously allocated remains.
> > It won't be cleared by unaccount_slab() because of
> > mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
> > should always be cleaned up in unaccount_slab() to avoid following erro=
r:
> >
> > [...]BUG: Bad page state in process...
> > ..
> > [...]page dumped because: page still charged to cgroup
> >
> > [andriy.shevchenko@linux.intel.com: fold need_slab_obj_ext() into its o=
nly user]
> > Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab object =
extensions")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Acked-by: Harry Yoo <harry.yoo@oracle.com>
> > Tested-by: Harry Yoo <harry.yoo@oracle.com>
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
> > Link: https://patch.msgid.link/20250421075232.2165527-1-quic_zhenhuah@q=
uicinc.com
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index dc9e729e1d26..be8b09e09d30 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2028,8 +2028,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct=
 kmem_cache *s,
> >         return 0;
> >  }
> >
> > -/* Should be called only if mem_alloc_profiling_enabled() */
> > -static noinline void free_slab_obj_exts(struct slab *slab)
> > +static inline void free_slab_obj_exts(struct slab *slab)
> >  {
> >         struct slabobj_ext *obj_exts;
> >
> > @@ -2049,18 +2048,6 @@ static noinline void free_slab_obj_exts(struct s=
lab *slab)
> >         slab->obj_exts =3D 0;
> >  }
> >
> > -static inline bool need_slab_obj_ext(void)
> > -{
> > -       if (mem_alloc_profiling_enabled())
> > -               return true;
> > -
> > -       /*
> > -        * CONFIG_MEMCG creates vector of obj_cgroup objects conditiona=
lly
> > -        * inside memcg_slab_post_alloc_hook. No other users for now.
> > -        */
> > -       return false;
> > -}
> > -
> >  #else /* CONFIG_SLAB_OBJ_EXT */
> >
> >  static inline void init_slab_obj_exts(struct slab *slab)
> > @@ -2077,11 +2064,6 @@ static inline void free_slab_obj_exts(struct sla=
b *slab)
> >  {
> >  }
> >
> > -static inline bool need_slab_obj_ext(void)
> > -{
> > -       return false;
> > -}
> > -
> >  #endif /* CONFIG_SLAB_OBJ_EXT */
> >
> >  #ifdef CONFIG_MEM_ALLOC_PROFILING
> > @@ -2129,7 +2111,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache=
 *s, void *object, gfp_t flags)
> >  static inline void
> >  alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_=
t flags)
> >  {
> > -       if (need_slab_obj_ext())
> > +       if (mem_alloc_profiling_enabled())
> >                 __alloc_tagging_slab_alloc_hook(s, object, flags);
> >  }
> >
> > @@ -2601,8 +2583,12 @@ static __always_inline void account_slab(struct =
slab *slab, int order,
> >  static __always_inline void unaccount_slab(struct slab *slab, int orde=
r,
> >                                            struct kmem_cache *s)
> >  {
> > -       if (memcg_kmem_online() || need_slab_obj_ext())
> > -               free_slab_obj_exts(slab);
> > +       /*
> > +        * The slab object extensions should now be freed regardless of
> > +        * whether mem_alloc_profiling_enabled() or not because profili=
ng
> > +        * might have been disabled after slab->obj_exts got allocated.
> > +        */
> > +       free_slab_obj_exts(slab);
> >
> >         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> >                             -(PAGE_SIZE << order));
> >

