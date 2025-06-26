Return-Path: <stable+bounces-158700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6608AEA238
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 17:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C4E6A72BE
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E0B2EA48F;
	Thu, 26 Jun 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htA+xgCC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4FE28C039;
	Thu, 26 Jun 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950638; cv=none; b=FsUa/74Dp4kZWehon3QupC80+YGe2zI5KeaES2KnAG1OP7XXEtYjjiMtBvYqHboV61gfYf0ULaACcfzja65+zreZIYQJUkLBZ0E6ca9wSLS0xdjPw9wgKhJQ+Fhz4l3qGTsfWequGqS7tjIqbvamtbi0985wxlO+C3kVjlBfd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950638; c=relaxed/simple;
	bh=Fsz5f/99U5JBaQvbPVrImfkgU9hAjFN83v0YZEnzFrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CO9mE09CmTqdMPzHVDwBWvIzdWXrk/fD2gt4QRrB91TFWsDKoXxklhSFJOqRwnOS/nKeHmvIY+SQG5rqJScNuysMcFalnRtVDum9S+xFePPITW1pUY3n6WlmeATBtoUvoLqaDCrBshFgRIC/TNKckvPh8KvqsOswqjZ4zBjKuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htA+xgCC; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5532a30ac45so1078505e87.0;
        Thu, 26 Jun 2025 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750950634; x=1751555434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axf5NbpAUzrmzPpqLLrUEqqBeYpEBv2j8XoiaPjeVEQ=;
        b=htA+xgCC5P+bdM5pRZAZunzSwqQ6LH42uACKcuIEzqOZ5HW7Ngf+WktrcD8AhpVudU
         TTQyj8xoqOY05vSHekDT3/M0UGMQTItenJB8soADs8+cLFCDi8/fZXTXS4bIxib+a1Ux
         /orC3o9hBGvoKPo0z6XPlzgtjRT5+Eo3lmvYd2VMYwoa+JY+oppJ3BVslR8tcvIUWl6T
         izvVON4z9NL9O4RbN6XkLFLEhHUkYTnlz3rQbqTD+mZp0fNhK7zJQ7i8sh87K+5cxnne
         YaynfJiTp/9yT9H+LM0CacoB7XHM+lmpTJTQ1Ys0Ude0UEhMC50+HvlKbR622eVbFUfl
         gbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750950634; x=1751555434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axf5NbpAUzrmzPpqLLrUEqqBeYpEBv2j8XoiaPjeVEQ=;
        b=g4Dn6kdIVJ0ZpenuOs8qEP7I7aor30xYJf9LauFlBD6yIb5tdkHC75T2Ppe6eRn0Yy
         pMGfLCn/jZTKbXhcJNF1wyOCXB6erjipB3l7GwMb9RZ68wpLnStNdZEmGRpuGDdBs6+w
         fyDCmsijknbrLolcPWMWVtV3OZ+pTcdJG32oIt0aLbZEOghcAtBrO1tCRhUOa6tqyeyu
         bVnVlTn7ySgjnN3UK9nhuh6odwc+ffFxtEHGecW3gwnGJvUuAG43FkIU0l7QYzRpz04g
         OQWQ92Dks06n0dOj6mmVQy0kYN5KrwZjHQK0mvegWTEAUHBj7QIuSnjZORKRGUwfQDRH
         vt6w==
X-Forwarded-Encrypted: i=1; AJvYcCWdc9bEfoXCF8JLe2fUtM08enXCNAXx9HLESvL3poS4Vi+Vdd4Bo53068Yvh/Q40EGT1LQvpnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJoTHWb1o16/Iqi0JWG9GRgIPfkq/b3BsOV58mkeAD1/MOcYaG
	UBEPQ6jL7jdp/5wTMY/S6Z4YvsM7b19Pi0QqQ/cUVpcc5w57/gfw3XaKvSLSFWwXzJ+0PWJMJ4p
	7tYGlmCHkzKiHgC1LHXBwl0ioNtabCMY=
X-Gm-Gg: ASbGnctCnDdhd61JN2NyT+kwDWr0gUmIjQ0IzypHnm35gmt6fCV3nOaSt8X/EYKGIdO
	fJnlNEEv9N3myRyWby8ElgRvpszP4gf9Bi0/EKnl69cELJTl9Oy4BSSMRlExqFOdHuW/aHWu2Bt
	V8beU3foY/SLhTkqkZSHOwLdCfKR4J107cDgx/v7fOy2PCI2onfPbR5Ala5NMMQpA9XSK3txdNH
	bYJ1g==
X-Google-Smtp-Source: AGHT+IG3aKdtoEX8k5XdMgWvxuQl/T0lmpkWTNORwe1brAkFFcnT7EjGtyotrt42fszQPUKuv/8ziotoOqBGlnuUj28=
X-Received: by 2002:a05:6512:239e:b0:553:2159:8716 with SMTP id
 2adb3069b0e04-55502caf1a4mr1616123e87.26.1750950633544; Thu, 26 Jun 2025
 08:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626142243.19071-1-pranav.tyagi03@gmail.com> <5baab2ed-c48d-41ae-819a-71ca195c4407@igalia.com>
In-Reply-To: <5baab2ed-c48d-41ae-819a-71ca195c4407@igalia.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Thu, 26 Jun 2025 20:40:22 +0530
X-Gm-Features: Ac12FXzNyUo0k5FLeYm1nQk0x2e9IyduCv2spuHDSlghF9NcaV2B_Em4IpBcyCY
Message-ID: <CAH4c4jLqQORVWNLmNGAqevbSCnALtkfod6gTuXe-oae0izR9Bw@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: Fix race-condition between the hrtimer and the
 atomic commit
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, hamohammed.sa@gmail.com, 
	daniel@ffwll.ch, airlied@linux.ie, arthurgrillo@riseup.net, 
	mairacanal@riseup.net, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:32=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Hi Pranav,
>
> On 26/06/25 11:22, Pranav Tyagi wrote:
> > From: Ma=C3=ADra Canal <mcanal@igalia.com>
> >
> > [ Upstream commit a0e6a017ab56936c0405fe914a793b241ed25ee0 ]
> >
> > Currently, it is possible for the composer to be set as enabled and the=
n
> > as disabled without a proper call for the vkms_vblank_simulate(). This
> > is problematic, because the driver would skip one CRC output, causing C=
RC
> > tests to fail. Therefore, we need to make sure that, for each time the
> > composer is set as enabled, a composer job is added to the queue.
> >
> > In order to provide this guarantee, add a mutex that will lock before
> > the composer is set as enabled and will unlock only after the composer
> > job is added to the queue. This way, we can have a guarantee that the
> > driver won't skip a CRC entry.
> >
> > This race-condition is affecting the IGT test "writeback-check-output",
> > making the test fail and also, leaking writeback framebuffers, as the
> > writeback job is queued, but it is not signaled. This patch avoids both
> > problems.
> >
> > [v2]:
> >      * Create a new mutex and keep the spinlock across the atomic commi=
t in
> >        order to avoid interrupts that could result in deadlocks.
> >
> > [ Backport to 5.15: context cleanly applied with no semantic changes.
> > Build-tested. ]
> >
> > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>
> > Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20230523123207.1739=
76-1-mcanal@igalia.com
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
>
> This patch violates locking rules and it was reversed a while ago.
> Please, check commit 7908632f2927 ("Revert "drm/vkms: Fix race-condition
> between the hrtimer and the atomic commit"").
>
> Best Regards,
> - Ma=C3=ADra

Thanks for pointing that out.

I missed the revert. I now see that commit 7908632f2927 reversed
this due to locking issues. I=E2=80=99ll drop this backport from 5.15
accordingly.

Regards
Pranav Tyagi

