Return-Path: <stable+bounces-23189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8635185E0C3
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156E01F23C68
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0C80036;
	Wed, 21 Feb 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCZ17FAs"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F687BB01
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528633; cv=none; b=jI3zhwIjqqRR1jnO5+lo58pZPxOMksE+P5to5zXUDX6Jvng0gN3H9Hj/wUmJAW+L7zd5FEujt85NYe/zG2fvtW5reSs8PFYkB13bnrNfLHy5c7XUnSiKZLWXC1a0/avULjyv+vcfrLG591dfBlAhWCrgwJQ0NYBp9jAE2JTxJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528633; c=relaxed/simple;
	bh=nGTqTtzt2sUbREhVbQv0j4QAW9PmN/RDVodP5ym54x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGudleh8ejDmDehLH3ei4wqhojW8bgMHjpyulUUd7FdEdgCC5kqvdxp0fBMqHHVnTNw/rhTF0L5XeR8grwYZIYWi6pwUMGE6l5gtN6DqTNeGukhhYsMIHtNRXKRhPM7MCLHw5Uyz4zCSFBtK9UvLhaPiaebikfK6j+/sU8dgULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCZ17FAs; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso8091001fa.3
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708528630; x=1709133430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXiICswg4YzXiw6dk2Mwt7frOWpPnP2GHTGVPqL0gDM=;
        b=UCZ17FAsK8+9jZuSQ0b07sg9RILaz1dFx8iFjYhAXJTE5AECHLr9QJI6PF/i72dI6w
         RmKed6iYD8Sx4qBACnIYsC35Fx93/FqI2U1ytOFApjynGCbt+HMlRW1NKJbN3lQpe+JX
         DkM4cfKtnFAV2pymD8gJhm8IzY66Ot+y4tWitJqbeY3upiVZdR0lD6rdT7ccUB/YTFRq
         y49m1X93Cms06niL9IOcdFFBacXo8wnedsRQUePoWIapL+gIx+uphB4jVfhNbaZ9Eosf
         U6uFEKfyvpG0rlizqp77NlMcfNPnwqGPDl6/2OZhzMYqEQyhXNlz4NrreqQHvT4afPnj
         lpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528630; x=1709133430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXiICswg4YzXiw6dk2Mwt7frOWpPnP2GHTGVPqL0gDM=;
        b=K2aKby8EPrr2MxH1jyKiYp4fSnOrpjpPA2z2VHRteAnxIBytZB4xULlpMGJ9xpqPTy
         fLmWYMe8EtTP1nn0qa4cvRdM3J6aEtuOlATldugI+ksrcaMb6RhutBMKLb9lcWJiFAME
         0jXJ6VkxW4PMadbZWpVnUzgSZGc28RcCEPOl9gbt5DWh+mlPvbt1PW5UC09Us3fEM1KW
         v1dCUH9zyC7QMs/ee5tEmVGe+tZ/9h62xdJhY4E/Ix8Rg5OxYX0ST6lDi6nwRwgXkJbf
         T+8CE4JXAEPAlUBkWNHnOM7iuFydFipFXXKk0VZQhGg2eBORgD79ldXDmuAZluRKIXnJ
         UAdA==
X-Gm-Message-State: AOJu0Yyw2BkWPfgdbDQW3zjBja/8zKZdKnAB9B3kAIwJBjyxgCpE+4EF
	T4L5WYFrMlwNfh5uA8gh824Gm0rJ6RUQrT6MM6nXvApTImeF2nUI4IrPY/oiWVRiE3eDg4O8gfb
	FLOI/cNn8oIpTlXE9t1zS9tB+cFE=
X-Google-Smtp-Source: AGHT+IHIynpkHqXe8avSjnJLeB5fSyluG656zsi359TGvdRHvZvNP0y0mooqtI6wTgWvZpDaDR39gmrlO8fgWUle50s=
X-Received: by 2002:a2e:8303:0:b0:2d0:97ac:69fa with SMTP id
 a3-20020a2e8303000000b002d097ac69famr11232242ljh.25.1708528629754; Wed, 21
 Feb 2024 07:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125931.742034354@linuxfoundation.org> <20240221125938.249496188@linuxfoundation.org>
In-Reply-To: <20240221125938.249496188@linuxfoundation.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 22 Feb 2024 00:16:53 +0900
Message-ID: <CAKFNMo=7OYs+_GWPqytySpnvRiY1LjFUV80ppE7WxSBzEjN9tg@mail.gmail.com>
Subject: Re: [PATCH 4.19 200/202] nilfs2: replace WARN_ONs for invalid DAT
 metadata block requests
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:23=E2=80=AFPM Greg Kroah-Hartman wrote:
>
> 4.19-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>
> commit 5124a0a549857c4b87173280e192eea24dea72ad upstream.
>
> If DAT metadata file block access fails due to corruption of the DAT file
> or abnormal virtual block numbers held by b-trees or inodes, a kernel
> warning is generated.
>
> This replaces the WARN_ONs by error output, so that a kernel, booted with
> panic_on_warn, does not panic.  This patch also replaces the detected
> return code -ENOENT with another internal code -EINVAL to notify the bmap
> layer of metadata corruption.  When the bmap layer sees -EINVAL, it
> handles the abnormal situation with nilfs_bmap_convert_error() and finall=
y
> returns code -EIO as it should.
>
> Link: https://lkml.kernel.org/r/0000000000005cc3d205ea23ddcf@google.com
> Link: https://lkml.kernel.org/r/20230126164114.6911-1-konishi.ryusuke@gma=
il.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: <syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com>
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/nilfs2/dat.c |   27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> --- a/fs/nilfs2/dat.c
> +++ b/fs/nilfs2/dat.c
> @@ -40,8 +40,21 @@ static inline struct nilfs_dat_info *NIL
>  static int nilfs_dat_prepare_entry(struct inode *dat,
>                                    struct nilfs_palloc_req *req, int crea=
te)
>  {
> -       return nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
> -                                           create, &req->pr_entry_bh);
> +       int ret;
> +
> +       ret =3D nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
> +                                          create, &req->pr_entry_bh);
> +       if (unlikely(ret =3D=3D -ENOENT)) {
> +               nilfs_error(dat->i_sb,
> +                         "DAT doesn't have a block to manage vblocknr =
=3D %llu",
> +                         (unsigned long long)req->pr_entry_nr);
> +               /*
> +                * Return internal code -EINVAL to notify bmap layer of
> +                * metadata corruption.
> +                */
> +               ret =3D -EINVAL;
> +       }
> +       return ret;
>  }
>
>  static void nilfs_dat_commit_entry(struct inode *dat,
> @@ -123,11 +136,7 @@ static void nilfs_dat_commit_free(struct
>
>  int nilfs_dat_prepare_start(struct inode *dat, struct nilfs_palloc_req *=
req)
>  {
> -       int ret;
> -
> -       ret =3D nilfs_dat_prepare_entry(dat, req, 0);
> -       WARN_ON(ret =3D=3D -ENOENT);
> -       return ret;
> +       return nilfs_dat_prepare_entry(dat, req, 0);
>  }
>
>  void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *=
req,
> @@ -154,10 +163,8 @@ int nilfs_dat_prepare_end(struct inode *
>         int ret;
>
>         ret =3D nilfs_dat_prepare_entry(dat, req, 0);
> -       if (ret < 0) {
> -               WARN_ON(ret =3D=3D -ENOENT);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         kaddr =3D kmap_atomic(req->pr_entry_bh->b_page);
>         entry =3D nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
>
>

Hi Greg,

Could you please drop this patch for 4.19?

This uses nilfs_error() instead of nilfs_err(), but they are different
functions.
I will separately send an equivalent replacement patch for 4.19 (and 5.4).

Ryusuke Konishi

