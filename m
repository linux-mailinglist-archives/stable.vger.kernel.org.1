Return-Path: <stable+bounces-107912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7AFA04CA3
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC5D3A12A0
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 22:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836381D5170;
	Tue,  7 Jan 2025 22:47:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235119D093;
	Tue,  7 Jan 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290050; cv=none; b=CIQs3m8hsmj5S+jiXt1Zba8R03vf5IekUvI3Ygsfw8ig07vizUebqYtKa12IUDBhUMXZaAkIv5TYPDnDU8NhhO0kLu5oDGfVEI7I+Kew8Rgek0OxpDTmGMk4Eg0tXZ3xYMxHIVOtit1d/rgjNiAep19QeLnI0UUz6ew08oib4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290050; c=relaxed/simple;
	bh=GblGydoFn0DWzO6v9Ui1AxPFAQkDzDp2SsyUVbYxXeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ji39q77APJwGUSb/ma8Xh9TuxrHup970IT1L8MbDGghMSQsJVCeNyZ4A/L6Qy085la64WtOcHMIl5HdORBBVIq533rg0zo9O/xxKqTnASgUumtIPgPI5l+xs8akOBVaPuO3Dexzrr1KgClOqAeC5H84e5RbGMQbrVT8YvlONh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afe7429d37so4154438137.2;
        Tue, 07 Jan 2025 14:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736290047; x=1736894847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ooH0vaWtWOqcdYrhPxvWhO/7+B2PYs9eRg1ein9EOg=;
        b=wE5XHC2nAPLefPrWQqiSuwAwDWz0i8sGwP4W4WoBxY6rEbE0landh3jAu1JyW1s/9Z
         /WiXoo+zkX60X3FK/CWNuMZsvAfBimVF3jZ8B/HH64oHRBuEBG2TVJcRcodIaOLzubDu
         IfCltve1WlzueuboXh/efJXm4+umSGHGue7BhIc9EL4HU/4gyS+2VHl6i//RoJYzttIX
         EjSz89UPH08m6HEkLmSKLTpKYktYrMemnVnLt7wkyDqdRNaGh1hZub4P9ppqwHENgo22
         NmV2f/gmPYblVuWhjmssMvrRhiT74ziiymhPpUZQVoufuSk0AAfz0qfQrl+IUZdgcOv3
         3rGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Vk+w4wRP/ipiSGbgWFwIKj4B9GqTBi3wPKGGpQ9i1xy3mEX6mqTLpcnf+3mcb48FZafAa+lvbtO4DSQ=@vger.kernel.org, AJvYcCWg33gq3Us1OMxOSqkUTsfr6X6eausraIvVctXQ5l5Qik8e6djD3Z+y89G9hgZVpN0tNYAJA3WC@vger.kernel.org
X-Gm-Message-State: AOJu0YwedmJs3zUBuW4PcfXYkLazYajk1kGHyjsvwQP+GLhD11VLbV5m
	6ayq0nMPVPU5aEh++cgx6Np36VdgeucuEaqP80g2I113G9OxUfMlYGpgYlgBaHbYfeA5NBbGUMG
	AHNEBh/XcOluTVXt60aMow74jAtg=
X-Gm-Gg: ASbGncto4iZNxOKrdT+wUinVIfAMlKV3BHR22ZiHsEGrac/B4ba4ESy3HXKYOdet6YP
	J3oYlh/b3zZXg1v2Ea7fm7m4i3+DDoky6joO0TSnE0W2MMF0PQ8dPTqWw1f+DdCtn2M7RrJs=
X-Google-Smtp-Source: AGHT+IGClFR4QNV/SEyGwTl8SkMBRo73dL+R/tN3+uEMnzHbAXKgypPI2N7hkTUZLt54KwIYmhzhTqwArZWIeu6wSVQ=
X-Received: by 2002:a05:6102:2922:b0:4b2:9eeb:518f with SMTP id
 ada2fe7eead31-4b3d0f99b14mr750480137.10.1736290047553; Tue, 07 Jan 2025
 14:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com> <20250107222236.2715883-2-yosryahmed@google.com>
In-Reply-To: <20250107222236.2715883-2-yosryahmed@google.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 8 Jan 2025 11:47:16 +1300
X-Gm-Features: AbW1kvZP6vuj9CYsgczXGnDcHIyoKmrMcAatROq88dIGiGXVOb2cj04nfYozpzc
Message-ID: <CAGsJ_4xN9=5cksaGPqh_6jyH-EJkw-DH1zwx81Kotqh85BJ+ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:22=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
> current CPU at the beginning of the operation is retrieved and used
> throughout.  However, since neither preemption nor migration are disabled=
,
> it is possible that the operation continues on a different CPU.
>
> If the original CPU is hotunplugged while the acomp_ctx is still in use,
> we run into a UAF bug as the resources attached to the acomp_ctx are free=
d
> during hotunplug in zswap_cpu_comp_dead().
>
> The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to use
> crypto_acomp API for hardware acceleration") when the switch to the
> crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
> retrieved using get_cpu_ptr() which disables preemption and makes sure th=
e
> CPU cannot go away from under us.  Preemption cannot be disabled with the
> crypto_acomp API as a sleepable context is needed.
>
> Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> per-acomp_ctx") increased the UAF surface area by making the per-CPU
> buffers dynamic, adding yet another resource that can be freed from under
> zswap compression/decompression by CPU hotunplug.
>
> This cannot be fixed by holding cpus_read_lock(), as it is possible for
> code already holding the lock to fall into reclaim and enter zswap
> (causing a deadlock). It also cannot be fixed by wrapping the usage of
> acomp_ctx in an SRCU critical section and using synchronize_srcu() in
> zswap_cpu_comp_dead(), because synchronize_srcu() is not allowed in
> CPU-hotplug notifiers (see
> Documentation/RCU/Design/Requirements/Requirements.rst).
>
> This can be fixed by refcounting the acomp_ctx, but it involves
> complexity in handling the race between the refcount dropping to zero in
> zswap_[de]compress() and the refcount being re-initialized when the CPU
> is onlined.
>
> Keep things simple for now and just disable migration while using the
> per-CPU acomp_ctx to block CPU hotunplug until the usage is over.
>
> Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware=
 acceleration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org=
/
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv=
4OcuruL4tPg6OaQ@mail.gmail.com/
> ---
>  mm/zswap.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb236..ecd86153e8a32 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, str=
uct hlist_node *node)
>         return 0;
>  }
>
> +/* Remain on the CPU while using its acomp_ctx to stop it from going off=
line */
> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_ct=
x __percpu *acomp_ctx)
> +{
> +       migrate_disable();

I'm not entirely sure, but I feel it is quite unsafe. Allowing sleep
during migrate_disable() and
migrate_enable() would require the entire scheduler, runqueue,
waitqueue, and CPU
hotplug mechanisms to be aware that a task is pinned to a specific CPU.

If there is no sleep during this period, it seems to be only a
runqueue issue=E2=80=94CPU hotplug can
wait for the task to be unpinned while it is always in runqueue.
However, if sleep is involved,
the situation becomes significantly more complex.

If static data doesn't consume much memory, it could be the simplest soluti=
on.

> +       return raw_cpu_ptr(acomp_ctx);
> +}
> +
> +static void acomp_ctx_put_cpu(void)
> +{
> +       migrate_enable();
> +}
> +
>  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>                            struct zswap_pool *pool)
>  {
> @@ -893,8 +905,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>         gfp_t gfp;
>         u8 *dst;
>
> -       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> -
> +       acomp_ctx =3D acomp_ctx_get_cpu(pool->acomp_ctx);
>         mutex_lock(&acomp_ctx->mutex);
>
>         dst =3D acomp_ctx->buffer;
> @@ -950,6 +961,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>                 zswap_reject_alloc_fail++;
>
>         mutex_unlock(&acomp_ctx->mutex);
> +       acomp_ctx_put_cpu();
>         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
>  }
>
> @@ -960,7 +972,7 @@ static void zswap_decompress(struct zswap_entry *entr=
y, struct folio *folio)
>         struct crypto_acomp_ctx *acomp_ctx;
>         u8 *src;
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       acomp_ctx =3D acomp_ctx_get_cpu(entry->pool->acomp_ctx);
>         mutex_lock(&acomp_ctx->mutex);
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> @@ -990,6 +1002,7 @@ static void zswap_decompress(struct zswap_entry *ent=
ry, struct folio *folio)
>
>         if (src !=3D acomp_ctx->buffer)
>                 zpool_unmap_handle(zpool, entry->handle);
> +       acomp_ctx_put_cpu();
>  }
>
>  /*********************************
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

Thanks
barry

