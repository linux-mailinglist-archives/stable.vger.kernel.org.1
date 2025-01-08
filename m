Return-Path: <stable+bounces-108038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEDAA06751
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 22:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5106F3A628D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B7203717;
	Wed,  8 Jan 2025 21:38:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCD202C4A;
	Wed,  8 Jan 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372334; cv=none; b=F0cRc5uCXB4fAMQ7JVXZyP8PGglGCxCX8NWuxE91YhawGIlkcBQmXWgczLuw30WZuKIgsrMVvt1Gh4Bm9js/ZBkftnl7Dzag7CynJ6AQqamP0kfAdVtweLuj3U7M7vMSg4lBd4MDr0IzKD/OnP+tdjvInMfZkDdT4ATF1oPOMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372334; c=relaxed/simple;
	bh=lOL+gZbcVFhYImbFEEadqMlOrUtbr+oUsMdmbhlMZ6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5TSkhYrAkdt0nED1PWla085gwqTQfrINuCEU5HhSxWCVn7rJj4yJdi4AuW+zg4g7wrxcOvtDPwbBcXVwTBRa4p3q2f3XA1IiZZw4ccdO1rk86PZCJrDQYaIa7dJIYK4wjgfNXANZN/Pwj/ds6VqrR+tHTwZVtvW05G9x/kwLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51c4bc9cd19so130710e0c.3;
        Wed, 08 Jan 2025 13:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736372332; x=1736977132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s0qVu/VqiCoKV6ZaSrjNbeV/DPOv/JZxoR4oPPdw1c=;
        b=bXLNK0XhOnvy8EIu6yx2izTrBiE3VEtIldyigRyMk9QC21BBZBuDZx1hDj5kNYDIme
         BKKmIKznNteSsY19sKakZ2cJ+y09wdsa7tTt0R/ny+0iIo1RWpCIHIyy+p1urTQYtdH+
         SKqdbV9gtv7b5DxIEj+kCEu2uJdVYq+mlkX941TKI6wGpeo8G65io+fQJfZG7B2wPW6T
         B0g5M1CI5fKARTINstRxFUJMuEsEwggfsFexBd16ehSs0pPOy8YDjbQYJ/tg6QWo8Fi2
         0lD4IF115THNlJ7zG/owdN9Om4rCEt489kx3kKEU4oj+4jTEr5ZlsLfJ3iaTFJANso1P
         Zl+A==
X-Forwarded-Encrypted: i=1; AJvYcCVehO29h5a87Irw2VNW1pO2+0zg5yHDouYHflz0XmKOb/JYyD5ZZWexAAUnrlLbSnhL/XyeAoRsILyb0M0=@vger.kernel.org, AJvYcCXqG7IGk7GqT++tEYdlUUqAq5AFTNjqE1hg5bw9EDUIjWrIaC+UCbIIjRPpuv3qWz80uCrN1CF/@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfGjmHVH0LPkj5uXsESM8I6qQxJGD5z7eSd8ltxYPkwh7XNU/
	wueYF3f5kTL+JSQsLBmVXV1wrfmelDx1ZZh3+OgGQw+sgwxTftfUsJw5tTrbl+kqxtEYGjnKLVx
	odqUa2iPNVP0Ku1vLOlVB2uYfcMI=
X-Gm-Gg: ASbGncuiOpDTBUGR5kfa6WT8m/IO9Gh9qlVAjeklmITSWJCX9DUIqT7DA/USt41S6w0
	barG+eCrdnxU8/j44AaxcE4hm2OuEbTDEoaBaYIUk0QvDMRxCfl+qCRo5mYRycccbh9Hc/6Hp
X-Google-Smtp-Source: AGHT+IEKXuweN+FxZk3E2jSDi14xQY//UX97egwLOz0Pcdn4d06tNUmeiyRBB/h+7mXAkoTl2Or4WLRmUbP5AINKOXs=
X-Received: by 2002:a05:6122:3bd6:b0:50d:6a43:d525 with SMTP id
 71dfb90a1353d-51c6c22ea8fmr3712039e0c.1.1736372331678; Wed, 08 Jan 2025
 13:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108161529.3193825-1-yosryahmed@google.com> <SJ0PR11MB56781DA3F7B94E44753FAB51C9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56781DA3F7B94E44753FAB51C9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 9 Jan 2025 10:38:40 +1300
X-Gm-Features: AbW1kvarJ64wHxrb7SK34eR15amEr79qITZ5h0D5l4xRysF8EGjxmolC7_JBV0g
Message-ID: <CAGsJ_4x=ZNJwj4R6Z3c5-rPs-D5xzTnv039=8VQxo7OdyxavMg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: properly synchronize freeing resources during
 CPU hotunplug
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 9:23=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Wednesday, January 8, 2025 8:15 AM
> > To: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>; Nhat Pham
> > <nphamcs@gmail.com>; Chengming Zhou <chengming.zhou@linux.dev>;
> > Vitaly Wool <vitalywool@gmail.com>; Barry Song <baohua@kernel.org>; Sam
> > Sun <samsun1006219@gmail.com>; Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com>; linux-mm@kvack.org; linux-
> > kernel@vger.kernel.org; Yosry Ahmed <yosryahmed@google.com>;
> > stable@vger.kernel.org
> > Subject: [PATCH] mm: zswap: properly synchronize freeing resources duri=
ng
> > CPU hotunplug
> >
> > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of
> > the
> > current CPU at the beginning of the operation is retrieved and used
> > throughout.  However, since neither preemption nor migration are
> > disabled, it is possible that the operation continues on a different
> > CPU.
> >
> > If the original CPU is hotunplugged while the acomp_ctx is still in use=
,
> > we run into a UAF bug as some of the resources attached to the acomp_ct=
x
> > are freed during hotunplug in zswap_cpu_comp_dead().
> >
> > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
> > use crypto_acomp API for hardware acceleration") when the switch to the
> > crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
> > retrieved using get_cpu_ptr() which disables preemption and makes sure
> > the CPU cannot go away from under us.  Preemption cannot be disabled
> > with the crypto_acomp API as a sleepable context is needed.
> >
> > During CPU hotunplug, hold the acomp_ctx.mutex before freeing any
> > resources, and set acomp_ctx.req to NULL when it is freed. In the
> > compress/decompress paths, after acquiring the acomp_ctx.mutex make sur=
e
> > that acomp_ctx.req is not NULL (i.e. acomp_ctx resources were not freed
> > by CPU hotunplug). Otherwise, retry with the acomp_ctx from the new CPU=
.
> >
> > This adds proper synchronization to ensure that the acomp_ctx resources
> > are not freed from under compress/decompress paths.
> >
> > Note that the per-CPU acomp_ctx itself (including the mutex) is not
> > freed during CPU hotunplug, only acomp_ctx.req, acomp_ctx.buffer, and
> > acomp_ctx.acomp. So it is safe to acquire the acomp_ctx.mutex of a CPU
> > after it is hotunplugged.
>
> Only other fail-proofing I can think of is to initialize the mutex right =
after
> the per-cpu acomp_ctx is allocated in zswap_pool_create() and de-couple
> it from the cpu onlining. This further clarifies the intent for this mute=
x
> to be used at the same lifetime scope as the acomp_ctx itself, independen=
t
> of cpu hotplug/hotunplug.

Good catch! That step should have been executed immediately after
calling alloc_percpu(). Initially, the mutex was dynamically
allocated and initialized in zswap_cpu_comp_prepare(). Later, it
was moved to the context and allocated statically. It would be
better to relocate the mutex_init() accordingly.

>
> Thanks,
> Kanchana
>
> >
> > Previously a fix was attempted by holding cpus_read_lock() [1]. This
> > would have caused a potential deadlock as it is possible for code
> > already holding the lock to fall into reclaim and enter zswap (causing =
a
> > deadlock). A fix was also attempted using SRCU for synchronization, but
> > Johannes pointed out that synchronize_srcu() cannot be used in CPU
> > hotplug notifiers [2].
> >
> > Alternative fixes that were considered/attempted and could have worked:
> > - Refcounting the per-CPU acomp_ctx. This involves complexity in
> >   handling the race between the refcount dropping to zero in
> >   zswap_[de]compress() and the refcount being re-initialized when the
> >   CPU is onlined.
> > - Disabling migration before getting the per-CPU acomp_ctx [3], but
> >   that's discouraged and is a much bigger hammer than needed, and could
> >   result in subtle performance issues.
> >
> > [1]https://lkml.kernel.org/20241219212437.2714151-1-
> > yosryahmed@google.com/
> > [2]https://lkml.kernel.org/20250107074724.1756696-2-
> > yosryahmed@google.com/
> > [3]https://lkml.kernel.org/20250107222236.2715883-2-
> > yosryahmed@google.com/
> >
> > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for
> > hardware acceleration")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > Closes:
> > https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
> > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > Closes:
> > https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4O
> > curuL4tPg6OaQ@mail.gmail.com/
> > ---
> >
> > This applies on top of the latest mm-hotfixes-unstable on top of 'Rever=
t
> > "mm: zswap: fix race between [de]compression and CPU hotunplug"' and
> > after 'mm: zswap: disable migration while using per-CPU acomp_ctx' was
> > dropped.
> >
> > ---
> >  mm/zswap.c | 42 +++++++++++++++++++++++++++++++++---------
> >  1 file changed, 33 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb236..4e3148050e093 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -869,17 +869,46 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
> > struct hlist_node *node)
> >       struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool,
> > node);
> >       struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool-
> > >acomp_ctx, cpu);
> >
> > +     mutex_lock(&acomp_ctx->mutex);
> >       if (!IS_ERR_OR_NULL(acomp_ctx)) {
> >               if (!IS_ERR_OR_NULL(acomp_ctx->req))
> >                       acomp_request_free(acomp_ctx->req);
> > +             acomp_ctx->req =3D NULL;
> >               if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
> >                       crypto_free_acomp(acomp_ctx->acomp);
> >               kfree(acomp_ctx->buffer);
> >       }
> > +     mutex_unlock(&acomp_ctx->mutex);
> >
> >       return 0;
> >  }
> >
> > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_lock(
> > +             struct crypto_acomp_ctx __percpu *acomp_ctx)
> > +{
> > +     struct crypto_acomp_ctx *ctx;
> > +
> > +     for (;;) {
> > +             ctx =3D raw_cpu_ptr(acomp_ctx);
> > +             mutex_lock(&ctx->mutex);
> > +             if (likely(ctx->req))
> > +                     return ctx;
> > +             /*
> > +              * It is possible that we were migrated to a different CP=
U
> > after
> > +              * getting the per-CPU ctx but before the mutex was
> > acquired. If
> > +              * the old CPU got offlined, zswap_cpu_comp_dead() could
> > have
> > +              * already freed ctx->req (among other things) and set it=
 to
> > +              * NULL. Just try again on the new CPU that we ended up o=
n.
> > +              */
> > +             mutex_unlock(&ctx->mutex);
> > +     }
> > +}
> > +
> > +static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *ctx)
> > +{
> > +     mutex_unlock(&ctx->mutex);
> > +}
> > +
> >  static bool zswap_compress(struct page *page, struct zswap_entry *entr=
y,
> >                          struct zswap_pool *pool)
> >  {
> > @@ -893,10 +922,7 @@ static bool zswap_compress(struct page *page,
> > struct zswap_entry *entry,
> >       gfp_t gfp;
> >       u8 *dst;
> >
> > -     acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> > -
> > -     mutex_lock(&acomp_ctx->mutex);
> > -
> > +     acomp_ctx =3D acomp_ctx_get_cpu_lock(pool->acomp_ctx);
> >       dst =3D acomp_ctx->buffer;
> >       sg_init_table(&input, 1);
> >       sg_set_page(&input, page, PAGE_SIZE, 0);
> > @@ -949,7 +975,7 @@ static bool zswap_compress(struct page *page, struc=
t
> > zswap_entry *entry,
> >       else if (alloc_ret)
> >               zswap_reject_alloc_fail++;
> >
> > -     mutex_unlock(&acomp_ctx->mutex);
> > +     acomp_ctx_put_unlock(acomp_ctx);
> >       return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
> >  }
> >
> > @@ -960,9 +986,7 @@ static void zswap_decompress(struct zswap_entry
> > *entry, struct folio *folio)
> >       struct crypto_acomp_ctx *acomp_ctx;
> >       u8 *src;
> >
> > -     acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > -     mutex_lock(&acomp_ctx->mutex);
> > -
> > +     acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool->acomp_ctx);
> >       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >       /*
> >        * If zpool_map_handle is atomic, we cannot reliably utilize its
> > mapped buffer
> > @@ -986,10 +1010,10 @@ static void zswap_decompress(struct
> > zswap_entry *entry, struct folio *folio)
> >       acomp_request_set_params(acomp_ctx->req, &input, &output,
> > entry->length, PAGE_SIZE);
> >       BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx-
> > >req), &acomp_ctx->wait));
> >       BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> > -     mutex_unlock(&acomp_ctx->mutex);
> >
> >       if (src !=3D acomp_ctx->buffer)
> >               zpool_unmap_handle(zpool, entry->handle);
> > +     acomp_ctx_put_unlock(acomp_ctx);
> >  }
> >
> >  /*********************************
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
>

Thanks
Barry

