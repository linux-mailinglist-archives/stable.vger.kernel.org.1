Return-Path: <stable+bounces-108682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4585A11C0B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE41884684
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD591DB14B;
	Wed, 15 Jan 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6fqVA6o"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59A23F286;
	Wed, 15 Jan 2025 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930018; cv=none; b=N6NdOS1h2RAE+F3zsEoYUwtkb6k5XtlhzO2aIPKmdqDKmuOVGD5+uaVLXjlFMPKjZAoBJHVfFg3ZQpEBEh42w5++oLzFIiY33WlWRdkWW2nhmxadUN0h/zKNc4SBEVctYv/azOm5imVUo+wOZyDfgt5mkG98UbHhroP4TV5jiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930018; c=relaxed/simple;
	bh=rr5s78EC3w/9YyGhSVI4b1y7Fm81akbFuF8CSzmLsUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pINOfkbx8sj3sDVmNVAPC3CmNjPn/Mjy+mS9qMgqwZmqOniwBqqwTNHzYDQxpctenziS8uOj/b9Y/LL4cxGmm1upq0+njMXx2ftOiDlan631B1V1b4WRM7bbi0FKN7922elC0CJUR7pJcgacz0QbiyHZjULm4CfVG6qGAWLrNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6fqVA6o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436a39e4891so44243395e9.1;
        Wed, 15 Jan 2025 00:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736930015; x=1737534815; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRbGA5hfKNQNoBMn6E9hxMPXAsQYQxuMoAfdDX+Ku3E=;
        b=N6fqVA6oNb6SWK4ZLNQflD8y9Mw0S0Sh/g9s+FkyHjEor3LKfacCFJQaLpknLLxZRU
         al6VEQSpKSh5X6ESZY2RCoXym3SV1uL+CpFflAWtBnfT7hbGyGtt2Dw6KVXESBdeL+dV
         LKZv1vLt1wzWukkN2A2Lb4XCRO6u5muTfcuSKaPbSQaq5x2OKZElKnV4QiF2dnm+eLN0
         xuD4Ov/QTKAl8LB0ls+1FMxH/klXvTA0x8ugzu5eH36xe8O1gDIsIzyuO9PKOA69v74r
         MLtOSv/xUlpvDzJYpHr6DzxLVXMOjzHbdC8ck6WICy+w06jD+OwlQNMTJqpgzpqJAPVB
         i2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736930015; x=1737534815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRbGA5hfKNQNoBMn6E9hxMPXAsQYQxuMoAfdDX+Ku3E=;
        b=wSb0Bo1l2O+aeqlqNOtLqHw0TnrdkjDmyM3QHGlDQcAZXGaosTvzgD0AHyt3WjiJ9D
         nDAa+qTqxH97eWhtlwUauk26GKQ3ez3NM9xWsaLsDSVSIotbjBDYxOv3b8jI6LM/DfOp
         6+YB7uXlAInR//9Ew0sXMay4dvowpwZt8cKjDhsCGn0vYz3Tqx1ef9RMzKbNf0iwUvfz
         L3YiTt8duCIkjnuNzjSZys+L5mwaeVPB/j1HKrV12+nLYyb4nlliZEMO6hKVgjUaIuRm
         QKvqc488a085YnL+oFpZOebKGK6rgidej7Sgi8E6RxjYIieCQfGtPhBcJD9kHcazERSs
         Qurg==
X-Forwarded-Encrypted: i=1; AJvYcCU9lpDQaC1DvM91IeOEO92/tTLt2234hcmw7EvUx0yNgmv0Z0MTjbYV0zDwBEnRvBEslX5yVk+DEyQ=@vger.kernel.org, AJvYcCVE+BmDGnZW6WPAalbF0tFXtCLbArSS+GMk+5mk1PkwPQvpr5xiLJPCl2AxBxVRhfxTLYyQjqhL9rSp9hcJ@vger.kernel.org, AJvYcCW8xrby+txV5vZtktr8BGLe068e5i+2fjzxzbSYaeYx80xZktsAmqvHWKGHsNhFFI/iSinTLIjD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkt6SW5RsDpHPDm6mxLElRzEZPP62Z/7Z7pjd9io9H0BVcgd39
	1f3JXkkcCfB5Efz+6k+sjStnCPoMEfEz3vSjZOpYNwuWMcTy+MxJBWKdEepD
X-Gm-Gg: ASbGncuxcLfjqNjOzKfj5InIWhkKQhhn8b+2DOYPwPRQkJkh/JPC8xeMTvhrKtjKpfl
	wZhuiqVmx1mXVphaNOxGNc0IZdpzJXZBsNPY0FjQPFWqUT3jJewZAFmjyQAM+Uxauoa7klAVj93
	Ef4YHbHd5iEtHj39mJuSzpFbWPOYnBRo0LDWDY9IPlKxeihVWDEq03XTNyQB4ir9uV0GDquSnN3
	fAiOfFPmRjB2TgJ4NujvlkuUlOFzoGaA406OqhnAb+8qs++BQs7WVPIyB4iOEE8YElW+DOp/HV6
	mm00iDf6
X-Google-Smtp-Source: AGHT+IF7Dra5d6ki8O3COk+SLqWcJq2xaGIUHP116tcbjhTFS3reuK1GgRmhqIcUq60sOxi9rfERQw==
X-Received: by 2002:a05:600c:3b99:b0:434:f925:f5c9 with SMTP id 5b1f17b1804b1-436e266dfe9mr223940145e9.6.1736930014457;
        Wed, 15 Jan 2025 00:33:34 -0800 (PST)
Received: from eichest-laptop (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c749a127sm15360785e9.7.2025.01.15.00.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 00:33:34 -0800 (PST)
Date: Wed, 15 Jan 2025 09:33:32 +0100
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
Message-ID: <Z4dy3LiEAQ_gkQGG@eichest-laptop>
References: <20250113094654.12998-1-eichest@gmail.com>
 <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
 <Z4ZRYMf_uJW4poW9@eichest-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4ZRYMf_uJW4poW9@eichest-laptop>

Hi Shengjiu Wang,

On Tue, Jan 14, 2025 at 12:58:24PM +0100, Stefan Eichenberger wrote:
> Hi Shengjiu Wang,
> 
> On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> > On Mon, Jan 13, 2025 at 5:54 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> > >
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > >
> > > Currently, the flags for the ACM clocks are set to 0. This configuration
> > > causes the fsl-sai audio driver to fail when attempting to set the
> > > sysclk, returning an EINVAL error. The following error messages
> > > highlight the issue:
> > > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.sai: -22
> > > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> > 
> > The reason for this error is that the current clock parent can't
> > support the rate
> > you require (I think you want 11289600).
> > 
> > We can configure the dts to provide such source, for example:
> > 
> >  &sai5 {
> > +       assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
> > +                       <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
> > +                       <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
> > +                       <&sai5_lpcg 0>;
> > +       assigned-clock-parents = <&aud_pll_div0_lpcg 0>, <&aud_rec1_lpcg 0>;
> > +       assigned-clock-rates = <0>, <0>, <786432000>, <49152000>, <12288000>,
> > +                                <722534400>, <45158400>, <11289600>,
> > +                               <49152000>;
> >         status = "okay";
> >  };
> > 
> > Then your case should work.
> > 
> > >
> > > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the ACM
> > 
> > I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which will cause
> > the driver don't get an error from clk_set_rate().
> 
> Thanks for the proposal, I will try it out tomorrow. Isn't this a
> problem if other SAIs use the same clock source but with different
> rates? 
> 
> If we have to define fixed rates in the DTS or else the clock driver
> will return an error, isn't that a problem? Maybe I should change the
> sai driver so that it ignores the failure and just takes the rate
> configured? In the end audio works, even if it can't set the requested
> rate.

The following clock tree change would allow the driver to work
in our scenario:
&sai5 {
	assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>;
	assigned-clock-parents = <&aud_pll_div1_lpcg 0>;
	assigned-clock-rates = <0>, <11289600>;
};

However, this means we have to switch the parent clock to the audio pll
1. For the simple setup with two SAIs, one for analog audio and one for
HDMI this wouldn't be a problem. But I'm not sure if this is a good
solution if a customer would add a third SAI which requires again a
different parent clock rate.

One potential solution could be that the SAI driver tries to first
derive the clock from the current parent and only if this fails it tries
to modify its parent clock. What do you think about this solution?

Regards,
Stefan


