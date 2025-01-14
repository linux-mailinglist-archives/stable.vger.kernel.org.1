Return-Path: <stable+bounces-108589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE0A10605
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 12:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76823A86B7
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988E52361C2;
	Tue, 14 Jan 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzE/QVvv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A02361C4;
	Tue, 14 Jan 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855910; cv=none; b=LFC6sR6h5l1ZVlfLBgkxeRMyjuIDNtq2VgnM2iZFiYfLbFmNhGxqYKvxJqDgZfl0ZCyntvi124DZtLPJ+pepxFRYaziz1XhScXO/EkXQeFwGAHtH+bAXBDOAUSxyfWDy3r2//4304DOkvkd+kHdvyZuKT6peXT0o5hvax9qNXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855910; c=relaxed/simple;
	bh=cAoPGZ5WniJLhFe6ZhvWTcohnLZfgZFpQiLS6/wxIUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdEo2DqJ8ScdNKRuSECyZOwt/b9hRCkMxiSRHtsSHTn97d0R+jk6gj+dAN7V8tXFqzn7ePtw1fYXUuwfVFJdPqRbXpCT9EM3LTtqJjmOhptGnwI7q4N/eVeuaRSb4YhHRodivgEZvYgiilldN/m1dQyO+AFsT1tAbcPtP52KFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzE/QVvv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso6961488a12.0;
        Tue, 14 Jan 2025 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736855907; x=1737460707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=keaeHuBnA6yPk+ht4Eab1BXo8HSV7VPRSpTgBTborOU=;
        b=ZzE/QVvvzjoFRdBK6nOG/vMsmEZseFTt0DwvzBXXsUr00aOYkWYBAPL8+DJKpbm2lF
         8IiYEOVqkqL1eFaf5619uYvxHCS6OjDXJMoHMQ9N371X8FaA/X05+xFg6YbhkbQ/JYBW
         ZnT3Oxg/r/Q1FXVFws1HE/xlGUpZv6bUzI1NRtKlIKfGleyC1ALxpf05b+TtGcPeacvR
         AWiXjDnVZC9mvT/Gs4ni2/aMldeSTf81Rw397GrFy6wb7qIupdwq/vpD87Qr2p4dSz2B
         0PtJTbxRcF9Yx7nQ11DgasaMcvivoDHPfgSQlXr3cZOBMQGBdlv+tFMgifCHzKjf4zk/
         WnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736855907; x=1737460707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keaeHuBnA6yPk+ht4Eab1BXo8HSV7VPRSpTgBTborOU=;
        b=GPeNXl+qqlIUgZWD6pKF+obFC+mFBu9wOhVSWZux3x5G12s6WrDy0Ypcrbz/QP5zH3
         fA+s7Zjb4BAl0IAuT8qqCWJ6OL9GxOJrUYBTXRhM90a9YgNcj1if4sUJUlLA1ER0DyzW
         /47XeWM2OMGYq7XW5ei0HBWp5KEhYKUJdwvIeW+F0xm3bNXOLpPCtGvY0gYsFIiYO7CX
         N34zZGZ/FUq4aZf35oiInFYUy08w24B7f8tX6MRolDuAm6dorxmfIhnCVy3VB48bC/lG
         rl//dWkf4GLvkYAVmidFeajECQPmLl0uDUG3yT/vSbVDQx1ABNcs0lDkiHkEAMOFUeCZ
         MfGw==
X-Forwarded-Encrypted: i=1; AJvYcCUwCCYQgcp0hXLgTzvVqIrRjBm5bJqzHVLSJmudJabiNB7CYIiQlX0Y6ksT36RHJf/rv/vhZOiA12A=@vger.kernel.org, AJvYcCWcOGMEBHOAlYSENqVtbewbCThVcCDYxpNLhSPhHnlrSBV55go48Z7N633TBStBVsqvAjFPPGxl@vger.kernel.org, AJvYcCXqtZjxHx758zK5LzQl9zJenABPILXd8Qis23EthlFzXYyJsCEKPKFUykFWMkClGX0mLVMEpMQY9nBC8uM0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87XU1guhpNNuoFphnX0QfF6z2MM22g8nZnPgo51LW7DIUYnlD
	5IyWM6dLn/LGUcKeFZ9Qcsy2i5R79FvKMJsK0Ue6Hst9eiFq/J/U
X-Gm-Gg: ASbGncuERMrmth+BjpzoAzfIN6pLsYCu9lpNM+OsLUncEwI2Vs+43L5bd7+OIREL9Sm
	QvS2pY4fi3lBwJp/3CZuSH0wXisCIt2lKoKRnEwC5BeHNX93UOVMU/ut5PwzrsQX5fcaXzt+/NT
	QMsYYwKgLFMrm0HRBkapEESpLw1Oz7RCIM+wc6VZy3EjSuBazuG0R4nqkiFWkk1DPtG3jMwiGPs
	duJnvhOICd35FbIIiVACyBAzaMTxJbiamlVZtJi8GzdiSBfa9R7Fqpi
X-Google-Smtp-Source: AGHT+IHTulWCj2YYnNBcefAEaJouVTvuufskMNNQK2TUTyQ/FQiVcwIMr5PX23StjL4mn4QQ41c9+g==
X-Received: by 2002:a17:907:6d01:b0:aab:d8de:64ed with SMTP id a640c23a62f3a-ab2ab6fcf85mr2426598466b.25.1736855906651;
        Tue, 14 Jan 2025 03:58:26 -0800 (PST)
Received: from eichest-laptop ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90dacf1sm629151066b.63.2025.01.14.03.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:58:26 -0800 (PST)
Date: Tue, 14 Jan 2025 12:58:24 +0100
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
Message-ID: <Z4ZRYMf_uJW4poW9@eichest-laptop>
References: <20250113094654.12998-1-eichest@gmail.com>
 <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8ANvKQKJhn6qKbPhQeXPD5kxUo3Hg-FBLkDMOaWLTA8vVg@mail.gmail.com>

Hi Shengjiu Wang,

On Tue, Jan 14, 2025 at 03:49:10PM +0800, Shengjiu Wang wrote:
> On Mon, Jan 13, 2025 at 5:54 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> >
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > Currently, the flags for the ACM clocks are set to 0. This configuration
> > causes the fsl-sai audio driver to fail when attempting to set the
> > sysclk, returning an EINVAL error. The following error messages
> > highlight the issue:
> > fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.sai: -22
> > imx-hdmi sound-hdmi: failed to set cpu sysclk: -22
> 
> The reason for this error is that the current clock parent can't
> support the rate
> you require (I think you want 11289600).
> 
> We can configure the dts to provide such source, for example:
> 
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
> 
> Then your case should work.
> 
> >
> > By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the ACM
> 
> I don't think CLK_SET_RATE_NO_REPARENT is a good choice. which will cause
> the driver don't get an error from clk_set_rate().

Thanks for the proposal, I will try it out tomorrow. Isn't this a
problem if other SAIs use the same clock source but with different
rates? 

If we have to define fixed rates in the DTS or else the clock driver
will return an error, isn't that a problem? Maybe I should change the
sai driver so that it ignores the failure and just takes the rate
configured? In the end audio works, even if it can't set the requested
rate.

Regards,
Stefan

