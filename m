Return-Path: <stable+bounces-109334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05586A149DF
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 07:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B660188D70D
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 06:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25251F78E3;
	Fri, 17 Jan 2025 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LShdQKrw"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2D1F75A6;
	Fri, 17 Jan 2025 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737096992; cv=none; b=dAWGaKr57XhAOdOCbkgEfAmFE8JU6iZ8c4UFGWN1j/PEs8FwXXXiiBJSanP3WflVt2QnJkoRKgZg3m/YaedQdD5Psl1aVzMLJ6JFrDXuYYjwZQnZgG9wxIe/HD1jMbyb37A66V3R5DelOpXSTgMek7W96MJMHKM1uKWGVIurnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737096992; c=relaxed/simple;
	bh=6NJY+dMgU534blJWmgk2BR5CWDLguT8XUkGUOeqMuZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmaPUHbEN+Wx1WvR8PwTnDo4/rcLpTuBTVWfYKxAizhsOzeOGVmx80RqiewdP9fWv1Bh6y1mEXIkN9dU4VveL5d8QdkObD5m2xiSIKjcuFKu0QhyZLGbKQSCRNICkaIHg+JS3QWN+oWfAmztfXjmC+EdJc/YjtJip7HSNI6n5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LShdQKrw; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce87d31480so6815585ab.2;
        Thu, 16 Jan 2025 22:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737096990; x=1737701790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3hRdY4ybGQZXWv8/ibzifjG0ONmXDf3+lS8nO2D8vQ=;
        b=LShdQKrwSa8GnK1nV2cb+M/Dp7Y0KcaS3Tj3IQejchFXr+uzovtkL6DZ3BqXeC6HbX
         aYq+3y6xbgZy8MMAon54Bzt12tFgxML/uIdP1+QuJjdOHa8i3ftbL67noDO64pRdEEeP
         6ZyffEzYRqVtLCbLK6+p7JVYIEQRGeSEMox3P3XnwpdCR/m8rDCBXkapVCTHelOOWVcH
         c208Vh5IKxS1hxWt6aZBhOg6LP6U0Ew7MqSqwI2pgXdit0koZc2UpZTQx/Xr2XWEQL74
         s3HTbeQw18Qz7a161HBl6CCCZWBf2lUnPYuCPxarLFpcKFG7Y0CrJ6ihqB37Q7Jq/vig
         GAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737096990; x=1737701790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3hRdY4ybGQZXWv8/ibzifjG0ONmXDf3+lS8nO2D8vQ=;
        b=j7GKldCSSaD1g/rQDaqdQF0IoW5gwN7XC4SXR2ty3nEQa106IfpeW5uxDCYLNejrIw
         vgsSKfCqpCgzNVe7qeLmZ61qbA9sIfKDL8a3D1mOZU0DNiOYKfTah8gO1mhj00QExUng
         CBQSDIFq61MKsMg/IAAfi8KSVJuafU8V1AW+uxhpVKmWJ/AzzzRQtEJqPGeUHJ2C6KGh
         n+Ue3I/QtM7FaBvqxHZffhMJHu2n1zb3coZZWC+sDusO4raIj3vtYTiWWaKTckILOaR3
         q3PRcpcIEDCcRPY9e9VhPFzUDogRjn1Nl4WtyYBo8JKHaANhrURLoAsOx1Yt9GIXHfMW
         /anQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwj8Vi47m9iLVC2+PfhGvJ589Wvc0Tdo/+vT0nBs5HBdL6b3QVNK2TML3goPBgxfUPHggQv03brbj/PBgt@vger.kernel.org, AJvYcCX8MT2R/YNuZ7USUYHKpU0WsZRPQVq68z5L5Qj1q2Enbfc4TL6cZuOEW4C1+bin7o3i1YifA7klROc=@vger.kernel.org, AJvYcCXN8J7xOORvNatZecubAfMbq89m443L9ZSIIc9BrAaO38mCPaKYxzhloTeRgsTpiDScLOGLYp1s@vger.kernel.org
X-Gm-Message-State: AOJu0YwF3PnYB5/FxmEq/rrabUaFwAoKw8dulNPzR4T8oczVJa5t8K9e
	JUjHowBYC/VL7mSLUssKPq/oLv5hs4KzUNJdbM+OjIm65I8vHKztTk+7pEu+iwDl1HmbMlkcV5d
	oZrdFrwLJf7cKUJLAoOSmQJHKXww=
X-Gm-Gg: ASbGncvR48bR+7Kiwht4Ue79vlGwH1M3405aczF/b5+izDg2zmxFcx8V5cgz1ThNWAN
	TnfzL4ZrL3aV/VvbZ0aVwQF+O32NuE/55ZA9XVQ==
X-Google-Smtp-Source: AGHT+IHcknrvKPRacXTQ4IOEOcVDoZlmeewl4EHr/jAukgg4Kg4r7OXIb6t6lnm52Zq3vEqrHYl9Godl41t3Q1WTwXA=
X-Received: by 2002:a05:6e02:2607:b0:3ce:8e89:90db with SMTP id
 e9e14a558f8ab-3cf7447b9c6mr10583865ab.14.1737096989650; Thu, 16 Jan 2025
 22:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113094654.12998-1-eichest@gmail.com> <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
 <Z4ZRYMf_uJW4poW9@eichest-laptop> <Z4dy3LiEAQ_gkQGG@eichest-laptop>
 <CAA+D8AO75MLyP5AWDJoogw8ae4GRtZfSR-HT+S26bXoaVs8saQ@mail.gmail.com>
 <Z4eQX_VnBEVqxT_r@eichest-laptop> <CAA+D8APivJWD-AqwmQ-mtcr=ZHot5rfA8FRWF2+p-_mq5BGxHA@mail.gmail.com>
 <Z4i0G5Tw4q0v8DTL@eichest-laptop> <CAA+D8AOakQdnEe9ZrfTCrWcjHJRRU0kqFVsiu8+FMiHeMAVV_g@mail.gmail.com>
 <Z4lDbMqCYW2W7iyX@eichest-laptop>
In-Reply-To: <Z4lDbMqCYW2W7iyX@eichest-laptop>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 17 Jan 2025 14:56:15 +0800
X-Gm-Features: AbW1kvY8ZuJTUqrf1ZEzfzgYRxjyAcbIRbeiu-ak5g16dpFU5gdubE8mulJFk6c
Message-ID: <CAA+D8AM9xwvyvU_0ODFwaq=YzzbP_R7hqMvHqx-Y1kHPpX_x_Q@mail.gmail.com>
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

On Fri, Jan 17, 2025 at 1:35=E2=80=AFAM Stefan Eichenberger <eichest@gmail.=
com> wrote:
>
> Hi Shengjiu Wang,
>
> On Thu, Jan 16, 2025 at 03:30:55PM +0800, Shengjiu Wang wrote:
> > On Thu, Jan 16, 2025 at 3:24=E2=80=AFPM Stefan Eichenberger <eichest@gm=
ail.com> wrote:
> > >
> > > Hi Shengjiu Wang,
> > >
> > > On Thu, Jan 16, 2025 at 12:01:13PM +0800, Shengjiu Wang wrote:
> > > > On Wed, Jan 15, 2025 at 6:39=E2=80=AFPM Stefan Eichenberger <eiches=
t@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jan 15, 2025 at 05:14:09PM +0800, Shengjiu Wang wrote:
> > > > > > On Wed, Jan 15, 2025 at 4:33=E2=80=AFPM Stefan Eichenberger <ei=
chest@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Shengjiu Wang,
> > > > > > >
> > > > > > > On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger=
 wrote:
> > > > > > > > Hi Shengjiu Wang,
> > > > > > > >
> > > > > > > > On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wro=
te:
> > > > > > > > > On Mon, Jan 13, 2025 at 5:54=E2=80=AFPM Stefan Eichenberg=
er <eichest@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.=
com>
> > > > > > > > > >
> > > > > > > > > > Currently, the flags for the ACM clocks are set to 0. T=
his configuration
> > > > > > > > > > causes the fsl-sai audio driver to fail when attempting=
 to set the
> > > > > > > > > > sysclk, returning an EINVAL error. The following error =
messages
> > > > > > > > > > highlight the issue:
> > > > > > > > > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sy=
sclk on 59090000.sai: -22
> > > > > > > > > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > > > > > > > >
> > > > > > > > > The reason for this error is that the current clock paren=
t can't
> > > > > > > > > support the rate
> > > > > > > > > you require (I think you want 11289600).
> > > > > > > > >
> > > > > > > > > We can configure the dts to provide such source, for exam=
ple:
> > > > > > > > >
> > > > > > > > >  &sai5 {
> > > > > > > > > +       assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_=
SEL>,
> > > > > > > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC=
_PM_CLK_PLL>,
> > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC=
_PM_CLK_SLV_BUS>,
> > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC=
_PM_CLK_MST_BUS>,
> > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC=
_PM_CLK_PLL>,
> > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC=
_PM_CLK_SLV_BUS>,
> > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC=
_PM_CLK_MST_BUS>,
> > > > > > > > > +                       <&sai5_lpcg 0>;
> > > > > > > > > +       assigned-clock-parents =3D <&aud_pll_div0_lpcg 0>=
, <&aud_rec1_lpcg 0>;
> > > > > > > > > +       assigned-clock-rates =3D <0>, <0>, <786432000>, <=
49152000>, <12288000>,
> > > > > > > > > +                                <722534400>, <45158400>,=
 <11289600>,
> > > > > > > > > +                               <49152000>;
> > > > > > > > >         status =3D "okay";
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > Then your case should work.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal=
 that the ACM
> > > > > > > > >
> > > > > > > > > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. =
which will cause
> > > > > > > > > the driver don't get an error from clk_set_rate().
> > > > > > > >
> > > > > > > > Thanks for the proposal, I will try it out tomorrow. Isn't =
this a
> > > > > > > > problem if other SAIs use the same clock source but with di=
fferent
> > > > > > > > rates?
> > > > > > > >
> > > > > > > > If we have to define fixed rates in the DTS or else the clo=
ck driver
> > > > > > > > will return an error, isn't that a problem? Maybe I should =
change the
> > > > > > > > sai driver so that it ignores the failure and just takes th=
e rate
> > > > > > > > configured? In the end audio works, even if it can't set th=
e requested
> > > > > > > > rate.
> > > > > > >
> > > > > > > The following clock tree change would allow the driver to wor=
k
> > > > > > > in our scenario:
> > > > > > > &sai5 {
> > > > > > >         assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>=
,
> > > > > > >                           <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_P=
M_CLK_PLL>;
> > > > > > >         assigned-clock-parents =3D <&aud_pll_div1_lpcg 0>;
> > > > > > >         assigned-clock-rates =3D <0>, <11289600>;
> > > > > > > };
> > > > > >
> > > > > > In which we configure PLL_0 for 48KHz series (8kHz/16kHz/32kHz/=
48kHz),
> > > > > > PLL_1 for 44kHz series (11kHz/22kHz/44kHz),
> > > > > > which should fit for most audio requirements.
> > > > > >
> > > > > > >
> > > > > > > However, this means we have to switch the parent clock to the=
 audio pll
> > > > > > > 1. For the simple setup with two SAIs, one for analog audio a=
nd one for
> > > > > > > HDMI this wouldn't be a problem. But I'm not sure if this is =
a good
> > > > > > > solution if a customer would add a third SAI which requires a=
gain a
> > > > > > > different parent clock rate.
> > > > > >
> > > > > > We won't change the PLL's rate in the driver,  so as PLL_0 for =
48kHz,
> > > > > > PLL_1 for 44kHz,  even with a third SAI or more,  they should w=
ork.
> > > > > >
> > > > > > >
> > > > > > > One potential solution could be that the SAI driver tries to =
first
> > > > > > > derive the clock from the current parent and only if this fai=
ls it tries
> > > > > > > to modify its parent clock. What do you think about this solu=
tion?
> > > > > > >
> > > > >
> > > > > I did some more testing and I'm still not happy with the current
> > > > > solution. The problem is that if we change the SAI5 mclk clock pa=
rent it
> > > > > can either support the 44kHz series or the 48kHz series. However,=
 in the
> > > > > case of HDMI we do not know in advance what the user wants.
> > > > >
> > > > > This means when testing either this works:
> > > > > speaker-test -D hw:2,0 -r 48000 -c 2
> > > > > or this works:
> > > > > speaker-test -D hw:2,0 -r 44100 -c 2
> > > > > With:
> > > > > card 2: imxaudiohdmitx [imx-audio-hdmi-tx], device 0: i.MX HDMI i=
2s-hifi-0 [i.MX HDMI i2s-hifi-0]
> > > >
> > > > Are you using the setting below?  then should not either,  should b=
oth works
> > > >  &sai5 {
> > > > +       assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PL=
L>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SL=
V_BUS>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MS=
T_BUS>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PL=
L>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SL=
V_BUS>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MS=
T_BUS>,
> > > > +                       <&sai5_lpcg 0>;
> > > > +       assigned-clock-parents =3D <&aud_pll_div0_lpcg 0>, <&aud_re=
c1_lpcg 0>;
> > > > +       assigned-clock-rates =3D <0>, <0>, <786432000>, <49152000>,=
 <12288000>,
> > > > +                                <722534400>, <45158400>, <11289600=
>,
> > > > +                               <49152000>;
> > > >         status =3D "okay";
> > > >  };
> > >
> > > Sorry I didn't communicate that properly. Yes I was trying with these
> > > settings but they do not work. The problem does not seem to be that t=
he
> > > driver can not adjust the rate for the audio (so e.g. 44kHz or 48kHz)
> > > but that snd_soc_dai_set_sysclk in imx-hdmi.c fails with EINVAL. This
> > > results in a call to fsl_sai_set_mclk_rate in fsl_sai.c with clk_id 1
> > > (mclk_clk[1]) and a freq of 11289600 which causes the fail.
> > > Interestingly, in fsl_sai_set_bclk we then only use clk_get_rate on
> > > mclk_clk[0] which is set to audio_ipg_clk (rate 175000000) and we do =
not
> > > use mclk_clk[1] anymore at all. This is why I'm not sure if this call=
 to
> > > snd_soc_dai_set_syclk is really necessary?
> > >
> >
> > Could you please check if you have the below commit in your test tree?
> > 35121e9def07 clk: imx: imx8: Use clk_hw pointer for self registered
> > clock in clk_parent_data
> >
> > if not, please cherry-pick it.
> >
> > The audio_ipg_clk can be selected if there is no other choice.
> > but the rate 175000000 is not accurate for 44kHz. what we got
> > is 44102Hz. This is the reason I don't like to use this source.
>
> Thanks a lot for the hint, in my test setup I indeed have not applied
> this commit. I tested it now with cherry-picking the commit and with
> applying the change to the dts. This made it work. I will do some more
> testing tomrrow and if I can't find any addtional issue I will use this
> as a solution.
>
I am thinking that your change may still be needed.

Your change plus the below change. then we can support more rate,
not only 48k/44kHz.  SAI driver will select the parent by itself before
the clk_set_rate().

+       assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+                       <&sai5_lpcg 0>;
+       assigned-clock-parents =3D <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg =
0>;
+       assigned-clock-rates =3D <0>, <0>, <786432000>, <49152000>, <122880=
00>,
+                                <722534400>, <45158400>, <11289600>,
+                               <49152000>;
+       clocks =3D <&sai5_lpcg 1>,
+               <&clk_dummy>,
+               <&sai5_lpcg 0>,
+               <&clk_dummy>,
+               <&clk_dummy>,
+               <&aud_pll_div0_lpcg 0>,
+               <&aud_pll_div1_lpcg 0>;
+       clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3",
"pll8k", "pll11k";

> Should I add the change to our Apalis board dtsi file or directly to
> imx8qm-ss-audio.dtsi? I think it fixes kind of a general issue or not?

It is still board related, so I think it is better to add to the board dts =
file.

Best regards
Shengjiu Wang

>
> Thanks for your support
> Stefan

