Return-Path: <stable+bounces-107775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4BA033A4
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 00:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF91A1886020
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157F1E2007;
	Mon,  6 Jan 2025 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYaNTEib"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9D1E2317
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207773; cv=none; b=OeNWhvdCoSiwzFbWza6uXYVj9GJa5hsNlH4DJ2tD2gRrQ5zEE3LG4mdMIkqovPp/M4q+zNMlCp1iYglE9CFG/RixyGZ4sFtFNauqJ6fkXqupTG0mWX66qqj6AfR4AVGSwzbz4Oyjw2lPEtidMz6Csh7iMYfuw8jEsAq4jQ0LjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207773; c=relaxed/simple;
	bh=rjvHZIBFIeftokIOITXjmQNdc4wflkQ635o0cY8uLrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3FEZDX7m1cwgwzRjvBaS+WBABSJ3pazqVBZPVzWoxExR2RpiUj8PwzMp31pj34sdc0c5HsS2J66rCNBqGvF8N5b5ppb9stOHtbVGQUMXhSD0lajeQJev/3zXTQFMAIEpNfQacQW6vE8/X5cVMgz/svB28f3vVsWbRtTeyhnR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYaNTEib; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso132083836d6.3
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736207770; x=1736812570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKzWo8/mhB9hJep4bU9unUuv8k+6b3C1sEduYVjtOdc=;
        b=AYaNTEibFhWVSEPMMTGfXCk+z1fRbNPDmsSjlJS7PVRz/K8P5vnTBBdM/E2durRseg
         JOgJ+ovUHzRIyrQQ4r29riITtEc+gz5AStERRmeBTda9VLQVssMFK8rVj1vYzv+DPrAp
         POMuY6P8RjcEig8b8S9WQn8XDul/mhHfb00AghlEGQHIvNl48QEjhImF7VDdvlQWM3ex
         xYMZHkTC+hBpyl9n9NYmPV8ddc5IKGZEglmKEMuvVENRAFL3ilRYmZWj0Od/wuUP3dKB
         m9+51bp+yi6PfPxm1RyAJahT4QD6eGDLHiNg1ZkMnbkws2ew3Ls44CTdRpnh/8iqglaP
         cxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736207770; x=1736812570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKzWo8/mhB9hJep4bU9unUuv8k+6b3C1sEduYVjtOdc=;
        b=SfnS3awjFmQKARexv4Ssy8Wl1ITrsHBc/1nCV+Ujve5yUwKheb+6JwQETgGHc16y/s
         xFayGExvKJIuh6Nf0KXCpuLAEa40JEZ9l1voLFnO2AKtSHuHh29V30EOustK97kQvewM
         bYwdAtNLL70/zmMNlRS+l/5aeK+JItGCQ792Ic/JlhyClZxgxZWy2ft7V6e2p88rEtZW
         SIjDCNWw5uIpA0utJIuhPFW+Ps5qWrMoPnHS8Ao2qZJkoID78swwpW+Veulh3sTnlIsY
         uMmrdXkkVGSeaL6UQz52U90Y13kcz5rNv4JWcyyJNqq5Ocv7PIcVHEp/IaZazvshCgR/
         9xWA==
X-Forwarded-Encrypted: i=1; AJvYcCXu8x85bBZKVLyj6NehcPc3Svyor3x3IPTvuJFvjmum3vN/clntk0Xx/pIMK39m/JpLZuDY4xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSpGMFlFgEBLyuAZq6mUvj6y+S83EOKT8LB6IB3G04/SHeINO
	ckD+tZG+oDqLXTXW/rI2PozhZ5gorOkXBveX4Noqmm1EKrqMGAgus4xkVebBNtn6Ssz4Kg/et6u
	/WFUyNvJr7uSkdG+mwjzcwEN61GtIpAdG1Dqt
X-Gm-Gg: ASbGncu6lU5246gsVBHxAgtSjfMVe39XhwdZEX02MK8OOHfcKcttZYQfAfMTxTRkH5f
	Ivep93PjkaY6xeF+Anzz+Pz4P5wpxgKPsWBk=
X-Google-Smtp-Source: AGHT+IE/K+r2USX4vnfYYds72zR/zback4h0PTgupBhaJOPTcyMHgu+DIBTrK7jaJKiQ10lGvfnmCVa//eV0O9XVvKA=
X-Received: by 2002:a05:6214:c64:b0:6d8:aa14:f5b8 with SMTP id
 6a1803df08f44-6dd233b6e4emr969338996d6.40.1736207769938; Mon, 06 Jan 2025
 15:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025010627-retry-detached-672f@gregkh>
In-Reply-To: <2025010627-retry-detached-672f@gregkh>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 Jan 2025 15:55:33 -0800
X-Gm-Features: AbW1kvYg3pt8Jeg-Y_nftexx81z4k9AlrcydXHMM4pd2Vv18agxtybxGgZGiH8M
Message-ID: <CAJD7tkaiUA6J1nb0=1ELpUD0OgjoD+tft-iPqbPdyXCpS=2AGQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] mm: zswap: fix race between
 [de]compression and CPU hotunplug" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, baohua@kernel.org, chengming.zhou@linux.dev, 
	hannes@cmpxchg.org, nphamcs@gmail.com, samsun1006219@gmail.com, 
	stable@vger.kernel.org, vitalywool@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 2:58=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I actually just sent out a revert for this patch as it turned out to
cause a potential deadlock:
https://lore.kernel.org/lkml/20250106235248.1501064-2-yosryahmed@google.com=
/

Please do not add it to any stable trees.

>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x eaebeb93922ca6ab0dd92027b73d0112701706ef
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010627-=
retry-detached-672f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
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
> From eaebeb93922ca6ab0dd92027b73d0112701706ef Mon Sep 17 00:00:00 2001
> From: Yosry Ahmed <yosryahmed@google.com>
> Date: Thu, 19 Dec 2024 21:24:37 +0000
> Subject: [PATCH] mm: zswap: fix race between [de]compression and CPU hotu=
nplug
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
> Link: https://lkml.kernel.org/r/20241219212437.2714151-1-yosryahmed@googl=
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
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Acked-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Cc: Vitaly Wool <vitalywool@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..5a27af8d86ea 100644
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
>

