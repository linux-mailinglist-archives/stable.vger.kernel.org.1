Return-Path: <stable+bounces-107966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34931A05297
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 06:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5EA3A4F54
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 05:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAAC1A01CC;
	Wed,  8 Jan 2025 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+V3TxST"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203070838;
	Wed,  8 Jan 2025 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736313935; cv=none; b=D+c56MObOSBRSOjUpoCju9LCr6oAQ0058tFKiiTAogrrlI2XyMT2a+8tyjvvT9G6YOGsLBMiKjNgB1w5W6P6h/1dfjpfuqsQP+bmDgpAYLhZLmLM6iCvAKmKVMd6AFavDNIJPfredWOCHNEyG9Q4sWMO1S1H3FkwhpR8PDgIric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736313935; c=relaxed/simple;
	bh=KBdLl+1CEAKh7RBee9afPxWTeEsKW6yCT0RU57wOa60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHDOk1AuAmN85FAC7TQS9vjOZ1aFLMtK3qRvKB4vgdG3TUGR6aL7ShwFQ/l3vzpJuSBzXxeHOTc1Bi9oI7PX5uShTtNBJElP8T8WrTKC9WOjcU4gB0YU4Diwoe6btneAjBAkDCBklXpTl37clGumtvU9YiL+ao6Uqsx27dTdgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+V3TxST; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85c4b057596so2882312241.3;
        Tue, 07 Jan 2025 21:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736313933; x=1736918733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyKIyH7Vxsq0pn4GW9Gt+XVcQVhl4PonXgEBMPAWdKw=;
        b=F+V3TxSTUjAn5pTeIcFxcB20xzK23uJLVQqulxXmheG8XJ3GHVLRWRDEFZiGgwZ9Td
         NE/Ij1vFwpEDswPiDJaEUGkxnTj+Xj4440fnKWVYp6kkv/YRB9FXATMPWxFs8PgEowmO
         ciJHsvUIJTCaZ8ZBSKRn7mfov+HdIiaqvzd2ooWn6oDRrhf6CnOBRP9bfjFK6JCftJr1
         M6JS65dYYaQDbWKgzNGzIdlxJrUjrcXMxPcFEQe7oz5ZTWpd1gvXdgRGh1//GsHoH7bt
         l/TBFfKV24ll7FMvWue6fTePxX6g7g5LrLWxNX7iQWPINvh1JiuYuWL2vh8hQHOHfnZw
         aqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736313933; x=1736918733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyKIyH7Vxsq0pn4GW9Gt+XVcQVhl4PonXgEBMPAWdKw=;
        b=tQOcQkNh5IcbLC2d9/r1z9sTXeOF8HcGth45Iemd+59XtlZiXu2Tiue8Zbp+Y+5VK5
         4AvhEghFkTxvq7ODSqGLfclpAs04Jij4b8ELBxCN1Vl1K2gzv2xk8gskhVL/X9m9GVUS
         um3vUaHDMhV0+3KyS1zBRK6VVISk/pe0vF0NN1IHa4rZ/ucIk29uwFAg/TB2nPd9sxZg
         l8fTWRdrlpjrU/eRJkfZT00uinsmTAV7iS+lrSTMjri5tiQQiViv5H/Liqk4eDu7WMBj
         QWzGSr97VXLVVfVIWo1e6kTqBqzc4uTEv4InGhjQCReuE8Ef793vjJiwDIjtoaJlBJdJ
         CIgw==
X-Forwarded-Encrypted: i=1; AJvYcCWfYsS/WI9SKgCnnSmBu15b1XDypQ09SOJynZm9OTgTvekmlcs3kP5fvU4VwtMG1lFm5qbWvwLFWl3ViS0=@vger.kernel.org, AJvYcCWypnvWcEl0Mvb8mF6auROkqCVnbPNp7kkCvyhFBPsSrc/i9LUOXPw/fGZXvKhT7W5j/BMz8nTX@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDgtEyD3PWJis6qx8pfAgJSJ9E11+hN1Gq1UOA1W2950cTN1H
	/hy2SsHGRYUTOuYM0NOpUux8o3a46xGUk+hVRe27OSQkLvIYB7upqQWLRhsFmR55Twk8ZsVgLa5
	FSoWr5vrZs5BlsfOJ8fXEuNsGHfU=
X-Gm-Gg: ASbGncuKVOEZ/nju/gLC9fasU3Cvg3coOoDW7Ymx5xTer97gBW6q+/15kwyTICxuLfP
	AplXMjl8ywAOBUNJuPf4qLDmTg+k45soE3yhuwjq2VkkMlF2QJei7qmgU6ZrJqWpVmjTnBl4=
X-Google-Smtp-Source: AGHT+IHFYfNR2caM2ZTLyDRLVZpt9LDF1Os5D+LOvbtZwZmycjWIfnAzlzv0dNZ6kRNCDi3WLzeWrhhyaHu9wJuPlVk=
X-Received: by 2002:a05:6102:3584:b0:4b1:24c0:4272 with SMTP id
 ada2fe7eead31-4b3d0f96d57mr1052770137.12.1736313932858; Tue, 07 Jan 2025
 21:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
 <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com>
 <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com>
 <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com> <CAGsJ_4z-5bsKT_6byG9ms1Ycfm4XX0gZ2LcCW=jA-umsHO=6eg@mail.gmail.com>
In-Reply-To: <CAGsJ_4z-5bsKT_6byG9ms1Ycfm4XX0gZ2LcCW=jA-umsHO=6eg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 8 Jan 2025 18:25:21 +1300
X-Gm-Features: AbW1kva6CDBPMvSXkPESLCFvzyzH3gmpHo5N45UReVZFtZHqfGgkeQRiULr-yO4
Message-ID: <CAGsJ_4za7KQNdHq2QP5eBNF0D=Npca+O_RJSE_gJN+_654-f6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 6:06=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Wed, Jan 8, 2025 at 5:46=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Wed, Jan 8, 2025 at 9:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > >
> > > Actually, using the mutex to protect against CPU hotunplug is not too
> > > complicated. The following diff is one way to do it (lightly tested).
> > > Johannes, Nhat, any preferences between this patch (disabling
> > > migration) and the following diff?
> >
> > I mean if this works, this over migration diasbling any day? :)
> >
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index f6316b66fb236..4d6817c679a54 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int cpu=
,
> > > struct hlist_node *node)
> > >         struct zswap_pool *pool =3D hlist_entry(node, struct zswap_po=
ol, node);
> > >         struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acom=
p_ctx, cpu);
> > >
> > > +       mutex_lock(&acomp_ctx->mutex);
> > >         if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > >                 if (!IS_ERR_OR_NULL(acomp_ctx->req))
> > >                         acomp_request_free(acomp_ctx->req);
> > > +               acomp_ctx->req =3D NULL;
> > >                 if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
> > >                         crypto_free_acomp(acomp_ctx->acomp);
> > >                 kfree(acomp_ctx->buffer);
> > >         }
> > > +       mutex_unlock(&acomp_ctx->mutex);
> > >
> > >         return 0;
> > >  }
> > >
> > > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
> > > +               struct crypto_acomp_ctx __percpu *acomp_ctx)
> > > +{
> > > +       struct crypto_acomp_ctx *ctx;
> > > +
> > > +       for (;;) {
> > > +               ctx =3D raw_cpu_ptr(acomp_ctx);
> > > +               mutex_lock(&ctx->mutex);
> >
> > I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting this
> > cpu-local data (including the mutex) from being invalidated under us
> > while we're sleeping and waiting for the mutex?
> >
> > If it is somehow protected, then yeah this seems quite elegant :)
>
> thought about this again. Could it be the following?
>
> bool cpus_is_read_locked(void)
> {
>         return percpu_is_read_locked(&cpu_hotplug_lock);
> }
>
> in zswap:
>
> bool locked =3D cpus_is_read_locked();
>
> if (!locked)
>      cpus_read_lock();
>
> .... // do our job
>
> if (!locked)
>      cpus_read_unlock();
>
> This seems to resolve all three problems:
> 1. if our context has held read lock, we won't hold it again;
> 2. if other contexts are holding write lock, we wait for the
> completion of cpuhotplug
> by acquiring read lock
> 3. if our context hasn't held a read lock, we hold it.
>

sorry for the noise.

This won't work because percpu_is_read_locked() is a sum:
bool percpu_is_read_locked(struct percpu_rw_semaphore *sem)
{
        return per_cpu_sum(*sem->read_count) !=3D 0 && !atomic_read(&sem->b=
lock);
}
EXPORT_SYMBOL_GPL(percpu_is_read_locked);

If other CPUs hold the read lock, it will also return true. However, once t=
hose
CPUs release the lock, our data might still be released by CPU hotplug.

This approach would require something like percpu_is_read_locked_by_me() :-=
(

> >
> > > +               if (likely(ctx->req))
> > > +                       return ctx;
> > > +               /* Raced with zswap_cpu_comp_dead() on CPU hotunplug =
*/
> > > +               mutex_unlock(&ctx->mutex);
> > > +       }
> > > +}
> > > +
> > > +static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *ctx)
> > > +{
> > > +       mutex_unlock(&ctx->mutex);
> > > +}
> > > +
> > >  static bool zswap_compress(struct page *page, struct zswap_entry *en=
try,
> > >                            struct zswap_pool *pool)
> > >  {
> > > @@ -893,10 +916,7 @@ static bool zswap_compress(struct page *page,
> > > struct zswap_entry *entry,
> > >         gfp_t gfp;
> > >         u8 *dst;
> > >
> > > -       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> > > -
> > > -       mutex_lock(&acomp_ctx->mutex);
> > > -
> > > +       acomp_ctx =3D acomp_ctx_get_cpu_locked(pool->acomp_ctx);
> > >         dst =3D acomp_ctx->buffer;
> > >         sg_init_table(&input, 1);
> > >         sg_set_page(&input, page, PAGE_SIZE, 0);
> > > @@ -949,7 +969,7 @@ static bool zswap_compress(struct page *page,
> > > struct zswap_entry *entry,
> > >         else if (alloc_ret)
> > >                 zswap_reject_alloc_fail++;
> > >
> > > -       mutex_unlock(&acomp_ctx->mutex);
> > > +       acomp_ctx_put_unlock(acomp_ctx);
> > >         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
> > >  }
> > >
> > > @@ -960,9 +980,7 @@ static void zswap_decompress(struct zswap_entry
> > > *entry, struct folio *folio)
> > >         struct crypto_acomp_ctx *acomp_ctx;
> > >         u8 *src;
> > >
> > > -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > > -       mutex_lock(&acomp_ctx->mutex);
> > > -
> > > +       acomp_ctx =3D acomp_ctx_get_cpu_locked(entry->pool->acomp_ctx=
);
> > >         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > >         /*
>
> Thanks
> Barry

