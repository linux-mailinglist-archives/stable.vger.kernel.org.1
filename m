Return-Path: <stable+bounces-107927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603AA04DFD
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705F33A116D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946341C32;
	Wed,  8 Jan 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGpG96HK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E852F37
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 00:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294543; cv=none; b=WJdNZd3h6jfBpZg2VQ6M74WylTTCtjEPn3jZCO/HDPuc2odk40bPZ3AJJ3i9Y1iwtkN0k1HMSgY1nxTmKujxjS5ik3BeQO8T/6PiRaYaFUvYGMsmJx525on00/XE5BfIecrgvMMK9lyGcqgotrCmwEmbTli8Y9S7SpN4oeE1go4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294543; c=relaxed/simple;
	bh=r8BRv5f7KMEpzYnWzrMPJ36mSreSi+c6omYKXkY/h44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bodRm+75bZh2dWsHk897pwJ1xDRt938OnqfbHVY6CUY//LlvXxz7t0wiBetW2OLr+yKOCTyrMYrMNZT2SWQfC77DVOsFNQIsoXuQlN03jNywKl49sRHPIqeXhn7vFkKY5z8il7tMq3EtZcYZ4nF73nk2n9xYvRkLlIN6jyYlVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGpG96HK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7ba0fa25f07so721511585a.2
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 16:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736294540; x=1736899340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5VcB/mTFuaRwJcsLEoa6X0skB2mYenl5uSlFRwJ3HY=;
        b=sGpG96HKmuawmsWC/xu4xWRcUqRO7Q99Y/zw3v4Z3bUm0vIisLQhZAb90qQ1inFhuv
         SrYQ714Dxb4B20X0GeM4ZTatuqqVm1uEfdb+tgbUFPO6v0uE7fwRQoVtWZdjWYuI9tH4
         6798t6K7UjLlY9E5/FxEaPtSQe5TtejpqeyS+jn+1HNBpKljzezSaQq8Wgstmo0gf4QW
         MGGAbruL7/GNtwz4qKlJX96qgnn9asmdHzPi/h5LwSLmJcEVnGd68qvuhi2QYx7EZcb3
         2Qvc3aH0UqXVxYRw1hs7uXCkooAE6PF/ZHs/6L1V7gXr74awfh2jhNs9jHxCT7uyQFHI
         pjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736294540; x=1736899340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5VcB/mTFuaRwJcsLEoa6X0skB2mYenl5uSlFRwJ3HY=;
        b=iTurYo3EBPS54ttm/7eyKBD3R3x/5J5gDaLelry2hexcXN3Fp0KgeuNZB+PUaa9owv
         MX5uFZPGpENftKbqf15MAda5CzLvDF6YU7QwoJgFoefxFgAqUOhuQVSjKo4o0/RXSFAZ
         IldKuBZH580JWUZmPGgY9ITC4+Y9Ch7XBsPntfZgl1PgC48VoioKqJK5YmuzLFR5rgck
         Z3jDMRJkTG5EGtZ60m2y2fbbjLCboqk3Ad/ur7lXUl4bIJa0F425Z/bKnEV7HdjDnDca
         Xwb8G4uyNWKO+k7vcjF+AP1CrAOdwabR2iK9srzPrmvlGGAWFfVghdeebrf6EEKiw6J+
         BRng==
X-Forwarded-Encrypted: i=1; AJvYcCWjyT+t+v76mGzy01yR8JS2zTiZpHeCX5oGzGGF9Atfzen1PHl9aYgBagCx3lR58eCD9glSad0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznWoHXhaWE6ilCGeG6rzEp0RuS5PfgcTRce9J5DGeYfCqZimg5
	lD5kelzpSd8rLKbNNngbhcay5OupgbIC3kZjQNk7u56MlOp+ZCSQWtEPKf5Aa9/IkdAPnZZgT1D
	FhAXqNWqormfx/0jluwLsg4d04Gqa5lgKf5fZ
X-Gm-Gg: ASbGnculu3EmBUVFvYE8eLwKlwudvEbdZiMjYWDD9+HY5vGwUYltx4Jt5WNSMPFE1on
	19hkACcrhEdVVr/yKl8PwLAcuEKcHrxo3VUbdGYjtGu/5mNOH7Ri4/YjmSr/snUuYsmdd
X-Google-Smtp-Source: AGHT+IHGWRaUqixp2cjxy4Eeujl4Tz+gAM8WomLT0kK8VB7P1yVycx0mNaR8UDUFGER6R/cVKFoAXXIrYASxCeGPlqw=
X-Received: by 2002:a05:6214:29ca:b0:6d8:876e:ef41 with SMTP id
 6a1803df08f44-6df9b1f6ae4mr15297536d6.21.1736294540149; Tue, 07 Jan 2025
 16:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <CAGsJ_4xN9=5cksaGPqh_6jyH-EJkw-DH1zwx81Kotqh85BJ+ZQ@mail.gmail.com>
 <CAJD7tkbnYaZFYw0ieor81e--e6qJVgb3045x86c0EKV546TyWw@mail.gmail.com>
 <CAGsJ_4wajczqt7P=1m7dmt3dk3uz+g6CnnsUOYidjWjL5CeLEw@mail.gmail.com> <CAGsJ_4wC-wgtamCwSgMXwUG_xCsxzLZPajjoFfR8pVhCB_CQKA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wC-wgtamCwSgMXwUG_xCsxzLZPajjoFfR8pVhCB_CQKA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 16:01:43 -0800
X-Gm-Features: AbW1kvZzYTdQbxIAphcN788kl4e475ndXnkGPAgm2e1fT4WkEBR5Cem40-ed3pk
Message-ID: <CAJD7tkYiN4y=VtRtSvTq5ayCJwfCqZGghBkAFwyhnFgCdSPgaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 3:56=E2=80=AFPM Barry Song <baohua@kernel.org> wrote=
:
>
> On Wed, Jan 8, 2025 at 12:38=E2=80=AFPM Barry Song <baohua@kernel.org> wr=
ote:
> >
> > On Wed, Jan 8, 2025 at 12:26=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Tue, Jan 7, 2025 at 2:47=E2=80=AFPM Barry Song <baohua@kernel.org>=
 wrote:
> > > >
> > > > On Wed, Jan 8, 2025 at 11:22=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx=
 of the
> > > > > current CPU at the beginning of the operation is retrieved and us=
ed
> > > > > throughout.  However, since neither preemption nor migration are =
disabled,
> > > > > it is possible that the operation continues on a different CPU.
> > > > >
> > > > > If the original CPU is hotunplugged while the acomp_ctx is still =
in use,
> > > > > we run into a UAF bug as the resources attached to the acomp_ctx =
are freed
> > > > > during hotunplug in zswap_cpu_comp_dead().
> > > > >
> > > > > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: mov=
e to use
> > > > > crypto_acomp API for hardware acceleration") when the switch to t=
he
> > > > > crypto_acomp API was made.  Prior to that, the per-CPU crypto_com=
p was
> > > > > retrieved using get_cpu_ptr() which disables preemption and makes=
 sure the
> > > > > CPU cannot go away from under us.  Preemption cannot be disabled =
with the
> > > > > crypto_acomp API as a sleepable context is needed.
> > > > >
> > > > > Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer t=
o
> > > > > per-acomp_ctx") increased the UAF surface area by making the per-=
CPU
> > > > > buffers dynamic, adding yet another resource that can be freed fr=
om under
> > > > > zswap compression/decompression by CPU hotunplug.
> > > > >
> > > > > This cannot be fixed by holding cpus_read_lock(), as it is possib=
le for
> > > > > code already holding the lock to fall into reclaim and enter zswa=
p
> > > > > (causing a deadlock). It also cannot be fixed by wrapping the usa=
ge of
> > > > > acomp_ctx in an SRCU critical section and using synchronize_srcu(=
) in
> > > > > zswap_cpu_comp_dead(), because synchronize_srcu() is not allowed =
in
> > > > > CPU-hotplug notifiers (see
> > > > > Documentation/RCU/Design/Requirements/Requirements.rst).
> > > > >
> > > > > This can be fixed by refcounting the acomp_ctx, but it involves
> > > > > complexity in handling the race between the refcount dropping to =
zero in
> > > > > zswap_[de]compress() and the refcount being re-initialized when t=
he CPU
> > > > > is onlined.
> > > > >
> > > > > Keep things simple for now and just disable migration while using=
 the
> > > > > per-CPU acomp_ctx to block CPU hotunplug until the usage is over.
> > > > >
> > > > > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for =
hardware acceleration")
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmp=
xchg.org/
> > > > > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > > > > Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD=
5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> > > > > ---
> > > > >  mm/zswap.c | 19 ++++++++++++++++---
> > > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index f6316b66fb236..ecd86153e8a32 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int =
cpu, struct hlist_node *node)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +/* Remain on the CPU while using its acomp_ctx to stop it from g=
oing offline */
> > > > > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_=
acomp_ctx __percpu *acomp_ctx)
> > > > > +{
> > > > > +       migrate_disable();
> > > >
> > > > I'm not entirely sure, but I feel it is quite unsafe. Allowing slee=
p
> > > > during migrate_disable() and
> > > > migrate_enable() would require the entire scheduler, runqueue,
> > > > waitqueue, and CPU
> > > > hotplug mechanisms to be aware that a task is pinned to a specific =
CPU.
> > >
> > > My understanding is that sleeping is already allowed when migration i=
s
> > > disabled (unlike preemption). See delete_all_elements() in
> > > kernel/bpf/hashtab.c for example, or __bpf_prog_enter_sleepable() in
> > > kernel/bpf/trampoline.c. I am not sure exactly what you mean.
> >
> > Initially, I had some doubts about whether the scheduler handled this c=
orrectly,
> > but after reviewing the scheduler code again, it seems fine. While a ta=
sk is
> > dequeued, its cpus_ptr is updated. When the task is woken up, it uses i=
ts
> > cpus_ptr instead of selecting a suitable CPU (e.g., idle or wake-affine=
 CPUs).
> > Only after migrate_enable() restores this_rq()->nr_pinned to zero can C=
PU
> > hotplug take down the CPU.
> >
> > Therefore, I sent another email to correct myself:
> > https://lore.kernel.org/linux-mm/CAGsJ_4yb03yo6So-8wZwcy2fa-tURRrgJ+P-X=
hDL-RHgg1DvVA@mail.gmail.com/
> >
> > >
> > > >
> > > > If there is no sleep during this period, it seems to be only a
> > > > runqueue issue=E2=80=94CPU hotplug can
> > > > wait for the task to be unpinned while it is always in runqueue.
> > > > However, if sleep is involved,
> > > > the situation becomes significantly more complex.
> > > >
> > > > If static data doesn't consume much memory, it could be the simples=
t solution.
> > >
> > > Do you mean allocating the buffers and requests for all possible CPUs
> > > instead of allocating them dynamically in CPU hotplug notifiers? I am
> > > not sure how much more memory this would be. Seems like it depends on
> > > CONFIG options and the firmware.
> >
> > Correct, the firmware/devicetree will help identify all possible CPUs. =
Even
> > if CONFIG is large, only those possible CPUs will be allocated memory.
> > However, if migrate_disable() and migrate_enable() work as expected,
> > we don't need to consider this option.
>
> By the way, there could be a slight performance regression if the previou=
s
> CPU is occupied with other tasks, as we would have to wait for preemption=
.
> However, when migrate_disable() is not in effect, the woken-up task can
> quickly select a neighboring idle CPU and continue execution.
>
> When the entire system is not busy, there might be no difference. However=
, when
> the system is packed with tasks, it could make a difference. Hopefully, t=
he
> regression is small enough to be negligible :-)

Hopefully the robot will let us know if it isn't :)

