Return-Path: <stable+bounces-107967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E15A052A9
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 06:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E76A166135
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 05:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D031A8400;
	Wed,  8 Jan 2025 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jF7HVkl9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE711A726B
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314494; cv=none; b=fAIS6OPGQ+MVdwSD4B+MOTa+y6QB07/bqV7utIOI45yMyLBb97pKiYdHG+JxDmjvzcl+UtpBcnmdFxlrjgpg23pyDjXqL2c8Ua+t/8j14auqq2kweNC69CddNdH7NVoNrecLaYm13maaibotbfVbsz8X0idbeL6ZJfKrjIVlgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314494; c=relaxed/simple;
	bh=ve+T+ZYfWiA6+4yW2k03bpUQfBwdOnw79/sPkA1TVeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSDnfyln3h1U0YSlcvXvtGIbQfWGTDm9S7+ku7YXYrd7ge7eujbIE3beE7zAIvA8UmFX/FTICDkcxsd5UA7tsPWV5iY5RN9niRo0j2bg9go+VL65Dnd0ofJ6/mItmGhuYcdIZf8KiY4ZNXJTeFrSs1xkyhMTCYWn7SPlFBetvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jF7HVkl9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd0d09215aso130075526d6.2
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 21:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736314492; x=1736919292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGGTpbai52pQZ2nEPdY6iTgX2oG72nzLWb46afIeUik=;
        b=jF7HVkl9PLfSbaOEsibaTP2CdZKZvLb6emTOXgcshibmQ4cXBOV35li5pcIuO7nOPO
         SbNo3/p+4ZiyFmZwrFVxcD9Y0ZyKaUZ4UWzEqLQxT33KKIIzKWQ/7If/4WJ8niWVKPh6
         qCOOUGTbH4L4cYnxUfYviHljfnbk3v/crVNoLOv+16tW45ATi+XsMyN3PgA/5/L8zIIa
         pH+IixD7BZK9KGh33GSfdDHBCdNqbpBXyVIJS+xXxZhmtEUiQNgF7ycVJMo1AFXw7xvr
         72UXne0locRptJE5mZq89drbPBKjKYVm1xWxjzu/1vpdPFVPseI35fIUzDbv0GwKF9zl
         0iUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314492; x=1736919292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGGTpbai52pQZ2nEPdY6iTgX2oG72nzLWb46afIeUik=;
        b=nJE7UQ6Ul933FuTE5B8rJfl5kk9d1HbwFgSyRAyl9cy324JIy80VKroL7nDy1maFfw
         PNYIiNKESTo9Ne1KgnnoScrG/qpmS7tpgYQaNUoJO1N1c5OfMGrU3TvlPk3bxkxMa+x8
         qt7+l7YJb/TgF26hSsqUYbd2+yUMftDPkZzCrBL8KE2kcsq+X01Bbp/E/wMN+/UXoW5y
         C8HxsUgoV3ZwM5JpqGCBIMxxOTUflP/UyGoCWckxjIxchVgq8IDMt30WbY6MJyUDg6IH
         XWBT85Ikr9Jsrnp8UsXtR+g5AhnmTYqbiA01HHOQAK8s5Vz6dU/vb/UnkRH9keSsR1SS
         LhWw==
X-Forwarded-Encrypted: i=1; AJvYcCVIOtS/AfB1QA+neLUg66xTwafqj8i/c4N/q8Pyg2lxu2mT8ps5nhB5XT+m85qNOYcHRnl0/kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUY7vC6EObijqUGi0sqWQOrIPWsmA3Ly++28fcbHpp5Kkcz0mk
	2BHnRSnrhOjY3tIFU2iti+73aORZU0zZk54joTMdjx7TiC3hSUgf3dNQyhC7KAC+JILEb/DxWCU
	+GnxQwAcVFBVI/d5Vc8OLoazM7tD6p+M96+Ej
X-Gm-Gg: ASbGnctS82ytYP0J06HmZwx2CUJ3d2VTxOJGxelSkonAAYqSHLS75tMnjxAlPqPosNw
	hZqmuKUWbzUjgP7+RsFIHQfAcVAThvD1Ds4k=
X-Google-Smtp-Source: AGHT+IEpGa22i1VWzWBqEUP7CYJT6s+0vIGD0eCOK6ljUBlWUp59HTcAocd/QJCSOpwC9GUWBBt7NGz3fuW/ofcDVAY=
X-Received: by 2002:ad4:5bcc:0:b0:6d8:a9dc:5a65 with SMTP id
 6a1803df08f44-6df9b32b347mr23989286d6.45.1736314491553; Tue, 07 Jan 2025
 21:34:51 -0800 (PST)
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
 <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com> <857acdc4-c4b7-44ea-a67d-2df83ca245ed@linux.dev>
In-Reply-To: <857acdc4-c4b7-44ea-a67d-2df83ca245ed@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 21:34:15 -0800
X-Gm-Features: AbW1kvbuH4zFO1DrM-8N0ej8AsO7sS4UchNazjpirfR1-uGUBsBqYVkPxlt_Tt0
Message-ID: <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
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

On Tue, Jan 7, 2025 at 9:00=E2=80=AFPM Chengming Zhou <chengming.zhou@linux=
.dev> wrote:
>
> On 2025/1/8 12:46, Nhat Pham wrote:
> > On Wed, Jan 8, 2025 at 9:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >>
> >>
> >> Actually, using the mutex to protect against CPU hotunplug is not too
> >> complicated. The following diff is one way to do it (lightly tested).
> >> Johannes, Nhat, any preferences between this patch (disabling
> >> migration) and the following diff?
> >
> > I mean if this works, this over migration diasbling any day? :)
> >
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index f6316b66fb236..4d6817c679a54 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
> >> struct hlist_node *node)
> >>          struct zswap_pool *pool =3D hlist_entry(node, struct zswap_po=
ol, node);
> >>          struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acom=
p_ctx, cpu);
> >>
> >> +       mutex_lock(&acomp_ctx->mutex);
> >>          if (!IS_ERR_OR_NULL(acomp_ctx)) {
> >>                  if (!IS_ERR_OR_NULL(acomp_ctx->req))
> >>                          acomp_request_free(acomp_ctx->req);
> >> +               acomp_ctx->req =3D NULL;
> >>                  if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
> >>                          crypto_free_acomp(acomp_ctx->acomp);
> >>                  kfree(acomp_ctx->buffer);
> >>          }
> >> +       mutex_unlock(&acomp_ctx->mutex);
> >>
> >>          return 0;
> >>   }
> >>
> >> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
> >> +               struct crypto_acomp_ctx __percpu *acomp_ctx)
> >> +{
> >> +       struct crypto_acomp_ctx *ctx;
> >> +
> >> +       for (;;) {
> >> +               ctx =3D raw_cpu_ptr(acomp_ctx);
> >> +               mutex_lock(&ctx->mutex);
> >
> > I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting this
> > cpu-local data (including the mutex) from being invalidated under us
> > while we're sleeping and waiting for the mutex?

Please correct me if I am wrong, but my understanding is that memory
allocated with alloc_percpu() is allocated for each *possible* CPU,
and does not go away when CPUs are offlined. We allocate the per-CPU
crypto_acomp_ctx structs with alloc_percpu() (including the mutex), so
they should not go away with CPU offlining.

OTOH, we allocate the crypto_acomp_ctx.acompx, crypto_acomp_ctx.req,
and crypto_acomp_ctx.buffer only for online CPUs through the CPU
hotplug notifiers (i.e. zswap_cpu_comp_prepare() and
zswap_cpu_comp_dead()). These are the resources that can go away with
CPU offlining, and what we need to protect about.

The approach I am taking here is to hold the per-CPU mutex in the CPU
offlining code while we free these resources, and set
crypto_acomp_ctx.req to NULL. In acomp_ctx_get_cpu_locked(), we hold
the mutex of the current CPU, and check if crypto_acomp_ctx.req is
NULL.

If it is NULL, then the CPU is offlined between raw_cpu_ptr() and
acquiring the mutex, and we retry on the new CPU that we end up on. If
it is not NULL, then we are guaranteed that the resources will not be
freed by CPU offlining until acomp_ctx_put_unlock() is called and the
mutex is unlocked.

>
> Yeah, it's not safe, we can only use this_cpu_ptr(), which will disable
> preempt (so cpu offline can't kick in), and get refcount of ctx. Since
> we can't mutex_lock in the preempt disabled section.

My understanding is that the purpose of this_cpu_ptr() disabling
preemption is to prevent multiple CPUs accessing per-CPU data of a
single CPU concurrently. In the zswap case, we don't really need that
because we use the mutex to protect against it (and we cannot disable
preemption anyway).

