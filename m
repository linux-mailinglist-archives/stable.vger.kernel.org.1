Return-Path: <stable+bounces-47768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33908D5C24
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED7228932A
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85476025;
	Fri, 31 May 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpyYTmFs"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB125249F5;
	Fri, 31 May 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142245; cv=none; b=oSRKWb0ylF5Yg73NhgddwdTcaf1/oO1uGE7MFshEgYOaHL7Rx5H46DeW1yPPG7aB/PuiAtqKY2241XgKjoc6tazrlguDDAEzVW9y1Y9XrumfAQ4loxgm2TpF2Tm4fQWtyaiJZsr/aFb3C7Tjs/GbOtbrQBs8E+OGjBxGbkksMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142245; c=relaxed/simple;
	bh=dtbFV9zEdTeCFlEoioN8O2RTCr1hEGD0umzhcVStJgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj6uuEg5l/Zgmwrm/fZutoI0IPI5sAsaahZrVMLEPbhKZlARno1QrUeYugg/Dci2tM9dzdcue2y1nr1xGApQbZ9G1Lsy3TIv5Md0Z/uSi9ZQfACJHW8wgEAB0niCz9BpkD2vT/cgW4hsDyhlL444Zjsys/I/9D/at9GZtPSk97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpyYTmFs; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48bb4f21172so389623137.3;
        Fri, 31 May 2024 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717142242; x=1717747042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzt8snM2VCLX6g/WUsa+ZZmSCUypdCiOL7U3kSZi5kE=;
        b=JpyYTmFsjcvCufBJuNjHe2qKcTBG96Nz/MTUcise0R0AO5h1YZFJrNgs6mJHQbomxK
         jWjmu+YPXjUTLdG7j0IeAYOfRhQlAdMUiq59fWYqp7XPiApqpbTuAOj02/rIgzdhBgHu
         XAKhDMBT89hx+R55KMzMg4/ktCP+Uc0w91U6rFsWC62iIHgwmUPkpKdUdTb+EiIBQyG0
         /ZH+DcFXpQpAVYXcfwa32PnW1ClJy1rwXqf7I9TjD2iv6Z/qdKP+koZ8tFVL6jyH0o0v
         2+XKhqJnGzkUK/GMJLS0TFox6zumDv+/5zxKsqhetwRpcuoa9zC99aVjLuFgu1R5dtkc
         T1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717142242; x=1717747042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzt8snM2VCLX6g/WUsa+ZZmSCUypdCiOL7U3kSZi5kE=;
        b=ZSozGQU306uE9Q9klL927hpJuMEb4HuRHcoFhdHP5QHgz82yAdtQHEtoZ8bCnZvL6i
         cZIo1K9RDtuf+kgLF2N0URsIa8cPoDbeHxW0/Ci2f9ObeVFyq8UW2vaz3WO1UngiN3vL
         sQapnU0wz7wHgxO8toNEAJ4J6MVXNIb/lBOC60bNLeOx7s4zu1pWH5HfVzx1g1zF7ric
         O1EQaYFgK5Kg9Baz+8GRNaFwqmhLw8bouc/GcjQ8F23KEXKYycnNZrFHzOXU7CamdWHg
         ncPHM4amTSex3eZBFZ1esC4OG+LxfcCkp/JuUjp6oS3NzyjvozH04gQGNTVawDxWjDw7
         jZqg==
X-Gm-Message-State: AOJu0YxzdRXlDB2nRSsSJArfIZjrt1TduvJeCES0nbPViy+bPa/VxZZi
	4M7Qg5c5m3q2wrjEzrdGUGtMurVjuuAvpT13jlgKdxZ1dsj4C/cLaaQLkfV4/BJkm+qzcfYNUC7
	c+igClytVlaEQAZjkFJ5NX5VU9+T7fT8O
X-Google-Smtp-Source: AGHT+IG9J+H4VcKd/0MmC6sQ97PLz4T2L/VIY4n/43ASf6eVJ5DAACzOY4UDjXoImZ8v4+E73F9ZedUWHR/tyEXxNsE=
X-Received: by 2002:a05:6102:1298:b0:48a:2e81:6671 with SMTP id
 ada2fe7eead31-48bc2280e45mr1156529137.34.1717142242414; Fri, 31 May 2024
 00:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530190512.19604-1-sashal@kernel.org>
In-Reply-To: <20240530190512.19604-1-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 31 May 2024 10:57:10 +0300
Message-ID: <CAOQ4uxj6y0TJs9ZEzGCY4UkqUc1frcEOZsnP4UnWvGtQX89mRA@mail.gmail.com>
Subject: Re: Patch "ovl: add helper ovl_file_modified()" has been added to the
 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:05=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     ovl: add helper ovl_file_modified()
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      ovl-add-helper-ovl_file_modified.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit f87db32c0cdadc7eea4a37560867da0bd0bb87e8
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Wed Sep 27 13:43:44 2023 +0300
>
>     ovl: add helper ovl_file_modified()
>
>     [ Upstream commit c002728f608183449673818076380124935e6b9b ]
>
>     A simple wrapper for updating ovl inode size/mtime, to conform
>     with ovl_file_accessed().
>
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>     Stable-dep-of: 7c98f7cb8fda ("remove call_{read,write}_iter() functio=
ns")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>

No objection to this patch, except for the fact that I think it is not
in the best
interest of the stable tree to backport 7c98f7cb8fda as is.

I suggest that you consider backporting only the parts of 7c98f7cb8fda that
open code call_{read,write}_iter() in call sites (some or all), if you
need those
as dependencies but actually leave the wrappers in the stable tree.

If the bots selected 7c98f7cb8fda to stable because of the Fixes: tag,
then I think that Fixes: tag was misleading the stable bots in this case.

Thanks,
Amir.

> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 8be4dc050d1ed..9fd88579bfbfb 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -235,6 +235,12 @@ static loff_t ovl_llseek(struct file *file, loff_t o=
ffset, int whence)
>         return ret;
>  }
>
> +static void ovl_file_modified(struct file *file)
> +{
> +       /* Update size/mtime */
> +       ovl_copyattr(file_inode(file));
> +}
> +
>  static void ovl_file_accessed(struct file *file)
>  {
>         struct inode *inode, *upperinode;
> @@ -290,10 +296,8 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_r=
eq *aio_req)
>         struct kiocb *orig_iocb =3D aio_req->orig_iocb;
>
>         if (iocb->ki_flags & IOCB_WRITE) {
> -               struct inode *inode =3D file_inode(orig_iocb->ki_filp);
> -
>                 kiocb_end_write(iocb);
> -               ovl_copyattr(inode);
> +               ovl_file_modified(orig_iocb->ki_filp);
>         }
>
>         orig_iocb->ki_pos =3D iocb->ki_pos;
> @@ -403,7 +407,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, str=
uct iov_iter *iter)
>                                      ovl_iocb_to_rwf(ifl));
>                 file_end_write(real.file);
>                 /* Update size */
> -               ovl_copyattr(inode);
> +               ovl_file_modified(file);
>         } else {
>                 struct ovl_aio_req *aio_req;
>
> @@ -489,7 +493,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_inf=
o *pipe, struct file *out,
>
>         file_end_write(real.file);
>         /* Update size */
> -       ovl_copyattr(inode);
> +       ovl_file_modified(out);
>         revert_creds(old_cred);
>         fdput(real);
>
> @@ -570,7 +574,7 @@ static long ovl_fallocate(struct file *file, int mode=
, loff_t offset, loff_t len
>         revert_creds(old_cred);
>
>         /* Update size */
> -       ovl_copyattr(inode);
> +       ovl_file_modified(file);
>
>         fdput(real);
>
> @@ -654,7 +658,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff=
_t pos_in,
>         revert_creds(old_cred);
>
>         /* Update size */
> -       ovl_copyattr(inode_out);
> +       ovl_file_modified(file_out);
>
>         fdput(real_in);
>         fdput(real_out);

