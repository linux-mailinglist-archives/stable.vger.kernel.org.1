Return-Path: <stable+bounces-81241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331789928F1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAD0285079
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF131E519;
	Mon,  7 Oct 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V4aP/rfI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50354136354
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296163; cv=none; b=qxm3kR7CnHCt8uvMtTp/c9nHEZxGLUsjmupicI6Lwaaqz2QEhoA6eT4G+BR5Fo9DaMIfvIjkPxKBRkQMdiuZdNxQwHtkRRJn6thdwL2oUkY0yWgEHlzyXLh/glU1CN/FYQ2k1ApqsWm56FJSV9Bz7DK+XZCGtuMPCgh4TuapD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296163; c=relaxed/simple;
	bh=QEW8xS45co+9Q5+FEHW81DqGS+oo/TRSeAM4ZM3skio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyVvSi8vVeUMI/zMaeuQwyVui7qwjWQDIs7AsHTAPkcMVyYGXDvUtH0CjAunhQLuC/uFAxKhjqjRzbVCYUcjOPAwjCtcu+EJuCjmcPOdbkGO9LZiadZVp5OICuQ5UnfpVRJH/L0nch+NlkrS1MG2YOZz7PIkMvOrMLtQoHwY83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V4aP/rfI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c87c7d6ad4so5891287a12.3
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728296158; x=1728900958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uD7+x06HNAsGvnUsU1IbHnMrioZv6+EXemRCdJxKLoc=;
        b=V4aP/rfIVYJxRLj7NCgAG5rh+521Cw9/uvwF3u0jKWC1gRmKSZd04K1zIt3oTJpmS6
         WjFuZD8nC1MmotYAUCcWFw+iiLX8hWUR+5QLvRVfYvMdOeBGZaeMZwQbKVZE6N5yAElE
         e0RTZyiUaWwc8u9VaSnB8KnYkF+zJQEgbI0JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296158; x=1728900958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uD7+x06HNAsGvnUsU1IbHnMrioZv6+EXemRCdJxKLoc=;
        b=VQ8BEjTZ4JOqVXVpBRj4ZzWzT0KZYGCZvmoWo6Qy5rodpyCn+mmtcApTdaU+DY1d+F
         +Nr4SyzfIpOKdni11JvsNG961eQ2VuvRq1BU2WyY1mR+NzXYxQ/AhG8e4znZ/Q1XTkvc
         OAJx8pGgDbwkEUihRajrzGjNF0pvuADnA5Bl9CsLnfr422i3HxtsXYbF8cXYhnpOIgz7
         wtxCAG8qnGZ+BD3ZbiY+ObA3LxnTcMmk4dXz82HTWsVJ/bktJ0faA7jN09QKbX5Nd3fn
         JtFAGmcOMf1msrZGZNAz/6/f5UtFwRMIfto1yh/WebjahI1GLOTNpPjy+nH1CMUxxzAA
         5KVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvEA4lluMgow/SVGu72lRGvH1cs75dfEKsK1pqzXA2+CQeRZIbI3XvASRytGBiVegFOHMGZaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgaTBsWdR0y3naCebFEuwNveSkmFR+U3xToaV0Sgo0IxiQRyk
	Sgc596dTxwY1lMR3bZZyX0qR6JKr7PSbFhmLIKp+jY8qOtuTP8MCeVj9fRMcB6Iy0teb6rT+hqJ
	3drdsvFDjU0g91JtHpD5VRKZiOgcuTBy8ThKwXw==
X-Google-Smtp-Source: AGHT+IHCZRkH8BOWmS+bXReQgFIle5qN39Wo9G9kYJNjoBdkjLUW7WB9tEXtznOwowsN9Uy1rnTsh/v4dV2Zx1Ta3bQ=
X-Received: by 2002:a17:907:7206:b0:a99:3dbf:648d with SMTP id
 a640c23a62f3a-a993dbf6715mr607796966b.45.1728296158491; Mon, 07 Oct 2024
 03:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004181828.3669209-1-sashal@kernel.org> <20241004181828.3669209-48-sashal@kernel.org>
In-Reply-To: <20241004181828.3669209-48-sashal@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 12:15:45 +0200
Message-ID: <CAJfpegtNF6CkSsE7yWq8-4W7HP3aOjE4xnAzJp0uiU-S7Wb8pg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 48/76] fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Miklos Szeredi <mszeredi@redhat.com>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 20:19, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> [ Upstream commit efad7153bf93db8565128f7567aab1d23e221098 ]
>
> Only f_path is used from backing files registered with
> FUSE_DEV_IOC_BACKING_OPEN, so it makes sense to allow O_PATH descriptors.
>
> O_PATH files have an empty f_op, so don't check read_iter/write_iter.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/fuse/passthrough.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 9666d13884ce5..62aee8289d110 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -228,16 +228,13 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
>         if (map->flags || map->padding)
>                 goto out;
>
> -       file = fget(map->fd);
> +       file = fget_raw(map->fd);
>         res = -EBADF;
>         if (!file)
>                 goto out;
>
> -       res = -EOPNOTSUPP;
> -       if (!file->f_op->read_iter || !file->f_op->write_iter)
> -               goto out_fput;
> -
>         backing_sb = file_inode(file)->i_sb;
> +       pr_info("%s: %x:%pD %i\n", __func__, backing_sb->s_dev, file, backing_sb->s_stack_depth);

That's a stray debug line that wasn't in there when I posted the patch
for review[1], but somehow made it into the pull...

Since this isn't a bug fix, it would be easiest to just drop the patch
from the stable queues.

But I'm okay with just dropping this stray line from the backport, or
waiting for an upstream fix which does that.

Thanks,
Miklos

[1] https://lore.kernel.org/all/20240913104703.1673180-1-mszeredi@redhat.com/

