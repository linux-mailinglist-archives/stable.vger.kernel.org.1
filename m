Return-Path: <stable+bounces-179621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D03B57C30
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 15:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2482E7A9992
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FEB2E9EB9;
	Mon, 15 Sep 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTOIrfAO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B36B2FF148
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941288; cv=none; b=IoI23jbvWQOtNf9PBSZYd7lvdgqxMX22415bsORT9dWTdMEpVTL4u4ucvGn5FM1CmmWWyNZHV+iCpwCoS38jlxGKs9TKGsQkyFOA9BfNVGzzs9ObVX85Deb42X39OogLSlYEcF3suF9u0582sn32O25jNkKf3xqo1WoFzoFEPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941288; c=relaxed/simple;
	bh=Ezck4rxHmKWprPtVv6zuENk42dYeOqTjH8/o6r/ii4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mcx8M6HAa3LZsgNnMn0aqztp0nYASDLewksTOsH+749GkdZMIniliwmNeA+y1KgLUzdS4d6MOmt0qWHBBqCq1Fo8AFEXLFxwfGWR2U4q39tx2YhSsSUQHUwD5IQg6inECen5+PwUJTlTIg2HUT0HQGD9bq8sz2ZUunTV6EyT0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTOIrfAO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0aaa7ea90fso50019566b.1
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941284; x=1758546084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45EkO46Qi4HHLwvj2lt+pH5doVvI2GU4+2jW47Bc4qI=;
        b=JTOIrfAOOE5kGV849J2cav3nPNeYiAtEddxNMQ0BsIUqUFc7DTTeC8r2j3369n0mJr
         0ZO1yYJOjNi4/bCSRa/BoI12aiT3mzsz/MHqbbvBmXZj/6+gmGs79hLtQIDyU73GPHUS
         PtSXnO8jgRFnxpfP84HaCU4t780goZhwxCqNlq3m9hNRFSsABg+zfUr7ZiKbOeKu/f0o
         uYh91dXUY+P7PrijOs9x666JxKGWPD2yralG9rHZLE8uzjRpLnTKZ1JSUj0R3KPhuksn
         P8kFccLw+O/mj9rJAQZ08wLJg7YzpFAYR2EwtlGbfOcCMI1I4XexQHXIJEmb9VUWhefD
         y7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941284; x=1758546084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45EkO46Qi4HHLwvj2lt+pH5doVvI2GU4+2jW47Bc4qI=;
        b=KgOkURzbv1I8b/19aHVKwd6jixhyZS6W4FD78CNMjnDHb/9NHpxCE8o5s3o9UiCqsw
         rW05Wi0MtziC0NJLD4zY+OsUKOdhyhHArgpXZj4bEYWZAs5gfUHpWZQL0/4QSF8Anc12
         BISM998SGjpfNpOOdcT+6uUrfabaTbbeIkUmKrkhrGgmhMIfO2UuNGy0VrdU4ICqIVBY
         i1grMqnZkTEhSqJZO5W/QyUvNt3RrUch6AvZarUPyIGyzcPSO6A6lX/IX15wysT/eh9o
         iTeso7Xnn5csbex3kvEzHfAIkjSd8EdbMzRTbJm6MGFhUfPwhuYDsPIv53sJW4OUdb7T
         h66g==
X-Forwarded-Encrypted: i=1; AJvYcCX8UuhRogv+az+BVDHcf7YLqPZkvs9ceBv9tgiXDASRtWJDcAcnA0Q6AOFTavioWVEuZE7mmQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hGl9MUrUxIF3JKKvgHfj6n3WOPoVCSpD5TWt57lUHj+Quc2R
	MaNw3TVK3M6cegZaKa0kBmoqVMYGQ+MyZ9TswR57uArk0/aaPGsvKDV+QkBN22DLiT2hAVQNPc1
	bWwRhllrm27xAdyzYP0l/nzcyoDFZLuM=
X-Gm-Gg: ASbGncuCYUN+AIxGjGDcE1/zhq9B7Qgy6YwZzGgA+SG4lfLkaPL9tArqKpBtvLvS0E8
	vxnwix3Jmqlq1Mdv52IbZz7HgpucReVHen5dRhcftOEOIUXo5h7irg6JSPiUF9QytxtdK4e1URY
	PieOqeHUh8cVPx5r4vSsHFT6Gmya0nvBKrjtkZz4lF/f+4qccu0x66wgZu7A1xnyPtxNDmpr0Sy
	2iYwhLzXL2WT1/D52xF5wMtru0vfAlEboayhYAS2Q==
X-Google-Smtp-Source: AGHT+IE0pshEQPchml3qLxCQRHDuqtH5L0cKDhGMqDazan4WSLspsvjhpC/hBVR8LmkWJPiNu+ARl65uKQLFDi+LdeQ=
X-Received: by 2002:a17:907:3e1e:b0:afe:9777:ed0e with SMTP id
 a640c23a62f3a-b07c3356e47mr1254804766b.0.1757941284123; Mon, 15 Sep 2025
 06:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915101510.7994-1-acsjakub@amazon.de>
In-Reply-To: <20250915101510.7994-1-acsjakub@amazon.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Sep 2025 15:01:13 +0200
X-Gm-Features: Ac12FXzOnPQ5wHS4xu7aVNWoFlUIY1GgVl-UQpmig0p0kiDTzt7kJQ5EB_XHWw8
Message-ID: <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
To: Jakub Acs <acsjakub@amazon.de>, Jan Kara <jack@suse.cz>
Cc: linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 12:15=E2=80=AFPM Jakub Acs <acsjakub@amazon.de> wro=
te:
>
> Calling intotify_show_fdinfo() on fd watching an overlayfs inode, while
> the overlayfs is being unmounted, can lead to dereferencing NULL ptr.
>
> This issue was found by syzkaller.
>
> Race Condition Diagram:
>
> Thread 1                           Thread 2
> --------                           --------
>
> generic_shutdown_super()
>  shrink_dcache_for_umount
>   sb->s_root =3D NULL
>
>                     |
>                     |             vfs_read()
>                     |              inotify_fdinfo()
>                     |               * inode get from mark *
>                     |               show_mark_fhandle(m, inode)
>                     |                exportfs_encode_fid(inode, ..)
>                     |                 ovl_encode_fh(inode, ..)
>                     |                  ovl_check_encode_origin(inode)
>                     |                   * deref i_sb->s_root *
>                     |
>                     |
>                     v
>  fsnotify_sb_delete(sb)
>
> Which then leads to:
>
> [   32.133461] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc0000000006: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   32.134438] KASAN: null-ptr-deref in range [0x0000000000000030-0x00000=
00000000037]
> [   32.135032] CPU: 1 UID: 0 PID: 4468 Comm: systemd-coredum Not tainted =
6.17.0-rc6 #22 PREEMPT(none)
>
> <snip registers, unreliable trace>
>
> [   32.143353] Call Trace:
> [   32.143732]  ovl_encode_fh+0xd5/0x170
> [   32.144031]  exportfs_encode_inode_fh+0x12f/0x300
> [   32.144425]  show_mark_fhandle+0xbe/0x1f0
> [   32.145805]  inotify_fdinfo+0x226/0x2d0
> [   32.146442]  inotify_show_fdinfo+0x1c5/0x350
> [   32.147168]  seq_show+0x530/0x6f0
> [   32.147449]  seq_read_iter+0x503/0x12a0
> [   32.148419]  seq_read+0x31f/0x410
> [   32.150714]  vfs_read+0x1f0/0x9e0
> [   32.152297]  ksys_read+0x125/0x240
>
> IOW ovl_check_encode_origin derefs inode->i_sb->s_root, after it was set
> to NULL in the unmount path.
>
> Minimize the window of opportunity by adding explicit check.
>
> Fixes: c45beebfde34 ("ovl: support encoding fid from inode with no alias"=
)
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>
> I'm happy to take suggestions for a better fix - I looked at taking
> s_umount for reading, but it wasn't clear to me for how long would the
> fdinfo path need to hold it. Hence the most primitive suggestion in this
> v1.
>
> I'm also not sure if ENOENT or EBUSY is better?.. or even something else?
>
>  fs/overlayfs/export.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb1567..424c73188e06 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -195,6 +195,8 @@ static int ovl_check_encode_origin(struct inode *inod=
e)
>         if (!ovl_inode_lower(inode))
>                 return 0;
>
> +       if (!inode->i_sb->s_root)
> +               return -ENOENT;

For a filesystem method to have to check that its own root is still alive s=
ounds
like the wrong way to me.
That's one of the things that should be taken for granted by fs code.

I don't think this is an overlayfs specific issue, because other fs would b=
e
happy if encode_fh() would be called with NULL sb->s_root.

Jan,

Can we change the order of generic_shutdown_super() so that
fsnotify_sb_delete(sb) is called before setting s_root to NULL?

Or is there a better solution for this race?

Thanks,
Amir.

