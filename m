Return-Path: <stable+bounces-105374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E49F8807
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 23:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC29F7A2E48
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 22:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E691D516B;
	Thu, 19 Dec 2024 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZwi48NN"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312419D8A9;
	Thu, 19 Dec 2024 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648239; cv=none; b=QZlYYO8uy9FiLKemVa0436gXBwubezyfCIHgxoPwWDp+zFuc1xWnU/ywJLEWxcZ8IdZ0EaT9CCFWgWdbXoBNwa3YfOK+ntB3cHNUBABEjTPmovMmaiACqsGaU599jafz+KKstf2Kw0L9uQWVPWYH36h4xAH1xOLnfBrQoIhyUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648239; c=relaxed/simple;
	bh=kR2Wcx9R7wP9M6Xd0DJH8dEkBGPTMYljtGittFX/NXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhnficVa4zy2tvfleS4h1Oy4lAUPzmzVIhkZ31p+JNeGvmAW3IbbghlCXc0gEcpMhRgQ8i4U936Ypk4EzgY4FPQtb53UMfjAXU7QJfkwcWTMMpSSKIPzZIkzijo/D4KB5VrSSAJxjQ+lOfYfSrVpQ29MW9wcLqxxAuC9Ne0+NL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZwi48NN; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-518911908b0so459695e0c.0;
        Thu, 19 Dec 2024 14:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734648236; x=1735253036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca8wF7paDL7rrljInQMjAYM9bceCl6oY8A3NHbvsl2c=;
        b=hZwi48NN1Hb38Qm1J7bQYPQqwU1ERQJJPPf/nla2qsDufcqzwid2hm5HKw0nLIdjKN
         bj8X8CVM3u18AwE//RuzOBwqFM5278JeyT+8A+hFGXGLh4xgGqCIU77yYH1YEcfKHC8u
         qC0cB/XaVuOITSHkavnLA5vn7xFYdojGi7A5+WaNCdIzOHvQD611HdV8S+JEQ10INUpe
         5ntW/kIEGqTpP1zDdLPqMNWwlAAo8Uvy2hrdEfoMX7rQwbbc035rN62w9Wcfq4POCCaH
         lnggW/pa44ITndB1TAh0E1KkigtEjF62fGgBn7jjiv9H/rMpigXV2EiGSHAsQL7SiwTM
         anpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734648236; x=1735253036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca8wF7paDL7rrljInQMjAYM9bceCl6oY8A3NHbvsl2c=;
        b=VQDq+ymLMvoW6lsLo8MJ16hbchb6KeP4/Y+HENqu0oxnBB5Y29EPhN0iWuBCCRTv6D
         jemewNNZ6azMgFbVD0FKDXOtXx6wQcVhhFUmrrmyTkliHbnZd7GgdFydgKeY1pMb+fyF
         CYi/JVTWuRXw8NWu1pC28zlMrnQbPe7hZj8I4ENRDpMNycsQJ+4HPaPlFXDCD+G8abae
         eHYikLq+lDleqOBApsefEQdTPdzFAyUGuN7ARWp7jP96+J12xKKwXj6pd6GYfq9j+hDo
         P5kMcHHeuCrvJTxdwhONrhiTq7IPGFaGReVG5cAm/AfNL4T5n9RDSH6rcACn4/l5H71K
         /BmA==
X-Forwarded-Encrypted: i=1; AJvYcCWwGbl7sBf8ttBxlbvw02xus6KZmT1TYXhbstjB9GHqHvl3xJfF345+h5E5ULhnLXPRThYxEMRS@vger.kernel.org, AJvYcCXntItx4WGGxjGgiHeWpwxKybACUVWzUcWRQTymBFXKRG619rmEAGsYASQxVHwjkdN93fU9OHddaAvGJjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRs+BBMhJ1jeeA9KmW8iJPaOHxuToEFynTbvZQrNUnXI0j1H+H
	6dhr/QdkIeCZox/Uzo+chMPlTlmyz7Ni4cSB9dB5dUSaaHQ2alP7zaXicvtBOYTWUc/udVWlDLD
	lEfH30b/qTxeTQzvIBgcgLlsd1c8=
X-Gm-Gg: ASbGncvlAXv7eiiZo6SYyxfC8Ovfk+uVlovW9gzHua+lyWKflJYjqw3QiUJSuy+4/Ib
	rcWgqG03Qil/t0A5Rm9x0OkGeZM/CGNmIDjl7A/jMMsTrzplMTH09vDrPFselqiraTKv+ykAL
X-Google-Smtp-Source: AGHT+IEDvOa56CM2TW90McyoCdDltvZgqDxiiO1bmboAF2fSbyceQHyzV5MQYDywsD/xk0aeWUoCu2YWZjNlF6qUnSU=
X-Received: by 2002:a05:6122:2490:b0:516:1a78:bfb with SMTP id
 71dfb90a1353d-51b75d3ff6fmr875174e0c.7.1734648236234; Thu, 19 Dec 2024
 14:43:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219212437.2714151-1-yosryahmed@google.com>
In-Reply-To: <20241219212437.2714151-1-yosryahmed@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 20 Dec 2024 11:43:45 +1300
Message-ID: <CAGsJ_4y_riVoGEbDnjKkrteiXDfY5FH+OFYMZ8x4_1hvZmi_Vw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix race between [de]compression and CPU hotunplug
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 10:24=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
> current CPU at the beginning of the operation is retrieved and used
> throughout. However, since neither preemption nor migration are
> disabled, it is possible that the operation continues on a different
> CPU.
>
> If the original CPU is hotunplugged while the acomp_ctx is still in use,
> we run into a UAF bug as the resources attached to the acomp_ctx are
> freed during hotunplug in zswap_cpu_comp_dead().
>
> The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
> use crypto_acomp API for hardware acceleration") when the switch to the
> crypto_acomp API was made. Prior to that, the per-CPU crypto_comp was
> retrieved using get_cpu_ptr() which disables preemption and makes sure
> the CPU cannot go away from under us. Preemption cannot be disabled with
> the crypto_acomp API as a sleepable context is needed.
>
> Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> per-acomp_ctx") increased the UAF surface area by making the per-CPU
> buffers dynamic, adding yet another resource that can be freed from
> under zswap compression/decompression by CPU hotunplug.
>
> There are a few ways to fix this:
> (a) Add a refcount for acomp_ctx.
> (b) Disable migration while using the per-CPU acomp_ctx.
> (c) Disable CPU hotunplug while using the per-CPU acomp_ctx by holding
> the CPUs read lock.
>
> Implement (c) since it's simpler than (a), and (b) involves using
> migrate_disable() which is apparently undesired (see huge comment in
> include/linux/preempt.h).
>
> Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware=
 acceleration")
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org=
/
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv=
4OcuruL4tPg6OaQ@mail.gmail.com/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Thanks for fixing this.

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  mm/zswap.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb236..5a27af8d86ea9 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, str=
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

Best Regards
Barry

