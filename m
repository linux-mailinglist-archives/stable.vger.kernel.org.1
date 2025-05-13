Return-Path: <stable+bounces-144186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C5AB59A1
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84A84A29B5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEBB2BF3C0;
	Tue, 13 May 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b="PFI7ywq9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190642BF3FE
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153209; cv=none; b=vD0H0ubGcevXM52MKkn6bI1zgZDnB4RKj01hOKJEi6rbpRfoGXjIxgvNLWk7jACK4Zh324O9iAuyiNUKWhaTrdIG7qj4lzAeLfa8eaIidTU9u1sh0pyTUHsA/Hap6AB+4bGmOSrokNFNeb48sJMvHOyW0FvT3kNn2e6ERFWtmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153209; c=relaxed/simple;
	bh=cWhfEEAw+tV/nQS2PrbAq7o6mdRDmYJ67CQa4j3Vk2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxPgCBSZkUGBeFUU4Q6YPkexnxYwdo3Pjxq6TP7JUYBeeAlFG/Z/vFOeByhMXnpD8vlE/p2XI+icGGfo7PXzAEOxPgDFFZnJh0sEKfIeGDFTVnvIhsWAz1N4TW9qcbi8306Hd9oTpJSS/cE5jiM2gGv5zc0Sl4s7YjKpJBYcq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com; spf=pass smtp.mailfrom=lessconfused.com; dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b=PFI7ywq9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lessconfused.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e730c05ddso54017255ad.2
        for <stable@vger.kernel.org>; Tue, 13 May 2025 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1747153207; x=1747758007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Okg4wdYw4WB8DO+V7q9yh5s+wPKhLzpza5jWmCmNzLM=;
        b=PFI7ywq9Nxu7618sDhq/hrQh7AHQ/+myKdLHbqzke1KJi5dH3LKQhujwt64wR5Qb63
         PpSPoLYxtskCwVB02+GPWh3zkMnhKfDv9XPAQASlWO9zzhr6GyXJXLZA4ZaVQpYG5sQs
         6UetmO7zcnd2Sd2ZUsZj/mtd2112cOEM35PiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747153207; x=1747758007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Okg4wdYw4WB8DO+V7q9yh5s+wPKhLzpza5jWmCmNzLM=;
        b=Hq4u+23hkw1IZn9khKQM0MXoKEjjEiO2xo5/iXmG+R/5xBK7QSdgDSFEaRSu2GpQES
         5o4fweZTRWpHlGioIG2Gh/zXUplTxHgDRN9qDBbghSDtIZ9PUSC3hXu3wRjQJs/KHMFA
         H/FuF7F6+26fWlxYAGTbpPS1xaq1815uX3d0fnMmTmo7H2yoA8u0fMQNrDuYf5R+M/iR
         N6JcKirOpFMqR5lDOmlUEp08J7J+TocJwXemames/27JPevJpOEjhxpr3RR46yTiCVT2
         4SCvsshS2rKik6xZwNn5jQL+hpex9oVlbSBA9Uw69IOCgY3+e4X17yOfbWns6utVksZF
         cWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcUO3IUzyCWtRDEnwF4IQjyEg8GWkGHGf+6IkATMHTgLDqP7xCC9vZU+uSAvkuOqBKHUAXcnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/jP50VE1/46FnzAVHv16+JrsQ6cy02X1ppn4wlLfSYXq857o
	WjsuUjw36gmRDS8qHRZ9KvqAgoVArTZfpFgllrqr23+nrVKIkQAN7xM/WaIdx8j2gn3GcJYZGy5
	/M6zgeRG5pvuylqrYU7wae6NWG5347c6Mp9fQWg==
X-Gm-Gg: ASbGncteEww9tlwcfxX8onMyefkXi+vtuq4Zb4RLkwae1O4bFdDmJdFJ5ViXfjxj4kn
	k4vv3ff7yuha1HQamFGenj6eUrncrnvT8ncV9nrt/Ik70JerYjjjNiddBXvhGCDDwEyV7gwPdsE
	GjDyni+EyERvOtvI3/oV+qBxBB0zuv2c6ocTJLWmE2dtTDHDSYRvvJcSeU1IBvP9iRuz8=
X-Google-Smtp-Source: AGHT+IEFiZZLEVm8p4exZqTgRnoEBDvu1NNpn5CecmgOUa1lbzow7S7xDOQ9y/PS6u/6mPTPI55hbsmTlWowpXVMs6Q=
X-Received: by 2002:a17:902:d492:b0:224:2a6d:55ae with SMTP id
 d9443c01a7336-231981d284emr53485ad.48.1747153207290; Tue, 13 May 2025
 09:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512142617.2175291-1-da@libre.computer> <1jecwtymsj.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jecwtymsj.fsf@starbuckisacylon.baylibre.com>
From: Da Xue <da@lessconfused.com>
Date: Tue, 13 May 2025 12:19:55 -0400
X-Gm-Features: AX0GCFvX20FlZeuRo40HJUU0H1dNyPENU2uA3HGGuO4tfwuq5uvg2W8hOH9cVak
Message-ID: <CACdvmAgNVf8jtRj-jONwunGXhheaizUEEyB4rz5tpqzXb6hKqg@mail.gmail.com>
Subject: Re: [PATCH v3] clk: meson-g12a: add missing fclk_div2 to spicc
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Da Xue <da@libre.computer>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, stable@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 3:52=E2=80=AFAM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> On Mon 12 May 2025 at 10:26, Da Xue <da@libre.computer> wrote:
>
> > SPICC is missing fclk_div2 which causes the spicc module to output sclk=
 at
> > 2.5x the expected rate. Adding the missing fclk_div2 resolves this.
>
> I had to re-read that a few times to get the what the actual problem is.
> If you don't mind, I'll amend the commit message with
>
> '''
> SPICC is missing fclk_div2, which means fclk_div5 and fclk_div7 indexes
> are wrong on this clock. This causes the spicc module to output sclk at
> 2.5x the expected rate when clock index 3 is picked.
>
> Adding the missing fclk_div2 resolves this.
> '''
>
> Is that OK with you Da ?

Feel free. Your description is better.

>
> >
> > Fixes: a18c8e0b7697 ("clk: meson: g12a: add support for the SPICC SCLK =
Source clocks")
> > Cc: <stable@vger.kernel.org> # 6.1
> > Signed-off-by: Da Xue <da@libre.computer>
> > ---
> > Changelog:
> >
> > v2 -> v3: remove gp0
> > v1 -> v2: add Fixes as an older version of the patch was sent as v1
> > ---
> >  drivers/clk/meson/g12a.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> > index 4f92b83965d5a..b72eebd0fa474 100644
> > --- a/drivers/clk/meson/g12a.c
> > +++ b/drivers/clk/meson/g12a.c
> > @@ -4099,6 +4099,7 @@ static const struct clk_parent_data spicc_sclk_pa=
rent_data[] =3D {
> >       { .hw =3D &g12a_clk81.hw },
> >       { .hw =3D &g12a_fclk_div4.hw },
> >       { .hw =3D &g12a_fclk_div3.hw },
> > +     { .hw =3D &g12a_fclk_div2.hw },
> >       { .hw =3D &g12a_fclk_div5.hw },
> >       { .hw =3D &g12a_fclk_div7.hw },
> >  };
>
> --
> Jerome
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

