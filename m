Return-Path: <stable+bounces-200079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB5CA595A
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 23:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 092E8306A306
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833D3081C2;
	Thu,  4 Dec 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTIJSdVe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186C1C862E
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764885922; cv=none; b=rLmRQwnxBuQJhP8b1ZlhZPjg3GZ2wTwZA5DXJfZpgEJsdiJS264x71v7rGHUQ98uIoKw8VGuniCee6qWe5Ddzktq8JWfEH6b9oUObX8ETjgUnrn054/f6fDrDPiFDBXVwJrfv2sU0ZFSDfxBkqckVOAZkO6UP7WFNPOhSBRHuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764885922; c=relaxed/simple;
	bh=O/p9f+fGjb5JRyj7xXiW6sdlvwqkCxGcca77LTKi/t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKEcoltzFctZ5BMmEoEy8vw4SVnaDari7uUdJtsVoJY7vGXH+pws1ePymewUYnYlBxgQbXZvL46t5ghSEsib0z/A64uQD02XPvBylaHDTzPOlxKcIqY1l6cSDTlsI0ge3hlGWxZgXm+k2p57M0Bdom1+CY+QinHYoRAmfoatLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTIJSdVe; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee243b98caso48291cf.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 14:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764885919; x=1765490719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlMojaibJswZ58Md6lSPxnF32xXnO1Wd7Xx7hEEyCgs=;
        b=sTIJSdVeuZIfKnNYVehnINy05oNNxDggxDHygpiYzlSBfE3b/rzchZxz7JAL1gt5ZQ
         JX/qfMU1BGda2JOuZrywxAreZHR91hKHO1bizFd2C4l9HpauOzghFkfhv4gTgy6OCxHD
         KXzPp4Cu2TjADeeWutYXEokaDAJUiDwf+RT/iQa3jVEPzvEcgjhowEBKi6pKUKhtLkWa
         XCgTGGId+IYUCzKNvhlHokVVw9bleQU/J8zpHYkTTjD0s4dgyIcaHDslmgz08xyvy4YU
         M6i3hXZyiiIBlrhC9EjRQOEPurbZyp88X85A7qPLKDoTYZA2T2QwnC/5KNY02Ionq+Us
         wBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764885919; x=1765490719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlMojaibJswZ58Md6lSPxnF32xXnO1Wd7Xx7hEEyCgs=;
        b=sIWe8OMhp0otEp/0J5UYaqdJPareJGEAzx0sHxBHDQ6dB+YLz6bSz2YnvJirawiTmr
         PgZNAQuEdzwRCdpw8PBhHXFr8Av8L9g546rKcWrtC5lrsox8rJQJZc3Sks49Iq8Mj9SL
         h9wRyfni3H4rZyT96YpbPIvgATiC0ItQHVGN7Qjqoz8pmpbRMbqP6DRZhKFQm92JXC8F
         qstAvYNmLdVqojbmu5ZIcGZuqyxm25s8CLxBPmpN0V9+I7f7sgPrEAR2q3Ndx39hHZ5N
         44SaM9Ufu7iQrzR+KX3RWrWTKejA2e2JiGnv2BVvLVeZ15ZRBLnwf6PMzxn3FyxoKBy0
         8AYA==
X-Forwarded-Encrypted: i=1; AJvYcCVGEPPZFcqGY4XGM6djCsV9h6v/GtfHlM8k/rh4+KjpFC8zpHnuDtDCwPel+eh6GDZP39WoSfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVA0iDbRcyS6v6HM5huKVmPmZomI4bzDS7V3SsFzVL2eCt0mu
	iqJ4hBlB4infCcOQWqZzXkRI8xxNCYnxdbfI0nyu0P/KbCZ2kqVVre2obYSclWpI57LLN21ZlC2
	RoiHNSW4cqaHDzV08M7F8Ei0Yakr4L2eROOM/EKNm
X-Gm-Gg: ASbGncviZWu9SVv/TJqv7Bj13/9AsdlMURjC8i/uClRcB2ftHW4ZMfUWqw1AZOG08fI
	TCsn3MGc+LE75HNo+MWg6I8nAVU5UFhBoBhBrHXIoN10p+5bktlTOX5/pB5JLjPFe4ALaWMoRSi
	PG5Q/wm0NSu40aK6+PejA9n/xsjuvdURzX+HIKWEkL0p5bJhdY+0fQGq/t30FWIfHeAdYQqAXZd
	AZq+u/lJZzAmUhNQcj1+IkcX/ZIg8dxzt47bkkbIW3XAGRLV1jdoM8F63+XuxNDBMziHD6OxE5Y
	uWXEegJSlUD/UaiZkqX8OOi8bw==
X-Google-Smtp-Source: AGHT+IFPNi1Qq6VnpviOUxpKZr81dFMcXNcb6T+4p6OQ/SGAOQNaW0ByA8FKshNAIkMbBHJmIRv/I4XWmKWNYD2+UjQ=
X-Received: by 2002:a05:622a:11c7:b0:4b7:9c77:6ba5 with SMTP id
 d75a77b69052e-4f0328c27f7mr986761cf.15.1764885918541; Thu, 04 Dec 2025
 14:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202101626.783736-1-harry.yoo@oracle.com>
In-Reply-To: <20251202101626.783736-1-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Dec 2025 14:05:07 -0800
X-Gm-Features: AQt7F2p0K1ADlvbRPKyMu031QLfpqGn6xZ7XRfN7KMrquLJSUSvofoLyz0mVl2M
Message-ID: <CAJuCfpE+g65Dm8-r=psDJQf_O1rfBG62DOzx4mE1mb+ottUKmQ@mail.gmail.com>
Subject: Re: [PATCH V2] mm/slab: introduce kvfree_rcu_barrier_on_cache() for
 cache destruction
To: Harry Yoo <harry.yoo@oracle.com>
Cc: vbabka@suse.cz, Liam.Howlett@oracle.com, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	sidhartha.kumar@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-modules@vger.kernel.org, mcgrof@kernel.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, atomlin@atomlin.com, lucas.demarchi@intel.com, 
	akpm@linux-foundation.org, jonathanh@nvidia.com, stable@vger.kernel.org, 
	Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 2:16=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
> caches when a cache is destroyed. This is unnecessary; only the RCU
> sheaves belonging to the cache being destroyed need to be flushed.
>
> As suggested by Vlastimil Babka, introduce a weaker form of
> kvfree_rcu_barrier() that operates on a specific slab cache.
>
> Factor out flush_rcu_sheaves_on_cache() from flush_all_rcu_sheaves() and
> call it from flush_all_rcu_sheaves() and kvfree_rcu_barrier_on_cache().
>
> Call kvfree_rcu_barrier_on_cache() instead of kvfree_rcu_barrier() on
> cache destruction.
>
> The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
> 5900X machine (1 socket), by loading slub_kunit module.
>
> Before:
>   Total calls: 19
>   Average latency (us): 18127
>   Total time (us): 344414
>
> After:
>   Total calls: 19
>   Average latency (us): 10066
>   Total time (us): 191264
>
> Two performance regression have been reported:
>   - stress module loader test's runtime increases by 50-60% (Daniel)
>   - internal graphics test's runtime on Tegra23 increases by 35% (Jon)
>
> They are fixed by this change.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() op=
erations")
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c93=
01@suse.cz
> Reported-and-tested-by: Daniel Gomez <da.gomez@samsung.com>
> Closes: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616d=
d742@kernel.org
> Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bb=
f262@nvidia.com
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>
> No code change, added proper tags and updated changelog.
>
>  include/linux/slab.h |  5 ++++
>  mm/slab.h            |  1 +
>  mm/slab_common.c     | 52 +++++++++++++++++++++++++++++------------
>  mm/slub.c            | 55 ++++++++++++++++++++++++--------------------
>  4 files changed, 73 insertions(+), 40 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index cf443f064a66..937c93d44e8c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -1149,6 +1149,10 @@ static inline void kvfree_rcu_barrier(void)
>  {
>         rcu_barrier();
>  }
> +static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> +{
> +       rcu_barrier();
> +}
>
>  static inline void kfree_rcu_scheduler_running(void) { }
>  #else
> @@ -1156,6 +1160,7 @@ void kvfree_rcu_barrier(void);
>
>  void kfree_rcu_scheduler_running(void);
>  #endif
> +void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);

Should the above line be before the #endif? I was expecting something like =
this:

#ifndef CONFIG_KVFREE_RCU_BATCHED
...
static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
{
    rcu_barrier();
}
#else
...
void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);
#endif

but when I apply this patch on mm-new I get this:

#ifndef CONFIG_KVFREE_RCU_BATCHED
...
static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
{
    rcu_barrier();
}
#else
...
#endif
void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);

Other than that LGTM

>
>  /**
>   * kmalloc_size_roundup - Report allocation bucket size for the given si=
ze
> diff --git a/mm/slab.h b/mm/slab.h
> index f730e012553c..e767aa7e91b0 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -422,6 +422,7 @@ static inline bool is_kmalloc_normal(struct kmem_cach=
e *s)
>
>  bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
>  void flush_all_rcu_sheaves(void);
> +void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
>
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 84dfff4f7b1f..dd8a49d6f9cc 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -492,7 +492,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>                 return;
>
>         /* in-flight kfree_rcu()'s may include objects from our cache */
> -       kvfree_rcu_barrier();
> +       kvfree_rcu_barrier_on_cache(s);
>
>         if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
>             (s->flags & SLAB_TYPESAFE_BY_RCU)) {
> @@ -2038,25 +2038,13 @@ void kvfree_call_rcu(struct rcu_head *head, void =
*ptr)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>
> -/**
> - * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> - *
> - * Note that a single argument of kvfree_rcu() call has a slow path that
> - * triggers synchronize_rcu() following by freeing a pointer. It is done
> - * before the return from the function. Therefore for any single-argumen=
t
> - * call that will result in a kfree() to a cache that is to be destroyed
> - * during module exit, it is developer's responsibility to ensure that a=
ll
> - * such calls have returned before the call to kmem_cache_destroy().
> - */
> -void kvfree_rcu_barrier(void)
> +static inline void __kvfree_rcu_barrier(void)
>  {
>         struct kfree_rcu_cpu_work *krwp;
>         struct kfree_rcu_cpu *krcp;
>         bool queued;
>         int i, cpu;
>
> -       flush_all_rcu_sheaves();
> -
>         /*
>          * Firstly we detach objects and queue them over an RCU-batch
>          * for all CPUs. Finally queued works are flushed for each CPU.
> @@ -2118,8 +2106,43 @@ void kvfree_rcu_barrier(void)
>                 }
>         }
>  }
> +
> +/**
> + * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> + *
> + * Note that a single argument of kvfree_rcu() call has a slow path that
> + * triggers synchronize_rcu() following by freeing a pointer. It is done
> + * before the return from the function. Therefore for any single-argumen=
t
> + * call that will result in a kfree() to a cache that is to be destroyed
> + * during module exit, it is developer's responsibility to ensure that a=
ll
> + * such calls have returned before the call to kmem_cache_destroy().
> + */
> +void kvfree_rcu_barrier(void)
> +{
> +       flush_all_rcu_sheaves();
> +       __kvfree_rcu_barrier();
> +}
>  EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>
> +/**
> + * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls o=
n a
> + *                               specific slab cache.
> + * @s: slab cache to wait for
> + *
> + * See the description of kvfree_rcu_barrier() for details.
> + */
> +void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> +{
> +       if (s->cpu_sheaves)
> +               flush_rcu_sheaves_on_cache(s);
> +       /*
> +        * TODO: Introduce a version of __kvfree_rcu_barrier() that works
> +        * on a specific slab cache.
> +        */
> +       __kvfree_rcu_barrier();
> +}
> +EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
> +
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *s=
c)
>  {
> @@ -2215,4 +2238,3 @@ void __init kvfree_rcu_init(void)
>  }
>
>  #endif /* CONFIG_KVFREE_RCU_BATCHED */
> -
> diff --git a/mm/slub.c b/mm/slub.c
> index 785e25a14999..7cec2220712b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4118,42 +4118,47 @@ static void flush_rcu_sheaf(struct work_struct *w=
)
>
>
>  /* needed for kvfree_rcu_barrier() */
> -void flush_all_rcu_sheaves(void)
> +void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
>  {
>         struct slub_flush_work *sfw;
> -       struct kmem_cache *s;
>         unsigned int cpu;
>
> -       cpus_read_lock();
> -       mutex_lock(&slab_mutex);
> +       mutex_lock(&flush_lock);
>
> -       list_for_each_entry(s, &slab_caches, list) {
> -               if (!s->cpu_sheaves)
> -                       continue;
> +       for_each_online_cpu(cpu) {
> +               sfw =3D &per_cpu(slub_flush, cpu);
>
> -               mutex_lock(&flush_lock);
> +               /*
> +                * we don't check if rcu_free sheaf exists - racing
> +                * __kfree_rcu_sheaf() might have just removed it.
> +                * by executing flush_rcu_sheaf() on the cpu we make
> +                * sure the __kfree_rcu_sheaf() finished its call_rcu()
> +                */
>
> -               for_each_online_cpu(cpu) {
> -                       sfw =3D &per_cpu(slub_flush, cpu);
> +               INIT_WORK(&sfw->work, flush_rcu_sheaf);
> +               sfw->s =3D s;
> +               queue_work_on(cpu, flushwq, &sfw->work);
> +       }
>
> -                       /*
> -                        * we don't check if rcu_free sheaf exists - raci=
ng
> -                        * __kfree_rcu_sheaf() might have just removed it=
.
> -                        * by executing flush_rcu_sheaf() on the cpu we m=
ake
> -                        * sure the __kfree_rcu_sheaf() finished its call=
_rcu()
> -                        */
> +       for_each_online_cpu(cpu) {
> +               sfw =3D &per_cpu(slub_flush, cpu);
> +               flush_work(&sfw->work);
> +       }
>
> -                       INIT_WORK(&sfw->work, flush_rcu_sheaf);
> -                       sfw->s =3D s;
> -                       queue_work_on(cpu, flushwq, &sfw->work);
> -               }
> +       mutex_unlock(&flush_lock);
> +}
>
> -               for_each_online_cpu(cpu) {
> -                       sfw =3D &per_cpu(slub_flush, cpu);
> -                       flush_work(&sfw->work);
> -               }
> +void flush_all_rcu_sheaves(void)
> +{
> +       struct kmem_cache *s;
> +
> +       cpus_read_lock();
> +       mutex_lock(&slab_mutex);
>
> -               mutex_unlock(&flush_lock);
> +       list_for_each_entry(s, &slab_caches, list) {
> +               if (!s->cpu_sheaves)
> +                       continue;
> +               flush_rcu_sheaves_on_cache(s);
>         }
>
>         mutex_unlock(&slab_mutex);
> --
> 2.43.0
>

