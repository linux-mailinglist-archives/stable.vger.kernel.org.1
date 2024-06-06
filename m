Return-Path: <stable+bounces-49909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB08FF00E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74971B29143
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB319B59C;
	Thu,  6 Jun 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gih88277"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DB195FDA
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684504; cv=none; b=UJDGczLUuRRBvfhb7UB6D/BK3AeVvJ45q5XsFpxd4U962zdDGLpovnb3HVcLBFs/yu8VgeahWtpZLb9jtpTRkm8GnRA0pzwQViltIJCDSOKsYb/6UFnZy9407TjQPnk06twvpJMHyd3jCdGkkFOV1Ud1wWLsw7bsaMnDgqr+k6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684504; c=relaxed/simple;
	bh=h9ZaPrAmxAPQehpDzjStkeIg6YJXxVarWCaYU2WS9kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK6Dvdx9XWLGKywPh54WtIFXlnGa89UV/qeAD93/uesoaRJPCOTWb5Txq6ADF725R/hYHvbcQ61Nu8Z4I61ELNdYYSd1M4UU7b8fi7fUSt+lSYy4hjEHloBE+YVSIBjRRCZX3Mz7CgO9EzhPAfv9Qw8EH/4/Qbnp24Wy0vb3NJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gih88277; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79532ec4306so48080785a.1
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684502; x=1718289302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk/yBrg3lB0eIyTR1z2aQPbvwHEOsAf8ISJq44rsaRI=;
        b=gih88277epJawk1SuxqwFyQOEfj9cx4y3SbIkBAoB+rVNE1Ra4ZvSW4rEoQAZIC5ou
         uACMkeVNXpTewPsYvJuiH7nisl3gCS1355B5lnzmuV+c+H+gcIhaOyIHqTHpJdAe3cqG
         AB0UthuivThFEkwcVqA38iVCdtXYbLDaSnql69q124o6jK+s/VDpy2Km7pnGfqzL08Rc
         aDkrolynl69WDEi/OOUssGgVuc7EbPHydZG+iyrlT10uurpK0ee7AuoWgEKqPs7uW3Ly
         XkJUW6Em23OwGQ4GgwoxopZKgc/ULKFkhWF8YKXn71xOypPqbylCLZEIa8qOmvSQjyL7
         VJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684502; x=1718289302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fk/yBrg3lB0eIyTR1z2aQPbvwHEOsAf8ISJq44rsaRI=;
        b=XpI71b28bdoVqFeMTyN69L0lHUbBISaUVLIFRpszaegC9YeuNGEpH2avZzSBzy9VMG
         PMCTP57QXKXdn5VB3WDGOC5Pxms59Z+pR7lZOjN/xRiyuc1qYQHkeFUusdOeKK2MSwFs
         lk8qeU6AcF40ISioRhDeCg9ejSNTpDhjDpt+YdFLLKi5RGZJkLrkuKHrR787qrPVAhW/
         blJO+2jdGfyYrIbh5a2utpKPjw9k6H+zi/nTCMwywumHwdvGSTU9frjXhEGeL/fOvkUv
         etn+MsSbZUzl/zVVHrXaHZuESuaHR4QYFzKJOQH70VzdKYjX7tHgT3Tko+MY77BxHpcm
         3kQg==
X-Gm-Message-State: AOJu0Yzg+CCkg2b7eiYX4MKjertsBnncm40XtH4cthSioxnPte1PvhEp
	Yr4Q6BlsYUmn7IcqMPscIiRGOMHvsCd8nXkHR+Exskhtn7FNXEMYal9XqL2wW+iy7pu/JFHh8f6
	gfDUfbmsAqjQUiFisuRNpXtO6Rwg=
X-Google-Smtp-Source: AGHT+IGialW1cgUFYrkwgo6znlv+dlJDrhpohenFUSsh7AtWMA1/F9Ae5x0lyonf7iHbyWTdszun78wPTkmnnYgf2WU=
X-Received: by 2002:a05:620a:2005:b0:792:c683:1f48 with SMTP id
 af79cd13be357-79523d4f6bamr611477785a.36.1717684501908; Thu, 06 Jun 2024
 07:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org> <20240606131746.600659628@linuxfoundation.org>
In-Reply-To: <20240606131746.600659628@linuxfoundation.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Jun 2024 17:34:50 +0300
Message-ID: <CAOQ4uxifOH00rFOgOb50-XySScixowqa3YfrFLDDcsdfmtEMCQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 440/744] fs: move kiocb_start_write() into vfs_iocb_iter_write()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:18=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>

I have objections and I wrote them when Sasha posted the patch for review:

https://lore.kernel.org/stable/CAOQ4uxg1Ce31UDDeb9ADYgEBvr582j4hqmJ-B72iAL+=
2xsAYzw@mail.gmail.com/

Where did this objection get lost?

Thanks,
Amir.

> ------------------
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> [ Upstream commit 6ae654392bb516a0baa47fed1f085d84e8cad739 ]
>
> In vfs code, sb_start_write() is usually called after the permission hook
> in rw_verify_area().  vfs_iocb_iter_write() is an exception to this rule,
> where kiocb_start_write() is called by its callers.
>
> Move kiocb_start_write() from the callers into vfs_iocb_iter_write()
> after the rw_verify_area() checks, to make them "start-write-safe".
>
> The semantics of vfs_iocb_iter_write() is changed, so that the caller is
> responsible for calling kiocb_end_write() on completion only if async
> iocb was queued.  The completion handlers of both callers were adapted
> to this semantic change.
>
> This is needed for fanotify "pre content" events.
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/r/20231122122715.2561213-14-amir73il@gmail.=
com
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Stable-dep-of: 7c98f7cb8fda ("remove call_{read,write}_iter() functions")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/cachefiles/io.c  | 5 ++---
>  fs/overlayfs/file.c | 8 ++++----
>  fs/read_write.c     | 7 +++++++
>  3 files changed, 13 insertions(+), 7 deletions(-)
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
> --
> 2.43.0
>
>
>

