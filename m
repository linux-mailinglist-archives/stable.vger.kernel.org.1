Return-Path: <stable+bounces-47870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CDF8D83C0
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 15:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9362810AB
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06612C484;
	Mon,  3 Jun 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqrg26Hd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACE12C491
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420834; cv=none; b=pcnoFIrF1TxZW7aepfuXwnhrDR9xPvoPug1Hzlab84Z30JYVTCgYon/paXD8DyfID83KVJa34YnCJMpQ49l574Yw1ssghwP6RHsK9m8LyGp7F+kL28c3C0keZEg7ziEVYmCVxelfMyDHfFAUTtZVAk4dY1yKaXDncSRzMLmCXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420834; c=relaxed/simple;
	bh=FTgqDe7aLb0YN8IKsPrCKcBlNd6z5Mp56gI1aahHaOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=O5ScgSIfx4ChBp+Wnc98n58/1SDDmnU7RGgWDqiu/Allns8S+SZk7zTal0Un8LTy1jOPd6r9k3+OhaMm3uColfC3Fs5+Hix8+aPQLicRZpKOgSpefjHRocpMt/PhItb8Zxue9EK1t8XMRPDI/2/P6NpUwheskLzA01AuuMHzTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqrg26Hd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b912198f1so2882062e87.0
        for <stable@vger.kernel.org>; Mon, 03 Jun 2024 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717420831; x=1718025631; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BJxgRktH9dFQiyyR1WiXSMwV3doqFnzYh9e/7jI3hc=;
        b=Cqrg26Hdxv2QmeSbbf6u54J9Zvs+BUkQ/xN/uuElcO2XrMLEMZjA+/IYv8YJ7yNwT6
         DLBc7YGAPOBqGIHy5GoRw5Xq8tsYyvTQYlcWgwSaYCTFaG2qa6/Etb3Gs+zYSzdRWfOc
         BcUKN66P3GqGYyeGfoqvmh9izhHbJ5zV8HIBGaFpO27ICBqwqtXyIwQpoFEvrAxe1Yj8
         0lEw2uJJnxn05r+3z16ev2ywNMD8BIjrdHlO9c9BRsaAdq03BVLuydtHJaSrDwDr5daJ
         0ursW/3Ob8/dlG+b9QnOrvwbOYHtwEb+CkETNSiVzo2lBPKvDw4mmb3/LvGiakda8RWi
         oL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717420831; x=1718025631;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BJxgRktH9dFQiyyR1WiXSMwV3doqFnzYh9e/7jI3hc=;
        b=MNtwiIkeCUTvKG00htTagxqz/76N7hFkDho+HMEEUQLnth4bdyTjuHL9Dn5KWqvYcM
         CsdI8PWGk3/B7M+4hHpq4oSXEWQgWNspzRHHeDjlKF0Irg4zhUOFubyw9fAIRxA0X2rT
         vwQxTbqcaOykOlW+6HXDbBLJ4RdmeGHPozXJT6lYSzOdkH2FRTnwgJ1xtP+1le6NKFAj
         ZprlI1ccM57IDPdORthLxPDMonNQpPQ80yPV4Wj3Wjb3wLn0xjdNxTq042kYjRihgIr0
         vWQOwTQm43vUr6gKwofOa89LGVgCBkvLYLnkUKtLc6sVbGPZO/vWqOVn7hfuoFOIczwU
         Haig==
X-Gm-Message-State: AOJu0Yw/uTqdkTN8QaCu/K8MYj9yxd5zJNP2kTlvHpaJ/AYf8VZtpLv6
	aTBUNcdGmaX7+H/f0Nl9nP2az9jusJmHwzlZdkGz8OvADGuXs5Q2KRESpeMKMepwdU7JugmuC/b
	73V7gWA3OZQ3K7is/tgFB6godVuSabQ==
X-Google-Smtp-Source: AGHT+IFDd3j4oj0THuo+6FsTc8qtbabf2x9RIDhWtrWJNYV7iom3RXo32yMo6SnM6CoR36WfU1hU9MRIqSlZC1ieZnQ=
X-Received: by 2002:a05:6512:3299:b0:52b:8c88:2d6e with SMTP id
 2adb3069b0e04-52b8c882e71mr5617577e87.42.1717420830449; Mon, 03 Jun 2024
 06:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603121142.1838281-1-sashal@kernel.org>
In-Reply-To: <20240603121142.1838281-1-sashal@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 3 Jun 2024 22:20:14 +0900
Message-ID: <CAKFNMontZ54JxOyK0_xy8P_SfpE0swgq9wiPUErnZ-yrO7wOJA@mail.gmail.com>
Subject: Re: Patch "nilfs2: make superblock data array index computation
 sparse friendly" has been added to the 6.1-stable tree
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

A week ago, I notified the stable mailing list that this patch is not
a bug fix that should be backported, and Greg removed it from the
backport queue to the stable trees.

[1] https://lkml.kernel.org/r/CAKFNMo=3DkyzbvfLrTv8JhuY=3De7-fkjtpL3DvcQ1r+=
RUPPeC4S9A@mail.gmail.com

On Tue, May 28, 2024 at 3:28=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
> > This commit fixes the sparse warning output by build "make C=3D1" with
> > the sparse check, but does not fix any operational bugs.
> >
> > Therefore, if fixing a harmless sparse warning does not meet the
> > requirements for backporting to stable trees (I assume it does),
> > please drop it as it is a false positive pickup.  Sorry if the
> > "Fixes:" tag is confusing.
> >
> > The same goes for the same patch queued to other stable-trees.
>
> Now dropped, thanks!
>
> greg k-h

So I think this is just a case where the "Fixes" tag was mechanically
detected and mistakenly picked up again.
Could you please confirm?

Regards,
Ryusuke Konishi


On Mon, Jun 3, 2024 at 9:11=E2=80=AFPM Sasha Levin wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     nilfs2: make superblock data array index computation sparse friendly
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      nilfs2-make-superblock-data-array-index-computation-.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 358bc3e8f5a5e2c51fc07aadb70e25fa206e764b
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
> index 71400496ed365..3e3c1d32da180 100644
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

