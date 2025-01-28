Return-Path: <stable+bounces-110939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA60A20693
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 09:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9003A8A99
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02A1DC994;
	Tue, 28 Jan 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNc8kTS9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CE198823
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054454; cv=none; b=WUsM6rC+ScinQ+z+FGtYyWkJTa9cund6xAQi4iZ2rvBvmn+tzkrg9ZkPsK3JxfIxiBH9DjMlrRubrBx4izQAaDVDox4xSQ6mT3VGdI0byWUzwHURsQLiWDbOFS8O0Op79OIW5s7V3IoKJ40IciR0R6owTW5XQrSmxR/R4eTlMlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054454; c=relaxed/simple;
	bh=ezRmCqMoFKNABb0S85ijOit3D1XvShjrVxMi83ddil4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axBElSiqGijOVSyWUD+LUp6PyW9iEQBLDme7ME4CMvJg+g7vIsA+gdBln2PUS46qmZCidQufhajCH74FmzJpTrOsoyItbsR24kV9T/5Jfx009VfayIIgMIi3fgl5NcxJW6V6YuiaUFVDg/znUw/3ceUezCQGzdWOkMv/klbEsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNc8kTS9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54025432becso6032901e87.1
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 00:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054450; x=1738659250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfydJTe7jinuFpK0+2LkOwiEj/DT05PU+SApnm7PN8o=;
        b=NNc8kTS9ysHDv0CPHD4qKGrcBS/qkScTdOB5SWPq7o8lR7aF2QuVQsJoO8jbH8nvS8
         bHk95daN0DCUkW2JVtrl+MTFyoMsegPRS+YDnoPzZT2bT0dl0mk2kF33bgmN3MYw//4U
         3NgIqINZrl5C3L9iwllTXhucCnl8cDHzhRxQZnJTlSPKSXN+N3qcVIyFsaTsuJtjz6zY
         vt6XhP6oD/qh69OMgs7aDATepao3nghkaGnoLfgdYruBEEQ3UQYXZytprBAqhIYs9V5c
         uN9abaLW0slPcJD4eN15fH6Rc5XpKg5VezC06FhxIPIhzwHUy5RugkpbWY17/we450ln
         o0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054450; x=1738659250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfydJTe7jinuFpK0+2LkOwiEj/DT05PU+SApnm7PN8o=;
        b=IIFNWGplLHFn0iU32fT65kk98E9FcRFSEzLx6ISBKLD9mLRKJU/pHgPy8TYkqgo9+S
         1NtACkyhSJcZ+1KeKgXWtiMwnw5DyiFHB6db8Fav8Bojg1fzHNAPWJNoPyYNLSc6wk+5
         jrZqF4fEVo7rZxUaxWoEGjPnbMuTwbKiL+ypYTjx3J3TCQFBxyhWs9NW5Zq+FpLyiDwg
         FHOJ12fsZq83Ets5F41goAFtE3zdBgfKpVN2BFVlPEMxR2orsEFyIKf62Q/bRWDn/mG1
         +e0S/2I9vYX0S+p2mH1ydMZ5GX7Ed8Ai3i2gTq2IoZgEk4jybgIAgpDw8xI1Ba1uiyal
         a6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXmA2B0GUJRDGuZ/CvKxTr7UN1AQYuvF0+1Pd0TAsN+NtKx5ekrZCmQkKPPsU0lsfmsUcrcYmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGczgf3XmmkqXyWfaQdWwVvsZhP7OPnOR3NrHV/fj8Qq7xTUD
	yNIWime4az0cJ+CSNdbuk8FStZhkfTRsMtBGwQgjzvnYE52Vh2OG5HX2LIAQEKwE1aaAZpb57iO
	n+/WOHp2/vBz6ayOipaq1tArLiXw=
X-Gm-Gg: ASbGncs4Q9P8jjGJ+n96tv04tBBJrVh6pQlJAYzWFcbwc9+jqLqPGWg6O+Q7R9Rxz1Q
	OyGawGQcQbEcK2/QHfeA58xZ2PDinUTHlbA3jBEE5W0f+1NZXUwX9jt/n23GCSf8L+CcHxiE33R
	U=
X-Google-Smtp-Source: AGHT+IEup4m/ZXOG4blLG4hyCgbU5fgaoubFQuSyD7c2Ae7eYlkfcy8WV669nJzd0BINwe5GoMWr+VGDAIsyWxaEoB0=
X-Received: by 2002:ac2:4896:0:b0:542:1bdd:511a with SMTP id
 2adb3069b0e04-5439c246115mr12508128e87.13.1738054450005; Tue, 28 Jan 2025
 00:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128174938.2638-1-42.hyeyoo@gmail.com>
In-Reply-To: <20250128174938.2638-1-42.hyeyoo@gmail.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 29 Jan 2025 02:53:29 +0900
X-Gm-Features: AWEUYZnrMGYgKdaFD0tRWEz6HmCDR6VMBu5ND8dS-UzfS8ETACvAnLM0Io2KNaM
Message-ID: <CAB=+i9SNugcwVNLkB5TxnRQO85Hch=ncibc7fyG3Db_JdGj2Ow@mail.gmail.com>
Subject: Re: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 5:50=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> mistakenly skipped charging any zswapped pages when a single call to
> zswap_store_page() failed, even if some pages in the folio are
> successfully stored in zswap.
>
> Making things worse, these not-charged pages are uncharged in
> zswap_entry_free(), making zswap charging inconsistent.
>
> This inconsistency triggers two warnings when following these steps:
>   # On a machine with 64GiB of RAM and 36GiB of zswap
>   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
>   $ sudo reboot
>
>   Two warnings are:
>     in mm/memcontrol.c:163, function obj_cgroup_release():
>       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
>
>     in mm/page_counter.c:60, function page_counter_cancel():
>       if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=3D%lu\=
n",
>           new, nr_pages))
>
> Charge zswapped pages even if some pages of the folio are not zswapped.
> After resolving the inconsistency, these warnings disappear.
>
> Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/zswap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6504174fbc6a..92752cd05c75 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1568,20 +1568,20 @@ bool zswap_store(struct folio *folio)
>
>                 bytes =3D zswap_store_page(page, objcg, pool);
>                 if (bytes < 0)
> -                       goto put_pool;
> +                       goto charge_zswap;
>                 compressed_bytes +=3D bytes;
>         }
>
> -       if (objcg) {
> -               obj_cgroup_charge_zswap(objcg, compressed_bytes);
> -               count_objcg_events(objcg, ZSWPOUT, nr_pages);
> -       }
> -
>         atomic_long_add(nr_pages, &zswap_stored_pages);
>         count_vm_events(ZSWPOUT, nr_pages);

Wait, it also does not account for these events/counters.
Will send v2. Sorry for the noise.

If I missed anything else, please let me know.

>         ret =3D true;
>
> +charge_zswap:
> +       if (objcg) {
> +               obj_cgroup_charge_zswap(objcg, compressed_bytes);
> +               count_objcg_events(objcg, ZSWPOUT, nr_pages);
> +       }
>  put_pool:
>         zswap_pool_put(pool);
>  put_objcg:
> --
> 2.47.1
>

