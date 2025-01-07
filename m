Return-Path: <stable+bounces-107921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8128A04D7E
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3041418866F6
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4961F2372;
	Tue,  7 Jan 2025 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4s90mV/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF621E47CD
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292394; cv=none; b=V9OTIJ1uomX200qF9g1tmm5ukYevMf/eu/PxIX8Z2sPLMFwUlofeNL04/0zRu77WrlreTKdpoUGk5zFOOjPTiseM2SBT30UgZSiNatqbzoWChwXrBkoITUEuLJlFVpEinhG6C3+qGhCWX85oN/OK/sHpnbFd/tGoUx6fq5BmP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292394; c=relaxed/simple;
	bh=lXCdCKyCbye6RmRymQL/gIDay9/V+/wyFqYx4AIMfr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEjd8NcSACbGCwEeNY/RNHrZFve3RHxtz5GmLOoXmfcNAUGld8cE2rcc2kiozrVdY7Pu8q2tS0u3jn5Zhicl/k77SDPExXZEeqdJjEkAJPQD3PLIkynlKJNJQhvgmcvjVjb4L/lDxhpNyRXl/gNYquKOEnFlAQs+Sj9eGBsgWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4s90mV/4; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d89a727a19so2904496d6.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 15:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736292391; x=1736897191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hGrSqrmdpX4tyBMP+VqZLOR834ah3UzKPlD5+TusBg=;
        b=4s90mV/4TbI5kP1I4aaVwO4qvTjoFEziSNSUtH9R6JVDzx3UvKfsxenBDqd8rYuWR4
         hmgAVClZgMG05s7IPRaJ8YL4gUfdZYQZ940LNhxqyj54qDVRGo4jMu+RrsFIoz9CHUVH
         doxlibB55dLCJuX3a8WQEV5kxg6Yx1C+89KtSN3fxkHp/ieLedWrF7by4W2TWYuNpWvH
         l0rr/n0Mv9HwQVGbR2Ly0hTukNLw7dz4DO2fADl5VTweabiTDe7U331n+nLsscCR1h6E
         OxrCd/q3RLfywXjdqudkROeOb0c2DbA/tlYqvK8W9SQvEV67ENkRgDEz+leI/IBmkE05
         1MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736292391; x=1736897191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hGrSqrmdpX4tyBMP+VqZLOR834ah3UzKPlD5+TusBg=;
        b=tOP7ev+klHnMasMZom3acLVXVKn4EdKp76l4zKz909Nz5xNrFwWatPFfWZ8cb6kY0r
         1BLtqnkG2Vb9UnBJh/gkYyK206B9bjtjLSd/1vvnq2A8/XzspasJh21kVg38mJzr0z0U
         /szumIMs9UaOEjE/K4l2MBDfg1Pq6xednyvs5G4HQ0YQHeqBTtYkqN1F7U2d7N/X8ZuK
         hjiQV8xV5FwQnIIp4VFu7oItLMCl6uHK3kWCdPy6AzyPnOPX7wclCcEYBxN6iYEZFk9e
         Cm8ErvmeypkywW9BVHEv54TobY61bqrA0iwQmdYEnvoQBck9Z5iR4wFCOeG4IMwRFcgG
         jw9g==
X-Forwarded-Encrypted: i=1; AJvYcCWEO9cEO6AIS88I50XwUS2wasZ90fbMe0my9s+u6f7tGwFnhjfZhbDRjPY07aA7HHteOBN6xyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrznkkMDTnV9NiAPgOGctd3L3k1cIRBtneg7w5Y7xd3oKxDw7E
	4Xn3iVfUsYTX+Uz2AOJ9cuyQqnpfAoevIE9LRKUVbQKrRvbs7o7Pb474aZouumQ4UKC00KXrJQs
	Pn1BC0Mbc/FGP4aO4JEtLXR509XT8qlReRlLt
X-Gm-Gg: ASbGncsZgSLIO/0uHMsVeDgxUu9HoaaB6g+AM4lHqKf/qW1D2rQAXBspDtBZbuq1zBh
	6dwUp/vOhyl8qjW/OmOSQPO+uD1BWzxwmGHUxsBRwS8UAIwRbhI8FJ3CPDBplS+uceeuU
X-Google-Smtp-Source: AGHT+IGeo4buhf3gUhtYgSoQ5NrDJaoAHdwhJtgc4THHGbI2Xo7Th1vgKNT5hAoKBC0XC89QB4ds+0P/GLNv1cPW9NM=
X-Received: by 2002:ad4:5969:0:b0:6d9:162a:27a2 with SMTP id
 6a1803df08f44-6df8e89a962mr73887636d6.21.1736292391235; Tue, 07 Jan 2025
 15:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <CAGsJ_4xN9=5cksaGPqh_6jyH-EJkw-DH1zwx81Kotqh85BJ+ZQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xN9=5cksaGPqh_6jyH-EJkw-DH1zwx81Kotqh85BJ+ZQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 15:25:54 -0800
X-Gm-Features: AbW1kvZgg6_6Cmw-lUETFjN7suc5PDdh2Ki8tuiK3wxZF9aqlELvcIfv6Q9XBqA
Message-ID: <CAJD7tkbnYaZFYw0ieor81e--e6qJVgb3045x86c0EKV546TyWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 2:47=E2=80=AFPM Barry Song <baohua@kernel.org> wrote=
:
>
> On Wed, Jan 8, 2025 at 11:22=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of th=
e
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
> > The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to u=
se
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
> > Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardwa=
re acceleration")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.o=
rg/
> > Reported-by: Sam Sun <samsun1006219@gmail.com>
> > Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7=
Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> > ---
> >  mm/zswap.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb236..ecd86153e8a32 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, s=
truct hlist_node *node)
> >         return 0;
> >  }
> >
> > +/* Remain on the CPU while using its acomp_ctx to stop it from going o=
ffline */
> > +static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_=
ctx __percpu *acomp_ctx)
> > +{
> > +       migrate_disable();
>
> I'm not entirely sure, but I feel it is quite unsafe. Allowing sleep
> during migrate_disable() and
> migrate_enable() would require the entire scheduler, runqueue,
> waitqueue, and CPU
> hotplug mechanisms to be aware that a task is pinned to a specific CPU.

My understanding is that sleeping is already allowed when migration is
disabled (unlike preemption). See delete_all_elements() in
kernel/bpf/hashtab.c for example, or __bpf_prog_enter_sleepable() in
kernel/bpf/trampoline.c. I am not sure exactly what you mean.

>
> If there is no sleep during this period, it seems to be only a
> runqueue issue=E2=80=94CPU hotplug can
> wait for the task to be unpinned while it is always in runqueue.
> However, if sleep is involved,
> the situation becomes significantly more complex.
>
> If static data doesn't consume much memory, it could be the simplest solu=
tion.

Do you mean allocating the buffers and requests for all possible CPUs
instead of allocating them dynamically in CPU hotplug notifiers? I am
not sure how much more memory this would be. Seems like it depends on
CONFIG options and the firmware.

