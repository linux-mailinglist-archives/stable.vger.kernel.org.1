Return-Path: <stable+bounces-107930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D955A04E08
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747E51887E9F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8D10E4;
	Wed,  8 Jan 2025 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWCkwbHQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1B645
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736295168; cv=none; b=Np3Awb/lQyBnKH6cMiBd/lmuNfZj9fe248BFLgEp96FmO3R8pC4uDClsWrCZ5HXFkORPTN4QVGDmJwgYhlU/PIyrHvWf8jiSAMW+GRQL0ATuzFCIHL36KuP3DfVy0pF7F50NZFUZD3RYCYIaBNAy8pDF+Ofajqevu8XwZgC/qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736295168; c=relaxed/simple;
	bh=qohhugrRBitVO9t0/4GuXnCpCCCNfyruEVWcx2YdId0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw2vq1dTnFZeF+mtydX442EFkpgej9uy9sWspE2VeoSdIGjmakhUJDzE9aCNaLS74svo1shcnrzRqMnT0FcuRruViNHYfO3kwLSA4s03NK8SogGAF47spUw1n3yQfAd3usq1zllCK/xR8V4i0CQsbNknu1pgNCrpkcbf4eV+x+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWCkwbHQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dcc42b5e30so95695276d6.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 16:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736295166; x=1736899966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyFOZ8N3L8gopi8oYWFnwAPpujFC0e4PTIWnAX+e2tY=;
        b=pWCkwbHQmtzsZUvR3DEa67m3N6ytwZit/jRf9GMDp+m5XvznRYZfg7fpr3JWB6OdQK
         cvBmLQdIMBuTL3yqd71T/eyq/D/OcPyN5mafbsinMOBAdyGuS+mLNkdn+f0WTpmvTxf9
         Slx/ifukqIjeFNlB0pWALsWagm88a1M9gym+mV27eNYbAanASY6SF+L2Xk47aUAdfxve
         O2dGf7bEeD0WmLt9tnxABzNcxlQjGyQpWDtDr7nMRWPA6ganJ73yvSM15aRtkRsBjKY4
         QJyBZGmcsjH2KSWC7D8HqmnRWivbYRSf2ecYzcogeqP0JFPxoaIuqvJjE0NtVFCIrN/y
         kB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736295166; x=1736899966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyFOZ8N3L8gopi8oYWFnwAPpujFC0e4PTIWnAX+e2tY=;
        b=rMy7r30PQL4dm6a/NaOJYbZxV9/qDEiJAHiJiSsxFN8XfIsNEK5UG29joOEEqqbuEX
         rYD8ji9gusOFD3LG8urqSuWXLv/oQNZBAvUIw5LH1T9CQReIng4Y/owvX5zTv2LdsthE
         mqWwDAaE3yq1Y6nIOIWg8qdlbcqqr4BENLgqBtINx/KmAunpZcWAvB3xZxNvNI83f/Nk
         8CzulCU93NNAMHPeZbGoHaFBroAYYI1tBixA/nF2G4Gmoayfjp4hIl1ZgLHxfo/TR6cD
         UpKmXaopkupCrdV6enAW5O7S7gMXBk5/gp5QoSJ3it1HZU/lD8pvZFKSOw64n3SI5lC6
         sKQA==
X-Forwarded-Encrypted: i=1; AJvYcCUI68HakEB9GBNuV0H7sJt1uU6UOAVkuY3lwO3yPeofjoNcJsp3U6t0w/2OdDLFdHyJPZe2mZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywd3TwUULFQfMGMHbR2XtVCua0hus9k4ht+On+2py6hT7jJoDD
	y2qtzEso0LXejIqt6NPvzgQq0/awQjsI30qjWQA4r0Yvx72tLmeD24npAqx5q8BG9/4MF7iTN31
	QNwvpMJYNu7VvQuNEir4pyYpnHTBBBxltwGAd
X-Gm-Gg: ASbGncshRbSRJ4+mIZ27VH277hsdGmP8mc7ddJqPq+/yI9IrtbcgRSCgqpLaimHf1dM
	2hIwp2RTVrhKBIry7jyqMzGtXIXxeMCklwuWQAjX6RhZA7eWZb6vo+X0qgZeLF3mGaSK4
X-Google-Smtp-Source: AGHT+IGG1H1HkngClefMwX+rP3psq1Y99MvS2W7HfkMNMccBO5UF8GeRK9GanfB9Z03ow6XNJJ+6jgAUXI6fK0/c2q8=
X-Received: by 2002:a05:6214:300f:b0:6d8:a730:110c with SMTP id
 6a1803df08f44-6df9b301163mr16423506d6.38.1736295165819; Tue, 07 Jan 2025
 16:12:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 16:12:09 -0800
X-Gm-Features: AbW1kvYzpWpq2pT1tCl4QyyuO236RYxeZfy1X4uJ4OsxzPPVJfcp_Hvu7Tl6yXs
Message-ID: <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, 
	Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:02=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Yosry,
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Tuesday, January 7, 2025 2:23 PM
> > To: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>; Nhat Pham
> > <nphamcs@gmail.com>; Chengming Zhou <chengming.zhou@linux.dev>;
> > Vitaly Wool <vitalywool@gmail.com>; Barry Song <baohua@kernel.org>; Sam
> > Sun <samsun1006219@gmail.com>; Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com>; linux-mm@kvack.org; linux-
> > kernel@vger.kernel.org; Yosry Ahmed <yosryahmed@google.com>;
> > stable@vger.kernel.org
> > Subject: [PATCH v2 2/2] mm: zswap: disable migration while using per-CP=
U
> > acomp_ctx
> >
> > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of
> > the
> > current CPU at the beginning of the operation is retrieved and used
> > throughout.  However, since neither preemption nor migration are disabl=
ed,
> > it is possible that the operation continues on a different CPU.
> >
> > If the original CPU is hotunplugged while the acomp_ctx is still in use=
,
> > we run into a UAF bug as the resources attached to the acomp_ctx are fr=
eed
> > during hotunplug in zswap_cpu_comp_dead().
> >
> > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
> > use
> > crypto_acomp API for hardware acceleration") when the switch to the
> > crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
> > retrieved using get_cpu_ptr() which disables preemption and makes sure =
the
> > CPU cannot go away from under us.  Preemption cannot be disabled with t=
he
> > crypto_acomp API as a sleepable context is needed.
> >
> > Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> > per-acomp_ctx") increased the UAF surface area by making the per-CPU
> > buffers dynamic, adding yet another resource that can be freed from und=
er
> > zswap compression/decompression by CPU hotunplug.
> >
> > This cannot be fixed by holding cpus_read_lock(), as it is possible for
> > code already holding the lock to fall into reclaim and enter zswap
> > (causing a deadlock). It also cannot be fixed by wrapping the usage of
> > acomp_ctx in an SRCU critical section and using synchronize_srcu() in
> > zswap_cpu_comp_dead(), because synchronize_srcu() is not allowed in
> > CPU-hotplug notifiers (see
> > Documentation/RCU/Design/Requirements/Requirements.rst).
> >
> > This can be fixed by refcounting the acomp_ctx, but it involves
> > complexity in handling the race between the refcount dropping to zero i=
n
> > zswap_[de]compress() and the refcount being re-initialized when the CPU
> > is onlined.
> >
> > Keep things simple for now and just disable migration while using the
> > per-CPU acomp_ctx to block CPU hotunplug until the usage is over.
> >
> > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for
> > hardware acceleration")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > Closes:
> > https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
> > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > Closes:
> > https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4O
> > curuL4tPg6OaQ@mail.gmail.com/
> > ---
> >  mm/zswap.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb236..ecd86153e8a32 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
> > struct hlist_node *node)
> >       return 0;
> >  }
> >
> > +/* Remain on the CPU while using its acomp_ctx to stop it from going o=
ffline
> > */
> > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct
> > crypto_acomp_ctx __percpu *acomp_ctx)
> > +{
> > +     migrate_disable();
> > +     return raw_cpu_ptr(acomp_ctx);
> > +}
> > +
> > +static void acomp_ctx_put_cpu(void)
> > +{
> > +     migrate_enable();
> > +}
> > +
> >  static bool zswap_compress(struct page *page, struct zswap_entry *entr=
y,
> >                          struct zswap_pool *pool)
> >  {
> > @@ -893,8 +905,7 @@ static bool zswap_compress(struct page *page, struc=
t
> > zswap_entry *entry,
> >       gfp_t gfp;
> >       u8 *dst;
> >
> > -     acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> > -
> > +     acomp_ctx =3D acomp_ctx_get_cpu(pool->acomp_ctx);
> >       mutex_lock(&acomp_ctx->mutex);
> >
> >       dst =3D acomp_ctx->buffer;
> > @@ -950,6 +961,7 @@ static bool zswap_compress(struct page *page, struc=
t
> > zswap_entry *entry,
> >               zswap_reject_alloc_fail++;
> >
> >       mutex_unlock(&acomp_ctx->mutex);
> > +     acomp_ctx_put_cpu();
>
> I have observed that disabling/enabling preemption in this portion of the=
 code
> can result in scheduling while atomic errors. Is the same possible while
> disabling/enabling migration?

IIUC no, migration disabled is not an atomic context.

>
> Couple of possibly related thoughts:
>
> 1) I have been thinking some more about the purpose of this per-cpu acomp=
_ctx
>      mutex. It appears that the main benefit is it causes task blocked er=
rors (which are
>      useful to detect problems) if any computes in the code section it co=
vers take a
>      long duration. Other than that, it does not protect a resource, nor =
prevent
>      cpu offlining from deleting its containing structure.

It does protect resources. Consider this case:
- Process A runs on CPU #1, gets the acomp_ctx, and locks it, then is
migrated to CPU #2.
- Process B runs on CPU #1, gets the same acomp_ctx, and tries to lock
it then waits for process A. Without the lock they would be using the
same lock.

It is also possible that process A simply gets preempted while running
on CPU #1 by another task that also tries to use the acomp_ctx. The
mutex also protects against this case.

>
> 2) Seems like the overall problem appears to be applicable to any per-cpu=
 data
>      that is being used by a process, vis-a-vis cpu hotunplug. Could it b=
e that a
>      solution in cpu hotunplug can safe-guard more generally? Really not =
sure
>      about the specifics of any solution, but it occurred to me that this=
 may not
>      be a problem unique to zswap.

Not really. Static per-CPU data and data allocated with alloc_percpu()
should be available for all possible CPUs, regardless of whether they
are online or not, so CPU hotunplug is not relevant. It is relevant
here because we allocate the memory dynamically for online CPUs only
to save memory. I am not sure how important this is as I am not aware
what the difference between the number of online and possible CPUs can
be in real life deployments.

>
> Thanks,
> Kanchana
>
> >       return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
> >  }
> >
> > @@ -960,7 +972,7 @@ static void zswap_decompress(struct zswap_entry
> > *entry, struct folio *folio)
> >       struct crypto_acomp_ctx *acomp_ctx;
> >       u8 *src;
> >
> > -     acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > +     acomp_ctx =3D acomp_ctx_get_cpu(entry->pool->acomp_ctx);
> >       mutex_lock(&acomp_ctx->mutex);
> >
> >       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > @@ -990,6 +1002,7 @@ static void zswap_decompress(struct zswap_entry
> > *entry, struct folio *folio)
> >
> >       if (src !=3D acomp_ctx->buffer)
> >               zpool_unmap_handle(zpool, entry->handle);
> > +     acomp_ctx_put_cpu();
> >  }
> >
> >  /*********************************
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
>

