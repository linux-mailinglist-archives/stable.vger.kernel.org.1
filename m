Return-Path: <stable+bounces-109305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC056A140FB
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 18:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D603A5306
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FEF153598;
	Thu, 16 Jan 2025 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al8RwGmY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7E24A7C6;
	Thu, 16 Jan 2025 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048946; cv=none; b=fEDZ21z/jH/MwT6kbJnLcGzFexn9SSV3D987LMdj0wmEIAFpyB/xSWhne7319I6MyM5xU14ZEa17AsBmvR2J4tzXiSQXII2iCLL0ttWDK7uGHjDmg3GgsRhaVAiXxT7PK7bDI0mjMNGRzoEc2GfWn1xYaGol/Bf6U8ptr4tpYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048946; c=relaxed/simple;
	bh=oRrQdjlMXee27y3404cKxsBGmmxH3reSt5HlrLAhTEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM/hVrfNNg3yjcyLjP5fdDQEUQ97azmP0+m5VEjIX3JBpKPu9guUDiDGDbZ2TIl8g7XywRW/bh0qZRvFWB8sARn/oxpF1qlMYPKR8+BBHgfzGA8nf1m14FG2gFzk0aG5AhLjUfE+JLItTKwVtpeossmxlHttg3K7dB18H++gIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al8RwGmY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so12915735e9.0;
        Thu, 16 Jan 2025 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737048943; x=1737653743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OXBv7mU3IUmuhGazcfTF0fMhicUzdzlonYKZ/ftM1lc=;
        b=al8RwGmYoPptwkvDdT8zDh5ewvhO99t6Qf8T2/LrMQu4dL49IvWm7q8lle8yoSnLQs
         dsdWITJBbdG+r716BtqAwYyp4E28osQSnohwRXhvDV8LMWq6a5mwoQ24fbercyK1o6e4
         uICPsVrYtxvZwIypvi8j4Nf/tmMOLlxu2LZO3oYDmeaPl8CjVDkTXANOMQ8s4N9+Qt+t
         a6sHiBzF2Dx8ewCfsY9YY25uEUdJtE5Lz6LfBqw5yW0uOct9SlzBfBwo+UUUacipe6GO
         TD7Z78sWIQNP7xIuiqw5OnkLSZcQIqjwKFTbhy5DXqFGch3mHU/eg566+zjFk4HB7nTI
         lUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737048943; x=1737653743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXBv7mU3IUmuhGazcfTF0fMhicUzdzlonYKZ/ftM1lc=;
        b=s+3EHWzn7ctEC6bSQwP5ZtfZtiCc3MYkaZNjNhwdMzTM95wVEWMIlJCiiyjmZfl7Ie
         wjbJN6lp41CiuaVkeYL68Zqh6q9ncn8t/6hQeNl3c4BtaGw8HlEBc1IBIG3yGZ2VTpS4
         icthApfdQE33xK4NDMvY2jIs9bE7hkTfGq3Ho/S1X7crBSFPSNLhF+MuzEGTEQBINF/M
         TKCHQnChZh4Utx1PxPk5+JZn2/oGKzCBBu97q5sHrQMutLl3KSmku/LGS6ZqIY/b6K2G
         aKP4H8kXZYarYr0KDOesCwqw1355fiFnzWAeoNs6ywWfBWCAv6A5fPaZvxf7RwYk/KFq
         /jGg==
X-Forwarded-Encrypted: i=1; AJvYcCUnbROGmqEdte2ZeOnIA5nuNMFVsDH4QZqsm0GvYgxal2ZhTCUFko2gPlRH92poq4QBlWr8hxeU5FTzD7uE@vger.kernel.org, AJvYcCVsahToN68L1jer9iuOvXagZAb1WXScAAYtNgRS5JkF8wKOdhQMD7a6zhkWo3BzFkgEKVzq3afm@vger.kernel.org, AJvYcCWfuPKdSLTe9u7ht3MSjmnVMXRkgeKtmgaFt7JEaS/pT8fsPMMOsBWheqncbHAVEWmWS0dcERzAWZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kZe67C9SMEunUg6GFDAln2Eq106dgWwffv177HvJCfD9qyVL
	MQRmRDMQbh2yqj6ZifdMVv0Z6oucznd0tOmJC1lBkjN5dLJCaEp13tvUDHoz
X-Gm-Gg: ASbGncthjC7MP3zzK5eVwR93Qr2RZk+dTMIUKYmwcNwdvBWkV0kkkidDJuC/uhuHlni
	JdINIIdFLYXQsykohoyLDGXN6xpq0Hu3Qt6OaTZZPelvO+zkJ4dT+QRST9gm7AVscb2GtpiC0a7
	zTYkglFvKDqJtMV0FvPeLLxBFoRzav1dzFx3/RVjBjA8yIN7nlkcnISYsQibPY9rTTtMKpPmtxz
	aH/xnSOOQgHPpVpC793MrtXKaWwlm5ehyWZFT3OHp69Tu8hWd0oXmj0
X-Google-Smtp-Source: AGHT+IE4uFPItlsauRShxJdLB24OsNy/KVeIOXphx1Hzsl5WiEKLoA/vq8qTUH8Lxbx1pF338OyP/w==
X-Received: by 2002:a05:6000:1849:b0:385:e5d8:3ec2 with SMTP id ffacd0b85a97d-38a8730b535mr32269071f8f.28.1737048942602;
        Thu, 16 Jan 2025 09:35:42 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:6c4e:8d77:c1b7:309e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389046b0f5sm5619075e9.39.2025.01.16.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:35:42 -0800 (PST)
Date: Thu, 16 Jan 2025 18:35:40 +0100
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
Message-ID: <Z4lDbMqCYW2W7iyX@eichest-laptop>
References: <20250113094654.12998-1-eichest@gmail.com>
 <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
 <Z4ZRYMf_uJW4poW9@eichest-laptop>
 <Z4dy3LiEAQ_gkQGG@eichest-laptop>
 <CAA+D8AO75MLyP5AWDJoogw8ae4GRtZfSR-HT+S26bXoaVs8saQ@mail.gmail.com>
 <Z4eQX_VnBEVqxT_r@eichest-laptop>
 <CAA+D8APivJWD-AqwmQ-mtcr=ZHot5rfA8FRWF2+p-_mq5BGxHA@mail.gmail.com>
 <Z4i0G5Tw4q0v8DTL@eichest-laptop>
 <CAA+D8AOakQdnEe9ZrfTCrWcjHJRRU0kqFVsiu8+FMiHeMAVV_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AOakQdnEe9ZrfTCrWcjHJRRU0kqFVsiu8+FMiHeMAVV_g@mail.gmail.com>

Hi Shengjiu Wang,

On Thu, Jan 16, 2025 at 03:30:55PM +0800, Shengjiu Wang wrote:
> On Thu, Jan 16, 2025 at 3:24 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> >
> > Hi Shengjiu Wang,
> >
> > On Thu, Jan 16, 2025 at 12:01:13PM +0800, Shengjiu Wang wrote:
> > > On Wed, Jan 15, 2025 at 6:39 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > >
> > > > On Wed, Jan 15, 2025 at 05:14:09PM +0800, Shengjiu Wang wrote:
> > > > > On Wed, Jan 15, 2025 at 4:33 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > > > >
> > > > > > Hi Shengjiu Wang,
> > > > > >
> > > > > > On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger wrote:
> > > > > > > Hi Shengjiu Wang,
> > > > > > >
> > > > > > > On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> > > > > > > > On Mon, Jan 13, 2025 at 5:54 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > > > > >
> > > > > > > > > Currently, the flags for the ACM clocks are set to 0. This configuration
> > > > > > > > > causes the fsl-sai audio driver to fail when attempting to set the
> > > > > > > > > sysclk, returning an EINVAL error. The following error messages
> > > > > > > > > highlight the issue:
> > > > > > > > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.sai: -22
> > > > > > > > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > > > > > > >
> > > > > > > > The reason for this error is that the current clock parent can't
> > > > > > > > support the rate
> > > > > > > > you require (I think you want 11289600).
> > > > > > > >
> > > > > > > > We can configure the dts to provide such source, for example:
> > > > > > > >
> > > > > > > >  &sai5 {
> > > > > > > > +       assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > > > > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
> > > > > > > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
> > > > > > > > +                       <&sai5_lpcg 0>;
> > > > > > > > +       assigned-clock-parents = <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg 0>;
> > > > > > > > +       assigned-clock-rates = <0>, <0>, <786432000>, <49152000>, <12288000>,
> > > > > > > > +                                <722534400>, <45158400>, <11289600>,
> > > > > > > > +                               <49152000>;
> > > > > > > >         status = "okay";
> > > > > > > >  };
> > > > > > > >
> > > > > > > > Then your case should work.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the ACM
> > > > > > > >
> > > > > > > > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which will cause
> > > > > > > > the driver don't get an error from clk_set_rate().
> > > > > > >
> > > > > > > Thanks for the proposal, I will try it out tomorrow. Isn't this a
> > > > > > > problem if other SAIs use the same clock source but with different
> > > > > > > rates?
> > > > > > >
> > > > > > > If we have to define fixed rates in the DTS or else the clock driver
> > > > > > > will return an error, isn't that a problem? Maybe I should change the
> > > > > > > sai driver so that it ignores the failure and just takes the rate
> > > > > > > configured? In the end audio works, even if it can't set the requested
> > > > > > > rate.
> > > > > >
> > > > > > The following clock tree change would allow the driver to work
> > > > > > in our scenario:
> > > > > > &sai5 {
> > > > > >         assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > > > >                           <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>;
> > > > > >         assigned-clock-parents = <&aud_pll_div1_lpcg 0>;
> > > > > >         assigned-clock-rates = <0>, <11289600>;
> > > > > > };
> > > > >
> > > > > In which we configure PLL_0 for 48KHz series (8kHz/16kHz/32kHz/48kHz),
> > > > > PLL_1 for 44kHz series (11kHz/22kHz/44kHz),
> > > > > which should fit for most audio requirements.
> > > > >
> > > > > >
> > > > > > However, this means we have to switch the parent clock to the audio pll
> > > > > > 1. For the simple setup with two SAIs, one for analog audio and one for
> > > > > > HDMI this wouldn't be a problem. But I'm not sure if this is a good
> > > > > > solution if a customer would add a third SAI which requires again a
> > > > > > different parent clock rate.
> > > > >
> > > > > We won't change the PLL's rate in the driver,  so as PLL_0 for 48kHz,
> > > > > PLL_1 for 44kHz,  even with a third SAI or more,  they should work.
> > > > >
> > > > > >
> > > > > > One potential solution could be that the SAI driver tries to first
> > > > > > derive the clock from the current parent and only if this fails it tries
> > > > > > to modify its parent clock. What do you think about this solution?
> > > > > >
> > > >
> > > > I did some more testing and I'm still not happy with the current
> > > > solution. The problem is that if we change the SAI5 mclk clock parent it
> > > > can either support the 44kHz series or the 48kHz series. However, in the
> > > > case of HDMI we do not know in advance what the user wants.
> > > >
> > > > This means when testing either this works:
> > > > speaker-test -D hw:2,0 -r 48000 -c 2
> > > > or this works:
> > > > speaker-test -D hw:2,0 -r 44100 -c 2
> > > > With:
> > > > card 2: imxaudiohdmitx [imx-audio-hdmi-tx], device 0: i.MX HDMI i2s-hifi-0 [i.MX HDMI i2s-hifi-0]
> > >
> > > Are you using the setting below?  then should not either,  should both works
> > >  &sai5 {
> > > +       assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
> > > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
> > > +                       <&sai5_lpcg 0>;
> > > +       assigned-clock-parents = <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg 0>;
> > > +       assigned-clock-rates = <0>, <0>, <786432000>, <49152000>, <12288000>,
> > > +                                <722534400>, <45158400>, <11289600>,
> > > +                               <49152000>;
> > >         status = "okay";
> > >  };
> >
> > Sorry I didn't communicate that properly. Yes I was trying with these
> > settings but they do not work. The problem does not seem to be that the
> > driver can not adjust the rate for the audio (so e.g. 44kHz or 48kHz)
> > but that snd_soc_dai_set_sysclk in imx-hdmi.c fails with EINVAL. This
> > results in a call to fsl_sai_set_mclk_rate in fsl_sai.c with clk_id 1
> > (mclk_clk[1]) and a freq of 11289600 which causes the fail.
> > Interestingly, in fsl_sai_set_bclk we then only use clk_get_rate on
> > mclk_clk[0] which is set to audio_ipg_clk (rate 175000000) and we do not
> > use mclk_clk[1] anymore at all. This is why I'm not sure if this call to
> > snd_soc_dai_set_syclk is really necessary?
> >
> 
> Could you please check if you have the below commit in your test tree?
> 35121e9def07 clk: imx: imx8: Use clk_hw pointer for self registered
> clock in clk_parent_data
> 
> if not, please cherry-pick it.
> 
> The audio_ipg_clk can be selected if there is no other choice.
> but the rate 175000000 is not accurate for 44kHz. what we got
> is 44102Hz. This is the reason I don't like to use this source.

Thanks a lot for the hint, in my test setup I indeed have not applied
this commit. I tested it now with cherry-picking the commit and with
applying the change to the dts. This made it work. I will do some more
testing tomrrow and if I can't find any addtional issue I will use this
as a solution. 

Should I add the change to our Apalis board dtsi file or directly to
imx8qm-ss-audio.dtsi? I think it fixes kind of a general issue or not?

Thanks for your support
Stefan

