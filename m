Return-Path: <stable+bounces-107949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8856EA051C9
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02470188A1E3
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480519CC29;
	Wed,  8 Jan 2025 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5SxzhG4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314D225D7;
	Wed,  8 Jan 2025 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308603; cv=none; b=Wh3kz7raqOpnPIaCtbcgxRLDIujpbAlJ79pGY71ULoXRIbaqZore8YngWhl6RUyLn7adVd9jBmP6zsYNNb1oYNVi4xpuGR05m3mb59TbLBET6B6oxyrd/WcsK6QhbyCzxmOXAzboY4TGbxyXCkKUectVjIqYjHAdk11RvYLb0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308603; c=relaxed/simple;
	bh=kTkHNFcAmLgA7DTfgLzYYdjnF54LXy3C+33BM3JSYik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUwh0GYQFBUi00+RL6BEq1jZFk6cCCSPHljEDyC17EM6XpTSKvuhaGOPQSt51xoL38BiqVKoYLNTyStKSkPkTcikDKiJxWKXZbb+Prk1unD+5ou+wg6jntLqABz3o9+4P+ksF7mTXOvrjutO5TVZgI3GMgfg+OKr5w8K32zGGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5SxzhG4; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd420f82e2so117857406d6.1;
        Tue, 07 Jan 2025 19:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736308601; x=1736913401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LmG5A5I+E9MxE/clW2UZdRgsfhoIXci32hD4W3/u0k=;
        b=g5SxzhG4vbn+YpbcU9JtL7EjwPlwiTofVmgYqLk6KD+GbTJUqHBlqRp2A7T3dTy8yN
         GIi+vwBLTFlc17DR/j2Qoovxl0b4OBEszARakuqPQnSU5hNBM2hmVRYyQLiD81DqRNgc
         xFs23ILfRQxcQWe/yU9HNvEDwvpFHGBiwrYG1A2c8tm/3ACorcspJxhVOWJ6oQdL/UZj
         DQ4vZXsfZ5EYxN8JQQESaQDY+S2gRcZhaeT0y/NxGap3USBiMd8ckQ4rOVFO8RznqZH5
         is0Cp9hb1we6FsFzhQU4X2Wd5dNLN6LHReq50efMtfMVQhCyl9780qpFlNCglnztB39j
         X1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736308601; x=1736913401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LmG5A5I+E9MxE/clW2UZdRgsfhoIXci32hD4W3/u0k=;
        b=HBkC0BtofgGglwmotXnjDWL1kF5lMZizvum7TyhsJHQIh0ZshMHhEAHFPqfnftuIkI
         QmNX0CiriG/cMAJIab9cCs8FxElbGa4KcenFy2tuzsXgZ/k6e8V8J4advV3bZxJDOxjW
         6YS6lH3DdpUcNIQ5+G2BbZTKc0oMWwqP2P8KQv3v+EEKsD9RV3vcbKkLvH/Byin+/YME
         quT0PRBNRGMw4mdzWwZIihR1cv32ruWUVYF/xijoqIUpaWXzMLBQh0GI65WFe0Hix6Az
         LkdjxUtZQV3frizOjTmD82++1nmPk1OgoZ9dZVey2QAmuOIBK6+GDpMud4AT3LCJOcnC
         R/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUy20rk+puI51vYHX+1pPIBhqFBAZzK9qP9bM+y6WNimVA/i0hce9JoINPPU5mcyDGR+e3Ay5tE@vger.kernel.org, AJvYcCWTfZ6T+zYrp9hDJAEVX027zmZNknJiQkbWMcCHAF/V/fNlKAKwEN5QWPw64kHtHllFqt2gG9ADtmLMlEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzeEwc+bmxgAjCvxFSxfljY3B6JpXZ7LKfrEJG6gsWCpz38oVs
	9FwCXnI5sazN4KWHl4CGp/D8sNrJ1a1IBV3AjHDjl9HrpJA2N8BDm7mhpOmiMJw+CNfcql5XJTo
	rw5nkAEuYzuYS7SUxG89lx2pDY1IDJuKIKyg=
X-Gm-Gg: ASbGncvwvvQAHCw1/vcKD/lYJm4VSEprGBjlFxjvOa5JphDluDXoEU7PhL3j4sdBCEm
	jbggJ7eJd2HEZxnbJWKO5tpsSiRZMXZrkIo3n
X-Google-Smtp-Source: AGHT+IHY7SvxFAE+sJ2buNA0FLVoUmgCXsdFA9pusrUT+WYVYwvPQEyRmPnn3JGlH2fsZV0FzFvUPCwmshAyjxtkV2g=
X-Received: by 2002:a05:6214:2e83:b0:6df:9b66:1041 with SMTP id
 6a1803df08f44-6df9b661062mr26062196d6.9.1736308601002; Tue, 07 Jan 2025
 19:56:41 -0800 (PST)
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
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Jan 2025 10:56:29 +0700
X-Gm-Features: AbW1kvaBN2ZiFdG-mi7swjIS4QrrebDd_-uxCuEn_Wsf0bLXJvRkUvqNXB9fkOc
Message-ID: <CAKEwX=M_wTnd9yWf4yzjjgPEsjMFW-TAr_m_29YK4-tDE0UMpA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU hotunplug
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 3:17=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
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

I much prefer the refcounting solution. IMO it's the "proper" fix -
disabling migration is such a heavy-handed resolution. A massive
hammer for a tiny nail, so to speak.

Is this a frequently occured problem in the wild? If so, we can
disable migration to firefight, and then do the proper thing down the
line.

(was also gonna suggest looking at zram, but it seems they have a
custom compression API now...)

