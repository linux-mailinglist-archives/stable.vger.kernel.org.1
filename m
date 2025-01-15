Return-Path: <stable+bounces-108721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17398A11FF6
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275F116272C
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FCE1E98ED;
	Wed, 15 Jan 2025 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOaAY4+V"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B41E98FD;
	Wed, 15 Jan 2025 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937582; cv=none; b=nHdEdiyE2rrdhIBvAzLES9opIPpKiGh0JPli/lnaSRZolv4JGEva+12/ddM/m9LQoN2VIXhwGqdZIu4tUs4XW7KyNBtD/wPalwI4ej5p34gIeQN0mviHdI/rDscnHHGTxRcBcj9FfN43s1bq1T0H6YT6bSgm4igch1egUWQEUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937582; c=relaxed/simple;
	bh=X8Bzq4vbc2nIS7e60WCciDuogVSuL4jGVmJ+gTlQLBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFw5obYcWcEN0vlDhQxJ2J+gQI3G86TYBY9djAG+aP45bGYanFd5fY5WGuIGl28nnajdNi5YSpW0C54QZOHuQxc9/0CHsqX6/YUuciRJWd6Elvm6DBTE8flznnQUAMAWNSkpMPqbLQRWkVyycjjnhDMqlbEFWm3O8s07aexqkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOaAY4+V; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3863703258fso418113f8f.1;
        Wed, 15 Jan 2025 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736937570; x=1737542370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dMGwxkrNU4EuX7kCK3KWCsT3+R0q8TNNOAL9QCORoDs=;
        b=eOaAY4+V9oCEW0A39dwDsuEfco3bWasH8kIUQb9IY2uL32AgISj5qpS1FnGZdlw26m
         IKqIQp9Fxrjh6hZn5eDkRAjSF6btS7hNSSnJ0AEdmcisUdwvq16KztDzLhR5oIe0JZzz
         YfqZy93RKDpEzdgcVehcwST7qj7erl/QrPHIwJgTr1P9TzNutOIWibuUqk1YYmvk2Kpb
         rqAPhSSbyKB8x2nukoDJKrOootyVujP1USeXFNavO/d+yuZ385+cMo9MY6FZonJJsCmK
         lTGbPOl5O1bHTX4H8V/7ujCJlaIQNYG+gaVeBI3FqluaBVEW/YIdDzZsH1lrXpcYC2jp
         wjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736937570; x=1737542370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMGwxkrNU4EuX7kCK3KWCsT3+R0q8TNNOAL9QCORoDs=;
        b=BNg7pswaooEzhNaQT2O8Yq7gDQkkEzXbdgJdZ/WAHveQ+8pJCPhByzsXCo7kTLPNdP
         gODl8s0reYrK+FKKjKBH4TTROHAQQ0iWvZhHQOgEWCNQACYRLPrvjK/Wqzp5BdiUfs0G
         60azOvJUIVou27ZyPhxXlmQM66VgOuisOMEKZTACiFXbI0hV1TyFcaRU7Np1D/AEqXom
         x/xYKPL3Q8kLgiYAlagHL6vI++SXJivm5TAisCEcQP1J75CYgRx7C4cha26nSizii/xb
         ebR3ovDa42Vtl9419P859sLTc55H8z0IB4SzgjEayDSEis0qlHmM7cr06c9V0lI4ctiT
         RrJw==
X-Forwarded-Encrypted: i=1; AJvYcCVmIQanvxXLjkSaJ6T86O5iK5RvXJH+/QvGuTDsl8fvkP88GtzmmV9SkPbJ+nExNNORQzMsxSiDPxs=@vger.kernel.org, AJvYcCWGAa5oGOSXnsTu3YDzcGUQq9vmhX4+g7nwKlAwwWStYdQDyY9uuekLWQvKCkC9wo6iwUTD11agXSJVKTlb@vger.kernel.org, AJvYcCWSSVqXRP9935x8fDqHYjiQc0qWtTDtTE1VPSc3RA1TyYZ+bgkN3r6REsO0z/d7um6WOJW9n6jE@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6tMZgCynsaDI4Pa6yGdTcXnyT17bAtIUE+MHi/lLhuKVhRwA
	FCYZOMxjLBADllixjGY0AdNeHdT5NI09yGE52GyRCTG4WwvCvKcp
X-Gm-Gg: ASbGncsLbyWzEDOjXC4p9tGq79cBYDJxOdLB4ZvcrBRJMNwSg4O9ThRZ3g0KxC/23SW
	ZWUXWy+XCLDaLSKGba3icAjc5f0kEvt9T2KKdv9UizXD7TVMiqi25Zw4LpXzEcR21H9WI3JZ0cL
	2SqVfhEZ6P2h/wNNaKEsMAxyScgymyLcAHZ2bNCJM+441HO4Q5a3cZ6VE5VHsKaAa/zFZZoGiN5
	Vqval+IMyqaZFRxa8xuuCaZGkXDzBnGI/4OXrpd+GNXgT7c0qYMF9LY7nHIKUHhxZXIux2tqzSz
	P/ni8zdt
X-Google-Smtp-Source: AGHT+IHOFTU9f4+9ieGESD+g8VrC92IkwfrseF/N43WFilUY2QDiHeaeuJlBZap4xY1mATLjrY8KLg==
X-Received: by 2002:a05:6000:2c1:b0:386:374b:e8bc with SMTP id ffacd0b85a97d-38a8b0d3425mr21291410f8f.15.1736937570162;
        Wed, 15 Jan 2025 02:39:30 -0800 (PST)
Received: from eichest-laptop (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74e5e69sm18287335e9.37.2025.01.15.02.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 02:39:29 -0800 (PST)
Date: Wed, 15 Jan 2025 11:39:27 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@nxp.com,
	francesco.dolcini@toradex.com, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] clk: imx: imx8-acm: fix flags for acm clocks
Message-ID: <Z4eQX_VnBEVqxT_r@eichest-laptop>
References: <20250113094654.12998-1-eichest@gmail.com>
 <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
 <Z4ZRYMf_uJW4poW9@eichest-laptop>
 <Z4dy3LiEAQ_gkQGG@eichest-laptop>
 <CAA+D8AO75MLyP5AWDJoogw8ae4GRtZfSR-HT+S26bXoaVs8saQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AO75MLyP5AWDJoogw8ae4GRtZfSR-HT+S26bXoaVs8saQ@mail.gmail.com>

On Wed, Jan 15, 2025 at 05:14:09PM +0800, Shengjiu Wang wrote:
> On Wed, Jan 15, 2025 at 4:33 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> >
> > Hi Shengjiu Wang,
> >
> > On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger wrote:
> > > Hi Shengjiu Wang,
> > >
> > > On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> > > > On Mon, Jan 13, 2025 at 5:54 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > > >
> > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > >
> > > > > Currently, the flags for the ACM clocks are set to 0. This configuration
> > > > > causes the fsl-sai audio driver to fail when attempting to set the
> > > > > sysclk, returning an EINVAL error. The following error messages
> > > > > highlight the issue:
> > > > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.sai: -22
> > > > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > > >
> > > > The reason for this error is that the current clock parent can't
> > > > support the rate
> > > > you require (I think you want 11289600).
> > > >
> > > > We can configure the dts to provide such source, for example:
> > > >
> > > >  &sai5 {
> > > > +       assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
> > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
> > > > +                       <&sai5_lpcg 0>;
> > > > +       assigned-clock-parents = <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg 0>;
> > > > +       assigned-clock-rates = <0>, <0>, <786432000>, <49152000>, <12288000>,
> > > > +                                <722534400>, <45158400>, <11289600>,
> > > > +                               <49152000>;
> > > >         status = "okay";
> > > >  };
> > > >
> > > > Then your case should work.
> > > >
> > > > >
> > > > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the ACM
> > > >
> > > > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which will cause
> > > > the driver don't get an error from clk_set_rate().
> > >
> > > Thanks for the proposal, I will try it out tomorrow. Isn't this a
> > > problem if other SAIs use the same clock source but with different
> > > rates?
> > >
> > > If we have to define fixed rates in the DTS or else the clock driver
> > > will return an error, isn't that a problem? Maybe I should change the
> > > sai driver so that it ignores the failure and just takes the rate
> > > configured? In the end audio works, even if it can't set the requested
> > > rate.
> >
> > The following clock tree change would allow the driver to work
> > in our scenario:
> > &sai5 {
> >         assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> >                           <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>;
> >         assigned-clock-parents = <&aud_pll_div1_lpcg 0>;
> >         assigned-clock-rates = <0>, <11289600>;
> > };
> 
> In which we configure PLL_0 for 48KHz series (8kHz/16kHz/32kHz/48kHz),
> PLL_1 for 44kHz series (11kHz/22kHz/44kHz),
> which should fit for most audio requirements.
> 
> >
> > However, this means we have to switch the parent clock to the audio pll
> > 1. For the simple setup with two SAIs, one for analog audio and one for
> > HDMI this wouldn't be a problem. But I'm not sure if this is a good
> > solution if a customer would add a third SAI which requires again a
> > different parent clock rate.
> 
> We won't change the PLL's rate in the driver,  so as PLL_0 for 48kHz,
> PLL_1 for 44kHz,  even with a third SAI or more,  they should work.
> 
> >
> > One potential solution could be that the SAI driver tries to first
> > derive the clock from the current parent and only if this fails it tries
> > to modify its parent clock. What do you think about this solution?
> >

I did some more testing and I'm still not happy with the current
solution. The problem is that if we change the SAI5 mclk clock parent it
can either support the 44kHz series or the 48kHz series. However, in the
case of HDMI we do not know in advance what the user wants.

This means when testing either this works:
speaker-test -D hw:2,0 -r 48000 -c 2
or this works:
speaker-test -D hw:2,0 -r 44100 -c 2
With:
card 2: imxaudiohdmitx [imx-audio-hdmi-tx], device 0: i.MX HDMI i2s-hifi-0 [i.MX HDMI i2s-hifi-0]

If I on the other hand avoid that fsl_sai_set_mclk_rate is called by
patching imx-hdmi.c. I can make both rates work with the standard clock
settings. So I wonder if calling snd_soc_dai_set_sysclk is really
necessary for the i.MX8?
diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index f9cec6f0aecd..7d8aa58645b7 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -92,15 +92,6 @@ static int imx_hdmi_hw_params(struct snd_pcm_substream *substream,
        u32 slot_width = data->cpu_priv.slot_width;
        int ret;

-       /* MCLK always is (256 or 192) * rate. */
-       ret = snd_soc_dai_set_sysclk(cpu_dai, data->cpu_priv.sysclk_id[tx],
-                                    8 * slot_width * params_rate(params),
-                                    tx ? SND_SOC_CLOCK_OUT : SND_SOC_CLOCK_IN);
-       if (ret && ret != -ENOTSUPP) {
-               dev_err(dev, "failed to set cpu sysclk: %d\n", ret);
-               return ret;
-       }
-
        ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0, 2, slot_width);
        if (ret && ret != -ENOTSUPP) {
                dev_err(dev, "failed to set cpu dai tdm slot: %d\n", ret);

Regards,
Stefan



