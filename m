Return-Path: <stable+bounces-109399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B979CA153FD
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C273A725D
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89313AA20;
	Fri, 17 Jan 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8BWhvvk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E9189B9D;
	Fri, 17 Jan 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130625; cv=none; b=hUNFC5w0XuL0lRta7Wv3ipzelFBG2ZvSzM7rXfeZPJu4EAg66dmBsiMjtxmhGlPb3H5ecX4nNjRMs2SSnpfNCrdxMwMvfDcUg+KhemcE3VbQACAIly134yfIYK0yu1jhQ+V8DEGxxSKoJPvlsRHF+CRIoifI+9MJWUh9jEOjHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130625; c=relaxed/simple;
	bh=JvQYmSLVx8xQw9ayQ82A6Fqgd6Lul6YYjp7oXACKtDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukque3vyQTcbcyYlyqYYhNSrXOfttrL235NQQRuwpVXQpTTqAKIyE0QWCZR1XR5L1NE3gm9EKT7HiVnbVVzyowa4EqjkwknArYPI6ipYSQvyHdxh0f0LbiVG1aZ2RZDK/8yek7zVatX17q42AIroMi6UXNgk83XmDq3HnyNXfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8BWhvvk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso15820265e9.2;
        Fri, 17 Jan 2025 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130621; x=1737735421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RkK3YraUhv52e6kmGNd3i6W1acEs14yvrmEO/fbWB6U=;
        b=J8BWhvvksSpk/B02lhtLhyQUvZCuvvZjSbPmey8q4HKC4ldbaDHIRyq73skallutoW
         bFneEnkU+x7hM34msk3AwzKiCphas511/LIVJUw5491vMCBMdsqlyyLpxoDdUuI8bpJQ
         54EyXXO7urnD6melD/k5yllwP/9k52GPOCVduzdwgPVo51CmY+1pIv/cDlaIm1frFndr
         ZiyyI4S5vCM2VI25Sn3RQTcs4CVYC7SA2nN3P8T7jF6w6AyOjQAW5yNRzfMPPwft5BBs
         r0MBrWk9aM8CTTS4p1GiRlhNVy4BlFuNBGPDvd9jRV/3VUU2e6HGl/IEa2hEIJQtGfUs
         6VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130621; x=1737735421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkK3YraUhv52e6kmGNd3i6W1acEs14yvrmEO/fbWB6U=;
        b=jNFE1NNPyCMU8QhLPPfvIxy7+ex4seXHorash4AvN2KGlbrem9296FBTpszALINz1E
         xiKBYxbi9c5KsPt88YDp8+gDf+P6FR5RQ7f0xj8CxCSAFXHuyaCpiRuPYlyYui1QMXee
         sKy21V45gugNZDo+I3FNvvs9OwncPI7BAlunyntioDhTqPfEsTcHRw9mG5QduG8lbKAL
         Svbsqh01+u7a9kF9rRa2VZM8KSyhKlWMgamaGFp8NajGFjOE1SEh6/Is2n8bG2eYJouz
         fMA5whPGMFOvUbD4puor1U0YFtnrEHzuTvlcU4hxcg9lQojds/v0csu2AW4dim2FgDj2
         SvIw==
X-Forwarded-Encrypted: i=1; AJvYcCWJaOIH14R34E1zuqb1+VSDLRoPhn1VCN7QUjCiuKUcI24fgi9gc0wsbpxlwNMWM6Ffi06li3rIDCk3zJE+@vger.kernel.org, AJvYcCXJ1dsHbIKajMaJtJp8fkuOv6lodbn41DIrACk2kTJ7YLcgic7+wi7caCQCDI4Zu+vHwNelYXIo@vger.kernel.org, AJvYcCXafx2UfWBVVgFiWTuRjQ5/HkT/zZxXc+/emAcwo7m9MWQ392+J5/tJZ4+2jfXywSrQ11Xye6sNALY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ddhThKDFIzA3iRgQ5e0NXv9Uwg1d4GhQvYRXCAqxrmrKdfNG
	XrBw3JHqB9mVx6Cwvje2beJ4KQvYqzO//D7b4WylpFbdFWpvM95/
X-Gm-Gg: ASbGncuabZmvYzWF9Krg7gdQEw7ZuZ0FCyq7K0w036h8QFhzmwAKhnm6yzVxGiId1Io
	WhJxWCRZTztvelK4T3bOZlKTVysouZ6SFPHmtE1sdc0v4CszCKoqX8SwrLYShkaeWpQKCZjWSL2
	dFpYRVF10imyaO8bGnSLRwHZk8B9uko6j6fvWXsdFXhxdJgWaWTKP648mY6MG2g7biCDeYPnIbb
	w828lwyaXf0zzUyPEUvjsjS559po7ZRjoPTD1t6pCKBNIW04qoOfOo7
X-Google-Smtp-Source: AGHT+IGAWQaM6yNh33X77UBZupdUNHFVnCSSzWPAqwT1T2yvjJ/mCaKmTHNr57vHQHkL4BIH2iTTdg==
X-Received: by 2002:a05:600c:4ed4:b0:434:fdbc:5cf7 with SMTP id 5b1f17b1804b1-438914373e4mr32114405e9.27.1737130621190;
        Fri, 17 Jan 2025 08:17:01 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:a17a:6a28:e744:9a06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74ac5f9sm96021605e9.11.2025.01.17.08.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:17:00 -0800 (PST)
Date: Fri, 17 Jan 2025 17:16:58 +0100
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
Message-ID: <Z4qCeo0H1kZxAuFE@eichest-laptop>
References: <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
 <Z4ZRYMf_uJW4poW9@eichest-laptop>
 <Z4dy3LiEAQ_gkQGG@eichest-laptop>
 <CAA+D8AO75MLyP5AWDJoogw8ae4GRtZfSR-HT+S26bXoaVs8saQ@mail.gmail.com>
 <Z4eQX_VnBEVqxT_r@eichest-laptop>
 <CAA+D8APivJWD-AqwmQ-mtcr=ZHot5rfA8FRWF2+p-_mq5BGxHA@mail.gmail.com>
 <Z4i0G5Tw4q0v8DTL@eichest-laptop>
 <CAA+D8AOakQdnEe9ZrfTCrWcjHJRRU0kqFVsiu8+FMiHeMAVV_g@mail.gmail.com>
 <Z4lDbMqCYW2W7iyX@eichest-laptop>
 <CAA+D8AM9xwvyvU_0ODFwaq=YzzbP_R7hqMvHqx-Y1kHPpX_x_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AM9xwvyvU_0ODFwaq=YzzbP_R7hqMvHqx-Y1kHPpX_x_Q@mail.gmail.com>

On Fri, Jan 17, 2025 at 02:56:15PM +0800, Shengjiu Wang wrote:
> On Fri, Jan 17, 2025 at 1:35 AM Stefan Eichenberger <eichest@gmail.com> wrote:
> >
> > Hi Shengjiu Wang,
> >
> > On Thu, Jan 16, 2025 at 03:30:55PM +0800, Shengjiu Wang wrote:
> > > On Thu, Jan 16, 2025 at 3:24 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > >
> > > > Hi Shengjiu Wang,
> > > >
> > > > On Thu, Jan 16, 2025 at 12:01:13PM +0800, Shengjiu Wang wrote:
> > > > > On Wed, Jan 15, 2025 at 6:39 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 15, 2025 at 05:14:09PM +0800, Shengjiu Wang wrote:
> > > > > > > On Wed, Jan 15, 2025 at 4:33 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Shengjiu Wang,
> > > > > > > >
> > > > > > > > On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger wrote:
> > > > > > > > > Hi Shengjiu Wang,
> > > > > > > > >
> > > > > > > > > On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> > > > > > > > > > On Mon, Jan 13, 2025 at 5:54 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > > > > > > >
> > > > > > > > > > > Currently, the flags for the ACM clocks are set to 0. This configuration
> > > > > > > > > > > causes the fsl-sai audio driver to fail when attempting to set the
> > > > > > > > > > > sysclk, returning an EINVAL error. The following error messages
> > > > > > > > > > > highlight the issue:
> > > > > > > > > > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.sai: -22
> > > > > > > > > > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > > > > > > > > >
> > > > > > > > > > The reason for this error is that the current clock parent can't
> > > > > > > > > > support the rate
> > > > > > > > > > you require (I think you want 11289600).
> > > > > > > > > >
> > > > > > > > > > We can configure the dts to provide such source, for example:
> > > > > > > > > >
> > > > > > > > > >  &sai5 {
> > > > > > > > > > +       assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > > > > > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> > > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> > > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> > > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> > > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
> > > > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
> > > > > > > > > > +                       <&sai5_lpcg 0>;
> > > > > > > > > > +       assigned-clock-parents = <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg 0>;
> > > > > > > > > > +       assigned-clock-rates = <0>, <0>, <786432000>, <49152000>, <12288000>,
> > > > > > > > > > +                                <722534400>, <45158400>, <11289600>,
> > > > > > > > > > +                               <49152000>;
> > > > > > > > > >         status = "okay";
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > > Then your case should work.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the ACM
> > > > > > > > > >
> > > > > > > > > > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which will cause
> > > > > > > > > > the driver don't get an error from clk_set_rate().
> > > > > > > > >
> > > > > > > > > Thanks for the proposal, I will try it out tomorrow. Isn't this a
> > > > > > > > > problem if other SAIs use the same clock source but with different
> > > > > > > > > rates?
> > > > > > > > >
> > > > > > > > > If we have to define fixed rates in the DTS or else the clock driver
> > > > > > > > > will return an error, isn't that a problem? Maybe I should change the
> > > > > > > > > sai driver so that it ignores the failure and just takes the rate
> > > > > > > > > configured? In the end audio works, even if it can't set the requested
> > > > > > > > > rate.
> > > > > > > >
> > > > > > > > The following clock tree change would allow the driver to work
> > > > > > > > in our scenario:
> > > > > > > > &sai5 {
> > > > > > > >         assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > > > > >                           <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>;
> > > > > > > >         assigned-clock-parents = <&aud_pll_div1_lpcg 0>;
> > > > > > > >         assigned-clock-rates = <0>, <11289600>;
> > > > > > > > };
> > > > > > >
> > > > > > > In which we configure PLL_0 for 48KHz series (8kHz/16kHz/32kHz/48kHz),
> > > > > > > PLL_1 for 44kHz series (11kHz/22kHz/44kHz),
> > > > > > > which should fit for most audio requirements.
> > > > > > >
> > > > > > > >
> > > > > > > > However, this means we have to switch the parent clock to the audio pll
> > > > > > > > 1. For the simple setup with two SAIs, one for analog audio and one for
> > > > > > > > HDMI this wouldn't be a problem. But I'm not sure if this is a good
> > > > > > > > solution if a customer would add a third SAI which requires again a
> > > > > > > > different parent clock rate.
> > > > > > >
> > > > > > > We won't change the PLL's rate in the driver,  so as PLL_0 for 48kHz,
> > > > > > > PLL_1 for 44kHz,  even with a third SAI or more,  they should work.
> > > > > > >
> > > > > > > >
> > > > > > > > One potential solution could be that the SAI driver tries to first
> > > > > > > > derive the clock from the current parent and only if this fails it tries
> > > > > > > > to modify its parent clock. What do you think about this solution?
> > > > > > > >
> > > > > >
> > > > > > I did some more testing and I'm still not happy with the current
> > > > > > solution. The problem is that if we change the SAI5 mclk clock parent it
> > > > > > can either support the 44kHz series or the 48kHz series. However, in the
> > > > > > case of HDMI we do not know in advance what the user wants.
> > > > > >
> > > > > > This means when testing either this works:
> > > > > > speaker-test -D hw:2,0 -r 48000 -c 2
> > > > > > or this works:
> > > > > > speaker-test -D hw:2,0 -r 44100 -c 2
> > > > > > With:
> > > > > > card 2: imxaudiohdmitx [imx-audio-hdmi-tx], device 0: i.MX HDMI i2s-hifi-0 [i.MX HDMI i2s-hifi-0]
> > > > >
> > > > > Are you using the setting below?  then should not either,  should both works
> > > > >  &sai5 {
> > > > > +       assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
> > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
> > > > > +                       <&sai5_lpcg 0>;
> > > > > +       assigned-clock-parents = <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg 0>;
> > > > > +       assigned-clock-rates = <0>, <0>, <786432000>, <49152000>, <12288000>,
> > > > > +                                <722534400>, <45158400>, <11289600>,
> > > > > +                               <49152000>;
> > > > >         status = "okay";
> > > > >  };
> > > >
> > > > Sorry I didn't communicate that properly. Yes I was trying with these
> > > > settings but they do not work. The problem does not seem to be that the
> > > > driver can not adjust the rate for the audio (so e.g. 44kHz or 48kHz)
> > > > but that snd_soc_dai_set_sysclk in imx-hdmi.c fails with EINVAL. This
> > > > results in a call to fsl_sai_set_mclk_rate in fsl_sai.c with clk_id 1
> > > > (mclk_clk[1]) and a freq of 11289600 which causes the fail.
> > > > Interestingly, in fsl_sai_set_bclk we then only use clk_get_rate on
> > > > mclk_clk[0] which is set to audio_ipg_clk (rate 175000000) and we do not
> > > > use mclk_clk[1] anymore at all. This is why I'm not sure if this call to
> > > > snd_soc_dai_set_syclk is really necessary?
> > > >
> > >
> > > Could you please check if you have the below commit in your test tree?
> > > 35121e9def07 clk: imx: imx8: Use clk_hw pointer for self registered
> > > clock in clk_parent_data
> > >
> > > if not, please cherry-pick it.
> > >
> > > The audio_ipg_clk can be selected if there is no other choice.
> > > but the rate 175000000 is not accurate for 44kHz. what we got
> > > is 44102Hz. This is the reason I don't like to use this source.
> >
> > Thanks a lot for the hint, in my test setup I indeed have not applied
> > this commit. I tested it now with cherry-picking the commit and with
> > applying the change to the dts. This made it work. I will do some more
> > testing tomrrow and if I can't find any addtional issue I will use this
> > as a solution.
> >
> I am thinking that your change may still be needed.
> 
> Your change plus the below change. then we can support more rate,
> not only 48k/44kHz.  SAI driver will select the parent by itself before
> the clk_set_rate().

When testing the only two frequency that are not working and seem to be
supported by HDMI is first 88.2 kHz.
fsl-sai 59090000.sai: failed to derive required Tx rate: 5644800
fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_hw_params on 59090000.sai: -22

and second 32kHz:
fsl-sai 59090000.sai: failed to set clock rate (8192000): -22
fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.sai: -22
imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
 i.MX HDMI: ASoC: error at snd_soc_link_hw_params on i.MX HDMI: -22

For our use case this doesn't seem to be relevant at the moment. I will
clarify this internally.
> 
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
> +       clocks = <&sai5_lpcg 1>,
> +               <&clk_dummy>,
> +               <&sai5_lpcg 0>,
> +               <&clk_dummy>,
> +               <&clk_dummy>,
> +               <&aud_pll_div0_lpcg 0>,
> +               <&aud_pll_div1_lpcg 0>;
> +       clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3",
> "pll8k", "pll11k";
> 
> > Should I add the change to our Apalis board dtsi file or directly to
> > imx8qm-ss-audio.dtsi? I think it fixes kind of a general issue or not?
> 
> It is still board related, so I think it is better to add to the board dts file.

Okay, then I will add this change to the board dts and prepare a v2.

Regards,
Stefan

