Return-Path: <stable+bounces-152713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE829ADB1EB
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861161883D0F
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86C1F4168;
	Mon, 16 Jun 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgvadkcd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46FF2BEFFE
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080615; cv=none; b=rTYyzAu1l84TL0792fG4g3Y/5QK2SdXMOlZhXQ436seT09n+77Cx/Gh87rHURhRSu0k8rBxzWo6s67je4v4l9EoEhJU3Fjuc7iqdWLYYG8qbLy0XDQ7LI+rpndFH3fdITGN+ghqEGBzzDTKap2yqqs5HfOkweVMdT60DJA9lE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080615; c=relaxed/simple;
	bh=59qFySa7X+/ac5Ydc1pV7JddQfv8+DTKdIh521qRg7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9A/vHOmq9MHX6SMLD5IFsFjgArYcr668PtL2AtduLxAZIY9PlkZph3xeB+rl1PTJlw/0j0dBLhHGEVYQ/N6w7GdQBiFfudUmxld7CgQiKoyh2BMuMBiu8gTZpryWdYq9uLxxxWmwX6rxyNAbNUDQove9NCatbC8jx/0OMN6n5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgvadkcd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234eaea2e4eso4284905ad.0
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750080613; x=1750685413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+QmnhYc0vGa92UC7MvCez/Zyxtl9c45qHEYK1lXUtU=;
        b=DgvadkcdpwO5KHlPGNfyhN9EhdisquHf5uViPO2ktCpHmwPCbrrqJlnTNDNTfkbgIz
         jfnUqrOAz/W6gUT6SMhqQw+7ZqbnTSAaD/XQEbYG/KRd1YarDz1G7nKk9IcdRTVxYc2Q
         LOOvMlw8CPx2qEvHTPG+2nSNQMb6ecZaMlqJiIovTqwETEnpDYE1LVzBiuLvbE578fRJ
         tnX9Mb/zCvtICaiecEFP2B1OnSovg+Ly8GmjfiXHy2Q0fv7Fhsb4bmetn+sSq/7NSumX
         qVHzpLKTNXdlcTXfvv+I8daVkCQUiwPpuOLiKUHPayBrAwDvFVEoJtXgWdBjGwQYsgB/
         Z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080613; x=1750685413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+QmnhYc0vGa92UC7MvCez/Zyxtl9c45qHEYK1lXUtU=;
        b=IXrqxk2F6gq/NneMMdepNdbIh5yfOKrzpwGCRLYHbfRDNw4y3I825HPDaj/WDhsbQz
         K6LSG0B0QrddcEgfIEf439HF4NoNVLwaifM6b1DaJxvi3A2cGzMUjXdcQBRkZ+cXxGaU
         5AdAPvFhJFcQiWiCKJ8UXdbYQs3qPGv86QleFAkHB9HFL0bzHGNyx7XnVlROdwPFdIU8
         /nI1hKwV9MhBBdLxxw/tJjLx40eeykjWwttNRJzcrcVbKr3mukfv0fmGXM6/yXmL/j9N
         Ofngtgw48+eGRGxPmhm71SaLBniKyurLLpTsunjSL/n9mSsz5QR0b58TLQdHb+D2Gf+W
         yDJw==
X-Gm-Message-State: AOJu0YxR2tosqifFRc0THcmXuhifINUVKpPzunQrKHkJs56QNDLvrprf
	mQdiBGqhEgz6tFilVGJ77oa6R2eyKdjED0ug8swlhlKT01izMVmmSOWpkuElzWzpuX2pmCFFvG2
	zvhlPRrsUfcdyj41T2i/I6lUSA9Tq0SewhA1E
X-Gm-Gg: ASbGncvBhuNjbaM9jDYxhhnXXf/+f6o2Po+4J+M3kPnlq7xeiuW2uVejwjcVx4a1RGd
	mAXactyT/35Kd96OWx53698nWyvm31vNDd+EjbbtMShL1PLq9PGkasPqOySZkn1+hbvrzEXHUAi
	v4lFlhYBmcL9yOQaFPuG1ZsSFi9dAtxe0mrTujmOozPnHX
X-Google-Smtp-Source: AGHT+IGh7h6yA8zvALC5hiiGFj0J/FBflTGa0Uz6Pkt1gyHm0RW4BdoiBIlQbL9w6OGrh/35fpnh4uTxfdlAObUNoZM=
X-Received: by 2002:a17:90b:1ccc:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-313f1de6397mr5102153a91.7.1750080613063; Mon, 16 Jun 2025
 06:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c415d9e0b08bcba068b01700225bf560@disroot.org> <CADnq5_PX1dYF2Jd3q7ghaBjpPhNLq9EmFJtN1w6YOSfVo++7sA@mail.gmail.com>
 <69b5ebaa719355994a383fa026dc3fba@disroot.org>
In-Reply-To: <69b5ebaa719355994a383fa026dc3fba@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 09:29:59 -0400
X-Gm-Features: AX0GCFthNM7567uej1TQBWHUevhiCE9wm4x56veEnyNPJYkkpKzt0iW-4Hg9ffs
Message-ID: <CADnq5_PkOuAHuDjMNXABEcenaZFZgU044G=9pTu=EgMr_grXbw@mail.gmail.com>
Subject: Re: Unplayable framerates in game but specific kernel versions work,
 maybe amdgpu problem
To: machion@disroot.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
	christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 3:38=E2=80=AFPM <machion@disroot.org> wrote:
>
> Hi,
> sorry for the delay.
> Besides less time, I had to make myself familiar with bisecting and
> again kernel compiling. Last time I compiled the kernel myself was
> around 2010 I think.
>
> Anyway it seems I found the bad commit. The result after bisecting 10
> commits is:
>
> a53d959fe660341788cb8dbc3ac3330d90a09ecf is the first bad commit
> commit a53d959fe660341788cb8dbc3ac3330d90a09ecf
> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
> Date:   Thu Mar 20 14:46:18 2025 +0100
>
>      drm/amdgpu: immediately use GTT for new allocations
>
>      commit a755906fb2b8370c43e91ba437ae1b3e228e8b02 upstream.
>
>      Only use GTT as a fallback if we already have a backing store. This
>      prevents evictions when an application constantly allocates and
> frees new
>      memory.
>
>      Partially fixes
>      https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2833985.
>
>      Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>      Fixes: 216c1282dde3 ("drm/amdgpu: use GTT only as fallback for
> VRAM|GTT")
>      Acked-by: Alex Deucher <alexander.deucher@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>      Cc: stable@vger.kernel.org
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Unfortunately reverting that commit will reintroduce a similar
performance issue for lots of other uses.  See:
https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2827990
for a description of the fundemental problem.

Alex

>
> Marion
>
>
> Am 2025-05-08 15:18, schrieb Alex Deucher:
> > On Thu, May 8, 2025 at 9:13=E2=80=AFAM <machion@disroot.org> wrote:
> >>
> >> Hello kernel/driver developers,
> >>
> >> I hope, with my information it's possible to find a bug/problem in the
> >> kernel. Otherwise I am sorry, that I disturbed you.
> >> I only use LTS kernels, but I can narrow it down to a hand full of
> >> them,
> >> where it works.
> >>
> >> The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD
> >> 7790/8GB
> >> RAM
> >> I already asked the Manjaro community, but with no luck.
> >>
> >> The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021),
> >> uses vulkan
> >>
> >> ---
> >>
> >> I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15,
> >> 6.1 and 6.6 and and the game was always unplayable, because the frames
> >> where around 1fps (performance of PC is not the problem).
> >> I asked the mesa and cinnamon team for help in the past, but also with
> >> no luck.
> >> It never worked, till on 2025-03-29 when I installed 6.12.19 for the
> >> first time and it worked!
> >>
> >> But it only worked with 6.12.19, 6.12.20 and 6.12.21
> >> When I updated to 6.12.25, it was back to unplayable.
> >
> > Can you bisect to see what fixed it in 6.12.19 or what broke it in
> > 6.12.25?  For example if it was working in 6.12.21 and not working in
> > 6.12.25, you can bisect between 6.12.21 and .25.
> >
> > Alex
> >
> >>
> >> For testing I installed 6.14.4 with the same result. It doesn't work.
> >>
> >> I also compared file /proc/config.gz of both kernels (6.12.21 <>
> >> 6.14.4), but can't seem to see drastic changes to the graphical part.
> >>
> >> I presume it has something to do with amdgpu.
> >>
> >> If you need more information, I would be happy to help.
> >>
> >> Kind regards,
> >> Marion

