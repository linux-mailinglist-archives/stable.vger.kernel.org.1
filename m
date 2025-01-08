Return-Path: <stable+bounces-107959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7355A0524A
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 05:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A74167715
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2319F422;
	Wed,  8 Jan 2025 04:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiuJHq1T"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C452594A1;
	Wed,  8 Jan 2025 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736311591; cv=none; b=NovAivQpIFKvb6b6O25cr6UGJ7avKt820ewLQkVSuTMBAavnUb2oAw6bnlAMjsn9pQRhG/zPNCpzeGoRh81n351TeMg8WQxehXWyygWIDhQi0LjwZlFS8kxmuk6MLHCdBHEY1CDbfHIb/7c+vdDmm2NI7RJyAXbP4CCdThGmkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736311591; c=relaxed/simple;
	bh=Zas+KKKicXlYLW28Mo8TrgxUH+kwaXAClBuswoW/7U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKxxaqKZM5wilyWQrIB8+qAfRjjlp0+eld2J2uj5vRT1SmjdDu9jztET9TO6RglPAKryo9RmqoHkRZtDjGonR5VaBcz8APIkSGw7XX0i7TcUBNFP7iWjOmXD2ibpSi6FX/h120nm7Q22SuF5vn/YtzQYkzSB21I4/0wcpuT4O3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiuJHq1T; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d88cb85987so3940406d6.1;
        Tue, 07 Jan 2025 20:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736311586; x=1736916386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0txkfgI9AJsEq1JrW9TzpGg0crvaiB+q5j6F36VQt4=;
        b=hiuJHq1TxU/QHtxO6xFdZ+osMSw8JW/lXXrCfKadL41dxQsMpdyXorb3zJT1aNR837
         wm0E0GNffVg25tDbsHRqigSJs1FKfCDbv5vzFhz9EzET/bo6LWqrzPXTC8zKzaWE0bA5
         2WVFA/27g6UXQSFSngMYS9QSdMvNEf2qzgG7YB8mYbIhEPCYKGCIKdMDvsvr0VDGNROI
         U4MpO1jTkOsgWoqL4n5iKkcmxwNzq7ho4lvtQ6qu3pQwpfvi7er9XY97dsSW6Kr8AbCh
         tWle38rx1+eOou+D8Ta4qH+eFyXT199w0MYTyiBLDBNdUAkkRnaHlEPDhcD6eLCO1fyF
         tRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736311586; x=1736916386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0txkfgI9AJsEq1JrW9TzpGg0crvaiB+q5j6F36VQt4=;
        b=iVxHsjigHLE7X+0mVd/UfWewJcLuZbhJUX78HjUvjYkWizOBm02arjJ1FHVWmO9jU6
         60Rg92TTKORgZVsWTWiLoschZn4HA2/w0yJX0W0GClQ63LYU2060uk+yvOvWrEVbeAEn
         HwZjaWTgls5Hf5hr6h4tcHtGg7cdDJT1znuRFn9iAVz/3wE6+0N6Y783i79CIGE/ST2d
         Ywsj84JkHbbWt2UvPKf6QWpu8EXZlqDGvcblc/eP5Xn89SHuHNdFI/XDYf0XtgCc7PWU
         /EId6+fI2VJX/b+E9mp1nJ8bZt99jUc611o+qeX4EZS8ftK9GmOSs+jpVTMhPlHosdMg
         Pmeg==
X-Forwarded-Encrypted: i=1; AJvYcCVW22cP5gbYZqa/V6xcBqpmBl5j89eCp9F1VS8YLr+xl02H+9PdZCEiZaoe6YYWGPu71qgizvQterwOIzI=@vger.kernel.org, AJvYcCVgO1uzaoKvoZgnh05hiEa2uwP610jaXuJVwhsuKAWp/C71/u7518gps2HiAk+FnCk5nMzuDKQz@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnua/ZA9IYbOdnDtfHS1AywIcWdx4YxElMM5lJqjjQTdsT1Nt
	zKBpQ37zQ4gl3Sg9zL8v6FxKVnFQ1n5L5SiLPryOH3p8ZTQG8YoKiEmRj5S/YpSZSyqrQOYXHiF
	DVobDKR5YeXogEyBoCPB2trJjcA0=
X-Gm-Gg: ASbGncuxVbFWKrxQhb+BdrtvLhFG5reNIlRnb9PZtV3CKfYZPHbqPHrUwWaReWCXWGf
	noS8p51c9JeDtnoCIlGvJq6hplsepEPXPj1Bd
X-Google-Smtp-Source: AGHT+IHAQdqL/GTBeXVY+2EWvbKlLawyuDlpqI4nGD3mQhFRgA4FaKQB9Q71tvt75HPNSRSieYvjp0XGIN2EKLGo/mA=
X-Received: by 2002:a05:6214:2486:b0:6d9:fb5:d496 with SMTP id
 6a1803df08f44-6df8e8d1ae4mr87631926d6.24.1736311586135; Tue, 07 Jan 2025
 20:46:26 -0800 (PST)
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
 <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com> <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com>
In-Reply-To: <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Jan 2025 11:46:15 +0700
X-Gm-Features: AbW1kvYHb_YsdnZTSLhSana6IE6_ivYCzIum3MAvTcDMPEBXvWdB2wN5-L0Q7ZA
Message-ID: <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 9:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
>
> Actually, using the mutex to protect against CPU hotunplug is not too
> complicated. The following diff is one way to do it (lightly tested).
> Johannes, Nhat, any preferences between this patch (disabling
> migration) and the following diff?

I mean if this works, this over migration diasbling any day? :)

>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb236..4d6817c679a54 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
> struct hlist_node *node)
>         struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, =
node);
>         struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ct=
x, cpu);
>
> +       mutex_lock(&acomp_ctx->mutex);
>         if (!IS_ERR_OR_NULL(acomp_ctx)) {
>                 if (!IS_ERR_OR_NULL(acomp_ctx->req))
>                         acomp_request_free(acomp_ctx->req);
> +               acomp_ctx->req =3D NULL;
>                 if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
>                         crypto_free_acomp(acomp_ctx->acomp);
>                 kfree(acomp_ctx->buffer);
>         }
> +       mutex_unlock(&acomp_ctx->mutex);
>
>         return 0;
>  }
>
> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
> +               struct crypto_acomp_ctx __percpu *acomp_ctx)
> +{
> +       struct crypto_acomp_ctx *ctx;
> +
> +       for (;;) {
> +               ctx =3D raw_cpu_ptr(acomp_ctx);
> +               mutex_lock(&ctx->mutex);

I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting this
cpu-local data (including the mutex) from being invalidated under us
while we're sleeping and waiting for the mutex?

If it is somehow protected, then yeah this seems quite elegant :)

> +               if (likely(ctx->req))
> +                       return ctx;
> +               /* Raced with zswap_cpu_comp_dead() on CPU hotunplug */
> +               mutex_unlock(&ctx->mutex);
> +       }
> +}
> +
> +static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *ctx)
> +{
> +       mutex_unlock(&ctx->mutex);
> +}
> +
>  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>                            struct zswap_pool *pool)
>  {
> @@ -893,10 +916,7 @@ static bool zswap_compress(struct page *page,
> struct zswap_entry *entry,
>         gfp_t gfp;
>         u8 *dst;
>
> -       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> -
> -       mutex_lock(&acomp_ctx->mutex);
> -
> +       acomp_ctx =3D acomp_ctx_get_cpu_locked(pool->acomp_ctx);
>         dst =3D acomp_ctx->buffer;
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
> @@ -949,7 +969,7 @@ static bool zswap_compress(struct page *page,
> struct zswap_entry *entry,
>         else if (alloc_ret)
>                 zswap_reject_alloc_fail++;
>
> -       mutex_unlock(&acomp_ctx->mutex);
> +       acomp_ctx_put_unlock(acomp_ctx);
>         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
>  }
>
> @@ -960,9 +980,7 @@ static void zswap_decompress(struct zswap_entry
> *entry, struct folio *folio)
>         struct crypto_acomp_ctx *acomp_ctx;
>         u8 *src;
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(&acomp_ctx->mutex);
> -
> +       acomp_ctx =3D acomp_ctx_get_cpu_locked(entry->pool->acomp_ctx);
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         /*

