Return-Path: <stable+bounces-109221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FBA133F5
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 08:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178933A0134
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F141A8F95;
	Thu, 16 Jan 2025 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YftAFy6p"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3541AB531;
	Thu, 16 Jan 2025 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012671; cv=none; b=CuaiNrEVYbqa9cibzIrGiO6iyHNaSnWdu81bZnJ+xpQq0ex6uxKvHov0WFtvAniJzR6KBmv7od8vcxLV5C8vl88c/Km//8NxXKy2E7Re0qRkAz3uW5iYwj55DoO71EJezzYPZ+sIjoU0U6uqpeVomBqqiuegITXY89ULBqu/irk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012671; c=relaxed/simple;
	bh=N4CTZPhh7SYMQpI3xkNGDWxExoBcXjQWr5wcyiutEaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qc8hinHC3DuHCTbDDobUmT7H4hteXUehoRoO8ZgRdG4+RCr2eOC9D+Kzr2hacnKr9R51k84MJ9fkXziBrcxkAS4J665/jO3JSUNY0dqS8FwUMpV2Lun5HsQ81xUfFIM0qdhQWcgUjZCgHgLRKhtxyEtJGmS2+O5bBl8Xjh/mFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YftAFy6p; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so4368345ab.2;
        Wed, 15 Jan 2025 23:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737012669; x=1737617469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMJuqVP9xZ6e824fp9u5ndERb9mrfeYm7csKDRij//w=;
        b=YftAFy6pZWVNuNj84kOpG05v6cUFZFzlHfZgLL/T+U117U0IBt/7JGktCEcf8N8R+W
         dkHrj47q3DT2ZkRwmOu7JQyQf2VwoSjJYj2bagJ84bhOAV0vjzJneX/wNoAC7fbuLSo2
         ZmZTqpk+A7oZnTPhU04H0EigHtioYh9mSgJ/eze3WOLFlG/Bl67i0yQGxz5CUjNRSOPr
         HFCRwhh/mdRBPy/jf/5vULaoWqF/OunIb1rBt57VDQkANLXjZzlGY+rqGTmsNVfGUADv
         V51Ta6mAqpe9qbYIrzqv5WDGdT9buBR7mmDKDzfIO/HFlWDlSwzvLYnMGtB3KlEPAlLV
         U3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737012669; x=1737617469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMJuqVP9xZ6e824fp9u5ndERb9mrfeYm7csKDRij//w=;
        b=sp821Aq7u6td59hp3ZyBmwOwISUIy2ZPd85LHnDqT+rqk9YHcbcnR0mPqlIX+V7282
         uFovUXdt7hu0vVwON21hrU5EqWtDDI26kRbsS0XyATUxA47nAnuGCBzbSjn1Oh4IyBtp
         eEHP7EG9Z/bo6pqaNHin4v9uIL4pSrRMs5+wanj29TwIOVwWBQr9qxGqIQ8Q3h8qZZUM
         tXp0CcpuBsweEd8YjN1Ifcu5z7c5Hg3AK9xbqiDrNYJE/uPqmaWISbAPI5jaqmByQb1B
         APoQm7Wt5u5kOMU14cOyd0/pMqR31EW8kzAqB1PQxrmQw4gbNePB4cylQGqMeSoCd8DW
         +6hw==
X-Forwarded-Encrypted: i=1; AJvYcCVSfbynEsQbV5V9vYgPV8dqxJAnRH1NqlXxHbHEwa81Dwwr2DhMO/x9zquJZ2xGcGrml0wB57CfLWP1L+Lv@vger.kernel.org, AJvYcCW/uI3jZVZFA5lm4r9qnHyDAUPbWfhDdPfvbKEE+WYvi1FiVtT/1+bEgokFdfe0mBYKD2vSGY3D@vger.kernel.org, AJvYcCXYqDECM+frXTg3TqalX0Frj5HBRHYrwQvPNVA/HRIbrCg3b+DSax7KblqevFF75G+SqHtCr7y5+Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNRA02XJekU2Bg67Z2p8te+SWip2y0dhsojXTqCRjjr/yuJHf
	HQikGFyv+hyWn0CvZhWFSsZJCuQkfKhAhoDxzRdCjoQPPrKDTsNZ9Y5RItDDQUp2f+i8Q9f7McE
	LPywlT2FQWShMbMtrrww2rMOmgUo=
X-Gm-Gg: ASbGncseO4ew/8rS5QwOXOGoCYFTv9G7daBdOWYbNim/x3pwaZCvVxVY/0WD83NLbSy
	B2RnUqPPCGT552jYoN1jaKsEcFQCQALv+7PviMA==
X-Google-Smtp-Source: AGHT+IF1ff9iGSm6xVezEjJOvE+/T2WhT+6/CMhCEb6PEQNtT4EoujG5Cy/nW1Q6k5jX4nnbRMzMBCjMXcEqUJNCrm4=
X-Received: by 2002:a05:6e02:1d11:b0:3ce:7f88:1f50 with SMTP id
 e9e14a558f8ab-3ce7f88218bmr82643225ab.2.1737012668468; Wed, 15 Jan 2025
 23:31:08 -0800 (PST)
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
 <Z4i0G5Tw4q0v8DTL@eichest-laptop>
In-Reply-To: <Z4i0G5Tw4q0v8DTL@eichest-laptop>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 16 Jan 2025 15:30:55 +0800
X-Gm-Features: AbW1kvaGTG5piw6TJpqkEDtHRmvjOo9HK905H8DjWClafLXjlYSC7QR9I0a9tm8
Message-ID: <CAA+D8AOakQdnEe9ZrfTCrWcjHJRRU0kqFVsiu8+FMiHeMAVV_g@mail.gmail.com>
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

On Thu, Jan 16, 2025 at 3:24=E2=80=AFPM Stefan Eichenberger <eichest@gmail.=
com> wrote:
>
> Hi Shengjiu Wang,
>
> On Thu, Jan 16, 2025 at 12:01:13PM +0800, Shengjiu Wang wrote:
> > On Wed, Jan 15, 2025 at 6:39=E2=80=AFPM Stefan Eichenberger <eichest@gm=
ail.com> wrote:
> > >
> > > On Wed, Jan 15, 2025 at 05:14:09PM +0800, Shengjiu Wang wrote:
> > > > On Wed, Jan 15, 2025 at 4:33=E2=80=AFPM Stefan Eichenberger <eiches=
t@gmail.com> wrote:
> > > > >
> > > > > Hi Shengjiu Wang,
> > > > >
> > > > > On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger wro=
te:
> > > > > > Hi Shengjiu Wang,
> > > > > >
> > > > > > On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> > > > > > > On Mon, Jan 13, 2025 at 5:54=E2=80=AFPM Stefan Eichenberger <=
eichest@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > > > >
> > > > > > > > Currently, the flags for the ACM clocks are set to 0. This =
configuration
> > > > > > > > causes the fsl-sai audio driver to fail when attempting to =
set the
> > > > > > > > sysclk, returning an EINVAL error. The following error mess=
ages
> > > > > > > > highlight the issue:
> > > > > > > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk=
 on 59090000.sai: -22
> > > > > > > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > > > > > >
> > > > > > > The reason for this error is that the current clock parent ca=
n't
> > > > > > > support the rate
> > > > > > > you require (I think you want 11289600).
> > > > > > >
> > > > > > > We can configure the dts to provide such source, for example:
> > > > > > >
> > > > > > >  &sai5 {
> > > > > > > +       assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>=
,
> > > > > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_=
CLK_PLL>,
> > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_=
CLK_SLV_BUS>,
> > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_=
CLK_MST_BUS>,
> > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_=
CLK_PLL>,
> > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_=
CLK_SLV_BUS>,
> > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_=
CLK_MST_BUS>,
> > > > > > > +                       <&sai5_lpcg 0>;
> > > > > > > +       assigned-clock-parents =3D <&aud_pll_div0_lpcg 0>, <&=
aud_rec1_lpcg 0>;
> > > > > > > +       assigned-clock-rates =3D <0>, <0>, <786432000>, <4915=
2000>, <12288000>,
> > > > > > > +                                <722534400>, <45158400>, <11=
289600>,
> > > > > > > +                               <49152000>;
> > > > > > >         status =3D "okay";
> > > > > > >  };
> > > > > > >
> > > > > > > Then your case should work.
> > > > > > >
> > > > > > > >
> > > > > > > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal tha=
t the ACM
> > > > > > >
> > > > > > > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. whic=
h will cause
> > > > > > > the driver don't get an error from clk_set_rate().
> > > > > >
> > > > > > Thanks for the proposal, I will try it out tomorrow. Isn't this=
 a
> > > > > > problem if other SAIs use the same clock source but with differ=
ent
> > > > > > rates?
> > > > > >
> > > > > > If we have to define fixed rates in the DTS or else the clock d=
river
> > > > > > will return an error, isn't that a problem? Maybe I should chan=
ge the
> > > > > > sai driver so that it ignores the failure and just takes the ra=
te
> > > > > > configured? In the end audio works, even if it can't set the re=
quested
> > > > > > rate.
> > > > >
> > > > > The following clock tree change would allow the driver to work
> > > > > in our scenario:
> > > > > &sai5 {
> > > > >         assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > >                           <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CL=
K_PLL>;
> > > > >         assigned-clock-parents =3D <&aud_pll_div1_lpcg 0>;
> > > > >         assigned-clock-rates =3D <0>, <11289600>;
> > > > > };
> > > >
> > > > In which we configure PLL_0 for 48KHz series (8kHz/16kHz/32kHz/48kH=
z),
> > > > PLL_1 for 44kHz series (11kHz/22kHz/44kHz),
> > > > which should fit for most audio requirements.
> > > >
> > > > >
> > > > > However, this means we have to switch the parent clock to the aud=
io pll
> > > > > 1. For the simple setup with two SAIs, one for analog audio and o=
ne for
> > > > > HDMI this wouldn't be a problem. But I'm not sure if this is a go=
od
> > > > > solution if a customer would add a third SAI which requires again=
 a
> > > > > different parent clock rate.
> > > >
> > > > We won't change the PLL's rate in the driver,  so as PLL_0 for 48kH=
z,
> > > > PLL_1 for 44kHz,  even with a third SAI or more,  they should work.
> > > >
> > > > >
> > > > > One potential solution could be that the SAI driver tries to firs=
t
> > > > > derive the clock from the current parent and only if this fails i=
t tries
> > > > > to modify its parent clock. What do you think about this solution=
?
> > > > >
> > >
> > > I did some more testing and I'm still not happy with the current
> > > solution. The problem is that if we change the SAI5 mclk clock parent=
 it
> > > can either support the 44kHz series or the 48kHz series. However, in =
the
> > > case of HDMI we do not know in advance what the user wants.
> > >
> > > This means when testing either this works:
> > > speaker-test -D hw:2,0 -r 48000 -c 2
> > > or this works:
> > > speaker-test -D hw:2,0 -r 44100 -c 2
> > > With:
> > > card 2: imxaudiohdmitx [imx-audio-hdmi-tx], device 0: i.MX HDMI i2s-h=
ifi-0 [i.MX HDMI i2s-hifi-0]
> >
> > Are you using the setting below?  then should not either,  should both =
works
> >  &sai5 {
> > +       assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BU=
S>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BU=
S>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BU=
S>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BU=
S>,
> > +                       <&sai5_lpcg 0>;
> > +       assigned-clock-parents =3D <&aud_pll_div0_lpcg 0>, <&aud_rec1_l=
pcg 0>;
> > +       assigned-clock-rates =3D <0>, <0>, <786432000>, <49152000>, <12=
288000>,
> > +                                <722534400>, <45158400>, <11289600>,
> > +                               <49152000>;
> >         status =3D "okay";
> >  };
>
> Sorry I didn't communicate that properly. Yes I was trying with these
> settings but they do not work. The problem does not seem to be that the
> driver can not adjust the rate for the audio (so e.g. 44kHz or 48kHz)
> but that snd_soc_dai_set_sysclk in imx-hdmi.c fails with EINVAL. This
> results in a call to fsl_sai_set_mclk_rate in fsl_sai.c with clk_id 1
> (mclk_clk[1]) and a freq of 11289600 which causes the fail.
> Interestingly, in fsl_sai_set_bclk we then only use clk_get_rate on
> mclk_clk[0] which is set to audio_ipg_clk (rate 175000000) and we do not
> use mclk_clk[1] anymore at all. This is why I'm not sure if this call to
> snd_soc_dai_set_syclk is really necessary?
>

Could you please check if you have the below commit in your test tree?
35121e9def07 clk: imx: imx8: Use clk_hw pointer for self registered
clock in clk_parent_data

if not, please cherry-pick it.

The audio_ipg_clk can be selected if there is no other choice.
but the rate 175000000 is not accurate for 44kHz. what we got
is 44102Hz. This is the reason I don't like to use this source.

best regards
Shengjiu Wang

