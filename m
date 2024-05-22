Return-Path: <stable+bounces-45592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 566478CC5BB
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 19:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8A41F22381
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5AB142910;
	Wed, 22 May 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Va+DFblz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9D7D071
	for <stable@vger.kernel.org>; Wed, 22 May 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399654; cv=none; b=pKYwSCpUGxsbr6/vXGQJphT7Wa2iSLa1ChaXJUiGL7fRrMljTWQr6tqOK/Eum7bl2vij7dQISt1Agevrgfm8xf1fFo8HhJv7I438r82rQz/x5DlfCun4k/cX77fo/zvym79vX65b+6kSLEJkKoQsGi1QI96DYYE6gXq9r+Zy7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399654; c=relaxed/simple;
	bh=9Sf2fhKuvu8tkTp39Symjm4BKM51pxxuc1V5R+6KeU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=On2kJ3yE4xeNqvQ2hr0cSH6br8RkhVwen5l4Emoq1foatihFofC5LFJftiaAwlndmC7AmeD2b9o9ydz8YwN2swXMo+qipVzjp7TlG/WCwVFee7uqVVEFVDLg5MCEg7XxU0lHw8Ny4aBXFOlhxGJ3b4OOw6tqFkYHDO6e9LF2o84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Va+DFblz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df4e40a3cb6so997328276.0
        for <stable@vger.kernel.org>; Wed, 22 May 2024 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716399652; x=1717004452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+KExuXY6x2RNXAGihFUdQFtzxyzRd1UAydMgLYyZeM=;
        b=Va+DFblzR94AUco0PnOXQeIFm052mEU6OAf0V6XRaBsIhEp7Apsmt3WCtZi3hkyoSz
         CBvSGAU4iL2P/Raf4ex7hjqEz0/nf+4gzlI3WIRZ2REfbGsZ+Akc/pPK4DxJOQH+77pe
         iUeFdronwjetQ3leoyFqrH76tJBP51RjNcmZZ5lx77EFli2PBcGgAVWX7NTe2CLcoJeN
         oMVM2OJ9eAB4Utv7eH7YO2GCWx0fxW8wi9idWOjvpQYHJgOAGVo60aeUrxtBE87wtCFF
         v9edRbQLiAluaRL+8RdKE5rBUQw4uuqTF+p1dcxsZST/OeYJKLvZ2kA0HmrTQ6SHxo8U
         wkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399652; x=1717004452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+KExuXY6x2RNXAGihFUdQFtzxyzRd1UAydMgLYyZeM=;
        b=PXMCR/PVrjobjf5HdWUl8vmfK3UEULlyN6cKSlAZzIC1pizYNNJYPvcUhsTxw//Ydb
         ayZfMvBuvrCfKsQnr+VQ7uQDVi8kxy39u+nzzOAAOys4gelh17XJfP2YPfhzxzZl3wbQ
         WK5hvWqtl6nio1g2v1A8NUFJ0QCjyClgbQn9lxGxJjUDCW1LWMbXOUDswrDODnXAbVm0
         oUzLaH23HFcb1PkDbBxWnw3YYteYwjbMEwp+KTC76hRHJXjQ8SNi25q3qvpS0nNjrRN4
         TcJPGaMgTuNyXdjnSEr1TcpgHGpo1k1TlM/Qt9S7p9+Yy3N+7iQujq9rPHYENVg78Npt
         y0/A==
X-Forwarded-Encrypted: i=1; AJvYcCVC6y+0QZX94TrlT3IfCoJT14w98uRIWdYVTZKJJ2Xn/Q6HVBfjCaXXB6FdwIcvP6UsuWpDelbSVY762lTMUhlTiM8/0L+k
X-Gm-Message-State: AOJu0Yx+pYObnEGnuvjytgyRrIVOkkN2MTkptnApWh1tP30J1cmRTmPb
	focHUM1+JidconX66Nw1qexE0NBQwjftlMKLyVXmNleOa/sxK1e0rDrtvo7iLtxSdx/GwIKOcPf
	bFqetU3Zd7I9+fEtwCer2KXU8WgQCvL3FCPEs5CPIYYprzaro7Q==
X-Google-Smtp-Source: AGHT+IFEar4omGEdEg7p1pIeJHpqJdxEZysSMoFwL4CvUt49f3bponvnO1J/Gp3qNrH1hFjfFb/lUdHwXQMMQUkAlvw=
X-Received: by 2002:a25:e08c:0:b0:de4:5d85:6928 with SMTP id
 3f1490d57ef6-df4e0bc6db1mr3041714276.31.1716399651838; Wed, 22 May 2024
 10:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522122326.696928-1-pchelkin@ispras.ru>
In-Reply-To: <20240522122326.696928-1-pchelkin@ispras.ru>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 22 May 2024 10:40:39 -0700
Message-ID: <CABdmKX2tb_Vn8sF_hXVOMZ7HV9cU9KMwu_WyKrJuoeNjWF85bQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: handle testing kthreads creation failure
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Chris Wilson <chris@chris-wilson.co.uk>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 5:24=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> kthread creation may possibly fail inside race_signal_callback(). In
> such case stop the already started threads and return with error code.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 2989f6451084 ("dma-buf: Add selftests for dma-fence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/dma-buf/st-dma-fence.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fenc=
e.c
> index b7c6f7ea9e0c..ab1ec4631578 100644
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
> +                                       kthread_stop(t[i].task);

This looks like it needs to be kthread_stop_put since get_task_struct
was called for previous successful kthread_run calls.

> +                               return ret;
> +                       }
>                         get_task_struct(t[i].task);
>                 }
>
> --
> 2.39.2
>

