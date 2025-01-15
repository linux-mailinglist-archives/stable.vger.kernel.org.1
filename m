Return-Path: <stable+bounces-108689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84655A11D10
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E53188B988
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8B8488;
	Wed, 15 Jan 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGdw+WAK"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BF246A32;
	Wed, 15 Jan 2025 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932464; cv=none; b=t1OWYFCOLi5wLlm4R+qg+EQ1SgWEcHKeqkhCrOyHx6dxXYK1vo4rE0LCYtcbTcE+qbJRlt72hWceoo3jd01fw01jreyUIxwoejSbnlpN/zvHQelbbutLEuP1qmD6Ejq9I743gJ9xYpIOH0mKoOmUTINy+9IoYR6Es+owDZX6hfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932464; c=relaxed/simple;
	bh=ZDS24qFPcz7PbO9ilrNaWuBvwLYDgt22ICaDCMtP7kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX8pNeWxv2c0LcExSx5EMHNjiBIDWj0fcMxEv8LLm3ePvwN7jOkHFh7o2C5BZyfu94Bdc8v+toTiFaJ859HyQOYw/rNFyUdUzARC/QKciY7SQqD9T9hyYODXwYy+kn/MjeVQq6xsZ/O8W6uH9/2B4oMJtucUEzDLERLBo/j81ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGdw+WAK; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso22159285ab.2;
        Wed, 15 Jan 2025 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736932462; x=1737537262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEHa30YI/D4TB5d5TCkCAkeAxF1mnHvfzhEDix3qPkY=;
        b=OGdw+WAKFWRm0UPB6DFtAkmVMlA1M6t68k4t11q6yybWdWuS83Rb+WrPg2h+Aka1Y1
         uvYtD74b0G3t3+Clf55PEzEvQLMXobEN2Y6QjM4R+BPUJZMfxX1xNeiy2z8A0oFMvHpN
         dx+M3J7xGo2fL5AvKrYFQ9FODJEnls2I2sqsp3/MVR5SV75WT1+hWYXQqGkyCY5H0H/Q
         WP7ji7ShEXJl8q9n0TILHJrD+W9DR8NvHBhl1oS560mzR1eMt01u0hKdwZ0e2tJ9txny
         Tz2hu8sSF22RslWBsR14xhEHBP6VIYjceUnwOVIGgzSCrcsf4u8TzrngKN3w3m8v9Z6l
         3WwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736932462; x=1737537262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEHa30YI/D4TB5d5TCkCAkeAxF1mnHvfzhEDix3qPkY=;
        b=L9GvsM6jJC+KZPerdUll7MFOjDshFBv6otk9/SW0EYRT6UhKRN66qfcL+UCUm95syS
         lX+cQtGalRdX0NMHCVp0SHYWpbz9ewiWLkuzwmV9PScEnZQIg8+abc/iJqmhbQi8S9cQ
         0JNkyf1gZdFSO+sLQkGqqqdAADIArON4YbHFrR1BlTgbboqe86wwX1JaFyFvc3JNP//7
         42Hk9UkWRAYIRIs82JC/oXpIgAqQJNobTsBWoFmKEFuq8SJL/UQadze54BVbKRZbFGrC
         xWKPWoOJZLSK6y0bfV/gmnx45+dRIy5A6i7hvJfLjFuIgfrXslPqfcwtpXAKvSukcK6b
         TblQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJz1Pv+g5iN0qDaZBWsHDm8rQ7dmjVQY+tDYL8Uvsd3Ti7uTdtyQhDhqnv7ALRB08Nl6YPT5Bd@vger.kernel.org, AJvYcCVOYrCGmy8YULPa1CV2ozOlgtr3wEme7Bx1EzgwPHl70dIFmE5gT5o9bAfq5ryXUCeDsPS8wCaMVPk=@vger.kernel.org, AJvYcCW2MgGfNDwMhQrnZZj4W4etO0NYTwdGgjMTJtd5C3VWgqozF6s18ddomRZA6h3n0J7oTiVvoLFlKva1zJeJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Vhi8ljV7ntUhzf8WHWN65NObEJDzcWI0EPnUSacva7hMAuBn
	QnVz5efoI14cMfz3lmx8JJT4dbilcTivrru5LFgX8jwanFwcStSwOkhvdGN8tCaP/Vt7C1ksyBF
	0u2N6noBOhg4lpo1895t1LnpwV08=
X-Gm-Gg: ASbGncv9SzN4b8JK6u8QhbYhmMoB+ceIKZmH/G6pvnXyBS4CmLuPUAyf0IRDt/4mXoc
	Vy7bhgecBJT+gW9h/af+WRtzwO603Om+pj7dWTg==
X-Google-Smtp-Source: AGHT+IHp2yxisjfC0hLM91sJ5IJ902hsppuSwXi035/jhixqUZj488OZUhs3oen2jZMSUhBJ8zUTJKPr8r3rc8NuV+M=
X-Received: by 2002:a05:6e02:1388:b0:3ce:7b61:588 with SMTP id
 e9e14a558f8ab-3ce7b6105admr42289285ab.14.1736932462018; Wed, 15 Jan 2025
 01:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113094654.12998-1-eichest@gmail.com> <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
 <Z4ZRYMf_uJW4poW9@eichest-laptop> <Z4dy3LiEAQ_gkQGG@eichest-laptop>
In-Reply-To: <Z4dy3LiEAQ_gkQGG@eichest-laptop>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 15 Jan 2025 17:14:09 +0800
X-Gm-Features: AbW1kvbGmYmFi47HyTpnehrf6vLaFKFPTfU5SSwIThsPUsGc6UrAlSPVPKgHKy4
Message-ID: <CAA+D8AO75MLyP5AWDJoogw8ae4GRtZfSR-HT+S26bXoaVs8saQ@mail.gmail.com>
Subject: Re: [PATCH v1] clk: imx: imx8-acm: fix flags for acm clocks
To: Stefan Eichenberger <eichest@gmail.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@nxp.com, 
	francesco.dolcini@toradex.com, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 4:33=E2=80=AFPM Stefan Eichenberger <eichest@gmail.=
com> wrote:
>
> Hi Shengjiu Wang,
>
> On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger wrote:
> > Hi Shengjiu Wang,
> >
> > On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> > > On Mon, Jan 13, 2025 at 5:54=E2=80=AFPM Stefan Eichenberger <eichest@=
gmail.com> wrote:
> > > >
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > >
> > > > Currently, the flags for the ACM clocks are set to 0. This configur=
ation
> > > > causes the fsl-sai audio driver to fail when attempting to set the
> > > > sysclk, returning an EINVAL error. The following error messages
> > > > highlight the issue:
> > > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 5909=
0000.sai: -22
> > > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > >
> > > The reason for this error is that the current clock parent can't
> > > support the rate
> > > you require (I think you want 11289600).
> > >
> > > We can configure the dts to provide such source, for example:
> > >
> > >  &sai5 {
> > > +       assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>=
,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_=
BUS>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_=
BUS>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>=
,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_=
BUS>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_=
BUS>,
> > > +                       <&sai5_lpcg 0>;
> > > +       assigned-clock-parents =3D <&aud_pll_div0_lpcg 0>, <&aud_rec1=
_lpcg 0>;
> > > +       assigned-clock-rates =3D <0>, <0>, <786432000>, <49152000>, <=
12288000>,
> > > +                                <722534400>, <45158400>, <11289600>,
> > > +                               <49152000>;
> > >         status =3D "okay";
> > >  };
> > >
> > > Then your case should work.
> > >
> > > >
> > > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the AC=
M
> > >
> > > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which will c=
ause
> > > the driver don't get an error from clk_set_rate().
> >
> > Thanks for the proposal, I will try it out tomorrow. Isn't this a
> > problem if other SAIs use the same clock source but with different
> > rates?
> >
> > If we have to define fixed rates in the DTS or else the clock driver
> > will return an error, isn't that a problem? Maybe I should change the
> > sai driver so that it ignores the failure and just takes the rate
> > configured? In the end audio works, even if it can't set the requested
> > rate.
>
> The following clock tree change would allow the driver to work
> in our scenario:
> &sai5 {
>         assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
>                           <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>;
>         assigned-clock-parents =3D <&aud_pll_div1_lpcg 0>;
>         assigned-clock-rates =3D <0>, <11289600>;
> };

In which we configure PLL_0 for 48KHz series (8kHz/16kHz/32kHz/48kHz),
PLL_1 for 44kHz series (11kHz/22kHz/44kHz),
which should fit for most audio requirements.

>
> However, this means we have to switch the parent clock to the audio pll
> 1. For the simple setup with two SAIs, one for analog audio and one for
> HDMI this wouldn't be a problem. But I'm not sure if this is a good
> solution if a customer would add a third SAI which requires again a
> different parent clock rate.

We won't change the PLL's rate in the driver,  so as PLL_0 for 48kHz,
PLL_1 for 44kHz,  even with a third SAI or more,  they should work.

>
> One potential solution could be that the SAI driver tries to first
> derive the clock from the current parent and only if this fails it tries
> to modify its parent clock. What do you think about this solution?
>

It's better to avoid modifying parent rate, as drivers don't know if the pa=
rent
is used by another instance.

Best regards
Shengjiu Wang

