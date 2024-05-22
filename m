Return-Path: <stable+bounces-45595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED378CC65D
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 20:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A31A1C20C36
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65531145B2D;
	Wed, 22 May 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAQURosu"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C941422DC
	for <stable@vger.kernel.org>; Wed, 22 May 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402833; cv=none; b=f5Jb4cb/umhTb/k/FtJeSw7/6Y69cHWRx3wlFw0CvzIYPPw4/6YTi900OYxvtHvR7XaADqqJYLNpprFLc4VaSaBKwdyWBy+SWho7jgrLy7kVEmWneOiIItwIxacQKYY48mGzDqKPX77BgEbNAAOxKkayVUToNK2iYOlze0YLMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402833; c=relaxed/simple;
	bh=jnEBtkTj6abvY8mxMmaxe+8NYxHaAdanWXFKxYwaKy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erXTkGFqpKqTZ5AUjVEBPiP6RP1feyECo4USzZl2CTXffMOWZtIielZr85ZsrzqP/FyqfPWZyG86QIvLzbbhdKUtbJmBcg9HElI2sLwoH0Zzkj+mPq1gTgOboKIhG9kpVc7CP9sedHbu6B8Y0EAKQ0q4D+iciNbCwN9zXB5Xcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAQURosu; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de462979e00so1365416276.3
        for <stable@vger.kernel.org>; Wed, 22 May 2024 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716402831; x=1717007631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EbhQWdOoh78Q/g/fDhY/dpoBbFrko5oWqLo7rk8/U0=;
        b=iAQURosuJKIEGwWLqugJ/0GW5yZsg9VxKsQhWA7Qqc6+rFSFLDbtWEo8q7xiItLTJM
         XUHgmeYz5TJu4SvfIMhmil5K8APXmbv6Rps1zGMTLMOsG/rf9VYotCuZPF3k8+Pop2o3
         DTQDy6bJRzBV/QGKkGpkGmnRjO4Aki0E+bVL/JyRPPzDtmfXWphXnw0Fvxe/mWXPps+S
         GT9mYrB/cg9cGeEpXs4GZEmttMMczSg4edIYQz8ES6x44RG7+tRLgJRfl1yxr/O7DwkJ
         vu3pRO5r8vyT7rEzFqfcS7iIQG0KyaAsCc13F4T8rbsgiihS0qzuGHxerq7/BYNUSD5E
         yp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716402831; x=1717007631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EbhQWdOoh78Q/g/fDhY/dpoBbFrko5oWqLo7rk8/U0=;
        b=RbmhdDdVlJGjeOfkw1ZgTQ/sv8RaXlmDtST/nO0ZTYHluRBlE7icEALdvGns1yqFAt
         oF9PbDB/9Nf2jjN2dm0NDMtY7/jt1ZSzSDJvJkWFjD7pZvTecYmzH6iIJIWWgqtPNnBn
         KFu3w9zhLFIOQhm/jnFmLScv3RNOmvG8587z3+3RUyUeDm0DdBmDGhyke/W7UhtKvWJU
         TCEv+lPvzUVzYeNW1ccgIKXBFL95UnUeBqU3umlOz/QWR9tB8f5XZoyYYLf+nzW8qotP
         vM6EOtOEnYvhgHSirbov/Omsc52jhETgtrAGCF04l++Zm/OuCi6X6i788AFBDjJEDDZV
         TOuA==
X-Forwarded-Encrypted: i=1; AJvYcCX+WuJ3pb3DHtFGbG2oeFvIu/zIQ6nm5WZQWpA/HSF61p3lMl5jBKLnoV4O02kTkxmuLcyu03UEelXPivLULUcQHSxV6hXF
X-Gm-Message-State: AOJu0YxGeA0t6G7nTI8PopNqn83mTR7CePoRSEB+RoMXVPUrZD0OWXXi
	+ttt5X/oDJi2SEv2TDlp7aiMfxIKJegU12un6HpI1yGwyq8+kJ/TweDoEGJ+VlkxgRV0TUtv0w/
	1Vste+Yjd89iu0lq+EjD0XN21k8clqEXzlifW
X-Google-Smtp-Source: AGHT+IGN47Nmo4f4RGiZUu/PPp/jTEE3uqbIMeUgnJAorz3ApRFTFuY2uRHKB4JKQhH3PzXLlW1bM1uS2dJXihd38dY=
X-Received: by 2002:a25:a2c4:0:b0:de5:51a1:d47a with SMTP id
 3f1490d57ef6-df4e0c1d0dbmr2686142276.28.1716402830630; Wed, 22 May 2024
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522181308.841686-1-pchelkin@ispras.ru>
In-Reply-To: <20240522181308.841686-1-pchelkin@ispras.ru>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 22 May 2024 11:33:38 -0700
Message-ID: <CABdmKX2qdT0HvkX0B6kcxALwxZsLFOtgPsOP_rY0AXM1eAtAtA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: handle testing kthreads creation failure
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Chris Wilson <chris@chris-wilson.co.uk>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:14=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru=
> wrote:
>
> kthread creation may possibly fail inside race_signal_callback(). In
> such a case stop the already started threads, put the already taken
> references to them and return with error code.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 2989f6451084 ("dma-buf: Add selftests for dma-fence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
> ---
> v2: use kthread_stop_put() to actually put the last reference as
>     T.J. Mercier noticed;
>     link to v1: https://lore.kernel.org/lkml/20240522122326.696928-1-pche=
lkin@ispras.ru/
>
>  drivers/dma-buf/st-dma-fence.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fenc=
e.c
> index b7c6f7ea9e0c..6a1bfcd0cc21 100644
> --- a/drivers/dma-buf/st-dma-fence.c
> +++ b/drivers/dma-buf/st-dma-fence.c
> @@ -540,6 +540,12 @@ static int race_signal_callback(void *arg)
>                         t[i].before =3D pass;
>                         t[i].task =3D kthread_run(thread_signal_callback,=
 &t[i],
>                                                 "dma-fence:%d", i);
> +                       if (IS_ERR(t[i].task)) {
> +                               ret =3D PTR_ERR(t[i].task);
> +                               while (--i >=3D 0)
> +                                       kthread_stop_put(t[i].task);
> +                               return ret;
> +                       }
>                         get_task_struct(t[i].task);
>                 }
>
> --
> 2.39.2
>

