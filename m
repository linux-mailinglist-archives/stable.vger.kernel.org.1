Return-Path: <stable+bounces-23190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F585E109
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5492E1C21DF6
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4717F7FD;
	Wed, 21 Feb 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi9iTckN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72D69D05
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529172; cv=none; b=Gwg9LuLHFzj8lI0P9Tn3+FZVGevizrael57L+ZPOT8yiV2LsBntMyB2Tvjr7GUawaHkI7UNVH/3jbpwyvNk2F5+mnqDMRjHiAFRNwY77Zi6hX9/YU6DeI79l93IfHlSjg72Ynlyoa0h0G0SpfqYlvRVkVi/1OtbchYoMfMmlbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529172; c=relaxed/simple;
	bh=cci5BOGZK3Spt55yQ2qdW1t58lXnRhMvgGTY0oAAFq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRP4HUuWkmnisVZWnX+AYVaS+NeTTwOOpNq3S8+/VQfwH8Nf4/EYW8KUTM+JUdfIogJREmHtg5gU3pMZO8RAmgYM80t54iJf18XEfBUym4qow5y+x9PJ6EbAgF2DBzVl3PNqgVlYLcjqWkc4z1OS/66rNCQv7DX6+WcDpmYUOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi9iTckN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so1019231e87.0
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708529168; x=1709133968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7CFRwEaj5O3n1vig9mmc40S2b7I6iaaWbSwi8GiOwQ=;
        b=gi9iTckNSt96N28N+n6zvBHLEIpK68lVodmPGWwFhWv2VeeJk5qdnt4j0A0Kt6vbbF
         P5lNTH7hiqztOVVG+Q0WFkRmgoVLvIxjcbS9muYrg/s8pcwpHzOw6AshIwMdWe9Y9RIT
         nD+JSC4iSRfBOiXgeW0nbg34NW2zl8jLAfJdbaCYEv8833DXaTrDjk2RZ26d47jtbP7u
         Oh7MxP5QN9V2h2XpatYD+9QaUHzF06FmvkBEdE8aO4zselcjn0dAUjXcVn1t30SqVqJe
         /705GC931RKp5KVSFq7O6tc2Dc8rMAT86Xnz79GS+V3NvUfDTedu+O8KL/s05WJ0MGmY
         Yh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529168; x=1709133968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7CFRwEaj5O3n1vig9mmc40S2b7I6iaaWbSwi8GiOwQ=;
        b=eq7qcj0Vf62bKymadkMb2NsZ1uwrgcobOY54/XOJ8jA8IRQov3xRThc4f/nNPbM+7P
         ceRIn9SbdV0P6GtKvMwA/H0BiEhq43NhjFct0D1jgLAIsG/CW/0SILbZehLBnqxFhjmG
         rGwYqKSXhIMqjLz6cRS1btSTFt6dQySzBvn2jj+H7HKUfrrv6otNUBxIqpLX6R/Apcm4
         tGhl9FFyQxCLMjqTcjPTxZPwzW8MyQa2CAdI+o3DeKXpdZejG25uEnT2tRLIITwx/IyY
         Laz/mCBA+PWCjEn6rVLCGZnSioABRniP40UdItwpAPjkwgHbrGPNbokqEZyb/XzhWkpI
         904A==
X-Gm-Message-State: AOJu0YwMI+N6+aQqmH64gs+pme5SnE7YspqXfcMfGHx2yph1PTKIKTRu
	xiU/Xb4CR6nVQJaAQDEexh7AHMHj2te6T9+Qz1ybSbn7/anMgnHa5F+BXUspT5GCuRMGxBdjR8V
	RzvID+bHcMaUbyeh3DhgUkIu2hzA=
X-Google-Smtp-Source: AGHT+IHKXAczEIV6dUiAdkT+Wz92ctah8iGk2CHccvb9gcB8i8NaBhlm16ApdXAmheuRwLyy/wxvNaN3pXDa62LWkqE=
X-Received: by 2002:a05:6512:6ce:b0:512:cc76:4dab with SMTP id
 u14-20020a05651206ce00b00512cc764dabmr3308659lff.29.1708529167899; Wed, 21
 Feb 2024 07:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125940.058369148@linuxfoundation.org> <20240221125948.348622258@linuxfoundation.org>
In-Reply-To: <20240221125948.348622258@linuxfoundation.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 22 Feb 2024 00:25:51 +0900
Message-ID: <CAKFNMonCSHt1ziZo=UcUvRSRfoARYUT+YycnoF2jQx78XENOyA@mail.gmail.com>
Subject: Re: [PATCH 5.4 258/267] nilfs2: replace WARN_ONs for invalid DAT
 metadata block requests
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:30=E2=80=AFPM Greg Kroah-Hartman wrote:
>
> 5.4-stable review patch.  If anyone has any objections, please let me kno=
w.
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

Please drop this patch for 5.4 as well as the patch for 4.19.
(same reason as the review comment for the 4.19 patch)

I will send an equivalent replacement patch.

Thanks,
Ryusuke Konishi

