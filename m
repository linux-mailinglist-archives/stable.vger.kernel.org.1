Return-Path: <stable+bounces-160448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC725AFC2F1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 08:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711BD1BC0991
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A023226173;
	Tue,  8 Jul 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ABImBFNW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6C223DEE
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956870; cv=none; b=Mu7HhM1AbMolFPQlmHeEXZ5lcltrvsZtYugA+vhoxC3I2y8aOIK+pywaePp/ml4/HxFNhkJrRQwDgm0a2FpAn3fZjNjgKtCHtAwnGWT5lHC+a8HAal68USWGKAhhn0oyxIweovUzb60zq8kYXp9NWclLMc3oWF9tBwJQA7/mPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956870; c=relaxed/simple;
	bh=mn3PjSRF5aAURidYrwQ4vjrt55R7G/gDBmdhvDiU7Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOF00r4FRgTHItJcKbSUaIJ+6LsbqFzEzJCuA0mPzsN5th376/Ov6Iv/1zLSNdyY95vgQ70SkHmWAA8SR3RNqe6Q4T8lN5d9y+mv+Z9upaF40v5n6rKt46rfTblZqR/smpfTCvFAdXHEHdPNe7vfZxKAvTfOGtJQDUEP+OAzSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ABImBFNW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-adfb562266cso629820566b.0
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751956866; x=1752561666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TZMEfz5WIJRj2nZJ2aYAIWpyLrUKEdr0s0Vm/UGWig=;
        b=ABImBFNWm8NRWv8vdBXp5pza3w85HtMyDV5UXU1KwpnehvHiHsgns0Sh+Fqv5Tq4ou
         iSolx+Esn5eN+0hL7zHeAeYM5Vy0ad1VKIAvRUw5ldSFbs4bl5g+OL4Pzcsj77ZlYaGf
         Q1FZQc2iFH0aWMgg9dwQqAPst9aC2IyA/rBfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956866; x=1752561666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TZMEfz5WIJRj2nZJ2aYAIWpyLrUKEdr0s0Vm/UGWig=;
        b=Zmn8QA1eQfIGLWB3brDTjQgGAiMb6YCVpfAoOOnUzbeoEwQPa6hySHr305ilu8dMCL
         Sjd3qJqPV8qfyoETKq6fAAh9QblAikg5R0N5Lhv3tsFmuKDZImpZ75Jh4wU8Tgpf3auO
         TAc27J6y/tQpYi0isTufUsumroGW4a5aUWG0pteZEELi2C52OR60jGik2Pr6YIny++z1
         7S1EMKpKk8NTRScKOtFXPcxbl7J9DIhSickzgu6khkx2nf2CjFHwx0zaHFlbHwZPCuAK
         Ae4JGfOrRgqJzB/GxmRXivocktbdAuEhv2ucv/6qcq9dxvxBaAJIXEcoGZRtHqpzSzar
         x01A==
X-Forwarded-Encrypted: i=1; AJvYcCUL4Rr+bUhe/XltwA+MWYRRK4HFiqMb8iKgW/F8ywB0imaT/GbeKzfkZE0DmFsXhxRiJeXYJRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxadukA6SiwWLRszXeYQnqTuUE8/r9TiihRPkjr00Kgkmf4/jFF
	Yq/QwkPLtVqDQJwd3LPDnMcNGn7nEfTXyzQsT2EZeYvAd31I4XcXJ7T7nV8zVFic+osUEjYXl6L
	D/XyP9g==
X-Gm-Gg: ASbGncu+ycyKK6qa0pihDXubukQR+Lo2NXCsAntkKs3zz73r9GNs38oyOdOW653goS6
	2RZAMmH4O0jlUVx8hdOCor8D5ZhXXF1pKss4KdrVSLjDFAGh+WlUKBkdzoSVVkqOkXNKlJLPHkG
	f/cJs2MUDHxQL+mSKqeiauomTx0qaeeMOksZTaRkfI/TLeopjJ9CmPef/3cM30RwYjZAQJifZjr
	jmqjLtM0aMpnbo7soPH0LkbY+sLKaU9T6LDd32n0GG2psvKvfOnC5lgMPlOMuVhY103r80AmkLj
	1r6OKZszrus8Ap3anP06PlL/KUO29GAjeTsnwRbfbnnILlcw3pGFZmRH1LSeOJmqC2O80ZJMJbj
	6td1QnzCZ08fRvvyps+edtax/UaQb+rUqpt7Ww/w=
X-Google-Smtp-Source: AGHT+IHErcn6cpgIfCC5uGpgHOgPBQSOQleL2ydVeBt9R+2SQrOm3NIOcQ3sQIBqfTJSqsDyPQN6Dw==
X-Received: by 2002:a17:907:7b88:b0:ae3:bb4a:91fc with SMTP id a640c23a62f3a-ae6b05895bdmr187413066b.22.1751956865467;
        Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca9bc53fsm6631855a12.36.2025.07.07.23.41.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso7909a12.0
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwadT2BmV2234hQV5wEgtiqGH4Sju5fUd6mFfITnHASs4OjlC/HwARab8gdp8TrrC/RsHbLRk=@vger.kernel.org
X-Received: by 2002:a05:6402:10c8:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-61051ba0baemr14560a12.0.1751956864575; Mon, 07 Jul 2025
 23:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org> <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 8 Jul 2025 14:40:28 +0800
X-Gmail-Original-Message-ID: <CAHc4DNK2_=81j-q4+1vsM9uyWJJ89dH4y2u_H5ie671umyNWxg@mail.gmail.com>
X-Gm-Features: Ac12FXzqSDrdQQK4kqjkvNzFjIs4Y1onDjlv36xI3xbZkB0uRyjH6h5P9pzUugQ
Message-ID: <CAHc4DNK2_=81j-q4+1vsM9uyWJJ89dH4y2u_H5ie671umyNWxg@mail.gmail.com>
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:57=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Jul 7, 2025 at 12:27=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium=
.org> wrote:
> >
> > After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
> > subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> > ("thermal/of: support thermal zones w/o trips subnode"), thermal zones
> > w/o trips subnode still fail to register since `mask` argument is not
> > set correctly. When number of trips subnode is 0, `mask` must be 0 to
> > pass the check in `thermal_zone_device_register_with_trips()`.
> >
> > Set `mask` to 0 when there's no trips subnode.
> >
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> >  drivers/thermal/thermal_of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd=
744725121ec7fd0d9 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_=
register(struct device_node *
> >         of_ops->bind =3D thermal_of_bind;
> >         of_ops->unbind =3D thermal_of_unbind;
> >
> > -       mask =3D GENMASK_ULL((ntrips) - 1, 0);
> > +       mask =3D ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
> >
> >         tz =3D thermal_zone_device_register_with_trips(np->name, trips,=
 ntrips,
> >                                                      mask, data, of_ops=
, &tzp,
> >
> > ---
>
> If this issue is present in the mainline, it is not necessary to
> mention "stable" in the changelog.
>
> Just post a patch against the mainline with an appropriate Fixes: tag.
>
> Thanks!
`mask` has been removed from the mainline, so this patch is only
applicable on old branches.

