Return-Path: <stable+bounces-142856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E42AAFB1D
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22AA1BC6AF4
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C9225414;
	Thu,  8 May 2025 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPiFVg7B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7714D2A0
	for <stable@vger.kernel.org>; Thu,  8 May 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710338; cv=none; b=N5cy/g9q+KoMZnwkflYXxzBcWDgygT366OfADSzk65UIKXtO2bZdM7LwgDA+3aKRIU5XXWCkxzeB3sjYJZ4kt5eRTK8t6lNv1fh0vjsKlxe4LEBssj/aBqEnv4EF7QyPbgLo+1HlZmPBRYvpRGZRJulxupvvON8hbQJKyaXkVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710338; c=relaxed/simple;
	bh=NC6aZCnk2yQCUTn2o/QPYLbt6yzD49eOOrZg5imo7KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juBVOgKe/GaAJNWGNKZbSfdhsZV0bNCR8IBDMECVY9y7ByzGZMQWlZdxO7NSIDJKQ45Dqg1eexP9v0js0mOQ1dacMv73T3tNzUoOX1d/tFAG2GG2ydW9jhbAeYmrv2fxaVKbIhlYcX5zGGEfZsJG4qKOmPTI1XRtK95uWFkGEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPiFVg7B; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3087a70557bso153299a91.2
        for <stable@vger.kernel.org>; Thu, 08 May 2025 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746710336; x=1747315136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1roDko1XbrOHKIMUjuHPe417xq/761zF6ZWegodHkQ=;
        b=bPiFVg7BlFhNOhBTzh07kO7I34+F2kLHNaNznnsahS1gmJEajRlhLjAZpikAD0KlRP
         Kr4eHZ7lczbipTtaffYjDN7rHIu9ffwmIlFNZjzU6DFO13LMOmrxli6c3sdR6RjqaEbQ
         /9sv+OvoQAlbmZqjz2x7tnE5FnZcymggYcuDFGJFjoFI2lXik3DSJcdH6boIaxKEYgsU
         hZYAbzVlIQ4jGDeJ1v6lfcbya5FXHVn3oM9naTRtMNDr+zWNPfRtmY2eTloAq7NuE70D
         ojGQwXY8jQJvE+OwKtVAa+0F32q52ImwHINXaSCtUUYoBD98qWLYTR0Q1ZvmV2OSGAtm
         V2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710336; x=1747315136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1roDko1XbrOHKIMUjuHPe417xq/761zF6ZWegodHkQ=;
        b=iPswE+MltXGchE5V9f+HDGDgMecvck4o2BZoe84me702zT4LvlDu7xCEJI3rFHw1JD
         L1yDbPTWlQBBhtatSPXtuLUQ7nVvFGPTaTfMmv/jb4/Jj2DzYAFntWgtfyjmXeQpgIQM
         EzPW85xdFJtOZHzN4MiGFZreUsZEQthjDsiUEyfJR4T9ofSPB35tf/KSfZF9w8DD6peu
         hd35i5aqERQjB+M0Q3RA1yrP5pW+b0vDXQdTjoBrETix08TTlt5WVF2chXZPhczBJ3ZZ
         IEgiaFd+UswzQmMEhhqcZPi97r8jsdumyS48eQAK6TlZ/t6x3dBSauJ9q661KTnKgiBj
         v1tA==
X-Gm-Message-State: AOJu0Yx7KRJxjTPt1kCqD+gLz2+UQhCdRkj+/ob9JcEMaeHIbz0kbvDG
	lEX5LgxcjrnVfHGX4sVe5aBkCzUrjxvqzoEFjv4lQlDOfZP5DMsOvxRaWZP0XB2qgQfXjN2E+r7
	EXQlYA8x8AgKRDl0xYrKciodSelw=
X-Gm-Gg: ASbGncvoKlb4TyL3usa8Qf9bNJ1VKCLa7xyV6wPnGYxQBFPj+ncrjBqDdXO9xr3n2H6
	kVzvxV2xToC9/Gj7uWKg6D87P5LTdDAnuAHkQA2uJslDEYqpmCEul9bwJ+DkHXrX0GS0HuOkWD0
	zqdMxU4ox8PqaDOCPpTho4BQ==
X-Google-Smtp-Source: AGHT+IFq0Lg3VZtCXUNslSbOl91jQC1KDok+Cuyoct+R62Hp6QOZMTlt5q0sgQH4VvcvrHtyIRM3g+TIjX0s0JSf60A=
X-Received: by 2002:a17:90b:4a0d:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-30aac168c32mr3996692a91.2.1746710335552; Thu, 08 May 2025
 06:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c415d9e0b08bcba068b01700225bf560@disroot.org>
In-Reply-To: <c415d9e0b08bcba068b01700225bf560@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 May 2025 09:18:43 -0400
X-Gm-Features: ATxdqUGPLOFgD59MDg0LhtzD4qji_j1FkqfSHl_wTRX4mI-vM5Sp5qVFzLgtUw8
Message-ID: <CADnq5_PX1dYF2Jd3q7ghaBjpPhNLq9EmFJtN1w6YOSfVo++7sA@mail.gmail.com>
Subject: Re: Unplayable framerates in game but specific kernel versions work,
 maybe amdgpu problem
To: machion@disroot.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
	christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:13=E2=80=AFAM <machion@disroot.org> wrote:
>
> Hello kernel/driver developers,
>
> I hope, with my information it's possible to find a bug/problem in the
> kernel. Otherwise I am sorry, that I disturbed you.
> I only use LTS kernels, but I can narrow it down to a hand full of them,
> where it works.
>
> The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD 7790/8GB
> RAM
> I already asked the Manjaro community, but with no luck.
>
> The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021),
> uses vulkan
>
> ---
>
> I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15,
> 6.1 and 6.6 and and the game was always unplayable, because the frames
> where around 1fps (performance of PC is not the problem).
> I asked the mesa and cinnamon team for help in the past, but also with
> no luck.
> It never worked, till on 2025-03-29 when I installed 6.12.19 for the
> first time and it worked!
>
> But it only worked with 6.12.19, 6.12.20 and 6.12.21
> When I updated to 6.12.25, it was back to unplayable.

Can you bisect to see what fixed it in 6.12.19 or what broke it in
6.12.25?  For example if it was working in 6.12.21 and not working in
6.12.25, you can bisect between 6.12.21 and .25.

Alex

>
> For testing I installed 6.14.4 with the same result. It doesn't work.
>
> I also compared file /proc/config.gz of both kernels (6.12.21 <>
> 6.14.4), but can't seem to see drastic changes to the graphical part.
>
> I presume it has something to do with amdgpu.
>
> If you need more information, I would be happy to help.
>
> Kind regards,
> Marion

