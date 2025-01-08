Return-Path: <stable+bounces-107968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8003A052EC
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 06:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D2A1888150
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A61A23AA;
	Wed,  8 Jan 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isnsjp1B"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9318EB0
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736315777; cv=none; b=VEVfRSa0/jFYiLl2derKFvHmvCTDzPKCOJYOebU4B4kTld61J8SRel/KeKrEgwttOo3sdp1sgnYnaQZJQmdMuQHTJwsBOpJK8WUfnWGWGoCjfNgptEMLnonVFY2IoTNuruNiND2Hsn+cDZUTfwCXdV1UKeUfSNkGF2vk2NCJj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736315777; c=relaxed/simple;
	bh=c4bBjOuWzrvkNwTP1VjGb7Wd4uvaXYJ+KchQ2NzeJiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGlIsIt+GZW30y5azf2k6HKWBL856kYzjAcfZG8aNhF4ABPJdXo3jEbPu9GxTriqGFwygtpksmhjqXpP5ouHc2ZRpZRO7FkMM5ggZuW0zrm7jARuTdfLKXH3yG2QzYDyGliAVtfZuqpOM6x8ZsV72ZIteNXDkaXKbAYGhtHrECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isnsjp1B; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d91653e9d7so142848736d6.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 21:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736315775; x=1736920575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX/cnpkXYzxhGFAOz7+6qXIi6/SLArdxuHweSSCM17s=;
        b=isnsjp1BvXqxv6vRt4tk+TX5GA2VuopJ1XZyaqdAf8j1Dhh1A/p/wvuSA/DMnfvso6
         YbiWxm6IeHo33TR/9hCHG6vWgtY1z8gIlhZWr/J3KXw7lDLV4HuqjscUa27O5E3iQ9Uu
         HGwfOhPqZIz5Gn+yLTqk1pZfbDJ5RAIZnP8iKHmoX3FaT4uHBNW1/jQ2VynwVRotVNPy
         AMDvq3SQcaJUZsio2V0bo+elUhgCyEYhoij2U5TvBITBrNwTawyjMkNuIcjiFjvAoeMR
         5WAXNIUPiWptvJ5gUpgi7abIoxFWtv7EHUmy7GhPQ6orJ/vOKoP/MVBOxAhiabhbEupG
         AnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736315775; x=1736920575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX/cnpkXYzxhGFAOz7+6qXIi6/SLArdxuHweSSCM17s=;
        b=cZDuYNxCIuRshUagPiKfZrRWqFOIZ65YWH350ad3Iw3IU9c7+plTHSXd6sVrrlnoo2
         ORgiNLk34rCOzK4i0vfL0zHVFutc6i7xNrcbPyB1cSn+BmitqaCfILn4nj49uuYXY92K
         66m0JCG8B1UpOYksq2+NqKWKLcxLdHMLPLu8wJcpuDETCAoQQfutytmEewO68/mzl/kb
         +fKnfSTP9tunUMLg7kqOuMtWmDcU8zPL+NjrcaAAZaSM7itYAYAuLsG2r2EdJhxGKsPL
         pKU0/ccTi3xc2JY3++yQKOPtCUX7xB9er6kSLdw2G6uf3TOvfYEQth8jN8UvjH6Jaakc
         5WbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLOlVX3hbxqP6D/Cu3WTiseXuF96DAfvehree9BOKD3rL22wyqerul5N11gOrcfTfoPkMXTDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxe2H6BYa04OqE/pB7o7U67Kctqu6+/O/ApwF9l5HtVWIepvHA
	iQbGlow9uqfyYjwL3fvkGtl8MHq6+Fzo/5PTCXjaQyqHh+XAsFAHiFpHCjnC/TJevyW88iVmESk
	UDoE2qI2a7TTZtST+2cH1kGJ9gktzihATsTOl
X-Gm-Gg: ASbGnctr7C6Sc+bndrn84gP6XEP0V1CVIM7ecAkAGYMfUGVqKUtTYMxjeFL23V05JpR
	HTdxTGGGdL+0AtncVZo+ivY4mqqe7zzXP8/o=
X-Google-Smtp-Source: AGHT+IHOpR+lmzo2NW+3OlN9CS63bZTHb8o98pgQMbFH1CH9aK2p0ryiPkG+rmndPVeNjWJUUGSFeDoDt62tcK8AgvY=
X-Received: by 2002:a05:6214:c25:b0:6df:99e9:39b3 with SMTP id
 6a1803df08f44-6df9b1eebccmr29452826d6.15.1736315774580; Tue, 07 Jan 2025
 21:56:14 -0800 (PST)
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
In-Reply-To: <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 21:55:38 -0800
X-Gm-Features: AbW1kvZ1fMp-hR4rSSt6sFl8GDUeXhqcsXaUXMlCrVfqamXbhTq-mrU7nYcGw7M
Message-ID: <CAJD7tkbb1W_de-8nFfNif8LrkDsw6VnZyPowAt67xBpV5mL3sg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, 
	Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Jan 7, 2025 at 9:00=E2=80=AFPM Chengming Zhou <chengming.zhou@lin=
ux.dev> wrote:
> >
> > On 2025/1/8 12:46, Nhat Pham wrote:
> > > On Wed, Jan 8, 2025 at 9:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >>
> > >>
> > >> Actually, using the mutex to protect against CPU hotunplug is not to=
o
> > >> complicated. The following diff is one way to do it (lightly tested)=
.
> > >> Johannes, Nhat, any preferences between this patch (disabling
> > >> migration) and the following diff?
> > >
> > > I mean if this works, this over migration diasbling any day? :)
> > >
> > >>
> > >> diff --git a/mm/zswap.c b/mm/zswap.c
> > >> index f6316b66fb236..4d6817c679a54 100644
> > >> --- a/mm/zswap.c
> > >> +++ b/mm/zswap.c
> > >> @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int cp=
u,
> > >> struct hlist_node *node)
> > >>          struct zswap_pool *pool =3D hlist_entry(node, struct zswap_=
pool, node);
> > >>          struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->ac=
omp_ctx, cpu);
> > >>
> > >> +       mutex_lock(&acomp_ctx->mutex);
> > >>          if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > >>                  if (!IS_ERR_OR_NULL(acomp_ctx->req))
> > >>                          acomp_request_free(acomp_ctx->req);
> > >> +               acomp_ctx->req =3D NULL;
> > >>                  if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
> > >>                          crypto_free_acomp(acomp_ctx->acomp);
> > >>                  kfree(acomp_ctx->buffer);
> > >>          }
> > >> +       mutex_unlock(&acomp_ctx->mutex);
> > >>
> > >>          return 0;
> > >>   }
> > >>
> > >> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
> > >> +               struct crypto_acomp_ctx __percpu *acomp_ctx)
> > >> +{
> > >> +       struct crypto_acomp_ctx *ctx;
> > >> +
> > >> +       for (;;) {
> > >> +               ctx =3D raw_cpu_ptr(acomp_ctx);
> > >> +               mutex_lock(&ctx->mutex);
> > >
> > > I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting thi=
s
> > > cpu-local data (including the mutex) from being invalidated under us
> > > while we're sleeping and waiting for the mutex?
>
> Please correct me if I am wrong, but my understanding is that memory
> allocated with alloc_percpu() is allocated for each *possible* CPU,
> and does not go away when CPUs are offlined. We allocate the per-CPU
> crypto_acomp_ctx structs with alloc_percpu() (including the mutex), so
> they should not go away with CPU offlining.
>
> OTOH, we allocate the crypto_acomp_ctx.acompx, crypto_acomp_ctx.req,
> and crypto_acomp_ctx.buffer only for online CPUs through the CPU
> hotplug notifiers (i.e. zswap_cpu_comp_prepare() and
> zswap_cpu_comp_dead()). These are the resources that can go away with
> CPU offlining, and what we need to protect about.

..and now that I explain all of this I am wondering if the complexity
is warranted in the first place. It goes back all the way to the first
zswap commit, so I can't tell the justification for it.

I am not sure if they are setups that have significantly different
numbers of online and possible CPUs. Maybe we should just bite the
bullet and just allocate everything with alloc_percpu() and rip out
the hotplug callbacks completely.

