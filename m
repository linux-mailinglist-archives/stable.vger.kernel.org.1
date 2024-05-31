Return-Path: <stable+bounces-47767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD78D5B97
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E272815DE
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D5474050;
	Fri, 31 May 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejb2LN3v"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8EF5588D;
	Fri, 31 May 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140945; cv=none; b=q3c/hd3DVGiSrW5bhOKjgKojiuYCwqRaSYVumZTltjOyBKEBYV93YJdSUvMW9TJMmg6TiuQ0SIn3y6ZKzytvZNOCBgDwhbR77h3rKJZLZwdBHHLUtaKhVcjsfCPV7Nz30OS7kNJuu9aU0NdeMLuqrcD4giaHCKhmI9Y6N/67MSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140945; c=relaxed/simple;
	bh=79EFiJ715P6QJWckc3+p619gX5OdwDaseMtRsIsV7Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMMLsdPt3KdriD0yFyIvjsi3ukjoUmW7WNRcD43/i3p3qk/ZNvsWcJFyxifh4cJjKE0UTqZVTZWmdVC7IDLwcZ62nwJnlP3Dj/iZcU3poProGF+PTeK6nsvGyXquZhDoLM6dV6nv6hpJ/gxMsvNDGehZIZBGEzPW3kMU2YMwVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejb2LN3v; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae259b1c87so9817206d6.1;
        Fri, 31 May 2024 00:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717140943; x=1717745743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfOA63xP8eIEGsvy1bWF9HD3XOOga8FjapvzB1veUDI=;
        b=Ejb2LN3v/MQZqJjpiPjBtipCCerTpN9ugig6uZ1xWaTzsjVRs4HqQ9kkM8gM2pmmxd
         OS5Tbcila5h3jCtvynRzzmBcNN+h3m/iY89uQPpQZ0NeaqVIadZSt/P4oKVTrhDlJi6q
         O7mlCBxc3nZvRk/Y2y5/vEna+qLGnUy/VStwl+jmDDrllE77L2J+pMc0F7EN56m3VSO6
         YcntMiS1X5DuLhfJM7lBB0NC+J5TRYRP/BlwtTtPEhaK7jPvDRVQwoMsIrZK4gADe5w9
         wgByQK3We+rwxcRSTDp8HNu+voxbjrDpM+i+mBDHNp2ruYtnn7JnhideaG3iVLJR0QZ5
         ibtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717140943; x=1717745743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfOA63xP8eIEGsvy1bWF9HD3XOOga8FjapvzB1veUDI=;
        b=TjSptC/OOq7i1L8h1CZAnr7gT7vHj4PLYiEoR1epigs1/OX9wZ8lP7ZhHNPwJlCIoV
         zdXbzLeyEmQjIb1Rg1I9MWs+7GFWQ74I0Ki4tvwuiUSu08JuKUbLzwckobOWFc9Whp7E
         I8bpJLwcJv3pbVD2UlNlk3KTlRla93QPdojZ0l3y6Jl/GgGERsglt0uHFOcaUBg2C3Iz
         Iq7UwOcEhLZWOzIPfBtrSP4NJsH5SZRM81tjo9DbgZ0sbg0Isf7ufMsnOVKUs0cjeoWl
         DGZQy+1vR1DB0mOdLPXCcHC5TGUjj1QvX34VYlyf9mq88H33u9bI267KZMKk7hZak6PB
         6kkg==
X-Gm-Message-State: AOJu0YwNkITagWFk+Km9dee0+ZIdZfWD+v8l73/XjaGfk6Ecry+4NnAP
	GQxaNPhKyHCSy1f7HAge501+2Er4ccOVlqMKWB6wcMDgZNchAiFnByditQE1e6MMrBV4yrPRUEu
	TntrxfqkX3lpMzk1Ud6Sx6yDyvVFjFiOr
X-Google-Smtp-Source: AGHT+IFAfHRC2QhKxkbvXMQ3Gn3ES4AYS7NafZQYdKHEXsY0dJj4Z+RL9Sc3c6L9ZsL9ms8VMSbSaXyqBrbr7KsuTDI=
X-Received: by 2002:a05:6214:1243:b0:6ad:8167:ac48 with SMTP id
 6a1803df08f44-6ae0faf6831mr72100276d6.24.1717140942979; Fri, 31 May 2024
 00:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530190518.19688-1-sashal@kernel.org>
In-Reply-To: <20240530190518.19688-1-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 31 May 2024 10:35:32 +0300
Message-ID: <CAOQ4uxg1Ce31UDDeb9ADYgEBvr582j4hqmJ-B72iAL+2xsAYzw@mail.gmail.com>
Subject: Re: Patch "fs: move kiocb_start_write() into vfs_iocb_iter_write()"
 has been added to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:05=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     fs: move kiocb_start_write() into vfs_iocb_iter_write()
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      fs-move-kiocb_start_write-into-vfs_iocb_iter_write.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 17f38d69e7960a2b346db04750b0e4ba867c0b83
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Wed Nov 22 14:27:12 2023 +0200
>
>     fs: move kiocb_start_write() into vfs_iocb_iter_write()
>
>     [ Upstream commit 6ae654392bb516a0baa47fed1f085d84e8cad739 ]
>
>     In vfs code, sb_start_write() is usually called after the permission =
hook
>     in rw_verify_area().  vfs_iocb_iter_write() is an exception to this r=
ule,
>     where kiocb_start_write() is called by its callers.
>
>     Move kiocb_start_write() from the callers into vfs_iocb_iter_write()
>     after the rw_verify_area() checks, to make them "start-write-safe".
>
>     The semantics of vfs_iocb_iter_write() is changed, so that the caller=
 is
>     responsible for calling kiocb_end_write() on completion only if async
>     iocb was queued.  The completion handlers of both callers were adapte=
d
>     to this semantic change.
>

This comment about semantics change looks like a clue from my past
self that backporting this commit as standalone is risky.

This commit was part of a pretty big shuffle in splice and ovl code.
I'd feel much more comfortable with backporting the entire ovl
series 14ab6d425e8067..5b02bfc1e7e3 and splice series
v6.7..6ae654392bb51 than just 3 individual commits in the middle.

Thanks,
Amir.




>     This is needed for fanotify "pre content" events.
>
>     Suggested-by: Jan Kara <jack@suse.cz>
>     Suggested-by: Josef Bacik <josef@toxicpanda.com>
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>     Link: https://lore.kernel.org/r/20231122122715.2561213-14-amir73il@gm=
ail.com
>     Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>     Reviewed-by: Jan Kara <jack@suse.cz>
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
>     Stable-dep-of: 7c98f7cb8fda ("remove call_{read,write}_iter() functio=
ns")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 009d23cd435b5..5857241c59181 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -259,7 +259,8 @@ static void cachefiles_write_complete(struct kiocb *i=
ocb, long ret)
>
>         _enter("%ld", ret);
>
> -       kiocb_end_write(iocb);
> +       if (ki->was_async)
> +               kiocb_end_write(iocb);
>
>         if (ret < 0)
>                 trace_cachefiles_io_error(object, inode, ret,
> @@ -319,8 +320,6 @@ int __cachefiles_write(struct cachefiles_object *obje=
ct,
>                 ki->iocb.ki_complete =3D cachefiles_write_complete;
>         atomic_long_add(ki->b_writing, &cache->b_writing);
>
> -       kiocb_start_write(&ki->iocb);
> -
>         get_file(ki->iocb.ki_filp);
>         cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 9fd88579bfbfb..a1c64c2b8e204 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -295,10 +295,8 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_r=
eq *aio_req)
>         struct kiocb *iocb =3D &aio_req->iocb;
>         struct kiocb *orig_iocb =3D aio_req->orig_iocb;
>
> -       if (iocb->ki_flags & IOCB_WRITE) {
> -               kiocb_end_write(iocb);
> +       if (iocb->ki_flags & IOCB_WRITE)
>                 ovl_file_modified(orig_iocb->ki_filp);
> -       }
>
>         orig_iocb->ki_pos =3D iocb->ki_pos;
>         ovl_aio_put(aio_req);
> @@ -310,6 +308,9 @@ static void ovl_aio_rw_complete(struct kiocb *iocb, l=
ong res)
>                                                    struct ovl_aio_req, io=
cb);
>         struct kiocb *orig_iocb =3D aio_req->orig_iocb;
>
> +       if (iocb->ki_flags & IOCB_WRITE)
> +               kiocb_end_write(iocb);
> +
>         ovl_aio_cleanup_handler(aio_req);
>         orig_iocb->ki_complete(orig_iocb, res);
>  }
> @@ -421,7 +422,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, str=
uct iov_iter *iter)
>                 aio_req->iocb.ki_flags =3D ifl;
>                 aio_req->iocb.ki_complete =3D ovl_aio_rw_complete;
>                 refcount_set(&aio_req->ref, 2);
> -               kiocb_start_write(&aio_req->iocb);
>                 ret =3D vfs_iocb_iter_write(real.file, &aio_req->iocb, it=
er);
>                 ovl_aio_put(aio_req);
>                 if (ret !=3D -EIOCBQUEUED)
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 4771701c896ba..9a56949f3b8d1 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -865,6 +865,10 @@ static ssize_t do_iter_write(struct file *file, stru=
ct iov_iter *iter,
>         return ret;
>  }
>
> +/*
> + * Caller is responsible for calling kiocb_end_write() on completion
> + * if async iocb was queued.
> + */
>  ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
>                             struct iov_iter *iter)
>  {
> @@ -885,7 +889,10 @@ ssize_t vfs_iocb_iter_write(struct file *file, struc=
t kiocb *iocb,
>         if (ret < 0)
>                 return ret;
>
> +       kiocb_start_write(iocb);
>         ret =3D call_write_iter(file, iocb, iter);
> +       if (ret !=3D -EIOCBQUEUED)
> +               kiocb_end_write(iocb);
>         if (ret > 0)
>                 fsnotify_modify(file);
>

