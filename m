Return-Path: <stable+bounces-108047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142DA069E5
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 01:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4BF3A6D63
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 00:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9E2EADA;
	Thu,  9 Jan 2025 00:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvSDCvWo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77B523A
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736382396; cv=none; b=JUDq7n6rVuj+jkbUk1269We+YMt8O+s3qoxpzSq5aG7ulhzWZb4mhq5WtSkVzEFLNxwlAypuxQAaNVPvCbyNhra1G6InNpZ+qtADC3Dq/SEd1OxkiUVP8ZzEALgDMyym63oQa1XB7uTxg+59NlzztJJE5GSwZsFOxiF7dHTshpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736382396; c=relaxed/simple;
	bh=sn0i5r9KPLvyv8p8LjYS0uiagSFu5q2fCumMUCSEV+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6vXpq4pnx/BbLMEJgN2oU2CBMUAtOw/0v2jJhNY92qV8Kah2Ir2O+R18UqT0g2121WRDw+UXQLflyEvnILTOnML5PpWopsuQyYn9opAGOuegEJUawKOw9Z01DVg+YK2Tbf8fzYiRzfFPMFtN/wa/HWal9NBfmNxQ9XzXvWo9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvSDCvWo; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d888fc8300so2266296d6.3
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 16:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736382393; x=1736987193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLgE0Q0cIPTZK8RuOUBCdOv21yWnN9ykzNp2HSvPXk8=;
        b=DvSDCvWoCBmPVvPOXOS4qtVJHrGCC83rd63qUNl76G4lwqj57GWA8BlcuSlI0mPU7f
         1LJWG6eQGYGeXxbFbub1OFChEOlhAkcq4bTjLFAYPG1fHN2lA+mAauZ1CQafQYMprjJD
         873ZbqYhrURyhJWSqttvWk2bJqwxpbkuf3gEzQPPcHWkBTPN6KfEiPZKvO6CqGqS/NQ3
         TXUxf+tKndrh/hJV3L9UyPdLs4Xqw4C315VivovLfDGovqMkhpGZ4jmlvb0gDhJWLpyy
         VeZ9wnHOaKUkoPesi9X3wqAlFG0bV86SUTV3MFXGbOHEDUOgu0TSQ6EaaJLHNX+9gDnu
         4IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736382393; x=1736987193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLgE0Q0cIPTZK8RuOUBCdOv21yWnN9ykzNp2HSvPXk8=;
        b=vgiPtOWrc60IOOVN5Deo/NAB+Cdp2PRamaNYkzlfnREOp/dgqVxoXSe6FFBC8x2Uie
         eB4obL2hgqixV0yUI6dniRhCSxVDshaXzTrnvBCpt45jcC4gA31uEI7MrVGm3HjjF/QE
         1rY0kRc+UDLCETsIAm6M4XV6l03sDQcUJHA2qxY9lWapyF2/0OZ0HScMvzbKdkHOAzbE
         HaAZ0/AeMTOK1ZFJKI0Ewan+x1fTjbXHE0sNijAHLMMSB8FA9enexzZNqGmUNjiOxR1f
         IIzLOgNP20CBdoWlKLWPw1V/jtGBWv3OFi2vb2JpANr6SrYJmxi/GUO7+3rd1XcVKX1N
         lcWA==
X-Forwarded-Encrypted: i=1; AJvYcCXcPrIcGe6DP2s99L0Oc2i3LdnaveOEwtKZXtU0qHMrWTHlkUuhkM7uWywUZ4fTw2mg7xLncEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65w7DnqgYryXGCzKLLSno4tPORmkEkStDwQwpuWN1G0RzVPXW
	MWdyUwEU63j7ecO9Qi7CELKBs88iKPDCqGsLvqb9k3Es0DuQfw/N12q2Oxa1xvHL7LY77qqYpEA
	talJ5fK6slI8tivNHQK5Rt50qPOMSguISoLhA
X-Gm-Gg: ASbGncs4Znp69xDYg8vtmF3EKzgf+bjfZJ9V0t9buAEmBtMKOl3dD49kGFTCnINZ4dn
	vYq9wRHrIUWVBKtva7TGdn94G1dMCHT4d+jk=
X-Google-Smtp-Source: AGHT+IENYv9CnknFzOJbCPZ2UbTQBoseHnypwVSub8bpZrdmMEr6ykgHuNKpG3EaOV6/1f5d27arO2reMg67ASRSi90=
X-Received: by 2002:a05:6214:2a4e:b0:6d8:9a85:5b34 with SMTP id
 6a1803df08f44-6df9b1d22a4mr78269516d6.10.1736382392701; Wed, 08 Jan 2025
 16:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108222441.3622031-1-yosryahmed@google.com> <SJ0PR11MB56788DAADC493DB60B36ECA9C9132@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56788DAADC493DB60B36ECA9C9132@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 8 Jan 2025 16:25:56 -0800
X-Gm-Features: AbW1kvahwVALjXZE_lkhWbY4X6wXHB4twdvoLsLVkOmzbIi19-49HpmhuP3WZF0
Message-ID: <CAJD7tkaxS1wjn+swugt8QCvQ-rVF5RZnjxwPGX17k8x9zSManA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: properly synchronize freeing resources
 during CPU hotunplug
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, 
	Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:12=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Wednesday, January 8, 2025 2:25 PM
> > To: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>; Nhat Pham
> > <nphamcs@gmail.com>; Chengming Zhou <chengming.zhou@linux.dev>;
> > Vitaly Wool <vitalywool@gmail.com>; Barry Song <baohua@kernel.org>; Sam
> > Sun <samsun1006219@gmail.com>; Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com>; linux-mm@kvack.org; linux-
> > kernel@vger.kernel.org; Yosry Ahmed <yosryahmed@google.com>;
> > stable@vger.kernel.org
> > Subject: [PATCH v2] mm: zswap: properly synchronize freeing resources
> > during CPU hotunplug
> >
> > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of
> > the
> > current CPU at the beginning of the operation is retrieved and used
> > throughout.  However, since neither preemption nor migration are
> > disabled, it is possible that the operation continues on a different
> > CPU.
> >
> > If the original CPU is hotunplugged while the acomp_ctx is still in use=
,
> > we run into a UAF bug as some of the resources attached to the acomp_ct=
x
> > are freed during hotunplug in zswap_cpu_comp_dead() (i.e.
> > acomp_ctx.buffer, acomp_ctx.req, or acomp_ctx.acomp).
> >
> > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
> > use crypto_acomp API for hardware acceleration") when the switch to the
> > crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
> > retrieved using get_cpu_ptr() which disables preemption and makes sure
> > the CPU cannot go away from under us.  Preemption cannot be disabled
> > with the crypto_acomp API as a sleepable context is needed.
> >
> > Use the acomp_ctx.mutex to synchronize CPU hotplug callbacks allocating
> > and freeing resources with compression/decompression paths. Make sure
> > that acomp_ctx.req is NULL when the resources are freed. In the
> > compression/decompression paths, check if acomp_ctx.req is NULL after
> > acquiring the mutex (meaning the CPU was offlined) and retry on the new
> > CPU.
> >
> > The initialization of acomp_ctx.mutex is moved from the CPU hotplug
> > callback to the pool initialization where it belongs (where the mutex i=
s
> > allocated). In addition to adding clarity, this makes sure that CPU
> > hotplug cannot reinitialize a mutex that is already locked by
> > compression/decompression.
> >
> > Previously a fix was attempted by holding cpus_read_lock() [1]. This
> > would have caused a potential deadlock as it is possible for code
> > already holding the lock to fall into reclaim and enter zswap (causing =
a
> > deadlock). A fix was also attempted using SRCU for synchronization, but
> > Johannes pointed out that synchronize_srcu() cannot be used in CPU
> > hotplug notifiers [2].
> >
> > Alternative fixes that were considered/attempted and could have worked:
> > - Refcounting the per-CPU acomp_ctx. This involves complexity in
> >   handling the race between the refcount dropping to zero in
> >   zswap_[de]compress() and the refcount being re-initialized when the
> >   CPU is onlined.
> > - Disabling migration before getting the per-CPU acomp_ctx [3], but
> >   that's discouraged and is a much bigger hammer than needed, and could
> >   result in subtle performance issues.
> >
> > [1]https://lkml.kernel.org/20241219212437.2714151-1-
> > yosryahmed@google.com/
> > [2]https://lkml.kernel.org/20250107074724.1756696-2-
> > yosryahmed@google.com/
> > [3]https://lkml.kernel.org/20250107222236.2715883-2-
> > yosryahmed@google.com/
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
> >
> > This applies on top of the latest mm-hotfixes-unstable on top of 'Rever=
t
> > "mm: zswap: fix race between [de]compression and CPU hotunplug"' and
> > after 'mm: zswap: disable migration while using per-CPU acomp_ctx' was
> > dropped.
> >
> > v1 -> v2:
> > - Move the initialization of the mutex to pool initialization.
> > - Use the mutex to also synchronize with the CPU hotplug callback (i.e.
> >   zswap_cpu_comp_prep()).
> > - Naming cleanups.
> >
> > ---
> >  mm/zswap.c | 60 +++++++++++++++++++++++++++++++++++++++++---------
> > ----
> >  1 file changed, 46 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb236..4d7e564732267 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -251,7 +251,7 @@ static struct zswap_pool *zswap_pool_create(char
> > *type, char *compressor)
> >       struct zswap_pool *pool;
> >       char name[38]; /* 'zswap' + 32 char (max) num + \0 */
> >       gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN |
> > __GFP_KSWAPD_RECLAIM;
> > -     int ret;
> > +     int ret, cpu;
> >
> >       if (!zswap_has_pool) {
> >               /* if either are unset, pool initialization failed, and w=
e
> > @@ -285,6 +285,9 @@ static struct zswap_pool *zswap_pool_create(char
> > *type, char *compressor)
> >               goto error;
> >       }
> >
> > +     for_each_possible_cpu(cpu)
> > +             mutex_init(&per_cpu_ptr(pool->acomp_ctx, cpu)->mutex);
> > +
> >       ret =3D
> > cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
> >                                      &pool->node);
> >       if (ret)
> > @@ -821,11 +824,12 @@ static int zswap_cpu_comp_prepare(unsigned int
> > cpu, struct hlist_node *node)
> >       struct acomp_req *req;
> >       int ret;
> >
> > -     mutex_init(&acomp_ctx->mutex);
> > -
> > +     mutex_lock(&acomp_ctx->mutex);
> >       acomp_ctx->buffer =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL,
> > cpu_to_node(cpu));
> > -     if (!acomp_ctx->buffer)
> > -             return -ENOMEM;
> > +     if (!acomp_ctx->buffer) {
> > +             ret =3D -ENOMEM;
> > +             goto buffer_fail;
> > +     }
> >
> >       acomp =3D crypto_alloc_acomp_node(pool->tfm_name, 0, 0,
> > cpu_to_node(cpu));
> >       if (IS_ERR(acomp)) {
> > @@ -844,6 +848,8 @@ static int zswap_cpu_comp_prepare(unsigned int
> > cpu, struct hlist_node *node)
> >               ret =3D -ENOMEM;
> >               goto req_fail;
> >       }
> > +
> > +     /* acomp_ctx->req must be NULL if the acomp_ctx is not fully
> > initialized */
> >       acomp_ctx->req =3D req;
>
> For this to happen, shouldn't we directly assign:
>  acomp_ctx->req =3D acomp_request_alloc(acomp_ctx->acomp);
>  if (!acomp_ctx->req) { ...}

For the initial zswap_cpu_comp_prepare() call on a CPU, it doesn't
matter because a failure will cause a failure of initialization or CPU
onlining. For calls after a CPU is offlined, zswap_cpu_comp_dead()
will have set acomp_ctx->req to NULL, so leaving it unmodified keeps
it as NULL.

Although I suppose the comment is not really clear because
zswap_cpu_comp_prepare() could fail before acomp_request_alloc() is
ever called and this would not be a problem (as the onlining will
fail).

Maybe it's best to just drop the comment.

Andrew, could you please fold this in?

diff --git a/mm/zswap.c b/mm/zswap.c
index 4d7e564732267..30f5a27a68620 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -848,8 +848,6 @@ static int zswap_cpu_comp_prepare(unsigned int
cpu, struct hlist_node *node)
                ret =3D -ENOMEM;
                goto req_fail;
        }
-
-       /* acomp_ctx->req must be NULL if the acomp_ctx is not fully
initialized */
        acomp_ctx->req =3D req;

        crypto_init_wait(&acomp_ctx->wait);

>
> I was wondering how error conditions encountered in zswap_cpu_comp_prepar=
e()
> will impact zswap_[de]compress(). This is probably unrelated to this patc=
h itself,
> but is my understanding correct that an error in this procedure will caus=
e
> zswap_enabled to be set to false, which will cause any zswap_stores() to =
fail early?

Yeah that is my understanding, for the initial call. For later calls
when a CPU gets onlined I think the CPU onlining fails and the
acomp_ctx is not used.

