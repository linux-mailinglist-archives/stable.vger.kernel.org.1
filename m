Return-Path: <stable+bounces-191965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F19C270BE
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 22:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB780351F95
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA37199939;
	Fri, 31 Oct 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNAvmuOb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9DA20FA9C
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946246; cv=none; b=Q1GgnDGUAvESxtethloIfXJ/5Ta9M6UqkTkJU5QckhXg2uWyRZMyJSraf6UBhfJx9gkAS4M8fBkV637c2okKXiWw2Bfk1+Xbk9Kx9wMcFsnmJCs96QQnFlOdO+zeuZ7qcfDOLPgQakBO9wN01Oj2TAK9dY5Jwt9C8yTimzKwd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946246; c=relaxed/simple;
	bh=Im012qh0MJpGdvOmFqSrqX4tKOtVONB+M0Go3dalb4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8at/s9HfM67mgKSzsXkXYjxxP44YfP6rb9Svr2Qf4eGhvgWLo4DOg2UWSCMQVdGR5lnp5YyHoxcXUVhO0et+hjwTYF7Z4KQoud7ExchwWtVgpyyOT2EXm5CIbrbbaUAkdturkXam+k1G8ePak0KfGN8GkspAv9IWl0Lr0YFgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNAvmuOb; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ecae310df8so41480671cf.2
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761946243; x=1762551043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+VLevZopoUL7OM8jNtLvOs6kVfhg97XSSemrzsfRdw=;
        b=RNAvmuObanwUoZ9eSQWdxwxdIOBCUaqrOkmLnjnYelOVQe3xL78dev8WyH60JIsZC3
         n9/AS9/l+IeR2yW7309XwLJvmiWsUtjGfoJE4tJSs6qSUWy9u/hUEFHGhuUsLEYHALwA
         rubu3mcxOmsYlcT7AUYQAk0BKqGPXbMwuqzFddgLrqdyCyE5AidKT1iD5Q3WNBSOODTC
         yc9cQNQ92CTeOVoIFaKLSe8OJI3yQg6GXg3ykReaCwfrDSVZyGsbyCVCDlv/ZDmywI/t
         j9YruDEGdsk41YCeyWs84K8PKReigtsLzQAZsDxFNz7njcrKkvb4yodJ7nbUPP61HBHF
         ifPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761946243; x=1762551043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+VLevZopoUL7OM8jNtLvOs6kVfhg97XSSemrzsfRdw=;
        b=dBjMiHe/brevfX504+ASjdSZ5TY4p3Xen2m2ZM/G9oskIvilCe2/sU7Q1tQ6npMmng
         TKik6yRwYFg0GRA3Tk78h2cpo78jLcq7gX3EP0fkKwGNBljRv6U8lcidb3+R84Rx6ZfK
         tZ23wJrKH7E6qiubl0EcEFvdKVGCq4cm1+9JfVmeKI6ijyKOCoTvZYEDrqqfT9nMx2ef
         wA7G+F021p2XEVnPGntZTtbsZQ9PSekAg/C8v1LPwMX1Qu7ZJbI1toiz9jRe5o2JUtqI
         AetZZO1P3rNVjHbSGaujCz0C8tO6JeHvUe1P0NFM0+KnoSrsnPGonWA76fFG7rKJ9CNP
         MbOw==
X-Forwarded-Encrypted: i=1; AJvYcCXhp8wXH8XqIEXa175zfofTJ5gDs2kgKuwEe8w0MBXMnV4ctewZ3CXOm2biAyhoY1qx7/4q1qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1cOJQa4Ggn7vaoXrGJQznxBIrbPQz/9fSNImze+c/TbqBmUk
	vGIWFCkTFk5GWeJ2lEk4pSsfkNzSMxEdrw3m1/LmMaBQLf96Yo26dSEjUqMBLA9mjlIDnjNRtbF
	H8vVk0yh4BEWjsAZCy4hCCnCtx64RYrkQI/b817k=
X-Gm-Gg: ASbGncsrEaf+t32Nc8SaDlqG7CDZwQyOpk9T9/lIoeLXb7DUuPZ91lSEYb532vsuJ5W
	I5ttbBXGzfBFn4CLBFrNTD1xBYFBYoOFeLLD/4h1nVGr/gTcmxn6orhtCydUaBOx+59VR6xOF79
	ymbkWkTfh8FY5GVjAj7qOTezH/rc2Xd+q10fen95Z6MnFexPh07h8HpnXDYeXLv92dyXQMpmX+Y
	37OoB+O3PdNNH1p+J2Bp+8ZY2q/o2suuUslPdM2khAxmM7S7YDLVUQST9xWXL7iejNJNoIj1tgG
	EFpbuIiXcDqBuiOZDx+b7U7tA8VEX5NQ
X-Google-Smtp-Source: AGHT+IGvpEcWAnufdVYjZrrJ/UQ22AI+c6oLcylk17vxXoDSf4VBfQSh8K/B1zqUDh7Etogh2HSPZZeo34lvnenc1BE=
X-Received: by 2002:a05:622a:1c12:b0:4d0:ac40:fab8 with SMTP id
 d75a77b69052e-4ed30d9286emr57909831cf.7.1761946243394; Fri, 31 Oct 2025
 14:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com> <20251021-io-uring-fixes-copy-finish-v1-1-913ecf8aa945@ddn.com>
In-Reply-To: <20251021-io-uring-fixes-copy-finish-v1-1-913ecf8aa945@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 31 Oct 2025 14:30:32 -0700
X-Gm-Features: AWmQ_bm2YRQTdTVsTJrVAWrmh292bBnOj8X2Yok5D4Ru31Xl7iFLnCGSslMae5w
Message-ID: <CAJnrk1aOsh-mFuueX0y=wvzvzF=MghNaLr85y+odToPB2pustg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: missing copy_finish in fuse-over-io-uring
 argument copies
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Cheng Ding <cding@ddn.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:46=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> From: Cheng Ding <cding@ddn.com>
>
> Fix a possible reference count leak of payload pages during
> fuse argument copies.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: <stable@vger.kernel.org> # v6.14
> Signed-off-by: Cheng Ding <cding@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c        |  2 +-
>  fs/fuse/dev_uring.c  | 12 +++++++++---
>  fs/fuse/fuse_dev_i.h |  1 +
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 132f38619d70720ce74eedc002a7b8f31e760a61..49b18d7accb39927e49bc3814=
ad2c3e51db84bb4 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -846,7 +846,7 @@ void fuse_copy_init(struct fuse_copy_state *cs, bool =
write,
>  }
>
>  /* Unmap and put previous page of userspace buffer */
> -static void fuse_copy_finish(struct fuse_copy_state *cs)
> +void fuse_copy_finish(struct fuse_copy_state *cs)
>  {
>         if (cs->currbuf) {
>                 struct pipe_buffer *buf =3D cs->currbuf;
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index f6b12aebb8bbe7d255980593b75b5fb5af9c669e..3721c2d91627f5438b6997df3=
de63734704e56ff 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -598,7 +598,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring=
 *ring,
>         cs.is_uring =3D true;
>         cs.req =3D req;
>
> -       return fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
> +       err =3D fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
> +       fuse_copy_finish(&cs);
> +       return err;
>  }
>
>   /*
> @@ -651,13 +653,17 @@ static int fuse_uring_args_to_ring(struct fuse_ring=
 *ring, struct fuse_req *req,
>                              (struct fuse_arg *)in_args, 0);
>         if (err) {
>                 pr_info_ratelimited("%s fuse_copy_args failed\n", __func_=
_);
> -               return err;
> +               goto copy_finish;
>         }
>
>         ent_in_out.payload_sz =3D cs.ring.copied_sz;
>         err =3D copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
>                            sizeof(ent_in_out));
> -       return err ? -EFAULT : 0;
> +       if (err)
> +               err =3D -EFAULT;
> +copy_finish:
> +       fuse_copy_finish(&cs);
> +       return err;
>  }

nit: this could just be

--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -649,6 +649,7 @@ static int fuse_uring_args_to_ring(struct
fuse_ring *ring, struct fuse_req *req,
        /* copy the payload */
        err =3D fuse_copy_args(&cs, num_args, args->in_pages,
                             (struct fuse_arg *)in_args, 0);
+       fuse_copy_finish(&cs);
        if (err) {
                pr_info_ratelimited("%s fuse_copy_args failed\n", __func__)=
;
                return err;

>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

