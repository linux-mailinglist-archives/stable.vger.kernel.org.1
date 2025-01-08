Return-Path: <stable+bounces-107974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D8DA054DD
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 08:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981471631E9
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318231ACEAF;
	Wed,  8 Jan 2025 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp3d7JkC"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8B1A83F9;
	Wed,  8 Jan 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323027; cv=none; b=DJpOQZJrEuecQoG9qJ8/C3zdQGFDl9RBxghjuSU4YYfYMGg+/4kQq6E9pTgVcwINOPnPzrxkqyaCOPyXdf9HGFvM80KF5A6+UIHdFuGmsUAyHPeucP7wLCgbb/JDgBCcMnQpI9X35xIUCT5uvcGS/FUpP7kEWLDJDVJRGHq+XlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323027; c=relaxed/simple;
	bh=gxOj/DoYoxlI1ScXJOrYyHXTcN+QUEIU0FYHoLGjBQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCaWdUhCGV0kFkL/VfPJWhCDTQzFdelk2hG9T7T+/oWf3zq90DSYl0jz7x3LJBzUtVt65q9eCPBazjAo6AtdljXUmfZD21lOA5uokrhccJnkmLIA9zCrrzvn+7TZUNW3yQH2vd0VDaeTeynbQ2vStsknrsnekOZH4386vqylTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp3d7JkC; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51889930cb1so4888277e0c.0;
        Tue, 07 Jan 2025 23:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736323024; x=1736927824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/nHnofGguTdw1vKNltVZXYt+IFuV4avQDVGGoRKljI=;
        b=Xp3d7JkCvTNheUxMhxEA/lfURPwWWn15QfmVgejD7XbJqTT+YXNFB6DvIhcWer10cS
         zdpsxFxX5Dbs8T0YH5KeLRlsxzLtsToXE7YIWwJYXEptqYDseeklTTb5660BQQcyCIJ2
         nitb+PmijYPfSoKUZ1rWH+QJHBQl1q5vsCpArykRaEp3jO7pFvPWpSdyVEw75DLEeqrn
         Hw3np8nQsGrz+YucirD4kyI4W3ADMY0m9/BDRdvYezUkauwhUuLjP/8lbPAIhO6bw6YI
         uQRsj6ACbXYwYzMKzq7xxATdmY1cW8vA2vif3E9ne7yzvASotmgnp21R5FSamONDoOfX
         jkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736323024; x=1736927824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/nHnofGguTdw1vKNltVZXYt+IFuV4avQDVGGoRKljI=;
        b=VNfbe5fxYwQrUUFTX5qljg1AsjqfxpIu+i8Pqa/Utq0YNlr/ZbdlWkeIj26E00l4jU
         WwdOUbqWVk5/JNTzkjGMr5gh5iqmulqwGC4zL239Rjkpnss7P1sBXxtaR2ugzW+zAlDW
         CyMDix2s1v+/mZSHHMsPzeoBPXrvIqHqohZL8Ihk1rEqGNyqkPEyhqXWkfRia3KEgXy7
         601wjyHlaG12fAz7fWGK3o8a6dQXMDDmycIR0QSe4cQndnXDAZoRXuw3UGCA2sJG3M3g
         6fGnvKAbHvcMnUo7/tUtJKPF7jKXgFcUDoXNjrPbhW9mLOalUDLy9Z1zrcJLWwjB6bEM
         MH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7arlCYh1UWSL3Kz0CwbwEvPzQkLD3tAEImzwqo/VLnn9f5yk6MsegKVtE4RgrysQrNexHWbcPb5K6q3c=@vger.kernel.org, AJvYcCWowPYCMzoVLs3bWs9fcTD5c6brH6ovE5a9vVmiR/PgR4Gg6m5h/oHcd+vtK1koxrnB6OH06yso@vger.kernel.org
X-Gm-Message-State: AOJu0YyX4CTdXP4BcrjWrQRJYccta0VGCQWp9tfq+50V7K1BRI53Kpjv
	DXDSdm+7VCZdXb4bpqd9+kMIG7jv7Jt6VnXZsUOlPm5L892Y9SUJfQcRjve18I05t30uxRoYnHX
	YAfv0ozWGl4P3TrGf0+5NHJToDBU=
X-Gm-Gg: ASbGncvEg9Ldblm9HKID9bExSaWzVoRzCzXJbC3R+pkwW7un7a3u0FgZdfwa4JcBam/
	MxtdV7I/+HkhDUHcNHOcKTIHAHz0ZbXfWFILa3xkaMAl1MC09y00q0yLvmo2GWtCUJ7F0L/4=
X-Google-Smtp-Source: AGHT+IGZ4rOtpqULk68Q3nCTHxwHuIitpr1OfmuohtzOigKXbQHtcmvCd8bnLU+jwku/h+ElLq2/bLl4t6D7H+zvLmU=
X-Received: by 2002:a05:6122:65a9:b0:518:859e:87ae with SMTP id
 71dfb90a1353d-51c6c52475cmr981935e0c.7.1736323024103; Tue, 07 Jan 2025
 23:57:04 -0800 (PST)
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
 <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
 <857acdc4-c4b7-44ea-a67d-2df83ca245ed@linux.dev> <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
 <CAJD7tkbb1W_de-8nFfNif8LrkDsw6VnZyPowAt67xBpV5mL3sg@mail.gmail.com>
In-Reply-To: <CAJD7tkbb1W_de-8nFfNif8LrkDsw6VnZyPowAt67xBpV5mL3sg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 8 Jan 2025 20:56:53 +1300
X-Gm-Features: AbW1kvYw-nDepavtTjSsXdMYyty0f6u5kWTpv8EjrnwJ3-Z4CLaYVGPblrfy7tw
Message-ID: <CAGsJ_4y=kP1yhnpDmpTgs-6Dj1OEHJYOOuHo7ia3TjNq+JRYSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 6:56=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Jan 7, 2025 at 9:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Tue, Jan 7, 2025 at 9:00=E2=80=AFPM Chengming Zhou <chengming.zhou@l=
inux.dev> wrote:
> > >
> > > On 2025/1/8 12:46, Nhat Pham wrote:
> > > > On Wed, Jan 8, 2025 at 9:34=E2=80=AFAM Yosry Ahmed <yosryahmed@goog=
le.com> wrote:
> > > >>
> > > >>
> > > >> Actually, using the mutex to protect against CPU hotunplug is not =
too
> > > >> complicated. The following diff is one way to do it (lightly teste=
d).
> > > >> Johannes, Nhat, any preferences between this patch (disabling
> > > >> migration) and the following diff?
> > > >
> > > > I mean if this works, this over migration diasbling any day? :)
> > > >
> > > >>
> > > >> diff --git a/mm/zswap.c b/mm/zswap.c
> > > >> index f6316b66fb236..4d6817c679a54 100644
> > > >> --- a/mm/zswap.c
> > > >> +++ b/mm/zswap.c
> > > >> @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int =
cpu,
> > > >> struct hlist_node *node)
> > > >>          struct zswap_pool *pool =3D hlist_entry(node, struct zswa=
p_pool, node);
> > > >>          struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->=
acomp_ctx, cpu);
> > > >>
> > > >> +       mutex_lock(&acomp_ctx->mutex);
> > > >>          if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > > >>                  if (!IS_ERR_OR_NULL(acomp_ctx->req))
> > > >>                          acomp_request_free(acomp_ctx->req);
> > > >> +               acomp_ctx->req =3D NULL;
> > > >>                  if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
> > > >>                          crypto_free_acomp(acomp_ctx->acomp);
> > > >>                  kfree(acomp_ctx->buffer);
> > > >>          }
> > > >> +       mutex_unlock(&acomp_ctx->mutex);
> > > >>
> > > >>          return 0;
> > > >>   }
> > > >>
> > > >> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
> > > >> +               struct crypto_acomp_ctx __percpu *acomp_ctx)
> > > >> +{
> > > >> +       struct crypto_acomp_ctx *ctx;
> > > >> +
> > > >> +       for (;;) {
> > > >> +               ctx =3D raw_cpu_ptr(acomp_ctx);
> > > >> +               mutex_lock(&ctx->mutex);
> > > >
> > > > I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting t=
his
> > > > cpu-local data (including the mutex) from being invalidated under u=
s
> > > > while we're sleeping and waiting for the mutex?
> >
> > Please correct me if I am wrong, but my understanding is that memory
> > allocated with alloc_percpu() is allocated for each *possible* CPU,
> > and does not go away when CPUs are offlined. We allocate the per-CPU
> > crypto_acomp_ctx structs with alloc_percpu() (including the mutex), so
> > they should not go away with CPU offlining.
> >
> > OTOH, we allocate the crypto_acomp_ctx.acompx, crypto_acomp_ctx.req,
> > and crypto_acomp_ctx.buffer only for online CPUs through the CPU
> > hotplug notifiers (i.e. zswap_cpu_comp_prepare() and
> > zswap_cpu_comp_dead()). These are the resources that can go away with
> > CPU offlining, and what we need to protect about.
>
> ..and now that I explain all of this I am wondering if the complexity
> is warranted in the first place. It goes back all the way to the first
> zswap commit, so I can't tell the justification for it.

Personally, I would vote for the added complexity, as it avoids the
potential negative side effects of reverting the scheduler's optimization
for selecting a suitable CPU for a woken-up task and I have been looking
for an approach to resolve it by cpuhotplug lock (obviously quite hacky
and more complex than using this mutex)

for (;;)  in acomp_ctx_get_cpu_locked() is a bit tricky but correct and
really interesting, maybe it needs some comments.

>
> I am not sure if they are setups that have significantly different
> numbers of online and possible CPUs. Maybe we should just bite the
> bullet and just allocate everything with alloc_percpu() and rip out
> the hotplug callbacks completely.

Thanks
Barry

