Return-Path: <stable+bounces-107909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59FA04BE1
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 22:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2902D3A4EB9
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A7A1F7547;
	Tue,  7 Jan 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpMZ25x1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F51F63D7
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286165; cv=none; b=B4NFKFdi2p70H8XayJEm9xoeitSWScSeTNxfiK4XWZUZPDDHST2EWmWX6gBfswmtuIKSLxFBjl9tsktYayZIFDn/5F7I14t12xvEaeRDNDpftnjqk4rnMhrOTOi2DzsY/NGmrPabtTkF8sapQd5TKupXxec65muzQ/f5rO8sGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286165; c=relaxed/simple;
	bh=WMiHv5ChmLVSHrGo2QbfEH3JxhB2fQsTn1V65PHJy14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJcaplKnkbcI5K0K+cp2Fx3P8C10lPaKqZtb6IRW6CXXe0x9nDaLFMvh++3MRBP9kQzMLPhxpejtdCBbhIhAReaZ6rt1E0qMA/2jwVgc6GdUwOS6UUCSGB3xI35lxH3/l0zgwZvgSQVYVfz7XzBGK4dIk1dsLkGqUqC+Ba6ykLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpMZ25x1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd01781b56so92866236d6.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 13:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736286163; x=1736890963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G13dOWsFZuEbwzRpJensoP5lUPWnfLnvqCe3d4eqvc=;
        b=IpMZ25x1uWocT+loUBx/8hM9MNFTCXAgLvrc/PumR/Uthg7ntXTEH/63qgT/nAGMlZ
         jiv6h0z1wenYHdew+ugn0vN4MnIW2NI4eJjQA+QUL0RQ1PAJzj1Babr5Mf6uAoO6VbGK
         56c5mcdNDWeb4fRbD9a3tKRu3bfxnTFid8o6U/y/ErTLpr7iCLsgjuOTmjjZvSO35bus
         XL3I0Cq3NSsqDmouSh0t8/Rg3m7FdTKpzaJKBujF14uONDobq5OUWKd2nAf6VUqo4n7F
         UCbwrEaHfH0gPPIQ9R2k6fPG2dZvE4+g/RtnqE61Pb2+XcIm7sj5BZUMgjduCtSYlSpU
         Ed+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736286163; x=1736890963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G13dOWsFZuEbwzRpJensoP5lUPWnfLnvqCe3d4eqvc=;
        b=LPUhZkd3EYvNTON6Axcuo/fjG5tg6/kBMie5QyL9ZtzqWzb38BcFY1i30yx9pnMeLl
         qHxu1MtLT8qnNmzzM3TNh3OoUTD5dRyLDUg85i/+cWFk3RnCT761STbPG4Z6zJYDJRPT
         1/K9IZ7gBc3PFdA9lqIgcj8/nmmrzkmD47EuhwaBGE4pm2JPhkj1zHqHF5tzIuQxrb6a
         710RHTlrIxCtxBw3LmdgSHGt01ybxY89Wf+CwMRw6fQGMbznJWPcpEwd5rqIF45L/Ndi
         i8/c/t3a3P5G0JkZyYjZ7MzZAt0dO8sShJkxE1Jt+hAudCLSv8QvlAzQxnhiDL20KFwT
         m17g==
X-Forwarded-Encrypted: i=1; AJvYcCUKnp54dIjFZRO7zdRaKapmqb2KwhMHtOWU3fss4G2uzZ5dmSZWmM3WO88bBL23iLwO6hr8sIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXozOKY7zUpH1O0sBuJr0QOHd0Y86U+aLurUmv3qhqgCP/JIF
	f6YoR5mbR5aohWDIgKk0xOU3XsrlUddZdcgKMSxtYd/tgTsaRlkyqPg0NV1SZ4l4Z8reSKGaP3h
	suUijgmIk8c+Rrd2Bt5IM2eRqKArPEqIU3Nrh
X-Gm-Gg: ASbGncu+atdbJFbmSDoX0HQHjdHGdcp0G1W/M9uQnT6C5TskpT2RC8sGXXB8MoF6voP
	WGPYtbIH42QNh04wvQ/ugEZunvxa3t/umaNYImsGwuLedQt8aqMtecIjxNOtMVY7IObIf
X-Google-Smtp-Source: AGHT+IHGzHCckp0YwLL6qWbbj7P4PmjgKcN3Cr3U0hMZnvo+Ul5RGfHUpFWdGpQef/jRx7cLlUayY+xHmSgyFmmczMU=
X-Received: by 2002:a05:6214:daf:b0:6df:9771:978e with SMTP id
 6a1803df08f44-6df9b2ff139mr9693256d6.34.1736286162458; Tue, 07 Jan 2025
 13:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107074724.1756696-1-yosryahmed@google.com>
 <20250107074724.1756696-2-yosryahmed@google.com> <20250107180345.GD37530@cmpxchg.org>
 <CAJD7tkYNvyVh2ETdbHrmtJRzKwVX3pPvite+cy0aS6cwJe5ePw@mail.gmail.com> <CAJD7tkYhO7DAQTrmb1A2H_FsaExoa1fp+C8vQw0MmzkmM+KyUA@mail.gmail.com>
In-Reply-To: <CAJD7tkYhO7DAQTrmb1A2H_FsaExoa1fp+C8vQw0MmzkmM+KyUA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 13:42:06 -0800
X-Gm-Features: AbW1kvYHuAZI5ZHdTP4Jr4nKvrys_7pWHHVFUnC3W3lg3PO78sQB-a0sd5EC8Ys
Message-ID: <CAJD7tkZpB_J=4hb8Mq68zTjMjshwY8JChdA904phbkroz2_eWw@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU hotunplug
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jan 7, 2025 at 10:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jan 7, 2025 at 10:03=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Tue, Jan 07, 2025 at 07:47:24AM +0000, Yosry Ahmed wrote:
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
> > > > There are a few ways to fix this:
> > > > (a) Add a refcount for acomp_ctx.
> > > > (b) Disable migration while using the per-CPU acomp_ctx.
> > > > (c) Use SRCU to wait for other CPUs using the acomp_ctx of the CPU =
being
> > > > hotunplugged. Normal RCU cannot be used as a sleepable context is
> > > > required.
> > > >
> > > > Implement (c) since it's simpler than (a), and (b) involves using
> > > > migrate_disable() which is apparently undesired (see huge comment i=
n
> > > > include/linux/preempt.h).
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
> > > >  mm/zswap.c | 31 ++++++++++++++++++++++++++++---
> > > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index f6316b66fb236..add1406d693b8 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -864,12 +864,22 @@ static int zswap_cpu_comp_prepare(unsigned in=
t cpu, struct hlist_node *node)
> > > >       return ret;
> > > >  }
> > > >
> > > > +DEFINE_STATIC_SRCU(acomp_srcu);
> > > > +
> > > >  static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node=
 *node)
> > > >  {
> > > >       struct zswap_pool *pool =3D hlist_entry(node, struct zswap_po=
ol, node);
> > > >       struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acom=
p_ctx, cpu);
> > > >
> > > >       if (!IS_ERR_OR_NULL(acomp_ctx)) {
> > > > +             /*
> > > > +              * Even though the acomp_ctx should not be currently =
in use on
> > > > +              * @cpu, it may still be used by compress/decompress =
operations
> > > > +              * that started on @cpu and migrated to a different C=
PU. Wait
> > > > +              * for such usages to complete, any news usages would=
 be a bug.
> > > > +              */
> > > > +             synchronize_srcu(&acomp_srcu);
> > >
> > > The docs suggest you can't solve it like that :(
> > >
> > > Documentation/RCU/Design/Requirements/Requirements.rst:
> > >
> > >   Also unlike other RCU flavors, synchronize_srcu() may **not** be
> > >   invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
> > >   periods make use of timers and the possibility of timers being
> > >   temporarily =E2=80=9Cstranded=E2=80=9D on the outgoing CPU. This st=
randing of timers
> > >   means that timers posted to the outgoing CPU will not fire until
> > >   late in the CPU-hotplug process. The problem is that if a notifier
> > >   is waiting on an SRCU grace period, that grace period is waiting on
> > >   a timer, and that timer is stranded on the outgoing CPU, then the
> > >   notifier will never be awakened, in other words, deadlock has
> > >   occurred. This same situation of course also prohibits
> > >   srcu_barrier() from being invoked from CPU-hotplug notifiers.
> >
> > Thanks for checking, I completely missed this. I guess it only works
> > with SRCU if we use call_srcu(), but then we need to copy the pointers
> > to a new struct to avoid racing with the CPU getting onlined again.
> > Otherwise we can just bite the bullet and add a refcount, or use
> > migrate_disable() despite that being undesirable.
> >
> > Do you have a favorite? :)
>
> I briefly looked into refcounting. The annoying thing is that we need
> to handle the race between putting the last refcount in
> zswap_compress()/zswap_decompress(), and the CPU getting onlined again
> and re-initializing the refcount. One way to do it would be to put all
> dynamically allocated resources in a struct with the same struct with
> the new refcount, and use RCU + refcounts to allocate and free the
> struct as a whole.
>
> I am leaning toward just disabling migration for now tbh unless there
> are objections to that, especially this close to the v6.13 release.

(Sorry for going back and forth on this, I am essentially thinking out loud=
)

Actually, as Kanchana mentioned before, we should be able to just hold
the mutex in zswap_cpu_comp_dead() before freeing the dynamic
resources. The mutex is allocated when the pool is created and will
not go away during CPU hotunplug AFAICT. It confused me before because
we call mutex_init() in zswap_cpu_comp_prepare(), but it really should
be in zswap_pool_create() after we allocate the pool->acomp_ctx.

