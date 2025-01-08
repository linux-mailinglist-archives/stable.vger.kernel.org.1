Return-Path: <stable+bounces-107939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2299BA050DD
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD0C3A9B21
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7BC1632C8;
	Wed,  8 Jan 2025 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIAnodpD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D56134AB
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303650; cv=none; b=U3mEejcIVCpjamlGwy5xIB+FXyouh60OsgVAyckJSYZMst/36ayUJO3NqrgVT/23dFGdFCjtKR/kxKakPVikGn9akbBW+mJTZUGRksJShkqr4FD0anDL2fb2TOrYuGHLBju3821mb13gTt5Y21a4QhGVdSBciPB65CFfodZsQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303650; c=relaxed/simple;
	bh=Cd/Duu66I/8Xi6LBkxrdX60nRt+RX9kM9MuBSAyT7/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pqya+OZ4PVmAlTm+kIosesGOPZ2XG6z5coQmQUDdnq2m5f7DH5WGKJUd6Y+XdFIz7dVLiZyxowDe8h/PxnKhH5qVsS9GlnvE1QBa55QFAxw3a/p6fmJ5bpyKl2MjBv1Hd+mZpKNKzyIXoO5ApQrsq1d30CY2Z2GRgMKJCU2T8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIAnodpD; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46769b34cbfso61518861cf.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 18:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736303647; x=1736908447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEAVPjDiQWu3tIjXyUt/7wC+P0xHFWQXNCXnwqpbpvA=;
        b=vIAnodpDmha9c8XrQ7P4Fz997UDU/pp5/Vz9ZOtO59Ugi4UnZr9HjYqFEXm7QLfPre
         30VP+iE6u5/U0TVbc1/YaoVaJrZKkn/8EUi4ohtBzY/WOpjM9BBV6Y3RzN8mE2NsX3zn
         IlAEUi5XFcvGK3jypKsTvlgWre4x9wf0RX1PuRrbNTtLAwTx/LTHQ4Goe7kCm5h6zPOb
         53D9twZXNQn5nV400WWS0Zj+OKBizqrhhjEZx179XkeMw+2XtfhtP/lPpdL+47eIy8hp
         xXT78aNEy9LAwVJynmUgjg7GEB/Lj1TXPD27N3GnVLTXK3VSslPFd4hwCKxeK9cW9EvC
         Oajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736303647; x=1736908447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEAVPjDiQWu3tIjXyUt/7wC+P0xHFWQXNCXnwqpbpvA=;
        b=mumpPi/8324yPuqhOtPsQy0qwcRYlvXYKfQNvf2SRilfoWPblJ+7JDaBDQCgf62JG8
         AZO0lUTMgA5I8T9MBC5fbSXhJJpHACW5zta9PB++7sOFCNq3Oja/VYasHhn2hBwdNAjY
         ex6JtTkuHPw/q9Oeq1MXgkgNNACfv+5oW7T2vdwNmE9EKky9BE3J30UInf9BgDRxSjnI
         HU0svbT+qhdc3PJmkvyqZwrgaXtAbKQi1lWxxQXFDvYb5TXk3UJYfS2M4YlCPJamhgdl
         3PgoVTsh5w3dtArTp0UUx2OeNnpxl3WSKx0qRGn45dHqI5khalWlrVQnI5psdgQJT0Kg
         MXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXPLx69unIJQxuX3ZPGrQBX9GqkhoKlMb7+LTmFuRETqjb+Kfb0s8/d3S2gfqwUFsSSZMSXQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMG+4GWirdoSNirLwe8AhwV8C427fPOi0+9Y8XoccPkoJsVpqS
	VEGxVAniCMJlqIYB413ScaWAYu+nMynP+wPYruR1BsSHYxVoF3T1uNNy0p29JlU2zhbm3/yHnHj
	3lIbA7jaMGbg9l2J1ZVccYTFac9TxmpIiKEqe
X-Gm-Gg: ASbGncu9ArUWrA3QB3F60wfPpjQADGEf2+zmrpsibTa47oYgZBoZncs5s6Z26TtZ8av
	sdeoPcaZl1MIQcS1yTRez7revSTYH7WrSwiJUpEBzwlc3CQ7EMEokd7kkh49QvemmtekB
X-Google-Smtp-Source: AGHT+IEp0mFaD6EWYlTmvXY23uKOhOykJzare1tAuHmU4auCcWrgdZicFHEaCzxL3Fmwe7WWBY5KdD0SCwA3RVmAebE=
X-Received: by 2002:a05:6214:2266:b0:6d8:a856:133 with SMTP id
 6a1803df08f44-6df9b1ea668mr22346316d6.12.1736303647461; Tue, 07 Jan 2025
 18:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
 <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com>
In-Reply-To: <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 18:33:30 -0800
X-Gm-Features: AbW1kvZFpesSFBOCECViZeKfLo_g51tw8jkJijUXun9isjO0Ksdckii3zW75WgQ
Message-ID: <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, 
	Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 5:18=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> [..]
> > > > Couple of possibly related thoughts:
> > > >
> > > > 1) I have been thinking some more about the purpose of this per-cpu
> > > acomp_ctx
> > > >      mutex. It appears that the main benefit is it causes task bloc=
ked errors
> > > (which are
> > > >      useful to detect problems) if any computes in the code section=
 it covers
> > > take a
> > > >      long duration. Other than that, it does not protect a resource=
, nor
> > > prevent
> > > >      cpu offlining from deleting its containing structure.
> > >
> > > It does protect resources. Consider this case:
> > > - Process A runs on CPU #1, gets the acomp_ctx, and locks it, then is
> > > migrated to CPU #2.
> > > - Process B runs on CPU #1, gets the same acomp_ctx, and tries to loc=
k
> > > it then waits for process A. Without the lock they would be using the
> > > same lock.
> > >
> > > It is also possible that process A simply gets preempted while runnin=
g
> > > on CPU #1 by another task that also tries to use the acomp_ctx. The
> > > mutex also protects against this case.
> >
> > Got it, thanks for the explanations. It seems with this patch, the mute=
x
> > would be redundant in the first example. Would this also be true of the
> > second example where process A gets preempted?
>
> I think the mutex is still required in the second example. Migration
> being disabled does not prevent other processes from running on the
> same CPU and attempting to use the same acomp_ctx.
>
> > If not, is it worth
> > figuring out a solution that works for both migration and preemption?
>
> Not sure exactly what you mean here. I suspect you mean have a single
> mechanism to protect against concurrent usage and CPU hotunplug rather
> than disabling migration and having a mutex. Yeah that would be ideal,
> but probably not for a hotfix.

Actually, using the mutex to protect against CPU hotunplug is not too
complicated. The following diff is one way to do it (lightly tested).
Johannes, Nhat, any preferences between this patch (disabling
migration) and the following diff?

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb236..4d6817c679a54 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
struct hlist_node *node)
        struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, no=
de);
        struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ctx,=
 cpu);

+       mutex_lock(&acomp_ctx->mutex);
        if (!IS_ERR_OR_NULL(acomp_ctx)) {
                if (!IS_ERR_OR_NULL(acomp_ctx->req))
                        acomp_request_free(acomp_ctx->req);
+               acomp_ctx->req =3D NULL;
                if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
                        crypto_free_acomp(acomp_ctx->acomp);
                kfree(acomp_ctx->buffer);
        }
+       mutex_unlock(&acomp_ctx->mutex);

        return 0;
 }

+static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
+               struct crypto_acomp_ctx __percpu *acomp_ctx)
+{
+       struct crypto_acomp_ctx *ctx;
+
+       for (;;) {
+               ctx =3D raw_cpu_ptr(acomp_ctx);
+               mutex_lock(&ctx->mutex);
+               if (likely(ctx->req))
+                       return ctx;
+               /* Raced with zswap_cpu_comp_dead() on CPU hotunplug */
+               mutex_unlock(&ctx->mutex);
+       }
+}
+
+static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *ctx)
+{
+       mutex_unlock(&ctx->mutex);
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
                           struct zswap_pool *pool)
 {
@@ -893,10 +916,7 @@ static bool zswap_compress(struct page *page,
struct zswap_entry *entry,
        gfp_t gfp;
        u8 *dst;

-       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
-
-       mutex_lock(&acomp_ctx->mutex);
-
+       acomp_ctx =3D acomp_ctx_get_cpu_locked(pool->acomp_ctx);
        dst =3D acomp_ctx->buffer;
        sg_init_table(&input, 1);
        sg_set_page(&input, page, PAGE_SIZE, 0);
@@ -949,7 +969,7 @@ static bool zswap_compress(struct page *page,
struct zswap_entry *entry,
        else if (alloc_ret)
                zswap_reject_alloc_fail++;

-       mutex_unlock(&acomp_ctx->mutex);
+       acomp_ctx_put_unlock(acomp_ctx);
        return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
 }

@@ -960,9 +980,7 @@ static void zswap_decompress(struct zswap_entry
*entry, struct folio *folio)
        struct crypto_acomp_ctx *acomp_ctx;
        u8 *src;

-       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
-       mutex_lock(&acomp_ctx->mutex);
-
+       acomp_ctx =3D acomp_ctx_get_cpu_locked(entry->pool->acomp_ctx);
        src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
        /*

