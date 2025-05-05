Return-Path: <stable+bounces-139726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C9AA9A8C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 19:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964B73BE1BC
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF251A2C04;
	Mon,  5 May 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qwg/Vvpw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6A17C98
	for <stable@vger.kernel.org>; Mon,  5 May 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466262; cv=none; b=khZVnalx6IXGMHYsZ6lhL3Z9YHmR/MQel0pgm2R94NlHySVpiZYJcRtdzo8DGMAdo1OSwlVFSfcjmflcg0RV9SowBDJm77s6E2wnvp1Srg0kIBZB24HMPbYFd0l5Bxm5oLgOYlX7EHsQNFU76yWbJFuB77OQON1F7VYttaSHFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466262; c=relaxed/simple;
	bh=icOdvGNpjsDv1bHoWRsl8306sihz3bMzKInirhh17ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfzC53ARM5Sufvu4jgUmcZC8yNqbRe3Hv+bS/WdHStOUnluu2+Wq5FXfyWT8cFjqEwvd7dBITkq06CsQW0pF0xMObnIVnQdodY4+LToQHN5UM4luv+Pq1tslm9ES75BQSbNFQDn12WUljWei+0GFn7hdx0sOoGgESzPauAbjNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qwg/Vvpw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-48b7747f881so16981cf.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746466260; x=1747071060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1ekk/EcVLPMO2RPC07oeBBANq7bPu8o21BFSsP6fvU=;
        b=Qwg/VvpwUd6GGJMIrBx22Stkk+VZOCUjI10c+0yFnKjDJ+qjZE0nQ9o116ArN796Hh
         XGI2lFvYv2uFImr0n0NYQd+b+oSJ9IqE3K2L76NnosMTVrCnSRToc4KN+I7+DSyREghR
         BGLOcoE2POt39GhEmoff7+otGZNHMXsx5sepZ5Lo+X51RIabm8NYnOB8k0iieJMZGWaF
         mR/JIeymGdChEDN564Tfz6j2/3WUcH/JcwlBmqIfqIaqS0T7SkqBs6KQ4kB4SO6wbVCS
         pWxGNpTT4LVHxsFvMv8xH2E8cgUHm7iscL0A9S4dlkZ38aDG36KdesK1Ouv0d8XC+Hn8
         XmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466260; x=1747071060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1ekk/EcVLPMO2RPC07oeBBANq7bPu8o21BFSsP6fvU=;
        b=v54MZ47hNo06ACfklX8MyJa+fhf1B+l8XiLFjl2HTYnG7GUh5jv7hNi0LekSl+gOCr
         wF1L/nxFQbbmOseZXhs4J55Bs5S08WyZAo1jVkZzSA10aqfBsXLtTu4Im4aeWTabVBmI
         MUQ7T7FmOcE0qfRiEWycZFwWFKZrYH5txNV+8wC0rOWSw6E6gC6mhhluHrxoNCf9gPdj
         pNRJggin+K5wjHEX3y38LXc4URwQ+DRAOT9/BASPgRIrvywksEFFYnr8NUGYVnpFECif
         sNdX4biRF6HfxG/8z+VaI4jcY85ZBTV0bi/ceS84itSqx/3YpI9M004a6zniPC8/ZUZF
         l+vw==
X-Forwarded-Encrypted: i=1; AJvYcCWIjBzH3qQny8Depf1iEy3W1fcxSgq27bxr/c+twXUMmlJHEZzzjfQmqTugTEY+5K5bbP10FwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6j+ksuhh6CT84KRLmdmgBlxjPrpOFb9d1/WyHbz/EjWwelyz
	OsInNX62f9dIBkhlsb7C8NRZ0zBx6sILP95pW1hoh9amCmbemUvepCao+/gsxu/cVboCF5CQ3A0
	oM+Z8635AlwalCO5Kx3qQ8MZ3oDX4rLMy72sl
X-Gm-Gg: ASbGncvdsQZkejkoDWluCcfK8umsWPU9JyM364+mifB7AF5huL5aVoLEPG9dLy1g1lF
	XZ7ib1wjOwyMNcZQ3fhGW6NSVzeXrA0AR+gVqfE304Dex3gKWgU7IurO0gShvtYW/2FIXiWVLZ0
	oNNaPPFPpJR+cUdArpwrsh
X-Google-Smtp-Source: AGHT+IEzPaJ6ZXtZL7m0R+5pk2aMUIz6WRdh+GAEHht03khM3N942OA+08ItQjKmCs6WsUMRU+K+bv7fM4PwAZUEMM4=
X-Received: by 2002:ac8:7f94:0:b0:471:eab0:ef21 with SMTP id
 d75a77b69052e-490cc658b33mr941421cf.13.1746466259277; Mon, 05 May 2025
 10:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025050521-provable-extent-4108@gregkh>
In-Reply-To: <2025050521-provable-extent-4108@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 5 May 2025 10:30:48 -0700
X-Gm-Features: ATxdqUG4tsOifqex5d44NjBVdd_0CoYYQywD6aQBW_oZKsQMgGiHA5E_F1Bx-0k
Message-ID: <CAJuCfpE-ZQwm7SxKVT49wgw=2Tko9xCVvCraacbQxp8inTG_RQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] mm, slab: clean up slab->obj_exts always"
 failed to apply to 6.14-stable tree
To: gregkh@linuxfoundation.org
Cc: quic_zhenhuah@quicinc.com, harry.yoo@oracle.com, rientjes@google.com, 
	vbabka@suse.cz, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 12:55=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I'll work on the backport. Thanks!

>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.14.y
> git checkout FETCH_HEAD
> git cherry-pick -x be8250786ca94952a19ce87f98ad9906448bc9ef
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050521-=
provable-extent-4108@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
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
> From be8250786ca94952a19ce87f98ad9906448bc9ef Mon Sep 17 00:00:00 2001
> From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> Date: Mon, 21 Apr 2025 15:52:32 +0800
> Subject: [PATCH] mm, slab: clean up slab->obj_exts always
>
> When memory allocation profiling is disabled at runtime or due to an
> error, shutdown_mem_profiling() is called: slab->obj_exts which
> previously allocated remains.
> It won't be cleared by unaccount_slab() because of
> mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
> should always be cleaned up in unaccount_slab() to avoid following error:
>
> [...]BUG: Bad page state in process...
> ..
> [...]page dumped because: page still charged to cgroup
>
> [andriy.shevchenko@linux.intel.com: fold need_slab_obj_ext() into its onl=
y user]
> Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab object ex=
tensions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> Tested-by: Harry Yoo <harry.yoo@oracle.com>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> Link: https://patch.msgid.link/20250421075232.2165527-1-quic_zhenhuah@qui=
cinc.com
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> diff --git a/mm/slub.c b/mm/slub.c
> index dc9e729e1d26..be8b09e09d30 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2028,8 +2028,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>         return 0;
>  }
>
> -/* Should be called only if mem_alloc_profiling_enabled() */
> -static noinline void free_slab_obj_exts(struct slab *slab)
> +static inline void free_slab_obj_exts(struct slab *slab)
>  {
>         struct slabobj_ext *obj_exts;
>
> @@ -2049,18 +2048,6 @@ static noinline void free_slab_obj_exts(struct sla=
b *slab)
>         slab->obj_exts =3D 0;
>  }
>
> -static inline bool need_slab_obj_ext(void)
> -{
> -       if (mem_alloc_profiling_enabled())
> -               return true;
> -
> -       /*
> -        * CONFIG_MEMCG creates vector of obj_cgroup objects conditionall=
y
> -        * inside memcg_slab_post_alloc_hook. No other users for now.
> -        */
> -       return false;
> -}
> -
>  #else /* CONFIG_SLAB_OBJ_EXT */
>
>  static inline void init_slab_obj_exts(struct slab *slab)
> @@ -2077,11 +2064,6 @@ static inline void free_slab_obj_exts(struct slab =
*slab)
>  {
>  }
>
> -static inline bool need_slab_obj_ext(void)
> -{
> -       return false;
> -}
> -
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
> @@ -2129,7 +2111,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *=
s, void *object, gfp_t flags)
>  static inline void
>  alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t =
flags)
>  {
> -       if (need_slab_obj_ext())
> +       if (mem_alloc_profiling_enabled())
>                 __alloc_tagging_slab_alloc_hook(s, object, flags);
>  }
>
> @@ -2601,8 +2583,12 @@ static __always_inline void account_slab(struct sl=
ab *slab, int order,
>  static __always_inline void unaccount_slab(struct slab *slab, int order,
>                                            struct kmem_cache *s)
>  {
> -       if (memcg_kmem_online() || need_slab_obj_ext())
> -               free_slab_obj_exts(slab);
> +       /*
> +        * The slab object extensions should now be freed regardless of
> +        * whether mem_alloc_profiling_enabled() or not because profiling
> +        * might have been disabled after slab->obj_exts got allocated.
> +        */
> +       free_slab_obj_exts(slab);
>
>         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
>                             -(PAGE_SIZE << order));
>

