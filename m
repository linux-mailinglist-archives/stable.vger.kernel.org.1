Return-Path: <stable+bounces-107910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002CA04BFD
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 22:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E231650F8
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEDE1F7098;
	Tue,  7 Jan 2025 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmHZdws9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD11F669F
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287164; cv=none; b=NG2uIZMRq+pc2h+jpV3O3yvAtdgJ5xYTRVVj/DS+NOVVnYMOSF7zWBdzuRMx+8vvlUBvIPfbUHxhnli4pC/DRohNit32EhFH18+I3Ga2QgUfoLhDGsrF1FBpe5hrGILiNByajyhpCX3ZjlT2Vz6K20D/niHvJIPsbVbsFfeEn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287164; c=relaxed/simple;
	bh=bSyq7+nk4FrdkdOa6hX63QG5F/kSmOPRA5w7qdW9bZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udMhWmswBXZ569vUdIxaDXkOpZDtXQSiKQHrSHBzM/cwjwkwRvpxkvzfxktiKB4jdZJubdHGQuPGURrkjlH4ndGMldtlLOZEh+oOTUqnpPhvtCn+E2pXlTRCaLD04J0UUx/1dgXMLcJ8nhmMOt/WC1K3ujl8iKAd6mQc0neJc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmHZdws9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso135853106d6.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 13:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736287162; x=1736891962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DAh/oAJ8aLvhN0jleLakh87KCtpa5pUhpozrVuVGeM=;
        b=gmHZdws9T/4cBE7fUqVlB11BVziqdPVVFvmS1KQC4xDZ4fL15eW6hxE5uh8qJyaETz
         pVWk90e7sOq04jmZCFS3svPp8j7CHCmkGnu0qac4vDOoQbd4ykJWDydiME3I8dls4gR3
         uyGR4C8rM4498HMeTD869vJyEvDJfVWMbdqhLhki/EAAvEIeJ1uZdYQ4QUmDCAxY96wC
         /j7JfV0tHbBTWblceBwoAh2MwG30HE/MkMZ3D4VXEE9Crj5WUidPyTiCJd6bWSlgSUUo
         suCwoDH8qs21k9dRV8Gcn60bmvjApVfTusn0Opl+ihSLxakqhlpScHzT0hbDMpZ/3yAY
         W4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287162; x=1736891962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DAh/oAJ8aLvhN0jleLakh87KCtpa5pUhpozrVuVGeM=;
        b=beonlaDohHEztFM5BPIvw0TtqT1b3VV0k9jXB5gD73vw+Cb0kuicpOopa/PhS8idqF
         kU6GR5N8SN0N3o+izQ0XzWpxB3ek7iK6BDY3FmYIHHN1QX12ccE2ZrNSQlaOpvalbGJp
         rb6VqdQa7SH4mKDPZAnhbmXph9k8l0rU3vVypr5Wgky5liDRYaJ+obYeYATepV6zDO71
         K6t2uf0O59KBUOsodJ1l9iFIrZmRg6iNMtu/OBGxXx3k03X/B/smMqpA0Qp8ZoMlUJfY
         ZqYX6S6TXLzJOT8MLtyVArsk7oDYqhBPmqThIRU7iO3zgOAiQvFuns2EhaUePJHDP48J
         ixXw==
X-Forwarded-Encrypted: i=1; AJvYcCUHulqtKzzx8Dv9NsGUGniXDeNSBzqPbq0+fSqlmvGwD03JXYeevMocnT/75pFkhz6IuCXrkKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GV0VEvGtlbAvZodu7vVwhJXUkgie2TnohP4jnnhjM59mE0Do
	agl1L5MMcDTo28+vfVC1xv1Q4mZ06dMzuk7tP26M6G15MqbYPcKTvs9a9eggtnDxHOJmvRCYUBq
	ycg4LAkcuKOfhbUd2jOaNDKj8Y8WSRdQvNf/r
X-Gm-Gg: ASbGncuks+LOoMgD/vj0T3tuEKh3mbOt5xXfELGr6JW0BetviuJEPbunUtoknB3aBVh
	Q3tA09u0CHNg09NqG7rvM26feEsRx3o/OBL7kpMKs5I99z1eUa6z/c+aRvblSJ6dz4lG7
X-Google-Smtp-Source: AGHT+IEido2qo2/HV1Z8wP3eQewiqY8nQhqAxWXvdzYKFLUPPEP30NxW/bqGPCWQlTrk6iNaoRCw7iXOeUoba1MVgV4=
X-Received: by 2002:ad4:5f0d:0:b0:6dd:d317:e0aa with SMTP id
 6a1803df08f44-6df9b1f6c82mr10348176d6.8.1736287161958; Tue, 07 Jan 2025
 13:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107074724.1756696-1-yosryahmed@google.com>
 <20250107074724.1756696-2-yosryahmed@google.com> <20250107180345.GD37530@cmpxchg.org>
 <CAJD7tkYNvyVh2ETdbHrmtJRzKwVX3pPvite+cy0aS6cwJe5ePw@mail.gmail.com>
 <CAJD7tkYhO7DAQTrmb1A2H_FsaExoa1fp+C8vQw0MmzkmM+KyUA@mail.gmail.com> <CAJD7tkZpB_J=4hb8Mq68zTjMjshwY8JChdA904phbkroz2_eWw@mail.gmail.com>
In-Reply-To: <CAJD7tkZpB_J=4hb8Mq68zTjMjshwY8JChdA904phbkroz2_eWw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 13:58:45 -0800
X-Gm-Features: AbW1kvbVWZ-2eLzm0L7j3z9hgsVFgf1vgJ2zHgq6aQ27r1p46DWoZo3tGSd-uLM
Message-ID: <CAJD7tkb9N7+O9RNu=15mPF8NMoufwAaErnVTZAbgTyLp6NepSw@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU hotunplug
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 1:42=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Jan 7, 2025 at 12:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jan 7, 2025 at 10:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Tue, Jan 7, 2025 at 10:03=E2=80=AFAM Johannes Weiner <hannes@cmpxc=
hg.org> wrote:
> > > >
> > > > On Tue, Jan 07, 2025 at 07:47:24AM +0000, Yosry Ahmed wrote:
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
> > > > > There are a few ways to fix this:
> > > > > (a) Add a refcount for acomp_ctx.
> > > > > (b) Disable migration while using the per-CPU acomp_ctx.
> > > > > (c) Use SRCU to wait for other CPUs using the acomp_ctx of the CP=
U being
> > > > > hotunplugged. Normal RCU cannot be used as a sleepable context is
> > > > > required.
> > > > >
> > > > > Implement (c) since it's simpler than (a), and (b) involves using
> > > > > migrate_disable() which is apparently undesired (see huge comment=
 in
> > > > > include/linux/preempt.h).
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
> > > > >  mm/zswap.c | 31 ++++++++++++++++++++++++++++---
> > > > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index f6316b66fb236..add1406d693b8 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -864,12 +864,22 @@ static int zswap_cpu_comp_prepare(unsigned =
int cpu, struct hlist_node *node)
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > +DEFINE_STATIC_SRCU(acomp_srcu);
> > > > > +
> > > > >  static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_no=
de *node)
> > > > >  {
> > > > >       struct zswap_pool *pool =3D hlist_entry(node, struct zswap_=
pool, node);
> > > > >       struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->ac=
omp_ctx, cpu);
> > > > >
> > > > >       if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > > > > +             /*
> > > > > +              * Even though the acomp_ctx should not be currentl=
y in use on
> > > > > +              * @cpu, it may still be used by compress/decompres=
s operations
> > > > > +              * that started on @cpu and migrated to a different=
 CPU. Wait
> > > > > +              * for such usages to complete, any news usages wou=
ld be a bug.
> > > > > +              */
> > > > > +             synchronize_srcu(&acomp_srcu);
> > > >
> > > > The docs suggest you can't solve it like that :(
> > > >
> > > > Documentation/RCU/Design/Requirements/Requirements.rst:
> > > >
> > > >   Also unlike other RCU flavors, synchronize_srcu() may **not** be
> > > >   invoked from CPU-hotplug notifiers, due to the fact that SRCU gra=
ce
> > > >   periods make use of timers and the possibility of timers being
> > > >   temporarily =E2=80=9Cstranded=E2=80=9D on the outgoing CPU. This =
stranding of timers
> > > >   means that timers posted to the outgoing CPU will not fire until
> > > >   late in the CPU-hotplug process. The problem is that if a notifie=
r
> > > >   is waiting on an SRCU grace period, that grace period is waiting =
on
> > > >   a timer, and that timer is stranded on the outgoing CPU, then the
> > > >   notifier will never be awakened, in other words, deadlock has
> > > >   occurred. This same situation of course also prohibits
> > > >   srcu_barrier() from being invoked from CPU-hotplug notifiers.
> > >
> > > Thanks for checking, I completely missed this. I guess it only works
> > > with SRCU if we use call_srcu(), but then we need to copy the pointer=
s
> > > to a new struct to avoid racing with the CPU getting onlined again.
> > > Otherwise we can just bite the bullet and add a refcount, or use
> > > migrate_disable() despite that being undesirable.
> > >
> > > Do you have a favorite? :)
> >
> > I briefly looked into refcounting. The annoying thing is that we need
> > to handle the race between putting the last refcount in
> > zswap_compress()/zswap_decompress(), and the CPU getting onlined again
> > and re-initializing the refcount. One way to do it would be to put all
> > dynamically allocated resources in a struct with the same struct with
> > the new refcount, and use RCU + refcounts to allocate and free the
> > struct as a whole.
> >
> > I am leaning toward just disabling migration for now tbh unless there
> > are objections to that, especially this close to the v6.13 release.
>
> (Sorry for going back and forth on this, I am essentially thinking out lo=
ud)
>
> Actually, as Kanchana mentioned before, we should be able to just hold
> the mutex in zswap_cpu_comp_dead() before freeing the dynamic
> resources. The mutex is allocated when the pool is created and will
> not go away during CPU hotunplug AFAICT. It confused me before because
> we call mutex_init() in zswap_cpu_comp_prepare(), but it really should
> be in zswap_pool_create() after we allocate the pool->acomp_ctx.

Nope. It's possible for zswap_cpu_comp_dead() to hold the mutex and
free the resources after zswap_[de]compress() calls raw_cpu_ptr() but
before it calls mutex_lock().

