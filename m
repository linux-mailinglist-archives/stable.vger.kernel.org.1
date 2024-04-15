Return-Path: <stable+bounces-39521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822328A5277
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386532828E1
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD173163;
	Mon, 15 Apr 2024 13:59:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048D33080
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189547; cv=none; b=jIa6Z2Xo1MHtpc+pWO4wA9rl+Lml8c+W/JfM1SEXH7TuKua6VEvFRiIaQKUzU27oFvDxn5WXvRAVr0ylsSJotmBdcIE42PkfPY8+66mJ/7a/5jmyC9PSCsCOU/3Ziv35YFf4fVlIRkZle9iWQZNGQhHCNsaqmEY7O+uIKIYda3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189547; c=relaxed/simple;
	bh=msxDw/jM3tTqiHBgIQH+095sy6PXL3tyk7y7JSGaImo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB84X0BTnhtB0ttn1AADY11uLgigRYq/TbA/vGTgwz3+a+T/xBeXAKlJEn+7KC1dWUniGCXFu52o3cCavSMxhz2mt8g73mEhbT7L7aH56iQBkH8TPwm/VhECvlRPbUcIWn52HBC/x/yGW2f14e8q8zVMTi7s4ZiiSGSKwAvjYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61ae6c615aaso2240327b3.0
        for <stable@vger.kernel.org>; Mon, 15 Apr 2024 06:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189543; x=1713794343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFXQCQPhsWVZ4ieH41FFbuYTo1u/hSsGzoM8VJRyz5A=;
        b=EW9Q80uNP43pCVwxh0nlPHInVt3wKtMx02Hb36hW1PgzVomtlt7kcji8s7Fw2kDMUn
         5yszI5b7rDbaEbmMNS1+cIQkzGBCyfpolCCTuQbIgSapPxpR7v3k0GgDFWCo1b1ggxtg
         1IOTwCq/CM95A28xQPaBDfHS9RQpH0gxmymUusKk0VnauWgmoZIQ0TpGxd/qR/z3IODa
         wUqn+cjKbi5e0maWVoCPKsMLOmRug5VOjuk6N8Ohn/yBxo0AYFo+/J6NhX5olI3Xj9U6
         mxbd06ovzfNG+wEP41vE0YU1KuCxzKzs/WZcPSokMa/Wr2hYGF10C2zmMMDj/LlX7n54
         wGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl04LnaWeyHy6X1aRid6aVrWIZz/cW6mbf9goxB+yn5qoHgxL9/juraATVM62gGgxClAobevTJ+FxyavdPKXJ9uogY/Dht
X-Gm-Message-State: AOJu0Ywm+TU+wP+ptMFOjQ1ruLS0YHBT1r1I8HXPruQhqnDHtD7xyqUZ
	WyBDQCrw2XWdQ2vf1jjI3eRuMr0DAb4a36lXXHLjeZRR+d0dj7TEZm9TncxE
X-Google-Smtp-Source: AGHT+IHPt74aY3lPrLr59YKLxrd8EqF4FGJucHJALaBWVtJIAjGfDOCcygB+lykcp69Fm5O+5w2VBw==
X-Received: by 2002:a0d:d5d6:0:b0:614:c76:26f1 with SMTP id x205-20020a0dd5d6000000b006140c7626f1mr9983102ywd.21.1713189543231;
        Mon, 15 Apr 2024 06:59:03 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id k25-20020a81ac19000000b0061ae278ca68sm125522ywh.12.2024.04.15.06.59.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 06:59:02 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso3500083276.1
        for <stable@vger.kernel.org>; Mon, 15 Apr 2024 06:59:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5Emh9NVY0p5nER7XTualm4+QoJ+I9E+Xi3SRXYKLTgKrbsYd9bHnfyjv8yDOWN6xEkn8OywuXXPs1BT+QL3jrMzCa8XQP
X-Received: by 2002:a25:848d:0:b0:dc2:4397:6ad3 with SMTP id
 v13-20020a25848d000000b00dc243976ad3mr10984105ybk.44.1713189542607; Mon, 15
 Apr 2024 06:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415105208.3137874-1-sashal@kernel.org> <20240415105208.3137874-10-sashal@kernel.org>
In-Reply-To: <20240415105208.3137874-10-sashal@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Apr 2024 15:58:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWig6tRnafHkYCiRvCZ49W4PyWah+QAnD79S=Sj62Y9_Q@mail.gmail.com>
Message-ID: <CAMuHMdWig6tRnafHkYCiRvCZ49W4PyWah+QAnD79S=Sj62Y9_Q@mail.gmail.com>
Subject: Re: [PATCH 4.14-openela 009/190] block: fix signed int overflow in
 Amiga partition support
To: Sasha Levin <sashal@kernel.org>
Cc: kernel-lts@openela.org, Michael Schmitz <schmitzmic@gmail.com>, 
	Martin Steigerwald <Martin@lichtvoll.de>, stable@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:38=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
> From: Michael Schmitz <schmitzmic@gmail.com>
>
> [ Upstream commit fc3d092c6bb48d5865fec15ed5b333c12f36288c ]
>
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
>
> Use sector_t as type for sector address and size to allow using disks
> up to 2 TB without LBD support, and disks larger than 2 TB with LBD.
>
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted. This patch differs from Joanne's patch only in its use of
> sector_t instead of unsigned int. No checking for overflows is done
> (see patch 3 of this series for that).
>
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D43511
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Cc: <stable@vger.kernel.org> # 5.2
                                   ^^^
Before commit 72deb455b5ec619f ("block: remove CONFIG_LBDAF") in
v5.2, support for 64-bit sector_t and blkcnt_t was optional on 32-bit
architectures.

> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20230620201725.7020-2-schmitzmic@gmail.co=
m
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  block/partitions/amiga.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index 560936617d9c1..4a4160221183b 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -32,7 +32,8 @@ int amiga_partition(struct parsed_partitions *state)
>         unsigned char *data;
>         struct RigidDiskBlock *rdb;
>         struct PartitionBlock *pb;
> -       int start_sect, nr_sects, blk, part, res =3D 0;
> +       sector_t start_sect, nr_sects;
> +       int blk, part, res =3D 0;
>         int blksize =3D 1;        /* Multiplier for disk block size */
>         int slot =3D 1;
>         char b[BDEVNAME_SIZE];
> @@ -100,14 +101,14 @@ int amiga_partition(struct parsed_partitions *state=
)
>
>                 /* Tell Kernel about it */
>
> -               nr_sects =3D (be32_to_cpu(pb->pb_Environment[10]) + 1 -
> -                           be32_to_cpu(pb->pb_Environment[9])) *
> +               nr_sects =3D ((sector_t)be32_to_cpu(pb->pb_Environment[10=
]) + 1 -
> +                          be32_to_cpu(pb->pb_Environment[9])) *
>                            be32_to_cpu(pb->pb_Environment[3]) *
>                            be32_to_cpu(pb->pb_Environment[5]) *
>                            blksize;
>                 if (!nr_sects)
>                         continue;
> -               start_sect =3D be32_to_cpu(pb->pb_Environment[9]) *
> +               start_sect =3D (sector_t)be32_to_cpu(pb->pb_Environment[9=
]) *
>                              be32_to_cpu(pb->pb_Environment[3]) *
>                              be32_to_cpu(pb->pb_Environment[5]) *
>                              blksize;

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

