Return-Path: <stable+bounces-107924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B979A04DF4
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12BDC1887F0B
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4F1F63F4;
	Tue,  7 Jan 2025 23:56:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FF1F63E7;
	Tue,  7 Jan 2025 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294218; cv=none; b=gQbfkh6w/Lod+suTMlbM5Uoh2T1qDkfywz/ulLWAh84qSJ3XjyslOfD0QTbs0la0kfYPhjx3eCQ577cqg11SsDzSIzozKLf+S0arlUaudxeocgRy147Ap1AhqglyTchICoTtMrzSMpMn7Z2LsZJDnguK7f39Qk0wVvOrh7HihBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294218; c=relaxed/simple;
	bh=6PmUO4qLkTp0n6U4wmFSj77Bij/HLw++L56gi1BS9LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC1e/PUoSp2J7RXIRe+8z1NkOm1FgGHnw9AP6a7MDGR8YvDs7pvyE9PiFUlhtnkH0b6HSFSUKyC05KCYzdlqL6nZwvcM1rAu33KXXsRX1VjOws1kFXTxsiadmsbGhdIUcYsQmqjdP0bRDBo5BHBZW58Or4evcvdalQg886i0XvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4afe70b41a8so5026008137.3;
        Tue, 07 Jan 2025 15:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736294215; x=1736899015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1cb1DUV4xv7Tq0nP/l08DLYi+sRYWSG7hM3AytBxfw=;
        b=nBhs6Ey1JU0gobVV1lsdJsYQzbyC8gKCB6xlur1H3A3u5BzMMJEk+PTxFHW4kh5L6z
         uxLfegK5y1pWF3m2XkK3Tut3gtR+s0A0JHTh7TfVCJ8i7oQUvYXla9RboDR5rg0eamfN
         /RV34APphp1LHBJS1hXJwgmczT+km7BQ+mvMxMIjTIgpYulPDWjaCYMQ1Xc8pkEnvH4W
         AzxU6KiLlmjX5iVnaF3fIruwCv8xDSB/+iW9htYKAUq3sdThnxnY7lRliOEd8S7TLgNq
         N29UnuxU9qh5/I6KC+ZfqHVYUGXUV6RypDYzmaQlHxNrNFLSvnh37J67Gy4qthWmAuNv
         ipHw==
X-Forwarded-Encrypted: i=1; AJvYcCUUiWPIn/1vZlUfxQeEUMD7YfX0DVJOavXMJx/bQHPEj8EXeb71+uSpxcG83qlYcVbpywR0zSNky9RPvdc=@vger.kernel.org, AJvYcCWGt2ypPJTbMjP6oEwsNg1Mt8Pew9kdEeCa0kKRgS9ppfd9epv//H2FaD+P1VfVZ1esbdfl67w7@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZXDd8ivjc2oHDHog25rsFTelt9sFtv2xrgSllXMUNH+xa9c3
	vuLjzIL2M7QAIDEzxL2gUMuCljXv59AwMH2E8gaPaGDFKWP4X37mWg8mfVJf5bYI0m9iXdFYvjK
	LHpgZ98c33th8h6gGfukCXM29MRk=
X-Gm-Gg: ASbGncumWiy/ivVlA9XQcWdvmHkSdsVR4Sr+cN1+FzqEXEwHAuPWQe7P7w0tDKrmAEK
	CWmK8Yhn6I4Ug0/EBU6j7tRwHVCeZLOI4j6I5p1RSiKN8RBkRTvg5vO9JNNEFFbXbh6nzAeg=
X-Google-Smtp-Source: AGHT+IFQF4rbOj57MKazphxT7zM4SmJ1w77ypufJOhWONq7MIAsLAJ+YyYuwY9/mzsLS9j2UZBSZZrr2gtNsmvm+M+8=
X-Received: by 2002:a05:6102:4b12:b0:4af:f044:9381 with SMTP id
 ada2fe7eead31-4b3d0eb9426mr925956137.27.1736294215244; Tue, 07 Jan 2025
 15:56:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <CAGsJ_4xN9=5cksaGPqh_6jyH-EJkw-DH1zwx81Kotqh85BJ+ZQ@mail.gmail.com>
 <CAJD7tkbnYaZFYw0ieor81e--e6qJVgb3045x86c0EKV546TyWw@mail.gmail.com> <CAGsJ_4wajczqt7P=1m7dmt3dk3uz+g6CnnsUOYidjWjL5CeLEw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wajczqt7P=1m7dmt3dk3uz+g6CnnsUOYidjWjL5CeLEw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 8 Jan 2025 12:56:44 +1300
X-Gm-Features: AbW1kvZuTDLWSyxXcLXp8bF7iKv37kirT_Z5D8NSVJ1__fCGZXi3JDZjpui5amo
Message-ID: <CAGsJ_4wC-wgtamCwSgMXwUG_xCsxzLZPajjoFfR8pVhCB_CQKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:38=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, Jan 8, 2025 at 12:26=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jan 7, 2025 at 2:47=E2=80=AFPM Barry Song <baohua@kernel.org> w=
rote:
> > >
> > > On Wed, Jan 8, 2025 at 11:22=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx o=
f the
> > > > current CPU at the beginning of the operation is retrieved and used
> > > > throughout.  However, since neither preemption nor migration are di=
sabled,
> > > > it is possible that the operation continues on a different CPU.
> > > >
> > > > If the original CPU is hotunplugged while the acomp_ctx is still in=
 use,
> > > > we run into a UAF bug as the resources attached to the acomp_ctx ar=
e freed
> > > > during hotunplug in zswap_cpu_comp_dead().
> > > >
> > > > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move =
to use
> > > > crypto_acomp API for hardware acceleration") when the switch to the
> > > > crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp =
was
> > > > retrieved using get_cpu_ptr() which disables preemption and makes s=
ure the
> > > > CPU cannot go away from under us.  Preemption cannot be disabled wi=
th the
> > > > crypto_acomp API as a sleepable context is needed.
> > > >
> > > > Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> > > > per-acomp_ctx") increased the UAF surface area by making the per-CP=
U
> > > > buffers dynamic, adding yet another resource that can be freed from=
 under
> > > > zswap compression/decompression by CPU hotunplug.
> > > >
> > > > This cannot be fixed by holding cpus_read_lock(), as it is possible=
 for
> > > > code already holding the lock to fall into reclaim and enter zswap
> > > > (causing a deadlock). It also cannot be fixed by wrapping the usage=
 of
> > > > acomp_ctx in an SRCU critical section and using synchronize_srcu() =
in
> > > > zswap_cpu_comp_dead(), because synchronize_srcu() is not allowed in
> > > > CPU-hotplug notifiers (see
> > > > Documentation/RCU/Design/Requirements/Requirements.rst).
> > > >
> > > > This can be fixed by refcounting the acomp_ctx, but it involves
> > > > complexity in handling the race between the refcount dropping to ze=
ro in
> > > > zswap_[de]compress() and the refcount being re-initialized when the=
 CPU
> > > > is onlined.
> > > >
> > > > Keep things simple for now and just disable migration while using t=
he
> > > > per-CPU acomp_ctx to block CPU hotunplug until the usage is over.
> > > >
> > > > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for ha=
rdware acceleration")
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxc=
hg.org/
> > > > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > > > Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+=
o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> > > > ---
> > > >  mm/zswap.c | 19 ++++++++++++++++---
> > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index f6316b66fb236..ecd86153e8a32 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cp=
u, struct hlist_node *node)
> > > >         return 0;
> > > >  }
> > > >
> > > > +/* Remain on the CPU while using its acomp_ctx to stop it from goi=
ng offline */
> > > > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_ac=
omp_ctx __percpu *acomp_ctx)
> > > > +{
> > > > +       migrate_disable();
> > >
> > > I'm not entirely sure, but I feel it is quite unsafe. Allowing sleep
> > > during migrate_disable() and
> > > migrate_enable() would require the entire scheduler, runqueue,
> > > waitqueue, and CPU
> > > hotplug mechanisms to be aware that a task is pinned to a specific CP=
U.
> >
> > My understanding is that sleeping is already allowed when migration is
> > disabled (unlike preemption). See delete_all_elements() in
> > kernel/bpf/hashtab.c for example, or __bpf_prog_enter_sleepable() in
> > kernel/bpf/trampoline.c. I am not sure exactly what you mean.
>
> Initially, I had some doubts about whether the scheduler handled this cor=
rectly,
> but after reviewing the scheduler code again, it seems fine. While a task=
 is
> dequeued, its cpus_ptr is updated. When the task is woken up, it uses its
> cpus_ptr instead of selecting a suitable CPU (e.g., idle or wake-affine C=
PUs).
> Only after migrate_enable() restores this_rq()->nr_pinned to zero can CPU
> hotplug take down the CPU.
>
> Therefore, I sent another email to correct myself:
> https://lore.kernel.org/linux-mm/CAGsJ_4yb03yo6So-8wZwcy2fa-tURRrgJ+P-XhD=
L-RHgg1DvVA@mail.gmail.com/
>
> >
> > >
> > > If there is no sleep during this period, it seems to be only a
> > > runqueue issue=E2=80=94CPU hotplug can
> > > wait for the task to be unpinned while it is always in runqueue.
> > > However, if sleep is involved,
> > > the situation becomes significantly more complex.
> > >
> > > If static data doesn't consume much memory, it could be the simplest =
solution.
> >
> > Do you mean allocating the buffers and requests for all possible CPUs
> > instead of allocating them dynamically in CPU hotplug notifiers? I am
> > not sure how much more memory this would be. Seems like it depends on
> > CONFIG options and the firmware.
>
> Correct, the firmware/devicetree will help identify all possible CPUs. Ev=
en
> if CONFIG is large, only those possible CPUs will be allocated memory.
> However, if migrate_disable() and migrate_enable() work as expected,
> we don't need to consider this option.

By the way, there could be a slight performance regression if the previous
CPU is occupied with other tasks, as we would have to wait for preemption.
However, when migrate_disable() is not in effect, the woken-up task can
quickly select a neighboring idle CPU and continue execution.

When the entire system is not busy, there might be no difference. However, =
when
the system is packed with tasks, it could make a difference. Hopefully, the
regression is small enough to be negligible :-)

Thanks
Barry

