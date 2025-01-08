Return-Path: <stable+bounces-108014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298FEA06065
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA64A7A1C2D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD01FE47E;
	Wed,  8 Jan 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="11w/bypi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64422199385
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350618; cv=none; b=rt2KIhN1UFm8M08GhvbW1WRpK25S50VwrrPKJiNFVfgAas6Bj0+SMzxi4NBrNWyJ/OmMZwAvP0rS2opRT2w1orr2Hfoxpd0FbUulTcSdCsd2ot3CkhniSt55Dh3ffllFCfdgVOazOghHaNDn5mOPPWNjsj4cqeiOWKURbxdfFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350618; c=relaxed/simple;
	bh=yzcOUYVz6NMtgg8QpuiF2adYF/1cKfRxCp+sST9w8Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHCEHwhU2uHQB5oJuMrJ6a8fH3CqqXPW4Dk5C9z6Pp27sehNpNWEYnF7wzk8AmJBfmo6Vm21RMXR6wMqS0Ou0YsEOcQ0fCVp2/9YhaJqVG7Xr1BAZFj+e29iLyl5dvKhxsV10z3Y9GpoCLLq6JJ9AdI0WuSehVdIB1SsrVsytJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=11w/bypi; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679eacf25cso93315731cf.3
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736350615; x=1736955415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axQHKpC6dD7D4GwLmKC298J+SeI1ebHuNyZt1l3JX/0=;
        b=11w/bypiy+p4vU2xebRv6TOuz55B/2wL2Fb4ubvFexhFAZLJJxstpWZUFs7qPmkemu
         apH1KqMMVrK6/0m8fP3Kdy0oFPYg7cpOb0NPiXbjQyoB30+NTWrHAUUzgbFnxNDXK93u
         d6eUJadu6es70sTG3vjwUd+Xe5GxDMb7iyPnz7ZBjYOeH01dPfeu10InvCNMs7bWV5/x
         7sQJEUU4DkoGJ05HxfY8jxc9QThMYzHVSUpZXX0Sp5EeBDKAz6uyTF+eSvl9wW3L4bkb
         EyuEVhUviE1DBX9VtA6xH0fLIJeRoM0roszuwe0uTh9WeKhLeUBsUM6FklEtvNJkRJlJ
         xX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736350615; x=1736955415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axQHKpC6dD7D4GwLmKC298J+SeI1ebHuNyZt1l3JX/0=;
        b=PsCe6Oi6WLcF/i8bNG/uG9hoqr4Y+QKP5qePjT6mTGA+9aksfKgqwVINhkb5U1Ca3r
         ZouBF+PJl1jZblifXLDVZQFICxhM2gv24xOg6KdkH59TxGNT/LoiM5WRpGmGVHey5Rnp
         V/RJXtUNfy94X7tgqZ3WeB+mdQkefhoGy6+kYdEAs/6X9kV64N3xg32mt9m0fRKinDG2
         yczxSpJsxflbb8Gmc35psNQ/SpTb+Rre3Ma2+xYDxgGNHF/wFhx3o52iMRvxz4Eklimz
         0wBYQhHsgXCCQwCk8EO6qzbLXS66fu0XFkLzAGifCawvHQjOY+5Coo493sofmUlZLsbU
         XLww==
X-Forwarded-Encrypted: i=1; AJvYcCXLVMRsxjTnqBEt0MuWKdnldtlPOH1h2H6jtq3IaZLnbUsPurBpfhS8KuU7iuI0VHx8jyW0ZTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKLCynBPe1tcu1QaK5fwbItmmsZ1wUQaMoSb/WE+Ljxm5YTsc
	Wqk2ulTqeHHTmM88Ff6Dd3B0swiQJLhLVaAWUxVxrBLKKPX09p6hpA8NNmLfHB+nOulOxRuDIzh
	DhWjBEq5Ik9pXFleVuEIYJzEmlBLCpx0pqs8p
X-Gm-Gg: ASbGncuIEHJtpkCsw6XTIiuHJa6FT04Zrhq6yVcZQO23ZiNlCxtYHPAwcnmaZz9a+p6
	A8YPhF+ZxDzlYxfnpL60pgNfa+bWTA5FyUWQ=
X-Google-Smtp-Source: AGHT+IHE30RdvHFwHrl8DYNVDwiHIEwA6KNtLh6e615xOvu6roP1M8aszxEP2FT6kKhU7XY6R/omU63DFXee33mPD48=
X-Received: by 2002:a05:6214:1313:b0:6d8:a7f7:c3a1 with SMTP id
 6a1803df08f44-6df9b2e71afmr50749576d6.40.1736350614534; Wed, 08 Jan 2025
 07:36:54 -0800 (PST)
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
 <CAJD7tkbb1W_de-8nFfNif8LrkDsw6VnZyPowAt67xBpV5mL3sg@mail.gmail.com> <CAGsJ_4y=kP1yhnpDmpTgs-6Dj1OEHJYOOuHo7ia3TjNq+JRYSw@mail.gmail.com>
In-Reply-To: <CAGsJ_4y=kP1yhnpDmpTgs-6Dj1OEHJYOOuHo7ia3TjNq+JRYSw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 8 Jan 2025 07:36:17 -0800
X-Gm-Features: AbW1kvaG4--WHdAxY2l6bGR_njCr75NcnNoIpCKSzpY1SUWHqWRh9wna1Yl5_WY
Message-ID: <CAJD7tkadoYEvCPx6wARTBDseWmroym=H8L60MPgbF5JJX+9OSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Barry Song <21cnbao@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 11:57=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Jan 8, 2025 at 6:56=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Tue, Jan 7, 2025 at 9:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > On Tue, Jan 7, 2025 at 9:00=E2=80=AFPM Chengming Zhou <chengming.zhou=
@linux.dev> wrote:
> > > >
> > > > On 2025/1/8 12:46, Nhat Pham wrote:
> > > > > On Wed, Jan 8, 2025 at 9:34=E2=80=AFAM Yosry Ahmed <yosryahmed@go=
ogle.com> wrote:
> > > > >>
> > > > >>
> > > > >> Actually, using the mutex to protect against CPU hotunplug is no=
t too
> > > > >> complicated. The following diff is one way to do it (lightly tes=
ted).
> > > > >> Johannes, Nhat, any preferences between this patch (disabling
> > > > >> migration) and the following diff?
> > > > >
> > > > > I mean if this works, this over migration diasbling any day? :)
> > > > >
> > > > >>
> > > > >> diff --git a/mm/zswap.c b/mm/zswap.c
> > > > >> index f6316b66fb236..4d6817c679a54 100644
> > > > >> --- a/mm/zswap.c
> > > > >> +++ b/mm/zswap.c
> > > > >> @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned in=
t cpu,
> > > > >> struct hlist_node *node)
> > > > >>          struct zswap_pool *pool =3D hlist_entry(node, struct zs=
wap_pool, node);
> > > > >>          struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool=
->acomp_ctx, cpu);
> > > > >>
> > > > >> +       mutex_lock(&acomp_ctx->mutex);
> > > > >>          if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > > > >>                  if (!IS_ERR_OR_NULL(acomp_ctx->req))
> > > > >>                          acomp_request_free(acomp_ctx->req);
> > > > >> +               acomp_ctx->req =3D NULL;
> > > > >>                  if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
> > > > >>                          crypto_free_acomp(acomp_ctx->acomp);
> > > > >>                  kfree(acomp_ctx->buffer);
> > > > >>          }
> > > > >> +       mutex_unlock(&acomp_ctx->mutex);
> > > > >>
> > > > >>          return 0;
> > > > >>   }
> > > > >>
> > > > >> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
> > > > >> +               struct crypto_acomp_ctx __percpu *acomp_ctx)
> > > > >> +{
> > > > >> +       struct crypto_acomp_ctx *ctx;
> > > > >> +
> > > > >> +       for (;;) {
> > > > >> +               ctx =3D raw_cpu_ptr(acomp_ctx);
> > > > >> +               mutex_lock(&ctx->mutex);
> > > > >
> > > > > I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting=
 this
> > > > > cpu-local data (including the mutex) from being invalidated under=
 us
> > > > > while we're sleeping and waiting for the mutex?
> > >
> > > Please correct me if I am wrong, but my understanding is that memory
> > > allocated with alloc_percpu() is allocated for each *possible* CPU,
> > > and does not go away when CPUs are offlined. We allocate the per-CPU
> > > crypto_acomp_ctx structs with alloc_percpu() (including the mutex), s=
o
> > > they should not go away with CPU offlining.
> > >
> > > OTOH, we allocate the crypto_acomp_ctx.acompx, crypto_acomp_ctx.req,
> > > and crypto_acomp_ctx.buffer only for online CPUs through the CPU
> > > hotplug notifiers (i.e. zswap_cpu_comp_prepare() and
> > > zswap_cpu_comp_dead()). These are the resources that can go away with
> > > CPU offlining, and what we need to protect about.
> >
> > ..and now that I explain all of this I am wondering if the complexity
> > is warranted in the first place. It goes back all the way to the first
> > zswap commit, so I can't tell the justification for it.
>
> Personally, I would vote for the added complexity, as it avoids the
> potential negative side effects of reverting the scheduler's optimization
> for selecting a suitable CPU for a woken-up task and I have been looking
> for an approach to resolve it by cpuhotplug lock (obviously quite hacky
> and more complex than using this mutex)

Oh, I was not talking about my proposed diff, but the existing logic
that allocates the requests and buffers in the hotplug callbacks
instead of just using alloc_percpu() to allocate them once for each
possible CPU. I was wondering if there are actual setups where this
matters and a significant amount of memory is being saved. Otherwise
we should simplify things and just rip out the hotplug callbacks.

Anyway, for now I will cleanup and send the mutex diff as a new patch.

>
> for (;;)  in acomp_ctx_get_cpu_locked() is a bit tricky but correct and
> really interesting, maybe it needs some comments.
>
> >
> > I am not sure if they are setups that have significantly different
> > numbers of online and possible CPUs. Maybe we should just bite the
> > bullet and just allocate everything with alloc_percpu() and rip out
> > the hotplug callbacks completely.
>
> Thanks
> Barry

