Return-Path: <stable+bounces-144988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F23ABCBF4
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 02:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950688A1F99
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531F3253F22;
	Tue, 20 May 2025 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="PkZ2Asis"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C1253B7A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747700380; cv=none; b=ahdATirnNWD0AJxpZ8cxMTN8E+Fq8tokCv9oDLD8n4b5Ts1GynpxGKs1VylXnL8jtHD58WsOiX/tkcyFFLVrj+hLEWqqcrnGvFrzLWCYZhI49vjkx16qyGiqzx+OFRvnloJUqybG/VmHwdNZwn9W7w+nvtjfnC7b+RTKIryjTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747700380; c=relaxed/simple;
	bh=belPEUsapN25iOuGeQPjjn6j/5b2scul4VtAIDngE3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G70KGPbNhNd4q5fZFJVSKe3dY0Kk+SlBKIhCiVYBMg6bPXPA9MmHYwVOsSbIfBNhujs94HRsvamWN9Ci1oF5FuI/FXTTAXyOl1uj6wPyq+83vjXGhPmR2Zdf7T86rf4YqOuYAZGMc3ZXOspiGrj0cuFu1LwMMWDwf2nx7IN1zJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtx.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=PkZ2Asis; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dc6f653152so4557115ab.3
        for <stable@vger.kernel.org>; Mon, 19 May 2025 17:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1747700377; x=1748305177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgpucrCznlYo2tETUeAGdqWOxY183+jT5ofeOG3vpwg=;
        b=PkZ2AsisCjMrmGylETxNzaBnpwz76ACU4s6m5HSWz+mT2ezxzqBkLEfMLe+EfxYCFJ
         MzUVNg5nfiz4isoJqSITK5ZRuBHrxJIumwWLv1QNRpfJVQAfscVNclzbsyZprJ9GbQ4N
         fWc1wEwigral0wwN3qJj6OI0xQ032ULDxffCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747700377; x=1748305177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgpucrCznlYo2tETUeAGdqWOxY183+jT5ofeOG3vpwg=;
        b=wP/fY+s49HMkHeZARhZ2t02nePkGoqWg4YXM51R5T4HrJnL5558aM285TbMJcPrpIO
         szO4ZPgbLXq49qX8NSGZgxhdi5ubtSgSsqy9nkxv5c/HWMqa8s1/oxMq8Vo4a1xrkh19
         J6OnXVg/S5OpgWsMAXTxK/Qd7lHRawc3C5DXFxdXm0OhLx9Nhm3UNv7rqr5eu66zqzfM
         j9DXl0mdxXLbVGuNgvbHHUCbaJEdc8PJrJcko5WMb5Nl+vlukkTpFpxs0g/N2wfKzw6O
         ZPrOdqc7hhIVq2Twq/gJUQjyyJkVFyjlx/1hldIS2Zz2jhBDNF87MZK/7qT4obGwtiSg
         i6Tw==
X-Gm-Message-State: AOJu0YwLY8MM6s6iDM50ktEd+hlmiiT4K2itQK9TgGOCKcXeE/WXvTa5
	nE1mbAzZLvUpV8smdLLSWGoWorVXVm0h7pfmpleiw5Nn1kADBKE9a6T879HNatme73bPQsE1H1O
	OIpVcW3N9cgz+VA6jTG2AAYZJWzPLa1uSg+EKBYap
X-Gm-Gg: ASbGncuDh0WzgOqcVRrJoZVrJVNfKD5k8GaW+Cq2+QZ6qW0I/7Q2ZLfsM6gg0ggtke3
	PJTw76Aq/84auVnHvoO1a/w0Wu2ba58ShfgfBpShHFgHiqpLV25X/XdDn9fioivXhACW5B0X8qL
	lReyO+jQPxN5+xO1z59nFDuWsajkRpi1E=
X-Google-Smtp-Source: AGHT+IHRjyvh72/+rxY5m65O5F9xKeCVC+PVBi5dxaOltw8gZBkjSmgbOOnICfVNFOXL4flqaNTHun2ihSNOL+Chwts=
X-Received: by 2002:a05:6e02:a:b0:3db:6cc1:36f9 with SMTP id
 e9e14a558f8ab-3db842ec6b8mr183077255ab.8.1747700376902; Mon, 19 May 2025
 17:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172044.326436266@linuxfoundation.org> <20250512172050.980575013@linuxfoundation.org>
In-Reply-To: <20250512172050.980575013@linuxfoundation.org>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 19 May 2025 18:19:26 -0600
X-Gm-Features: AX0GCFtig-XrQhwkDivLDGH5fqpb7b2HNo1DDX6Sn1rPgLk1vIGe4bFyrdfmYvA
Message-ID: <CAFxkdAq+5ur__TPi6ZW9uoOBv037hgn1d_9906cBeXWE=X3Sgw@mail.gmail.com>
Subject: Re: [PATCH 6.14 162/197] loop: Add sanity check for read/write_iter
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com, 
	Lizhi Xu <lizhi.xu@windriver.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:51=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.14-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Lizhi Xu <lizhi.xu@windriver.com>
>
> [ Upstream commit f5c84eff634ba003326aa034c414e2a9dcb7c6a7 ]
>
> Some file systems do not support read_iter/write_iter, such as selinuxfs
> in this issue.
> So before calling them, first confirm that the interface is supported and
> then call it.
>
> It is releavant in that vfs_iter_read/write have the check, and removal
> of their used caused szybot to be able to hit this issue.
>
> Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffere=
d I/O")
> Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6af973a3b8dfd2faefdc
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20250428143626.3318717-1-lizhi.xu@windriv=
er.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/block/loop.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

We have had an issue failing to set up loop devices with CI and Linus'
tree since rc6, and once this patch hit stable it proved to be the
culprit.  If I revert this patch, things work as they should. The
problem we are seeing is "

More information can be found in:
https://github.com/coreos/fedora-coreos-tracker/issues/1948
and
https://openqa.fedoraproject.org/tests/3438220#step/_boot_to_anaconda/5

Justin

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 61ce7ccde3445..b378d2aa49f06 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -504,6 +504,17 @@ static void loop_assign_backing_file(struct loop_dev=
ice *lo, struct file *file)
>                         lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
>  }
>
> +static int loop_check_backing_file(struct file *file)
> +{
> +       if (!file->f_op->read_iter)
> +               return -EINVAL;
> +
> +       if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  /*
>   * loop_change_fd switched the backing store of a loopback device to
>   * a new file. This is useful for operating system installers to free up
> @@ -525,6 +536,10 @@ static int loop_change_fd(struct loop_device *lo, st=
ruct block_device *bdev,
>         if (!file)
>                 return -EBADF;
>
> +       error =3D loop_check_backing_file(file);
> +       if (error)
> +               return error;
> +
>         /* suppress uevents while reconfiguring the device */
>         dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
>
> @@ -956,6 +971,14 @@ static int loop_configure(struct loop_device *lo, bl=
k_mode_t mode,
>
>         if (!file)
>                 return -EBADF;
> +
> +       if ((mode & BLK_OPEN_WRITE) && !file->f_op->write_iter)
> +               return -EINVAL;
> +
> +       error =3D loop_check_backing_file(file);
> +       if (error)
> +               return error;
> +
>         is_loop =3D is_loop_device(file);
>
>         /* This is safe, since we have a reference from open(). */
> --
> 2.39.5
>
>
>
>

