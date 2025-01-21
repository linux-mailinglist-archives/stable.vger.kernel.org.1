Return-Path: <stable+bounces-110037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF8A18522
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED50188781A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4619F424;
	Tue, 21 Jan 2025 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VeDm8Ll"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF71714B3
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483682; cv=none; b=L3HlzCtNwkkUu/NuIk8hGjjMjOUx6UWtngpVpLKbRIRSkQhhQ8YCTBRjdXZcja4FclO9M2VG8np2nTIgHM0DEaH7UmqQ5l7B2MnXCnBK9wlJdujrgG3Nz75muJV1spIfVcPxjWUvPJJ5IciqlQc06EAOeTqaL4wk4GQfgXNxYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483682; c=relaxed/simple;
	bh=j8z5TJxGfqbdgrbwg62tJeVyyOpLB+Oen3Ogt6ggOX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af3Ux1ezOVKWTR5reLyygAE8sK7RyfQx2Aq++Zd2yCqufQRprdwR12KNNB/9SHCEM5b+DrmbnIBy6w6xmcRbiXeESxFHYK7BWIrZSaU9eaM95OFmO1mTUmbhG+fAWMNLEx5KO+acvDVf1KlSdEmqs+Tl8QI678RfPc/W2V14XLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0VeDm8Ll; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd5c544813so62786206d6.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737483679; x=1738088479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkA5SSuKYJ5f6lWdE4BUrHKd8uVmK9XKfQsEboi6hgs=;
        b=0VeDm8LlkOvUTTKgPcmjFnmLCpcdyov0IOB71DeVT7HtE8q5hWCYpqyNfKb4wqpf6m
         X59RaXBcs8nl76WWYVB3nCo/EDmfMIIezCJQMl6BkOwsb6263ZJGU4bs2SIJpG9xfk71
         /XNmptD6UEp28Ly5/8ojpBr+ekLWFiCk/vSZAAdadZWPRyLR5L87qy0xLz5/RitSm1MS
         gp2DwcQdsdYxNZZV8yKtpXats5sOBUdu1JeONgNVisuvmz3XjwZiwm6nlEYefFNKhsqM
         9oU1KRdhQYfP15DieGYtqJO9+fTrdejC3lJMKvYefz0XdpyZ3wG4ffUOhunt1+lKAIY3
         shEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737483679; x=1738088479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkA5SSuKYJ5f6lWdE4BUrHKd8uVmK9XKfQsEboi6hgs=;
        b=G5iTs5e/A86jyOZbZKECrV28Kf5wk7olO32UsKCHBLeYku/dBMPiKab+TzHJasaqL0
         WUv99epbSW8PNmW86qfauhLt0O5ppuSSz5ZZ99iXlpQ4/vKYlFpK5kEBHYo8qW7900lH
         EV5oAkfOtle5n5vr7ubdeogMcb4snyqv8opztcmna80O5YxqLquhRj5j3PWHk8DxbQBQ
         caPKk/BUYYqDSPc8qiqqMacvX6LxxIRLyB1hgXGlT0O4bEciyXF/zuHQ10ULQdKxqL/w
         pWbzIQlkapVhmv4uM5wUvzVTX+2FIptwUMe0G4asL0+5YKHeN5eovLQmNQj0SPA0Mxb3
         cvwA==
X-Forwarded-Encrypted: i=1; AJvYcCV98cLtZfZ6zgSrH5duDpimixAHNSF9TxJ0Eml/8Sd+T+9mI+GRrGJB3VdxxgPPk/4Er1wMgdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQsocUBpfHtl8P+sedxyTBoUDpDN8XXKQr9nam3hGFuyT2xRm
	VmoQkLMMjozvLvzrDpYKw9qfy8tGzakJYxDVrVVjfpvboizRKwMFWr91L5xpS/lXOOFtTLgopc9
	g/wT3WHoo+g05kiSwmW5CJ4NomHbf9mO6Ld4L
X-Gm-Gg: ASbGncv4YfpLYCIO4JTVrsdmBSAxVkOVN5oNLXB7iSzheDIXUoCrw0aAeG1wDXfM5bv
	5SVOT97Gc+NbPhgLZyfSM3nmrO+3MewMMba8z4m6qmhb1MxaI9+KRUBTmCXIJRvdHLeOigDwqa3
	Ekv+5sSA==
X-Google-Smtp-Source: AGHT+IFpijw7Nc4+bNvTAGOO8tVq4d6QgFfp0zvRE2y/qX8EC8r1ftGr33gMJhgH4JwPgbb92O+d2gPWqWzTjAwZ+ck=
X-Received: by 2002:a05:6214:23ca:b0:6d8:9e16:d07e with SMTP id
 6a1803df08f44-6e1b21713b7mr238899956d6.4.1737483678942; Tue, 21 Jan 2025
 10:21:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025012012-capacity-swiftly-0214@gregkh>
In-Reply-To: <2025012012-capacity-swiftly-0214@gregkh>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 21 Jan 2025 10:20:42 -0800
X-Gm-Features: AbW1kvbwlarFDEBzRbvLNRhKkDcwd2mTiPo17YEHE_BnJurRhnLUUTomQ19s21I
Message-ID: <CAJD7tka_cQm2mpi7BPh9igxkuoaSOFiV_D6hfRR7Fpd55hORvw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] mm: zswap: properly synchronize freeing
 resources during CPU" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, baohua@kernel.org, chengming.zhou@linux.dev, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, nphamcs@gmail.com, 
	samsun1006219@gmail.com, stable@vger.kernel.org, vitalywool@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 5:37=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 12dcb0ef540629a281533f9dedc1b6b8e14cfb65
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012012-=
capacity-swiftly-0214@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

I sent a backport for this (and the followup fix) to v6.12. However,
for v6.6 (and previous kernels), it's more complicated. It's back when
we had a separate hotplug notifier to allocate the buffers (when they
were shared by different acomp_ctxs), and before a lot of refactoring
was done (e.g. before writeback shared code with decompression).

Given that the problem has existed since v5.11 but was only reported
now, and is a rare race condition with CPU hotunplug, I think it's not
worth backporting the fix before v6.12 given the complexity.

If anyone objects please let me know. Otherwise I won't send backports
further back than v6.12.

>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 12dcb0ef540629a281533f9dedc1b6b8e14cfb65 Mon Sep 17 00:00:00 2001
> From: Yosry Ahmed <yosryahmed@google.com>
> Date: Wed, 8 Jan 2025 22:24:41 +0000
> Subject: [PATCH] mm: zswap: properly synchronize freeing resources during=
 CPU
>  hotunplug
>
> In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
> current CPU at the beginning of the operation is retrieved and used
> throughout.  However, since neither preemption nor migration are disabled=
,
> it is possible that the operation continues on a different CPU.
>
> If the original CPU is hotunplugged while the acomp_ctx is still in use,
> we run into a UAF bug as some of the resources attached to the acomp_ctx
> are freed during hotunplug in zswap_cpu_comp_dead() (i.e.
> acomp_ctx.buffer, acomp_ctx.req, or acomp_ctx.acomp).
>
> The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to use
> crypto_acomp API for hardware acceleration") when the switch to the
> crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
> retrieved using get_cpu_ptr() which disables preemption and makes sure th=
e
> CPU cannot go away from under us.  Preemption cannot be disabled with the
> crypto_acomp API as a sleepable context is needed.
>
> Use the acomp_ctx.mutex to synchronize CPU hotplug callbacks allocating
> and freeing resources with compression/decompression paths.  Make sure
> that acomp_ctx.req is NULL when the resources are freed.  In the
> compression/decompression paths, check if acomp_ctx.req is NULL after
> acquiring the mutex (meaning the CPU was offlined) and retry on the new
> CPU.
>
> The initialization of acomp_ctx.mutex is moved from the CPU hotplug
> callback to the pool initialization where it belongs (where the mutex is
> allocated).  In addition to adding clarity, this makes sure that CPU
> hotplug cannot reinitialize a mutex that is already locked by
> compression/decompression.
>
> Previously a fix was attempted by holding cpus_read_lock() [1].  This
> would have caused a potential deadlock as it is possible for code already
> holding the lock to fall into reclaim and enter zswap (causing a
> deadlock).  A fix was also attempted using SRCU for synchronization, but
> Johannes pointed out that synchronize_srcu() cannot be used in CPU hotplu=
g
> notifiers [2].
>
> Alternative fixes that were considered/attempted and could have worked:
> - Refcounting the per-CPU acomp_ctx. This involves complexity in
>   handling the race between the refcount dropping to zero in
>   zswap_[de]compress() and the refcount being re-initialized when the
>   CPU is onlined.
> - Disabling migration before getting the per-CPU acomp_ctx [3], but
>   that's discouraged and is a much bigger hammer than needed, and could
>   result in subtle performance issues.
>
> [1]https://lkml.kernel.org/20241219212437.2714151-1-yosryahmed@google.com=
/
> [2]https://lkml.kernel.org/20250107074724.1756696-2-yosryahmed@google.com=
/
> [3]https://lkml.kernel.org/20250107222236.2715883-2-yosryahmed@google.com=
/
>
> [yosryahmed@google.com: remove comment]
>   Link: https://lkml.kernel.org/r/CAJD7tkaxS1wjn+swugt8QCvQ-rVF5RZnjxwPGX=
17k8x9zSManA@mail.gmail.com
> Link: https://lkml.kernel.org/r/20250108222441.3622031-1-yosryahmed@googl=
e.com
> Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware=
 acceleration")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org=
/
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv=
4OcuruL4tPg6OaQ@mail.gmail.com/
> Cc: Barry Song <baohua@kernel.org>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Vitaly Wool <vitalywool@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..30f5a27a6862 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -251,7 +251,7 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>         struct zswap_pool *pool;
>         char name[38]; /* 'zswap' + 32 char (max) num + \0 */
>         gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM=
;
> -       int ret;
> +       int ret, cpu;
>
>         if (!zswap_has_pool) {
>                 /* if either are unset, pool initialization failed, and w=
e
> @@ -285,6 +285,9 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>                 goto error;
>         }
>
> +       for_each_possible_cpu(cpu)
> +               mutex_init(&per_cpu_ptr(pool->acomp_ctx, cpu)->mutex);
> +
>         ret =3D cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
>                                        &pool->node);
>         if (ret)
> @@ -821,11 +824,12 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
>         struct acomp_req *req;
>         int ret;
>
> -       mutex_init(&acomp_ctx->mutex);
> -
> +       mutex_lock(&acomp_ctx->mutex);
>         acomp_ctx->buffer =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu=
_to_node(cpu));
> -       if (!acomp_ctx->buffer)
> -               return -ENOMEM;
> +       if (!acomp_ctx->buffer) {
> +               ret =3D -ENOMEM;
> +               goto buffer_fail;
> +       }
>
>         acomp =3D crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_no=
de(cpu));
>         if (IS_ERR(acomp)) {
> @@ -855,12 +859,15 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
>         acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
>                                    crypto_req_done, &acomp_ctx->wait);
>
> +       mutex_unlock(&acomp_ctx->mutex);
>         return 0;
>
>  req_fail:
>         crypto_free_acomp(acomp_ctx->acomp);
>  acomp_fail:
>         kfree(acomp_ctx->buffer);
> +buffer_fail:
> +       mutex_unlock(&acomp_ctx->mutex);
>         return ret;
>  }
>
> @@ -869,17 +876,45 @@ static int zswap_cpu_comp_dead(unsigned int cpu, st=
ruct hlist_node *node)
>         struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, =
node);
>         struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ct=
x, cpu);
>
> +       mutex_lock(&acomp_ctx->mutex);
>         if (!IS_ERR_OR_NULL(acomp_ctx)) {
>                 if (!IS_ERR_OR_NULL(acomp_ctx->req))
>                         acomp_request_free(acomp_ctx->req);
> +               acomp_ctx->req =3D NULL;
>                 if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
>                         crypto_free_acomp(acomp_ctx->acomp);
>                 kfree(acomp_ctx->buffer);
>         }
> +       mutex_unlock(&acomp_ctx->mutex);
>
>         return 0;
>  }
>
> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_lock(struct zswap_pool=
 *pool)
> +{
> +       struct crypto_acomp_ctx *acomp_ctx;
> +
> +       for (;;) {
> +               acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> +               mutex_lock(&acomp_ctx->mutex);
> +               if (likely(acomp_ctx->req))
> +                       return acomp_ctx;
> +               /*
> +                * It is possible that we were migrated to a different CP=
U after
> +                * getting the per-CPU ctx but before the mutex was acqui=
red. If
> +                * the old CPU got offlined, zswap_cpu_comp_dead() could =
have
> +                * already freed ctx->req (among other things) and set it=
 to
> +                * NULL. Just try again on the new CPU that we ended up o=
n.
> +                */
> +               mutex_unlock(&acomp_ctx->mutex);
> +       }
> +}
> +
> +static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
> +{
> +       mutex_unlock(&acomp_ctx->mutex);
> +}
> +
>  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>                            struct zswap_pool *pool)
>  {
> @@ -893,10 +928,7 @@ static bool zswap_compress(struct page *page, struct=
 zswap_entry *entry,
>         gfp_t gfp;
>         u8 *dst;
>
> -       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> -
> -       mutex_lock(&acomp_ctx->mutex);
> -
> +       acomp_ctx =3D acomp_ctx_get_cpu_lock(pool);
>         dst =3D acomp_ctx->buffer;
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
> @@ -949,7 +981,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>         else if (alloc_ret)
>                 zswap_reject_alloc_fail++;
>
> -       mutex_unlock(&acomp_ctx->mutex);
> +       acomp_ctx_put_unlock(acomp_ctx);
>         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
>  }
>
> @@ -960,9 +992,7 @@ static void zswap_decompress(struct zswap_entry *entr=
y, struct folio *folio)
>         struct crypto_acomp_ctx *acomp_ctx;
>         u8 *src;
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(&acomp_ctx->mutex);
> -
> +       acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool);
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         /*
>          * If zpool_map_handle is atomic, we cannot reliably utilize its =
mapped buffer
> @@ -986,10 +1016,10 @@ static void zswap_decompress(struct zswap_entry *e=
ntry, struct folio *folio)
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
>         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> -       mutex_unlock(&acomp_ctx->mutex);
>
>         if (src !=3D acomp_ctx->buffer)
>                 zpool_unmap_handle(zpool, entry->handle);
> +       acomp_ctx_put_unlock(acomp_ctx);
>  }
>
>  /*********************************
>

