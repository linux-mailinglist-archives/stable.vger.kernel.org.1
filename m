Return-Path: <stable+bounces-109206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A06CA131D8
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 05:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9491188771E
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 04:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F417D07D;
	Thu, 16 Jan 2025 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTZRKM17"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA44C81;
	Thu, 16 Jan 2025 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737000089; cv=none; b=AWjAj5Mof4bj3WBYV0MCN2hkeNXZz800pgG4JRRc/zxAebYUgNshhN5WuAszY9enJ/mNF+Ss52lU2yltyU1SB0RPNx36da5566tZdcx/DXTBzD2byCXLpuBnE4RYYx/Opz+ji7AsMFh7ByHS3AmjRePMv4o83EAjZ4WavwQSPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737000089; c=relaxed/simple;
	bh=t3x2c8yD8TamSxAoUDt4VHvIAH2qKQef+BxbaMcI5bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSyD8qbD6k3k3zx5aunr4G2cgHNMDUptaNcZCZJxjUZcoa+U3m/tvCpmTTNWUABh2u2H8Xls1IoDUg/rLiZG9IKJ7KBK2sRpiNWcOmF29l1LXhzapB08uJq1tiE9vQCAPKtalEYnoKF/2+Jevi58SzudSm34K0ltiHL6EZW4x7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTZRKM17; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce868498d3so1870225ab.3;
        Wed, 15 Jan 2025 20:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737000086; x=1737604886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9M4SyKYooW3q4Dei0iCf9xE9Hjb2tN9dOmHlNyoAFI=;
        b=RTZRKM17GIWLQmYG+r/Mo06H/MMfbycSaUdYV1AyBJylGGXUvUd2VXxJiQG9wF7m8Q
         VwgCgbetfZ6Mh13OPvqUMMyz384oOwqi0wJkCbRwdPaDlN1T94BKCqSLTbGRFbJ9KNFm
         thIpFFdYWNiM/OzwSHiVTMXpHAJK8GhAWO04iO8iuBRIBX3xHYiz6hftC9su+SMxveTq
         DPEScMbj+FycPVZP2jM1YQTxbjeJniWxPyAWo8bGCEE9ssK9SRuTllBP6vJKJJx2nltQ
         D916i0/2fzY5fwy5PsTzD1aOtSkpP+IAyhl1Lj9zEFVIPviiqLcXlcmr3Aqlg8STaRoo
         7hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737000086; x=1737604886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9M4SyKYooW3q4Dei0iCf9xE9Hjb2tN9dOmHlNyoAFI=;
        b=c+GXQS++dYYIbG/b99LENPrlYx+M7Uwss4SSxwVEeT22tdoRVbiTEd72JKx5MdCd/Y
         4V/pLduMqUNIjjh8pUJQ4e6WYzOxXSRPsnLfZKKfQ62WfBEd6POpDR9JBiQV2ybphrfC
         /hEyG7wApgMWgIuvrzVlAh9O2X1gHrNxOCiyrLUXN/nBkNwxxInqyMnQHwlMeybNJrnO
         E1K9eGGHckIV1i9wp62WWFwP0ZEtU+JekSgKOYCISwyT+UKli+8u82bNfKdrVNoqxgx9
         qVgp5jUo3Xl+svVJOZJtdMFyWmR8GmZoo0lWfSzDU3xTItERN0mut9hoGSDH1gEwEI9J
         xoeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0fp0FjDAmH0+pv/payDLdwjF5j24PNDa42kIlqDBsZBxVpXYTb8zyivS9pgFl/1WexlRjpWZ4@vger.kernel.org, AJvYcCV22oh0fPI+EA5jObkEV0ZH9wqq23Ty0xjLL3olbhb5WaSWucSWNi8uWF+UokDIe6Kq2MSvmdeKbdmvJaKs@vger.kernel.org, AJvYcCXElQt/dCvHd9T2uGx0NUg02NhDkuD+AAAoxEmP0ePBv9/lkmzLvXl/B95J1uOxcp2QsiK+zjmtgqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMaDBKpj/sjFPAh8nmTLE764QTROu/I4jHNN+ohncdIOVUOmU
	tq5yUqwZ2/mkgnDgQgJ0L036JbY+xfhUpOby+apUQ1VkPVrF4325FJEqCl99OmD4pBPGOjXbByQ
	eiK2+YyLpwEOq+BF6e+0yHHZ8XTY=
X-Gm-Gg: ASbGnctu0gNj2qUhLh5y5cM0MOo3jyLjbwD1cEEY/ucUkO8fmBeuBwikC2isTRCu4nR
	5iyqzP2pAJ7Z3CCnmBwvB9oYVxbb2HQdaDmDaIg==
X-Google-Smtp-Source: AGHT+IHQyfRw5kKg9ivPpFGOXhquLee3vQrmRPw5XCpd5KhNgurc5hPjzNgvG44Ia/WHmiwvSs0BEBCDTkY0jsl8GJw=
X-Received: by 2002:a05:6e02:198a:b0:3ce:8cd1:f671 with SMTP id
 e9e14a558f8ab-3ce8cd1f9b5mr42766315ab.21.1737000086327; Wed, 15 Jan 2025
 20:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113094654.12998-1-eichest@gmail.com> <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
 <Z4ZRYMf_uJW4poW9@eichest-laptop> <Z4dy3LiEAQ_gkQGG@eichest-laptop>
 <CAA+D8AO75MLyP5AWDJoogw8ae4GRtZfSR-HT+S26bXoaVs8saQ@mail.gmail.com> <Z4eQX_VnBEVqxT_r@eichest-laptop>
In-Reply-To: <Z4eQX_VnBEVqxT_r@eichest-laptop>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 16 Jan 2025 12:01:13 +0800
X-Gm-Features: AbW1kvbQkp5AqMkITUkxczD4Jz0nXSdjZCCO560XBpLCP-4-Hn1eL6UeOWJMsWo
Message-ID: <CAA+D8APivJWD-AqwmQ-mtcr=ZHot5rfA8FRWF2+p-_mq5BGxHA@mail.gmail.com>
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

On Wed, Jan 15, 2025 at 6:39=E2=80=AFPM Stefan Eichenberger <eichest@gmail.=
com> wrote:
>
> On Wed, Jan 15, 2025 at 05:14:09PM +0800, Shengjiu Wang wrote:
> > On Wed, Jan 15, 2025 at 4:33=E2=80=AFPM Stefan Eichenberger <eichest@gm=
ail.com> wrote:
> > >
> > > Hi Shengjiu Wang,
> > >
> > > On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger wrote:
> > > > Hi Shengjiu Wang,
> > > >
> > > > On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> > > > > On Mon, Jan 13, 2025 at 5:54=E2=80=AFPM Stefan Eichenberger <eich=
est@gmail.com> wrote:
> > > > > >
> > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > >
> > > > > > Currently, the flags for the ACM clocks are set to 0. This conf=
iguration
> > > > > > causes the fsl-sai audio driver to fail when attempting to set =
the
> > > > > > sysclk, returning an EINVAL error. The following error messages
> > > > > > highlight the issue:
> > > > > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on =
59090000.sai: -22
> > > > > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > > > >
> > > > > The reason for this error is that the current clock parent can't
> > > > > support the rate
> > > > > you require (I think you want 11289600).
> > > > >
> > > > > We can configure the dts to provide such source, for example:
> > > > >
> > > > >  &sai5 {
> > > > > +       assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_=
PLL>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_=
SLV_BUS>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_=
MST_BUS>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_=
PLL>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_=
SLV_BUS>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_=
MST_BUS>,
> > > > > +                       <&sai5_lpcg 0>;
> > > > > +       assigned-clock-parents =3D <&aud_pll_div0_lpcg 0>, <&aud_=
rec1_lpcg 0>;
> > > > > +       assigned-clock-rates =3D <0>, <0>, <786432000>, <49152000=
>, <12288000>,
> > > > > +                                <722534400>, <45158400>, <112896=
00>,
> > > > > +                               <49152000>;
> > > > >         status =3D "okay";
> > > > >  };
> > > > >
> > > > > Then your case should work.
> > > > >
> > > > > >
> > > > > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that th=
e ACM
> > > > >
> > > > > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which wi=
ll cause
> > > > > the driver don't get an error from clk_set_rate().
> > > >
> > > > Thanks for the proposal, I will try it out tomorrow. Isn't this a
> > > > problem if other SAIs use the same clock source but with different
> > > > rates?
> > > >
> > > > If we have to define fixed rates in the DTS or else the clock drive=
r
> > > > will return an error, isn't that a problem? Maybe I should change t=
he
> > > > sai driver so that it ignores the failure and just takes the rate
> > > > configured? In the end audio works, even if it can't set the reques=
ted
> > > > rate.
> > >
> > > The following clock tree change would allow the driver to work
> > > in our scenario:
> > > &sai5 {
> > >         assigned-clocks =3D <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > >                           <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PL=
L>;
> > >         assigned-clock-parents =3D <&aud_pll_div1_lpcg 0>;
> > >         assigned-clock-rates =3D <0>, <11289600>;
> > > };
> >
> > In which we configure PLL_0 for 48KHz series (8kHz/16kHz/32kHz/48kHz),
> > PLL_1 for 44kHz series (11kHz/22kHz/44kHz),
> > which should fit for most audio requirements.
> >
> > >
> > > However, this means we have to switch the parent clock to the audio p=
ll
> > > 1. For the simple setup with two SAIs, one for analog audio and one f=
or
> > > HDMI this wouldn't be a problem. But I'm not sure if this is a good
> > > solution if a customer would add a third SAI which requires again a
> > > different parent clock rate.
> >
> > We won't change the PLL's rate in the driver,  so as PLL_0 for 48kHz,
> > PLL_1 for 44kHz,  even with a third SAI or more,  they should work.
> >
> > >
> > > One potential solution could be that the SAI driver tries to first
> > > derive the clock from the current parent and only if this fails it tr=
ies
> > > to modify its parent clock. What do you think about this solution?
> > >
>
> I did some more testing and I'm still not happy with the current
> solution. The problem is that if we change the SAI5 mclk clock parent it
> can either support the 44kHz series or the 48kHz series. However, in the
> case of HDMI we do not know in advance what the user wants.
>
> This means when testing either this works:
> speaker-test -D hw:2,0 -r 48000 -c 2
> or this works:
> speaker-test -D hw:2,0 -r 44100 -c 2
> With:
> card 2: imxaudiohdmitx [imx-audio-hdmi-tx], device 0: i.MX HDMI i2s-hifi-=
0 [i.MX HDMI i2s-hifi-0]

Are you using the setting below?  then should not either,  should both work=
s
 &sai5 {
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
        status =3D "okay";
 };

best regards
Shengjiu Wang
>
> If I on the other hand avoid that fsl_sai_set_mclk_rate is called by
> patching imx-hdmi.c. I can make both rates work with the standard clock
> settings. So I wonder if calling snd_soc_dai_set_sysclk is really
> necessary for the i.MX8?
> diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
> index f9cec6f0aecd..7d8aa58645b7 100644
> --- a/sound/soc/fsl/imx-hdmi.c
> +++ b/sound/soc/fsl/imx-hdmi.c
> @@ -92,15 +92,6 @@ static int imx_hdmi_hw_params(struct snd_pcm_substream=
 *substream,
>         u32 slot_width =3D data->cpu_priv.slot_width;
>         int ret;
>
> -       /* MCLK always is (256 or 192) * rate. */
> -       ret =3D snd_soc_dai_set_sysclk(cpu_dai, data->cpu_priv.sysclk_id[=
tx],
> -                                    8 * slot_width * params_rate(params)=
,
> -                                    tx ? SND_SOC_CLOCK_OUT : SND_SOC_CLO=
CK_IN);
> -       if (ret && ret !=3D -ENOTSUPP) {
> -               dev_err(dev, "failed to set cpu sysclk: %d\n", ret);
> -               return ret;
> -       }
> -
>         ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0, 2, slot_width);
>         if (ret && ret !=3D -ENOTSUPP) {
>                 dev_err(dev, "failed to set cpu dai tdm slot: %d\n", ret)=
;
>
> Regards,
> Stefan
>
>

