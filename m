Return-Path: <stable+bounces-46269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660D38CF725
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 02:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930201C20C8B
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9F64D;
	Mon, 27 May 2024 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfQoHoU9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337F1C3D
	for <stable@vger.kernel.org>; Mon, 27 May 2024 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716771245; cv=none; b=uiNCA4tbyZGFPgSBDBDLYxVf6x6nQJC0gAlrbd8gI53wcI4rITg/DtTNNGoMFtjpAEMgUJBNzRQQKgmjXPOkpIw4+0lGnOJ51GOxL3SnEQBmGUx+ImdAGHXK1rCaEy2BUJtXIpN4bxQFl7VaDIslOKYVQrKvwFRa+3cV2I+spd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716771245; c=relaxed/simple;
	bh=RHwgtPwjVpxWztCWTJ0rLfzk2zeAE4qr4eqYpoZrx6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uOlBqyzxQypkcf7ft9MKpb0+gBaktQ/C9rijLgtCAQyNAMwfzeHV4q/G8J5UuJBPSC6StQV0WII00WBzD0SShyq++GawRfcFuQOafIkUNc7nk/a23KfI7RM+3246O98Qa7eZ+rqIczjDRS3uris/X6x4mtey+0suqZrQdCTyAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfQoHoU9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso8067987e87.3
        for <stable@vger.kernel.org>; Sun, 26 May 2024 17:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716771242; x=1717376042; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX73lvofI1rjCKK2P/066nRLSGUHTrc1zqCsieGMItI=;
        b=OfQoHoU979hE+4qPndW1oBS43N8UZkMpDss24TfdzYzLcVg4j2kli6t365sLbium1D
         ZOxdMw+x6AN1fwauCGqGDAcyZ3dKLL6JAXbwotdMCXjfFBdqQqZ9IBexLddxFnzRuaK9
         7+YT/9T1l31LYLTNTHIuhnKxt5h5yyc8MvHiVVtcvZ0BKXP+0PLKYN8jUbCUM+MUV7uy
         k4neEd1FOmAVLNYxJnxElmkKqsLAPYuoEG35+MiUO94dBkYRrdYL+zLmE+LNONpPm7zH
         KwgpR31ZWmfOy9q/BGC03KTXXRvy85O+V/rF1kPm4qeDfxXNbwRzQJOkQHELg1y8ZodJ
         a+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716771242; x=1717376042;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX73lvofI1rjCKK2P/066nRLSGUHTrc1zqCsieGMItI=;
        b=csOOY8Ge21Kxdh00rSLrMo3t818bdjmdiN2UCKsnvHLcSW+E6E7Fa6HHs1cEd6Togm
         QbCl74+mM1ebKehIywjWlyopjxCZFoGnEl0Epl6xqv2GPMYbb5w0hB7r+NX5hKhnsAx3
         lpefxmjGP0OYahM6rPVIpmkciruKQs/nYoS1M8Rm+rV9HAafUFsEVPQot4SXfTnoLjox
         pvFVc+LcLOHik6DuCgQlU6Td8DSsLiYnh5capBCclIFu0fQzycihDMIbJPZA4JMSnAR0
         2qCeGndfGA54iCYBZVcC6SZTDCCUGk97eektOjaypWA+s2cl267INS1G3tHIprI13Eve
         sdOA==
X-Gm-Message-State: AOJu0Yx6Q78AqSF9ARSDbxbIQwpp8Z/gAv7bJ9ASP5flg2ax5EtuJ847
	gH7OIbD8FiHrmDRmAcpXFMpYRX52IWC/8WDyI17q1yv5JdBsdxssxe+7NM4ZLO44QM7s8Px5QOi
	aUcRrM3uhay+0woBoGhAGnIcJM1ZaFttG
X-Google-Smtp-Source: AGHT+IGoqC8Y+YY3IpsFdPJk6PLWKLgJq6Frs5OJv9/C3Ubg2vxtIHDdvzYYExoaSSQ/IdjwVtFQoI5pigbDl7t2v0s=
X-Received: by 2002:a05:6512:402a:b0:523:8c79:147f with SMTP id
 2adb3069b0e04-52965199a45mr5731262e87.35.1716771241810; Sun, 26 May 2024
 17:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526172110.3470368-1-sashal@kernel.org>
In-Reply-To: <20240526172110.3470368-1-sashal@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 27 May 2024 09:53:45 +0900
Message-ID: <CAKFNMo=kyzbvfLrTv8JhuY=e7-fkjtpL3DvcQ1r+RUPPeC4S9A@mail.gmail.com>
Subject: Re: Patch "nilfs2: make superblock data array index computation
 sparse friendly" has been added to the 6.9-stable tree
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 2:21=E2=80=AFAM Sasha Levin wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     nilfs2: make superblock data array index computation sparse friendly
>
> to the 6.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      nilfs2-make-superblock-data-array-index-computation-.patch
> and it can be found in the queue-6.9 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 5017482ff3b29550015cce7f81279dc69aefd6fe
> Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Date:   Tue Apr 30 17:00:19 2024 +0900
>
>     nilfs2: make superblock data array index computation sparse friendly
>
>     [ Upstream commit 91d743a9c8299de1fc1b47428d8bb4c85face00f ]
>
>     Upon running sparse, "warning: dubious: x & !y" is output at an array
>     index calculation within nilfs_load_super_block().
>
>     The calculation is not wrong, but to eliminate the sparse warning, re=
place
>     it with an equivalent calculation.
>
>     Also, add a comment to make it easier to understand what the unintuit=
ive
>     array index calculation is doing and whether it's correct.
>
>     Link: https://lkml.kernel.org/r/20240430080019.4242-3-konishi.ryusuke=
@gmail.com
>     Fixes: e339ad31f599 ("nilfs2: introduce secondary super block")
>     Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>     Cc: Bart Van Assche <bvanassche@acm.org>
>     Cc: Jens Axboe <axboe@kernel.dk>
>     Cc: kernel test robot <lkp@intel.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
> index 2ae2c1bbf6d17..adbc6e87471ab 100644
> --- a/fs/nilfs2/the_nilfs.c
> +++ b/fs/nilfs2/the_nilfs.c
> @@ -592,7 +592,7 @@ static int nilfs_load_super_block(struct the_nilfs *n=
ilfs,
>         struct nilfs_super_block **sbp =3D nilfs->ns_sbp;
>         struct buffer_head **sbh =3D nilfs->ns_sbh;
>         u64 sb2off, devsize =3D bdev_nr_bytes(nilfs->ns_bdev);
> -       int valid[2], swp =3D 0;
> +       int valid[2], swp =3D 0, older;
>
>         if (devsize < NILFS_SEG_MIN_BLOCKS * NILFS_MIN_BLOCK_SIZE + 4096)=
 {
>                 nilfs_err(sb, "device size too small");
> @@ -648,9 +648,25 @@ static int nilfs_load_super_block(struct the_nilfs *=
nilfs,
>         if (swp)
>                 nilfs_swap_super_block(nilfs);
>
> +       /*
> +        * Calculate the array index of the older superblock data.
> +        * If one has been dropped, set index 0 pointing to the remaining=
 one,
> +        * otherwise set index 1 pointing to the old one (including if bo=
th
> +        * are the same).
> +        *
> +        *  Divided case             valid[0]  valid[1]  swp  ->  older
> +        *  -------------------------------------------------------------
> +        *  Both SBs are invalid        0         0       N/A (Error)
> +        *  SB1 is invalid              0         1       1         0
> +        *  SB2 is invalid              1         0       0         0
> +        *  SB2 is newer                1         1       1         0
> +        *  SB2 is older or the same    1         1       0         1
> +        */
> +       older =3D valid[1] ^ swp;
> +
>         nilfs->ns_sbwcount =3D 0;
>         nilfs->ns_sbwtime =3D le64_to_cpu(sbp[0]->s_wtime);
> -       nilfs->ns_prot_seq =3D le64_to_cpu(sbp[valid[1] & !swp]->s_last_s=
eq);
> +       nilfs->ns_prot_seq =3D le64_to_cpu(sbp[older]->s_last_seq);
>         *sbpp =3D sbp[0];
>         return 0;
>  }

This commit fixes the sparse warning output by build "make C=3D1" with
the sparse check, but does not fix any operational bugs.

Therefore, if fixing a harmless sparse warning does not meet the
requirements for backporting to stable trees (I assume it does),
please drop it as it is a false positive pickup.  Sorry if the
"Fixes:" tag is confusing.

The same goes for the same patch queued to other stable-trees.

Thanks,
Ryusuke Konishi

