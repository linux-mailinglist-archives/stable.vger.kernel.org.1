Return-Path: <stable+bounces-107964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE1FA0527C
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 06:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A644A1887ED0
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 05:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63E19CC31;
	Wed,  8 Jan 2025 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbfvx718"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039D13B797;
	Wed,  8 Jan 2025 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736312805; cv=none; b=NJ29nMUJOJXGfmrNRFY9CIJSr9W074n3Ft8tUYvzo/pz3i3Tk79P2sKMWL1kj9oZ4EQ9WOdBvdigU8tE0xi1BL1xr9wdBJDG+ZGaQCMHYlPmwaMtXOm0oDcf6DTyRwJgWuyoFL55ISAx6QNiNVFIw69Ba6VWwhABCxHEyGNG+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736312805; c=relaxed/simple;
	bh=a5sUMA/D4v8xrmTjaOb4KBK4NdcIVJWx4Sg++leGxjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUbnJhTyrvK1GNyRvuuNl6dIlra8xl2E6ZwX8bzIRvQCsgG07k6wG74WKM/ou0/I2zru07LLQJyCvnrjrCQN3QzJRwitEsRft4QidpZHEvEJFdQ7PVp1ke4o9n/JZjncUGm/d20hmYfozsI75DqlncctVcLM7pyC985yNb8iQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbfvx718; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so4047277241.1;
        Tue, 07 Jan 2025 21:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736312802; x=1736917602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuHUj4dIaDgAm9+h4UiMj4vEuRqX6naNBIjrtSVnTqo=;
        b=Wbfvx7185VoyxE5QP4EOHwKA3vDA87lVa0BtPvqX9nG8X/bCjoeACfrdaZXkzeiPv+
         GVOdzKAXl8XQ7RygsNfhTEv/6FSdX4Wpo1qyj+WOnN5CP6xQFzUe7qMxuUwLrybo3PjS
         ZCr8Rh4ys1BlvgPezv6k87bkn6KPS0opnPBBy94ZsXuqDJLbHrPyr0P1mG4GmSepAyt/
         tOs+esKJt6bwFmJsHShqng/Un/nQJmkGIiOd5IFq8etCBXW9bcZujWgCgh/L+CDa0fMZ
         KDleGWJSv8zo3mf/L2LgxcfnIbXJzv06mPgXJBDF2jTIr2swPZk1oJ4DFCzpzd0/qY5X
         5CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736312802; x=1736917602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuHUj4dIaDgAm9+h4UiMj4vEuRqX6naNBIjrtSVnTqo=;
        b=Wgjz4dYof1I99nRIEjIFe6hhkKbv8F/D3dK6kNuasJ9v2mVUMXQ+tk4ZPp84Zt/KEJ
         B3hg72RYEqKsNVE/2/llZwDThD/dO2kUI2G3WQfMYLL9gzokoGIYqjRlv7oYLUnWDlSQ
         KbHX10mQWfvkN0PsDhtVNvK6uQra2tqxdBvV8HCU0/ACrMqgSZXK9Hp5UWhn34T0NZAg
         RO2oLah+Esi1rz4hOKPVeBf9cnD/vlwGhnk/4xu9h8e/aefwzuZck+djdvK0DXv2Vzcj
         kUwXE3ClQ2UjWp0huGAbC5yjW3BN8tdTCyAz1Qpxd3HQWhot1KE+TlqfbDzlgwjMlmnz
         ci3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9w9CxyzX0i9PSAOJK7kvJN8kbQQG/eEDrCfRV2diCfH74hAfblCqjXTXYr5amaFt7N0z9yV0smXV3X1g=@vger.kernel.org, AJvYcCVcWE7FDigFXeTKX7+94hrDu8jIv8NsI6sUYW+mEzqBRj5nixfuX5bMO+acnDP5PHALdxfmgTWY@vger.kernel.org
X-Gm-Message-State: AOJu0YwvH9wJv/EY9vB9gnyoF0qYv64qt6zOAnfVvxDet57R8Mgy2Syz
	3bMbkF+HpmlUztDTCxiYecZJn8f+y/RqaTy4c7iZheU2wB17skPRZXgSlYLzxbckr8MGcAVIziZ
	7R1Qva3KHhHh0TFvss6sPq6ENOGU=
X-Gm-Gg: ASbGncswOLv2gdFzG5Mp4Az55FvQd3RG7AfmahV8IOUXXeftHHCGOZzh0S7gakKtzif
	HcER2UAAMqwYM1EnvDFLc+7J4hD9lbwrL3hs6MorkvRuCcDwWSk5anrULvwbfpcPtSx88fAA=
X-Google-Smtp-Source: AGHT+IHYkcgXVqBzp0wYwNKe0EAxYkg33lq3J3t749SzgatOZl9b7IA4Mdmzev4G/+1KqiLskIdTHphYBVcf5HHV20A=
X-Received: by 2002:a05:6102:2928:b0:4af:c31d:b4e8 with SMTP id
 ada2fe7eead31-4b3d0dd756emr1261673137.14.1736312802546; Tue, 07 Jan 2025
 21:06:42 -0800 (PST)
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
 <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com> <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
In-Reply-To: <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 8 Jan 2025 18:06:30 +1300
X-Gm-Features: AbW1kvYysiX0vlU67zpkRf7DvH5Z0lqmGE1f8gfsIHCYq6jHWED5sm2VnBKu7WU
Message-ID: <CAGsJ_4z-5bsKT_6byG9ms1Ycfm4XX0gZ2LcCW=jA-umsHO=6eg@mail.gmail.com>
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

On Wed, Jan 8, 2025 at 5:46=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Wed, Jan 8, 2025 at 9:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> >
> > Actually, using the mutex to protect against CPU hotunplug is not too
> > complicated. The following diff is one way to do it (lightly tested).
> > Johannes, Nhat, any preferences between this patch (disabling
> > migration) and the following diff?
>
> I mean if this works, this over migration diasbling any day? :)
>
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb236..4d6817c679a54 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
> > struct hlist_node *node)
> >         struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool=
, node);
> >         struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_=
ctx, cpu);
> >
> > +       mutex_lock(&acomp_ctx->mutex);
> >         if (!IS_ERR_OR_NULL(acomp_ctx)) {
> >                 if (!IS_ERR_OR_NULL(acomp_ctx->req))
> >                         acomp_request_free(acomp_ctx->req);
> > +               acomp_ctx->req =3D NULL;
> >                 if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
> >                         crypto_free_acomp(acomp_ctx->acomp);
> >                 kfree(acomp_ctx->buffer);
> >         }
> > +       mutex_unlock(&acomp_ctx->mutex);
> >
> >         return 0;
> >  }
> >
> > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
> > +               struct crypto_acomp_ctx __percpu *acomp_ctx)
> > +{
> > +       struct crypto_acomp_ctx *ctx;
> > +
> > +       for (;;) {
> > +               ctx =3D raw_cpu_ptr(acomp_ctx);
> > +               mutex_lock(&ctx->mutex);
>
> I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting this
> cpu-local data (including the mutex) from being invalidated under us
> while we're sleeping and waiting for the mutex?
>
> If it is somehow protected, then yeah this seems quite elegant :)

thought about this again. Could it be the following?

bool cpus_is_read_locked(void)
{
        return percpu_is_read_locked(&cpu_hotplug_lock);
}

in zswap:

bool locked =3D cpus_is_read_locked();

if (!locked)
     cpus_read_lock();

.... // do our job

if (!locked)
     cpus_read_unlock();

This seems to resolve all three problems:
1. if our context has held read lock, we won't hold it again;
2. if other contexts are holding write lock, we wait for the
completion of cpuhotplug
by acquiring read lock
3. if our context hasn't held a read lock, we hold it.

>
> > +               if (likely(ctx->req))
> > +                       return ctx;
> > +               /* Raced with zswap_cpu_comp_dead() on CPU hotunplug */
> > +               mutex_unlock(&ctx->mutex);
> > +       }
> > +}
> > +
> > +static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *ctx)
> > +{
> > +       mutex_unlock(&ctx->mutex);
> > +}
> > +
> >  static bool zswap_compress(struct page *page, struct zswap_entry *entr=
y,
> >                            struct zswap_pool *pool)
> >  {
> > @@ -893,10 +916,7 @@ static bool zswap_compress(struct page *page,
> > struct zswap_entry *entry,
> >         gfp_t gfp;
> >         u8 *dst;
> >
> > -       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> > -
> > -       mutex_lock(&acomp_ctx->mutex);
> > -
> > +       acomp_ctx =3D acomp_ctx_get_cpu_locked(pool->acomp_ctx);
> >         dst =3D acomp_ctx->buffer;
> >         sg_init_table(&input, 1);
> >         sg_set_page(&input, page, PAGE_SIZE, 0);
> > @@ -949,7 +969,7 @@ static bool zswap_compress(struct page *page,
> > struct zswap_entry *entry,
> >         else if (alloc_ret)
> >                 zswap_reject_alloc_fail++;
> >
> > -       mutex_unlock(&acomp_ctx->mutex);
> > +       acomp_ctx_put_unlock(acomp_ctx);
> >         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
> >  }
> >
> > @@ -960,9 +980,7 @@ static void zswap_decompress(struct zswap_entry
> > *entry, struct folio *folio)
> >         struct crypto_acomp_ctx *acomp_ctx;
> >         u8 *src;
> >
> > -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > -       mutex_lock(&acomp_ctx->mutex);
> > -
> > +       acomp_ctx =3D acomp_ctx_get_cpu_locked(entry->pool->acomp_ctx);
> >         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >         /*

Thanks
Barry

