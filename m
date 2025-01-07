Return-Path: <stable+bounces-107923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3946A04DA7
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2661518877A8
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5FD1E5729;
	Tue,  7 Jan 2025 23:38:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2E1DF75C;
	Tue,  7 Jan 2025 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293112; cv=none; b=DjrBxid+PvNarEjRZ9+STy+chaA6SLAZ+7ryOc6Tzu6ZtI97nhOCk6bf9rOYc5C8lZ9BT81WLYOBJ7V38rt1AlrNTu/ibfkqKbbjRHwhOvNvGjsGNUgqyn46em/iLcc7iSkMSLG7PerdSr0RNbP/Mlpcc8qNuROrWYJiMO/K/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293112; c=relaxed/simple;
	bh=ArJ2QOdI+t0ZlJ9mcLqh53JmtNmuhEI9MMn/8Lgf5OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DINMk3niOf95JXVe9KcNjMvP5ekFNIO/FLDF2ChdS8YWgzBiYiqmmbfiZK43bf4XQJxaGlBOhRDWHPQa36VE+Ns+Exih+KXur1uVzPkAs7Q0y64G6MXwENQu9BXsohBdCoCxVyr9zPmhbRZHasCq3hyPVCkdCguEhtmbsBytQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51619b06a1cso8978348e0c.3;
        Tue, 07 Jan 2025 15:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293110; x=1736897910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVG5MMYsXJNeiUqHwxOiADsVxvbz1uR1TXbbkCWmeBs=;
        b=D8R5Dcy1UOe0Vnp5VpTG/17JVFyoSFKRmhnFQP1PmcXvmnGst9EnseKAZ1oKnFsrvU
         uhPgXg0c3eawlQV6RnY9u9JzhVx5sBDgGcPP0nfQsqb/+cxYTCf98yD7HrosGs5Gz7rm
         yuiQnil01w3A5zXM7+UF1uk9aYkCAyv7txKujxdwiXOrRxO6E46ddIUFTvQvwelMIduu
         tka4hATw4BXke8bW2X3Ic15XmQGvMBRNwTRbUyTrVcXWVRtGZGDbq31hgv84IM+1nbzg
         WsH+Oev1+X97zBU5flJKN9BC7Evbp1Q4nJyi4JpLPYpsQgk5iKP1g0ND6QLOLNop2kUm
         uWiA==
X-Forwarded-Encrypted: i=1; AJvYcCWLXoKpanhoxYZEv21lgXlGAp/3s391Co1esYCKSuXeupBeWmXSEDHP+y6a1cT15dB7wYF/pN2vj8wtEsU=@vger.kernel.org, AJvYcCWSg7SIQuqcnmXH5IMEut8422LEG2BcsRyxnEHMZUjyd/Zap0km6MvSm66d5BORAso1zy6avJP4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09GtCE9/ZouLQEIvkM36w5tZou8nyY+/D+UH0/GHDk1baK9tp
	+17dPXNVK0Avj2TflQNjZNM2MyKIOGwRxGAvx8a7cQ1F4RR34kHp5h7yGPs/s9sAhBBFN6oylIV
	0IqKpHhUrfvP7N1+SPtBk+e5unSI=
X-Gm-Gg: ASbGncvEVpRtTBvLvaMk/mj3I7SJEWsnVKk2k5fmfqucbuf8La8oSyiQqJIXx8GuVOD
	DHnv1XrqJIw3EaMwOvo9t9gD8U9GAh8KjtohD+A+xWs1971aYHlHiDFmAi1VDCfvo4FK7IpU=
X-Google-Smtp-Source: AGHT+IGjvk9ah/tNJ4ANNx3UV1HlbtvQXIQoAJvoGcqH5EQYuQAJ+6Mq1pS/+peJcybL84RMbgRSZbcMFUBf4W5rsKM=
X-Received: by 2002:a05:6122:7cf:b0:51c:27a0:25b8 with SMTP id
 71dfb90a1353d-51c6c1fdc97mr869648e0c.2.1736293109936; Tue, 07 Jan 2025
 15:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <CAGsJ_4xN9=5cksaGPqh_6jyH-EJkw-DH1zwx81Kotqh85BJ+ZQ@mail.gmail.com>
 <CAJD7tkbnYaZFYw0ieor81e--e6qJVgb3045x86c0EKV546TyWw@mail.gmail.com>
In-Reply-To: <CAJD7tkbnYaZFYw0ieor81e--e6qJVgb3045x86c0EKV546TyWw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 8 Jan 2025 12:38:18 +1300
X-Gm-Features: AbW1kvY4B5vetMcMduqj-X_Iak1T60IpVXH1Tr_iwkt3YeZYdfteT9CM37USdy0
Message-ID: <CAGsJ_4wajczqt7P=1m7dmt3dk3uz+g6CnnsUOYidjWjL5CeLEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:26=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jan 7, 2025 at 2:47=E2=80=AFPM Barry Song <baohua@kernel.org> wro=
te:
> >
> > On Wed, Jan 8, 2025 at 11:22=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of =
the
> > > current CPU at the beginning of the operation is retrieved and used
> > > throughout.  However, since neither preemption nor migration are disa=
bled,
> > > it is possible that the operation continues on a different CPU.
> > >
> > > If the original CPU is hotunplugged while the acomp_ctx is still in u=
se,
> > > we run into a UAF bug as the resources attached to the acomp_ctx are =
freed
> > > during hotunplug in zswap_cpu_comp_dead().
> > >
> > > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to=
 use
> > > crypto_acomp API for hardware acceleration") when the switch to the
> > > crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp wa=
s
> > > retrieved using get_cpu_ptr() which disables preemption and makes sur=
e the
> > > CPU cannot go away from under us.  Preemption cannot be disabled with=
 the
> > > crypto_acomp API as a sleepable context is needed.
> > >
> > > Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> > > per-acomp_ctx") increased the UAF surface area by making the per-CPU
> > > buffers dynamic, adding yet another resource that can be freed from u=
nder
> > > zswap compression/decompression by CPU hotunplug.
> > >
> > > This cannot be fixed by holding cpus_read_lock(), as it is possible f=
or
> > > code already holding the lock to fall into reclaim and enter zswap
> > > (causing a deadlock). It also cannot be fixed by wrapping the usage o=
f
> > > acomp_ctx in an SRCU critical section and using synchronize_srcu() in
> > > zswap_cpu_comp_dead(), because synchronize_srcu() is not allowed in
> > > CPU-hotplug notifiers (see
> > > Documentation/RCU/Design/Requirements/Requirements.rst).
> > >
> > > This can be fixed by refcounting the acomp_ctx, but it involves
> > > complexity in handling the race between the refcount dropping to zero=
 in
> > > zswap_[de]compress() and the refcount being re-initialized when the C=
PU
> > > is onlined.
> > >
> > > Keep things simple for now and just disable migration while using the
> > > per-CPU acomp_ctx to block CPU hotunplug until the usage is over.
> > >
> > > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hard=
ware acceleration")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg=
.org/
> > > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > > Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2=
e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> > > ---
> > >  mm/zswap.c | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index f6316b66fb236..ecd86153e8a32 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu,=
 struct hlist_node *node)
> > >         return 0;
> > >  }
> > >
> > > +/* Remain on the CPU while using its acomp_ctx to stop it from going=
 offline */
> > > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acom=
p_ctx __percpu *acomp_ctx)
> > > +{
> > > +       migrate_disable();
> >
> > I'm not entirely sure, but I feel it is quite unsafe. Allowing sleep
> > during migrate_disable() and
> > migrate_enable() would require the entire scheduler, runqueue,
> > waitqueue, and CPU
> > hotplug mechanisms to be aware that a task is pinned to a specific CPU.
>
> My understanding is that sleeping is already allowed when migration is
> disabled (unlike preemption). See delete_all_elements() in
> kernel/bpf/hashtab.c for example, or __bpf_prog_enter_sleepable() in
> kernel/bpf/trampoline.c. I am not sure exactly what you mean.

Initially, I had some doubts about whether the scheduler handled this corre=
ctly,
but after reviewing the scheduler code again, it seems fine. While a task i=
s
dequeued, its cpus_ptr is updated. When the task is woken up, it uses its
cpus_ptr instead of selecting a suitable CPU (e.g., idle or wake-affine CPU=
s).
Only after migrate_enable() restores this_rq()->nr_pinned to zero can CPU
hotplug take down the CPU.

Therefore, I sent another email to correct myself:
https://lore.kernel.org/linux-mm/CAGsJ_4yb03yo6So-8wZwcy2fa-tURRrgJ+P-XhDL-=
RHgg1DvVA@mail.gmail.com/

>
> >
> > If there is no sleep during this period, it seems to be only a
> > runqueue issue=E2=80=94CPU hotplug can
> > wait for the task to be unpinned while it is always in runqueue.
> > However, if sleep is involved,
> > the situation becomes significantly more complex.
> >
> > If static data doesn't consume much memory, it could be the simplest so=
lution.
>
> Do you mean allocating the buffers and requests for all possible CPUs
> instead of allocating them dynamically in CPU hotplug notifiers? I am
> not sure how much more memory this would be. Seems like it depends on
> CONFIG options and the firmware.

Correct, the firmware/devicetree will help identify all possible CPUs. Even
if CONFIG is large, only those possible CPUs will be allocated memory.
However, if migrate_disable() and migrate_enable() work as expected,
we don't need to consider this option.

Thanks
Barry

