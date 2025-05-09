Return-Path: <stable+bounces-143043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44515AB117F
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 13:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E32E3B4BCB
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D128ECE9;
	Fri,  9 May 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2v614rF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972B228C99
	for <stable@vger.kernel.org>; Fri,  9 May 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788789; cv=none; b=HoJSlZzvvA2Q3PVjx7sG4nGmc3HugjA72CPxEE/XMJ8ajyCAJ0zbeM6i7Zfnr2hKUWlzb4WX6JWp2zP6gMB0hovvbzR7LPXPItuAvqxrpQgJahWhzATRZ93S+Ba/1CUx7+/UIjyDO9cYWYAwwuCqNzMrRwJcqokyjNSX6/BS+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788789; c=relaxed/simple;
	bh=t2C4HMX2q+ykrxCLasIqR6WQaMhRrz7zJKiG5kqBRoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZJ9SKJIHQH+q76RU1R83yWnoMHk61HULwWAeSkdUzwSJulprROd7pIUb8uqSfSj/rZkw91KFw2BF1MNetv1nx+yg5JAt6bkaho4kYXIDsc7wsqUof4c0f1KMlxHCj9HmIY4YOqMxf446h85M8BYSbqhmlRKCLOjYVllLtXaJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2v614rF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-326c38c7346so7100191fa.2
        for <stable@vger.kernel.org>; Fri, 09 May 2025 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746788786; x=1747393586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2C4HMX2q+ykrxCLasIqR6WQaMhRrz7zJKiG5kqBRoM=;
        b=c2v614rFWLGatAcdM33dOJ+3ljkRpOZf3JGfOHsP+Uf6QojE2f/tuwsnd2ybF7cJP9
         ByZWVPOXwgFW2JldXWX+aAbVc2MPUaM3kBi7si1AS9B3ykuTlcLk+gKD9I5yF91c27PN
         MJzEndWet+j1DCY3s0oIRt06Q7m1/kt717adRHw81oK4UrE9LAOH2q/MLhbrcroaXB7N
         IEYS0vae9l4YFE6sSTMypkzQ0RAT7R0NwGxm3vOOu1Gf7bj1tkFgHEcFjJ3FbW58PXl5
         GDcw1xKQ6PRB9AbZPHpfWfGUkgmuUnmhzMRPy5mhZonOkuKR3cTCxmwilw0VBDf5FXMQ
         4saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788786; x=1747393586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2C4HMX2q+ykrxCLasIqR6WQaMhRrz7zJKiG5kqBRoM=;
        b=Nln+2qqtz+TA3i50o1Lwfrc4YiD0AS4vitu1URCGpSkZ7Vk30x/7Yl+8cHslXVFOuO
         OqMhqzLc4PlATTOfsiZmhLb4xY6que69CSO0jAxWClUJQWmsx98p9lBBK303hMOB0E0Y
         4jNSo6z8UrgQYr5BJBvUSPT2Fcgo20WYj2eCMw6HGblxY7i7vxRn0CEN4xtsXjyy+EGP
         hZrd2fPM1hNB4NOXZIWAFMHDiNK8TwBMQlZr7vaC3YvFvsPqWmDOp0i+aynw2Pa6LsdW
         6OmIEHkvBWEngONU2+KYl8QcSi1oz5Zm6abFPsLuKFRX8Z5nq7PHU5X0ef3wmTLWHe+J
         u9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6qqy8VVlTxQ/bav1+75IeQwza++h/FeRXw9FZ31ZJW6LtR6TGwWg3X5GmAPzhayEYShPnv1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9QQguszoTu6AfjmI7GGen4zK5CzquIf4/njBtbTw8Nf8OL0y
	Y2O840d4a4m83riTCsSiQZRAafQ7G4LR2Ge5N6RBxcxENmQqt3x77VmgRz3AVSrCIszQ7V9323D
	pjG9Zl7QVUkPAW67Jo6ZVxMbfMrE=
X-Gm-Gg: ASbGncvH4lRawNKwKJ0y9qb0SXqMiCbfGzkvies+omTxqcQE59IbIxThEF1WFRI5j/x
	y658Nvtix+vjmI7CpYIkbeSSCWME+RCgrr5BB1kqlDgajj2D1Zowvobyt5OFz7709hQS5MJXem6
	A6V/3I/ZP67qv58pXGGj4ZHDRTMGe4NYgS0fydPWLocPa/U2KOohc1bw==
X-Google-Smtp-Source: AGHT+IHiMtszuL64FRiLenfMWJnjacyFz/EaJ395z0Hb6Q2QJkAv3A/Z9lBNihBKSxG9s8jWhG0EvBQMivIP3Y13B+I=
X-Received: by 2002:a2e:a10a:0:b0:30d:e104:cd57 with SMTP id
 38308e7fff4ca-326c469229bmr10665481fa.40.1746788785405; Fri, 09 May 2025
 04:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417103458.2496790-1-festevam@gmail.com> <87cyd3c180.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87cyd3c180.fsf@minerva.mail-host-address-is-not-set>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 9 May 2025 08:06:14 -0300
X-Gm-Features: ATxdqUGhLIWwN25Ny1sR2sK7ptO4iuCb08bNbX96W5xMiFLLSRewadVWruWN4GA
Message-ID: <CAOMZO5CghWOyYse2nJjKzAk2tTGXTsag=EYeS+cS6tV6YO+NLw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()
To: Javier Martinez Canillas <javierm@redhat.com>, tzimmermann@suse.de
Cc: simona@ffwll.ch, airlied@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, noralf@tronnes.org, dri-devel@lists.freedesktop.org, 
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier and Thomas,

On Tue, Apr 22, 2025 at 6:53=E2=80=AFPM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Fabio Estevam <festevam@gmail.com> writes:
>
> Hello Fabio,
>
> > From: Fabio Estevam <festevam@denx.de>
> >
> > Since commit 559358282e5b ("drm/fb-helper: Don't use the preferred dept=
h
> > for the BPP default"), RGB565 displays such as the CFAF240320X no longe=
r
> > render correctly: colors are distorted and the content is shown twice
> > horizontally.
> >
> > This regression is due to the fbdev emulation layer defaulting to 32 bi=
ts
> > per pixel, whereas the display expects 16 bpp (RGB565). As a result, th=
e
> > framebuffer data is incorrectly interpreted by the panel.
> >
> > Fix the issue by calling drm_client_setup_with_fourcc() with a format
> > explicitly selected based on the display's bits-per-pixel value. For 16
> > bpp, use DRM_FORMAT_RGB565; for other values, fall back to the previous
> > behavior. This ensures that the allocated framebuffer format matches th=
e
> > hardware expectations, avoiding color and layout corruption.
> >
> > Tested on a CFAF240320X display with an RGB565 configuration, confirmin=
g
> > correct colors and layout after applying this patch.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 559358282e5b ("drm/fb-helper: Don't use the preferred depth for =
the BPP default")
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
> > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Could you please help apply this fix?

Thanks

