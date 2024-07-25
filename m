Return-Path: <stable+bounces-61794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C193CA00
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC5FB219D2
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 20:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D59D13D50E;
	Thu, 25 Jul 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCaz5/pO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895431C6BE;
	Thu, 25 Jul 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941171; cv=none; b=uHI2ojITx9dT4UWzyg6o2cXxLQhHPF+ESucHQj6BtNimtjhi2SRSw71Sa8VkIHpcOQvgE8UK2IqP8UE1qCRcdVSZs+EFmOuqJCQJ0nYzIpL7Lz8gJvjO5gzURfOL/ZCp1WkInxmrK5ILK+t4Hp+Xl4uJyHiWHhBvulM2RZhnETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941171; c=relaxed/simple;
	bh=e1KohRFif6uCY9LT104gO5hBEyXEhKhGGC4vLFpivm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em4rLYApoaOf0z/26csprDALMq6i94+n0mj+hfb+3xR+b3GY6jz8IQeRwMSvXx/URo+sbDAMPDrwWM57pD5aGkt6e5mdFT1JlMCIe3rFDEGOOH9Dzl03ZQcx65XWLKVAAHxMS2Dc1KvflnOft4EPB+YmoyTtAXAwCmXYeCaMb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCaz5/pO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-710437d0affso221231a12.3;
        Thu, 25 Jul 2024 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721941169; x=1722545969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4gCniBGiUh7RbvIXsajAgjTfTdLghfosUa+OF1HFMA=;
        b=nCaz5/pOAWprToJEkVcVx77yHGJgy/DFwSPl+YHPp5dZtfF3lNrNyLKO8/pZiHJDn2
         Ffp7V4fJ8NseXbdr2AkxgT1s2uLIzcLw6EanB/N0z9XNrs3/PcrSMtaL0czDFLyR0a95
         MRpdYqrOUxcEn9AH5qJ1qbLyYW7gUEQJZS8K+Cfw8KLYE+zLRXtJaduGvbtQTkA7i5yk
         FkC1PrM4r0N793AVKYi8/vuY1rFQSbswRPc6SuXfMcEydbIQfJiBbvuDEbL2hqbJVl8g
         da/l+oA1jUlndqo8FXE1o7ZGNsWRoe/LW/IBPAJB5xCB4292b4eEvFPVH8qDRQ38C9kX
         9MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721941169; x=1722545969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4gCniBGiUh7RbvIXsajAgjTfTdLghfosUa+OF1HFMA=;
        b=SPULCI85HNPwcvC0oHbPthGqAlRu5tnC1H1jJzkydrfGviMmASbCrNUO15drkorAFJ
         zE5yewtItrLlsw7SHR4dJTmW0udooWnni7Zgx+rEiVRym2Df2gY4t8r8oDoLNbOdgv4C
         kcxbzzIxlAKhev6P0nHK61LhthCs0qkoi4gDqs2lf7sAHQztRQFwtNrFHESgRnl6CXlp
         LnYfm7IKgJIp7GOPGp8KKd0DpX+ef+nezWX1x5AhA2+oscgAUEeaM/NmT8sv6HA++mXJ
         dXdi+4h9djFJerMZqTYlN0eHgyboitzRs8QfmIj1uTp3A/WA6nOG5+Br9yG2I4TVPiLX
         HYlw==
X-Forwarded-Encrypted: i=1; AJvYcCVcPAxYi70Y2nez6A7CNSHHYXTDsl7uLVSxZOBHaZMJqV5gYw7avPWiRA8HWJBq7+HzfXDz1Kvq5hbohpXDATiTTgi1T6Wk8eF5QTZ/DzKTammuYcg8fSxfDfFQwfoNASn06062
X-Gm-Message-State: AOJu0Yz5fAsT4cc/C4okeikdNq0vQJlpXLs0kYnu34UcLi6fJJq4UZkg
	3CBlhGcxYR0YXCQgG3V9kBZTZYJ4PlRffsaPxLkRGn1GqCWdfVmGUuSaa4DgkR7Kb7MNkKFb3hC
	cZLj6B8vYWUMS4tMqmlse9HOcLo0=
X-Google-Smtp-Source: AGHT+IFA0VZ111JxLn9HdP00YaL4Z9quBI2prN0idkkDGmhMU4bZZeeTu2CxFkR1MXDUXDfcRnEz5m1mcFb+wqqyzHE=
X-Received: by 2002:a05:6a20:7494:b0:1c0:bf35:ef4c with SMTP id
 adf61e73a8af0-1c4727aad83mr5501536637.11.1721941168624; Thu, 25 Jul 2024
 13:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725180950.15820-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240725180950.15820-1-n.zhandarovich@fintech.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jul 2024 16:59:16 -0400
Message-ID: <CADnq5_NuAL4=hMyc6G0QkbSrjCXa6qFM-bFtt3A7DY6cCmCt9w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/evergreen_cs: fix int overflow errors in cs
 track offsets
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jerome Glisse <jglisse@redhat.com>, Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Jul 25, 2024 at 2:20=E2=80=AFPM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Several cs track offsets (such as 'track->db_s_read_offset')
> either are initialized with or plainly take big enough values that,
> once shifted 8 bits left, may be hit with integer overflow if the
> resulting values end up going over u32 limit.
>
> Some debug prints take this into account (see according dev_warn() in
> evergreen_cs_track_validate_stencil()), even if the actual
> calculated value assigned to local 'offset' variable is missing
> similar proper expansion.
>
> Mitigate the problem by casting the type of right operands to the
> wider type of corresponding left ones in all such cases.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 285484e2d55e ("drm/radeon: add support for evergreen/ni tiling inf=
ormations v11")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> P.S. While I am not certain that track->cb_color_bo_offset[id]
> actually ends up taking values high enough to cause an overflow,
> nonetheless I thought it prudent to cast it to ulong as well.
>
>  drivers/gpu/drm/radeon/evergreen_cs.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/rade=
on/evergreen_cs.c
> index 1fe6e0d883c7..d734d221e2da 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -433,7 +433,7 @@ static int evergreen_cs_track_validate_cb(struct rade=
on_cs_parser *p, unsigned i
>                 return r;
>         }
>
> -       offset =3D track->cb_color_bo_offset[id] << 8;
> +       offset =3D (unsigned long)track->cb_color_bo_offset[id] << 8;
>         if (offset & (surf.base_align - 1)) {
>                 dev_warn(p->dev, "%s:%d cb[%d] bo base %ld not aligned wi=
th %ld\n",
>                          __func__, __LINE__, id, offset, surf.base_align)=
;
> @@ -455,7 +455,7 @@ static int evergreen_cs_track_validate_cb(struct rade=
on_cs_parser *p, unsigned i
>                                 min =3D surf.nby - 8;
>                         }
>                         bsize =3D radeon_bo_size(track->cb_color_bo[id]);
> -                       tmp =3D track->cb_color_bo_offset[id] << 8;
> +                       tmp =3D (unsigned long)track->cb_color_bo_offset[=
id] << 8;
>                         for (nby =3D surf.nby; nby > min; nby--) {
>                                 size =3D nby * surf.nbx * surf.bpe * surf=
.nsamples;
>                                 if ((tmp + size * mslice) <=3D bsize) {
> @@ -476,10 +476,10 @@ static int evergreen_cs_track_validate_cb(struct ra=
deon_cs_parser *p, unsigned i
>                         }
>                 }
>                 dev_warn(p->dev, "%s:%d cb[%d] bo too small (layer size %=
d, "
> -                        "offset %d, max layer %d, bo size %ld, slice %d)=
\n",
> +                        "offset %ld, max layer %d, bo size %ld, slice %d=
)\n",
>                          __func__, __LINE__, id, surf.layer_size,
> -                       track->cb_color_bo_offset[id] << 8, mslice,
> -                       radeon_bo_size(track->cb_color_bo[id]), slice);
> +                       (unsigned long)track->cb_color_bo_offset[id] << 8=
,
> +                       mslice, radeon_bo_size(track->cb_color_bo[id]), s=
lice);
>                 dev_warn(p->dev, "%s:%d problematic surf: (%d %d) (%d %d =
%d %d %d %d %d)\n",
>                          __func__, __LINE__, surf.nbx, surf.nby,
>                         surf.mode, surf.bpe, surf.nsamples,
> @@ -608,7 +608,7 @@ static int evergreen_cs_track_validate_stencil(struct=
 radeon_cs_parser *p)
>                 return r;
>         }
>
> -       offset =3D track->db_s_read_offset << 8;
> +       offset =3D (unsigned long)track->db_s_read_offset << 8;
>         if (offset & (surf.base_align - 1)) {
>                 dev_warn(p->dev, "%s:%d stencil read bo base %ld not alig=
ned with %ld\n",
>                          __func__, __LINE__, offset, surf.base_align);
> @@ -627,7 +627,7 @@ static int evergreen_cs_track_validate_stencil(struct=
 radeon_cs_parser *p)
>                 return -EINVAL;
>         }
>
> -       offset =3D track->db_s_write_offset << 8;
> +       offset =3D (unsigned long)track->db_s_write_offset << 8;
>         if (offset & (surf.base_align - 1)) {
>                 dev_warn(p->dev, "%s:%d stencil write bo base %ld not ali=
gned with %ld\n",
>                          __func__, __LINE__, offset, surf.base_align);
> @@ -706,7 +706,7 @@ static int evergreen_cs_track_validate_depth(struct r=
adeon_cs_parser *p)
>                 return r;
>         }
>
> -       offset =3D track->db_z_read_offset << 8;
> +       offset =3D (unsigned long)track->db_z_read_offset << 8;
>         if (offset & (surf.base_align - 1)) {
>                 dev_warn(p->dev, "%s:%d stencil read bo base %ld not alig=
ned with %ld\n",
>                          __func__, __LINE__, offset, surf.base_align);
> @@ -722,7 +722,7 @@ static int evergreen_cs_track_validate_depth(struct r=
adeon_cs_parser *p)
>                 return -EINVAL;
>         }
>
> -       offset =3D track->db_z_write_offset << 8;
> +       offset =3D (unsigned long)track->db_z_write_offset << 8;
>         if (offset & (surf.base_align - 1)) {
>                 dev_warn(p->dev, "%s:%d stencil write bo base %ld not ali=
gned with %ld\n",
>                          __func__, __LINE__, offset, surf.base_align);

