Return-Path: <stable+bounces-109219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B14A133AD
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 08:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01281886EC7
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ACF193407;
	Thu, 16 Jan 2025 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8E0RDWI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399B28DB3;
	Thu, 16 Jan 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012258; cv=none; b=HKLWQX/TTU39nUOTft7QtehkLqVMApOWBSoJLNZIy/yD3pgE++rjHbRojGW327rrB90503tydVNou+QUFgSD/6KUXcRRZvhym34eT0DIFQPSPXcT5QRSZb9/e8NejMLGWhqTwB7QiMmjDeOz1eRF8lh4r69HLGdNKzZOwQ4ltQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012258; c=relaxed/simple;
	bh=EJHXyEE0jtpEBe9StnNuUXOL/9zcbWBVwrq+49cPX8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTnczQ3m/yJvDSLJUNsvyKkoDvKjpMkD7SL1YWD8+JyzLRDIRGmbHCS1pz1s/cLXW06LRSFbZdc2Pnz7Ru9prXgkrdo81Q1nV2N3qNg2NEmdg2rVFxW0Mt/euIJYCx0r1XDVCnp6BVoM/kK++i7TYlm/cgF86/S15oUpSOx0S28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8E0RDWI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso10222775e9.0;
        Wed, 15 Jan 2025 23:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737012254; x=1737617054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IgVDZJK/ujB65O5I2vwx4J+q5AFipQItIeJr4iAC6iA=;
        b=N8E0RDWIao7J2jnYuunK3mjfUkoWoZbxo55INtG/bvyMvZ3mV6EJ2qDAPdTtRkanya
         yltGyEdXfgFz1LRcymydOc9LogUMgThBXZnxaQqH4c3RlCA+EsQQ99JshllzeAOAc3RX
         xPu6KhZH3pgp9VmTtm9Kf6yQ6e1EEWNSJzZbgjdaSZdPzyzD2xgGPCi1lkH9Cq42JMjf
         /ONDGXuH8m/TDPGPvAypphQLPKQIu/z4Sto1uBl8w2tMBSdQ5F2KZJ/iXlBHWth+s0vj
         7rb7JiB/TYzDhEmh/8pAmGwPlnx4xTdL/bpLdaVURZWiwPOKqjKzD5BkHLfZro9lz99y
         wefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737012254; x=1737617054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgVDZJK/ujB65O5I2vwx4J+q5AFipQItIeJr4iAC6iA=;
        b=XLRXDHTZw1/nrv0x9R0KvtQRyWLMZA1lG4Kl5HZ4KEiyV2LyGskqa4muNDrx2Nc8O7
         IcF5oiwyu2MumWqwUO4ZLJ5+jPKzQzlOgEr4KNHQT9LC402fBR1zycS205a6v5PimPxD
         COe1db1bv220oNKKfxSqw7iF/La6CLAUnJ4m6p9A3vOWO3JqP2ZvDuXxebvckaihpayu
         /HNvpYSXjs930WDZ/AtnYSsEBHledvN5m4UTnR5JxqwezIktdsFb2RzwtovJyL/B0660
         6ozTQgXk3/XtFI2NY4tLHI6I/uqkjWBh9ScXJKdBITLssnAQUtyT7JI3hhTup5Yk3h4z
         JY3g==
X-Forwarded-Encrypted: i=1; AJvYcCVkJf+hmtZFMwxhc4av9EhNkQ0XjnZWowFzx1kClXLz7Hpz/Dc275/3OFWCPLQMMkm7AuEHyO3hKUc+X6ja@vger.kernel.org, AJvYcCX2JnCmjOmebxaCvxH6/jXzPHfPC7KiXE+8OKGDD2R5aa52Kxt/6i9GfI5tb5ZTrP22QZk9Uqqx@vger.kernel.org, AJvYcCXvfnb9BV8OCOlz4vD7BOC76ZDy+JBP+7txDuzeCT6ZcGNaH4Ri9Ah1Oyl/S1VUDegOdn2JEBiR6O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYzsvN+yDNCoR0U6YT/hlWFbHs2PmRCvnc8LJOh04PNm/zUFf
	ma3+nRpmL3E+kI3ASXDc2lv4L/YkYbRPRP5aB2q0eUTmqc1POBNd
X-Gm-Gg: ASbGnctDBGUw2sn3KmBLjB9SNeHMfHTdttvcz+K18asCYgybCCAqb7EFJOc6D1fXHaP
	1ZfUU/DxZUGqRbSC/rJwTh8luqn3bGrVpye5Emf7Ud9dSraKplECb+mgF35vA3r16AiWpI7skc+
	RSZ1YHtVYuknJPcbB032M3EfQ0Sall6gskR51ctAB/BDyNoM79vncYl1EyKl1wQ2p3oUZV6W7+Z
	rqj7CJ05rW617OYNFDWUMInFchO0pvGsV7MCw3H/CHiYeLEXjl2oEhs
X-Google-Smtp-Source: AGHT+IEoUDQBvRyW1rj5PdvWwHSZrTwh0+MhedH5EL9nzscjOPcqJoxU9CPjQ5ErDBkS7bIkez2gdQ==
X-Received: by 2002:a05:600c:c06:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-437c6b26e74mr45097105e9.12.1737012254194;
        Wed, 15 Jan 2025 23:24:14 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:6c4e:8d77:c1b7:309e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74bf061sm48499725e9.17.2025.01.15.23.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:24:13 -0800 (PST)
Date: Thu, 16 Jan 2025 08:24:11 +0100
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
Message-ID: <Z4i0G5Tw4q0v8DTL@eichest-laptop>
References: <20250113094654.12998-1-eichest@gmail.com>
 <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
 <Z4ZRYMf_uJW4poW9@eichest-laptop>
 <Z4dy3LiEAQ_gkQGG@eichest-laptop>
 <CAA+D8AO75MLyP5AWDJoogw8ae4GRtZfSR-HT+S26bXoaVs8saQ@mail.gmail.com>
 <Z4eQX_VnBEVqxT_r@eichest-laptop>
 <CAA+D8APivJWD-AqwmQ-mtcr=ZHot5rfA8FRWF2+p-_mq5BGxHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8APivJWD-AqwmQ-mtcr=ZHot5rfA8FRWF2+p-_mq5BGxHA@mail.gmail.com>

Hi Shengjiu Wang,

On Thu, Jan 16, 2025 at 12:01:13PM +0800, Shengjiu Wang wrote:
> On Wed, Jan 15, 2025 at 6:39 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> >
> > On Wed, Jan 15, 2025 at 05:14:09PM +0800, Shengjiu Wang wrote:
> > > On Wed, Jan 15, 2025 at 4:33 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > >
> > > > Hi Shengjiu Wang,
> > > >
> > > > On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger wrote:
> > > > > Hi Shengjiu Wang,
> > > > >
> > > > > On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> > > > > > On Mon, Jan 13, 2025 at 5:54 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > > >
> > > > > > > Currently, the flags for the ACM clocks are set to 0. This configuration
> > > > > > > causes the fsl-sai audio driver to fail when attempting to set the
> > > > > > > sysclk, returning an EINVAL error. The following error messages
> > > > > > > highlight the issue:
> > > > > > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.sai: -22
> > > > > > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > > > > >
> > > > > > The reason for this error is that the current clock parent can't
> > > > > > support the rate
> > > > > > you require (I think you want 11289600).
> > > > > >
> > > > > > We can configure the dts to provide such source, for example:
> > > > > >
> > > > > >  &sai5 {
> > > > > > +       assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
> > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
> > > > > > +                       <&sai5_lpcg 0>;
> > > > > > +       assigned-clock-parents = <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg 0>;
> > > > > > +       assigned-clock-rates = <0>, <0>, <786432000>, <49152000>, <12288000>,
> > > > > > +                                <722534400>, <45158400>, <11289600>,
> > > > > > +                               <49152000>;
> > > > > >         status = "okay";
> > > > > >  };
> > > > > >
> > > > > > Then your case should work.
> > > > > >
> > > > > > >
> > > > > > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the ACM
> > > > > >
> > > > > > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which will cause
> > > > > > the driver don't get an error from clk_set_rate().
> > > > >
> > > > > Thanks for the proposal, I will try it out tomorrow. Isn't this a
> > > > > problem if other SAIs use the same clock source but with different
> > > > > rates?
> > > > >
> > > > > If we have to define fixed rates in the DTS or else the clock driver
> > > > > will return an error, isn't that a problem? Maybe I should change the
> > > > > sai driver so that it ignores the failure and just takes the rate
> > > > > configured? In the end audio works, even if it can't set the requested
> > > > > rate.
> > > >
> > > > The following clock tree change would allow the driver to work
> > > > in our scenario:
> > > > &sai5 {
> > > >         assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > >                           <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>;
> > > >         assigned-clock-parents = <&aud_pll_div1_lpcg 0>;
> > > >         assigned-clock-rates = <0>, <11289600>;
> > > > };
> > >
> > > In which we configure PLL_0 for 48KHz series (8kHz/16kHz/32kHz/48kHz),
> > > PLL_1 for 44kHz series (11kHz/22kHz/44kHz),
> > > which should fit for most audio requirements.
> > >
> > > >
> > > > However, this means we have to switch the parent clock to the audio pll
> > > > 1. For the simple setup with two SAIs, one for analog audio and one for
> > > > HDMI this wouldn't be a problem. But I'm not sure if this is a good
> > > > solution if a customer would add a third SAI which requires again a
> > > > different parent clock rate.
> > >
> > > We won't change the PLL's rate in the driver,  so as PLL_0 for 48kHz,
> > > PLL_1 for 44kHz,  even with a third SAI or more,  they should work.
> > >
> > > >
> > > > One potential solution could be that the SAI driver tries to first
> > > > derive the clock from the current parent and only if this fails it tries
> > > > to modify its parent clock. What do you think about this solution?
> > > >
> >
> > I did some more testing and I'm still not happy with the current
> > solution. The problem is that if we change the SAI5 mclk clock parent it
> > can either support the 44kHz series or the 48kHz series. However, in the
> > case of HDMI we do not know in advance what the user wants.
> >
> > This means when testing either this works:
> > speaker-test -D hw:2,0 -r 48000 -c 2
> > or this works:
> > speaker-test -D hw:2,0 -r 44100 -c 2
> > With:
> > card 2: imxaudiohdmitx [imx-audio-hdmi-tx], device 0: i.MX HDMI i2s-hifi-0 [i.MX HDMI i2s-hifi-0]
> 
> Are you using the setting below?  then should not either,  should both works
>  &sai5 {
> +       assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
> +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
> +                       <&sai5_lpcg 0>;
> +       assigned-clock-parents = <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg 0>;
> +       assigned-clock-rates = <0>, <0>, <786432000>, <49152000>, <12288000>,
> +                                <722534400>, <45158400>, <11289600>,
> +                               <49152000>;
>         status = "okay";
>  };

Sorry I didn't communicate that properly. Yes I was trying with these
settings but they do not work. The problem does not seem to be that the
driver can not adjust the rate for the audio (so e.g. 44kHz or 48kHz)
but that snd_soc_dai_set_sysclk in imx-hdmi.c fails with EINVAL. This
results in a call to fsl_sai_set_mclk_rate in fsl_sai.c with clk_id 1
(mclk_clk[1]) and a freq of 11289600 which causes the fail.
Interestingly, in fsl_sai_set_bclk we then only use clk_get_rate on
mclk_clk[0] which is set to audio_ipg_clk (rate 175000000) and we do not
use mclk_clk[1] anymore at all. This is why I'm not sure if this call to
snd_soc_dai_set_syclk is really necessary?

Regards,
Stefan

