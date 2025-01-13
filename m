Return-Path: <stable+bounces-108467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CFA0BCC1
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE377A1540
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1614A4D1;
	Mon, 13 Jan 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVy0ILAD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91A1494A9
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784027; cv=none; b=CyqSk4vcok8W2NlzOecyoVm2i10YWqePkN6Kc4iA+K5/sh0iikCJQl5Cn1XY55UNdUX1zH8fjkz/QpBXmbjVeUHQZ6GJD03bnD8JgMlkfvASaqQ4VIUR007vVrvUrHlfaxp6ntznstdVcNf+J5ko2Rn1OO9uOrmoRFAV5knCtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784027; c=relaxed/simple;
	bh=KTpihp9PpF67ubP1cSpAe+/L6Dkn2WaK1c5A2B+Y7/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaSaXy04d6AHwZOpUExEyU7uFGoKywVASps/qN05oUJdmuPXXkfSqXL6RNajNG6ZYrW0xwzZI/UlOBNEp/Z5Fc82MFmIkSh8lCALqtJHDOuAeDFSJxRCTZltmdYztcmezGnGX2SBjDD2ZrUK7VgRt+Lj+bNMV8tWRS+0gl0QdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVy0ILAD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6f53c12adso358724185a.1
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 08:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736784024; x=1737388824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAYqGiQrMzKyyOAIGSVf23PCYDYkpyjbCE0vivyp7gw=;
        b=AVy0ILADYtavMsxiHRMCROa4aw+7StwqniKowU1nhAhkkJy6Ie2Rb5uUtX3wsWHJcD
         04LGp9hxYCVjlPVL9C7xx6fVjza89Uy7YJ/YHZXI5hDrOiEVzgjEbl8L6pH+e7JWIXNL
         IoiIC3mWagCIn8aeJHJ3ShVcNlMUM5E3P5yO2CSORsWa27e3o64B/GuWoEkwEnV9Ngjn
         HxvZec4GfNThaVbAYXRlujaNjeZFlHhEBIpFA756h+Zg+7fyINut9OIjxgZcKKitz4nP
         KNZRgET8aTMjb3HVjC6TQkf3xggmXaykGoY70eG7uhESzlngohg3BewuGCrb7OLIazrR
         msdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784024; x=1737388824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAYqGiQrMzKyyOAIGSVf23PCYDYkpyjbCE0vivyp7gw=;
        b=uTOQ1ZJEbAERafMAMf149d0Uqx+rZO7EKzavIZpJ/9w/uL3NlBwU63YFBCU7N65vK5
         o4J6nlDXFfCx9nYIsFPiPu+8GdwhGeq8R8+61MC5/leglSucrqQRbMulOZsH5gbojERi
         IhbrmwG+rTitQkagh9lHfvPyhPeImC2eVQCHbT62/4NDu3N8wwQQNG07dwMQ9fa8hhKS
         x77QzeOeDWPzx1Ioz10ikAGv3XqSYY2l8lZjxcBal2Yt8hJwMm61G2bbjadm1g/ZgM7p
         1+wvfwfRAzOH1L2Mn/AXKO3NhH7HBz+9EVSNLRncfgWccrW2QEYzqxVuzNuxB29Vfk5H
         RoNA==
X-Gm-Message-State: AOJu0Yy80XF4mzWqte16xGx/zq7HpE26cYsfp6MDHSRyWbV2Jvf6Dyrx
	lmi+aQmTZfakcjbd61HOuLcymkzluVNrFYYH+9X3384TvitAuHNK+FsvjDGCovv8FX8vXRXyyRO
	pwZ+HdOykRXRcb/CQRs1EnnOdCC29unQNE38mkUOPthKo66SECLT8
X-Gm-Gg: ASbGncsXlDU5UjI1v/BD8y1uxzqrDqrUTyiD/DO9a4Ts+xxVLieO2chLpzu6VVVAzeM
	DkxPI4qic5VnW70sYy07mJv2LiBVE/m3ApVg=
X-Google-Smtp-Source: AGHT+IFe9e3TDfdZ8J+YGDGZaU9tKgBlvb04OxSfhUSLAJlwarSJTQidhdJMlHhCCXTIx6gzegM2mNWTP5HaBpD3dwA=
X-Received: by 2002:a05:6214:23c5:b0:6d8:890c:1f08 with SMTP id
 6a1803df08f44-6df9b2348a7mr317049846d6.26.1736784023890; Mon, 13 Jan 2025
 08:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113140408.1739713-1-sashal@kernel.org>
In-Reply-To: <20250113140408.1739713-1-sashal@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 13 Jan 2025 07:59:47 -0800
X-Gm-Features: AbW1kvYO_b-67tfIOClFCf77d4f-xrvZWF_AWG2iIkmZ7QwkuagS49Td-97_hc8
Message-ID: <CAJD7tkYY=aUDzDDpPHW6qiPxJxAD7mM-Lrs9GZGyamSEJX8CyA@mail.gmail.com>
Subject: Re: Patch "mm: zswap: fix race between [de]compression and CPU
 hotunplug" has been added to the 6.12-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 6:04=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     mm: zswap: fix race between [de]compression and CPU hotunplug
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      mm-zswap-fix-race-between-de-compression-and-cpu-hot.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch from v6.12 (and all stable trees) as it has a
bug, as I pointed out in [1] (was that the correct place to surface
this?).

Andrew's latest PR contains a revert of this patch (and alternative fix) [2=
].

Thanks!

[1]https://lore.kernel.org/stable/CAJD7tkaiUA6J1nb0=3D1ELpUD0OgjoD+tft-iPqb=
PdyXCpS=3D2AGQ@mail.gmail.com/
[2]https://lore.kernel.org/lkml/20250113000543.862792e948c2646032a477e0@lin=
ux-foundation.org/

>
>
>
> commit c56e79d453ef5b5fc6ded252bc6ba461f12946ba
> Author: Yosry Ahmed <yosryahmed@google.com>
> Date:   Thu Dec 19 21:24:37 2024 +0000
>
>     mm: zswap: fix race between [de]compression and CPU hotunplug
>
>     [ Upstream commit eaebeb93922ca6ab0dd92027b73d0112701706ef ]
>
>     In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of =
the
>     current CPU at the beginning of the operation is retrieved and used
>     throughout.  However, since neither preemption nor migration are disa=
bled,
>     it is possible that the operation continues on a different CPU.
>
>     If the original CPU is hotunplugged while the acomp_ctx is still in u=
se,
>     we run into a UAF bug as the resources attached to the acomp_ctx are =
freed
>     during hotunplug in zswap_cpu_comp_dead().
>
>     The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to=
 use
>     crypto_acomp API for hardware acceleration") when the switch to the
>     crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp wa=
s
>     retrieved using get_cpu_ptr() which disables preemption and makes sur=
e the
>     CPU cannot go away from under us.  Preemption cannot be disabled with=
 the
>     crypto_acomp API as a sleepable context is needed.
>
>     Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
>     per-acomp_ctx") increased the UAF surface area by making the per-CPU
>     buffers dynamic, adding yet another resource that can be freed from u=
nder
>     zswap compression/decompression by CPU hotunplug.
>
>     There are a few ways to fix this:
>     (a) Add a refcount for acomp_ctx.
>     (b) Disable migration while using the per-CPU acomp_ctx.
>     (c) Disable CPU hotunplug while using the per-CPU acomp_ctx by holdin=
g
>     the CPUs read lock.
>
>     Implement (c) since it's simpler than (a), and (b) involves using
>     migrate_disable() which is apparently undesired (see huge comment in
>     include/linux/preempt.h).
>
>     Link: https://lkml.kernel.org/r/20241219212437.2714151-1-yosryahmed@g=
oogle.com
>     Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hard=
ware acceleration")
>     Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>     Reported-by: Johannes Weiner <hannes@cmpxchg.org>
>     Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg=
.org/
>     Reported-by: Sam Sun <samsun1006219@gmail.com>
>     Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2=
e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
>     Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>     Acked-by: Barry Song <baohua@kernel.org>
>     Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>     Cc: Vitaly Wool <vitalywool@gmail.com>
>     Cc: <stable@vger.kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0030ce8fecfc..c86d4bcbb447 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -875,6 +875,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, str=
uct hlist_node *node)
>         return 0;
>  }
>
> +/* Prevent CPU hotplug from freeing up the per-CPU acomp_ctx resources *=
/
> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_ct=
x __percpu *acomp_ctx)
> +{
> +       cpus_read_lock();
> +       return raw_cpu_ptr(acomp_ctx);
> +}
> +
> +static void acomp_ctx_put_cpu(void)
> +{
> +       cpus_read_unlock();
> +}
> +
>  static bool zswap_compress(struct folio *folio, struct zswap_entry *entr=
y)
>  {
>         struct crypto_acomp_ctx *acomp_ctx;
> @@ -887,8 +899,7 @@ static bool zswap_compress(struct folio *folio, struc=
t zswap_entry *entry)
>         gfp_t gfp;
>         u8 *dst;
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -
> +       acomp_ctx =3D acomp_ctx_get_cpu(entry->pool->acomp_ctx);
>         mutex_lock(&acomp_ctx->mutex);
>
>         dst =3D acomp_ctx->buffer;
> @@ -944,6 +955,7 @@ static bool zswap_compress(struct folio *folio, struc=
t zswap_entry *entry)
>                 zswap_reject_alloc_fail++;
>
>         mutex_unlock(&acomp_ctx->mutex);
> +       acomp_ctx_put_cpu();
>         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
>  }
>
> @@ -954,7 +966,7 @@ static void zswap_decompress(struct zswap_entry *entr=
y, struct folio *folio)
>         struct crypto_acomp_ctx *acomp_ctx;
>         u8 *src;
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       acomp_ctx =3D acomp_ctx_get_cpu(entry->pool->acomp_ctx);
>         mutex_lock(&acomp_ctx->mutex);
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> @@ -984,6 +996,7 @@ static void zswap_decompress(struct zswap_entry *entr=
y, struct folio *folio)
>
>         if (src !=3D acomp_ctx->buffer)
>                 zpool_unmap_handle(zpool, entry->handle);
> +       acomp_ctx_put_cpu();
>  }
>
>  /*********************************

