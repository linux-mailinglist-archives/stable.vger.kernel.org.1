Return-Path: <stable+bounces-77064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F7984F9D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 02:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D71C22B8F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 00:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B811136345;
	Wed, 25 Sep 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="kPpkFzRV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC26135A54
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225583; cv=none; b=mmGCHbPE8XdgpE+Vvmdj8pcmjbtm9w69wtcPovHHElEWaQYcxI7gvbV9mPA0lerXn+0YpYKLcBFUxQnG5M9GOe7yOa8iIF5Sx5j1z9AJ2ZuYrk3WCjlgFete9XSu5xn+WjnenVM+lWfOP4QcKj2WhZ9OTJjc0Q7H8TcSiDtlc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225583; c=relaxed/simple;
	bh=Ci4/UoxRRXd5uvuxYWSx4T5/MgJvAfME+zZeKA/e0oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwQoCVVzs3hKzzlOWrSiDHBkIIYEzGuggRpEdMJMFnvWpUgLfGSvHp5F8hrx+ejZ0w0Yvc6uP9XRjfSGSVHRz6m16CyOZi9mAtqgYYfmPk3fitTp+90h33aOT0t993imyb2VXw/YZiYHCmlG2fTIeY9VQd8h9PDr30exqTpcJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=android.com; spf=pass smtp.mailfrom=android.com; dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b=kPpkFzRV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=android.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=android.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so65551191fa.3
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 17:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20230601; t=1727225579; x=1727830379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8FbQywdH0oWZCGZXj5Hbv7B2G2tFNgGOo6kZcwthgc=;
        b=kPpkFzRVtxE+6FzFTW2iPA11I7blLrzEq2d8CtFRs1y6u+ns7TG8qHikKFrYCdKrw/
         901r0rm+r3MgxwqJNmHqCUjTzQuJdZyIJnw1b3z3oZm9gBFihsvEyr3CtuulxXDxkKpc
         dwGvhalbMvbpgmSi5K99Z/0zCgugitr4hUdAxx0Lu92FbOwHeS0jotlKP+EvgpmWATlG
         yh9oxFiqMorO1hBSn+szu6PiY49FIBPA40gGrsUagwdwVNh4NXnY3v8eW3kJqL/1l/Fe
         CTrxbeKSW0BUuvzXlMrErVNEjEOO6XXS9hJbItqj/m+8H/WyCjXNG9ilt5Wd3Z0nfiTt
         +kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727225579; x=1727830379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8FbQywdH0oWZCGZXj5Hbv7B2G2tFNgGOo6kZcwthgc=;
        b=vNCqJEsJhhVUNh9b6Vz8YOBwmUj0JIReVPhxvjcSva5mTDza3eLE2+bXQCo3jAbtLY
         VAkckk2h1MoKpAfLR8mtQmWOyX1Q5bhmP7P8InEmQSoMjZbNw/ZTf2utPfLYtzGOYMDd
         CuNg25pLu9p9oo6fWZYTIOciBu18qk+K4bgotDa0jaF7cqHxk1sMsr/mrt9CqL1Er8JL
         zO2heRCXPjG0U0M31GRQQyd0xS7peaNNtJ6HRKd7qkVGIfN+ACuy3VY99dnghvDGqfJ2
         G15zn6sBSw5bkc5E8LPPTolfitkbQBmpO2BMJuVnkbAOHY3hQQHfHjpdIyPqYtEAAT6R
         5e+A==
X-Forwarded-Encrypted: i=1; AJvYcCW5z6wexwHkGpNJX9hL27+IYWYiHOQgMrsCDEYlx7Oz2/QQBQ1H8RZWoVaiky4qtv8sDODs2vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQgpVk2HJ4NuN6Cy78oWxp1jYdL3a/5j9Q049xc6ZwDkeJtMyW
	Bcv6O+3Xa9YNxbDOE5FYACJCMjd95+4HSsnZEXaay5qJo3dVnbagILBEZSP/yBKE2L4v4JMZl9R
	l1WCq5OUi3d2sc8SIN7NCfiMP2Qd9UFfcU/a8
X-Google-Smtp-Source: AGHT+IEKqWZXHJ23DqHLKjn4v9fYYdxuY4ehghseFGkkd3Td6DXyGrindh9PvHj2mgDcjz/xQVGCMaxpHu4dh7YjjOs=
X-Received: by 2002:a05:651c:1502:b0:2f3:df8f:bfaa with SMTP id
 38308e7fff4ca-2f91ca6ed4fmr5783971fa.36.1727225578729; Tue, 24 Sep 2024
 17:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-4-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-4-cmllamas@google.com>
From: Todd Kjos <tkjos@android.com>
Date: Tue, 24 Sep 2024 17:52:47 -0700
Message-ID: <CAD0t5oNFc0UtFpsPVWBVTzZbEgqy+PeuW4uv1_sNM=+Aqbu2kA@mail.gmail.com>
Subject: Re: [PATCH 3/4] binder: fix freeze UAF in binder_release_work()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:44=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> When a binder reference is cleaned up, any freeze work queued in the
> associated process should also be removed. Otherwise, the reference is
> freed while its ref->freeze.work is still queued in proc->work leading
> to a use-after-free issue as shown by the following KASAN report:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-use-after-free in binder_release_work+0x398/0x3d0
>   Read of size 8 at addr ffff31600ee91488 by task kworker/5:1/211
>
>   CPU: 5 UID: 0 PID: 211 Comm: kworker/5:1 Not tainted 6.11.0-rc7-00382-g=
fc6c92196396 #22
>   Hardware name: linux,dummy-virt (DT)
>   Workqueue: events binder_deferred_func
>   Call trace:
>    binder_release_work+0x398/0x3d0
>    binder_deferred_func+0xb60/0x109c
>    process_one_work+0x51c/0xbd4
>    worker_thread+0x608/0xee8
>
>   Allocated by task 703:
>    __kmalloc_cache_noprof+0x130/0x280
>    binder_thread_write+0xdb4/0x42a0
>    binder_ioctl+0x18f0/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>    invoke_syscall+0x6c/0x254
>
>   Freed by task 211:
>    kfree+0xc4/0x230
>    binder_deferred_func+0xae8/0x109c
>    process_one_work+0x51c/0xbd4
>    worker_thread+0x608/0xee8
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This commit fixes the issue by ensuring any queued freeze work is removed
> when cleaning up a binder reference.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@android.com>

> ---
>  drivers/android/binder.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8bca2de6fa24..d955135ee37a 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1225,6 +1225,12 @@ static void binder_cleanup_ref_olocked(struct bind=
er_ref *ref)
>                 binder_dequeue_work(ref->proc, &ref->death->work);
>                 binder_stats_deleted(BINDER_STAT_DEATH);
>         }
> +
> +       if (ref->freeze) {
> +               binder_dequeue_work(ref->proc, &ref->freeze->work);
> +               binder_stats_deleted(BINDER_STAT_FREEZE);
> +       }
> +
>         binder_stats_deleted(BINDER_STAT_REF);
>  }
>
> --
> 2.46.0.792.g87dc391469-goog
>

