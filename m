Return-Path: <stable+bounces-88208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB89B13D0
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 02:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D531282CBD
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 00:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45B20ED;
	Sat, 26 Oct 2024 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="IONi7o3u"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFBB660
	for <stable@vger.kernel.org>; Sat, 26 Oct 2024 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729902208; cv=none; b=lYdaSKYTVvnBg9vj0IJHEKq2Wrp2wj+xfPm7GfL7YJ/wVycm/XlqulwU8SOqWm77IUkxmPem3gMv3zvqOuwDAqNx1GS7IUVLRH7sqFYLsUHiP8asbi9lKuGIyIRmnJ78zhvBCQAS/eSVTTyNRpDWUlyAWtMy3I2ngzPQTCKtFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729902208; c=relaxed/simple;
	bh=kHhUUsS7acJboSqyOaR4b0wxr2z4CQuptpcP3cOxPOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1MhVMZcrIzYMi/YsF4YQiB8a3u+7VOPz4tY++oaLNLdo+eHjOPSZnGmzO3m/jSmgh07NNoTMpIxqX0qwHBQnKrQnJS8dADvS40DaCQF1dIU52zejRy9Pu7F4H9eSFfEg5AeKqJOUdcFxMhSzRmyhNJAbuipW64xVWlmfGtHSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=IONi7o3u; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so1879422a91.2
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 17:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1729902205; x=1730507005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kHhUUsS7acJboSqyOaR4b0wxr2z4CQuptpcP3cOxPOA=;
        b=IONi7o3u32UCam1LRvPRs9kNYcHuApaJBdhMjsY2O6d0dG+gXrdSYuKtBvff+8SnZD
         P6W2S+Bq+zul15drH4+0CmAEYICoKMtkgogrgqmz/mMRd1dhDLwnEQuxurIDs8IqDXYq
         7nANPsMjZ2qO+gWQspZzXBANlSjIURaiygxezXSy48TcI+kVTyPPG4PjMCdJIUnX09SW
         thO5eyAdJKq5yuww2U3kdEaNwscCDwBxoOUwOuNUkvTZDQ7aBGXZOBEaMkt4LoMoLIob
         FMDi5xBPS3abhqUSccOGqMC+98tjvkvxWxQ+FGI06lXsS1ICZWzcPrYZXLvu2BMWoJEK
         u0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729902205; x=1730507005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHhUUsS7acJboSqyOaR4b0wxr2z4CQuptpcP3cOxPOA=;
        b=tFJvvkN2nMAyoQLMWxVaxEyf34zReZDMnxpA5qi4D9EMgNkabq2jgZ6NPmz0zrgzwu
         aZFQW17DVo/XXUhnG1MYc4xZ/w0eivIkD4cTxHkXHFqDAVGtLVx5BqPQ/Rp87xLHgcI6
         2Fy2l4HZ6Yxe4mO1M/30wDgh2Eiy67BvcnzESp12r7Ks7Onp08dj1koNt1oTtQIxNysm
         4NyVKZk4R4sSPy95k4rPfYeiN8kAA38Wldvqw1aouRHVumZkX6G/k23B+XJni4Eky95P
         +khwfcHTEzmN74dZF6qt5he5wNVZTDLdTK4ygWGVXKjk2ebsr2jjslHZXHbrZBRnnMdP
         VICg==
X-Forwarded-Encrypted: i=1; AJvYcCUkj+3b2T6eUuikAerLGmc1EZsGowV5YHPXUvqlTBLIiGbpysjbt0tw4DUPk8NUaD/t3f0d4v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6wpsmFtLFGbD7oWSv/XmVjCcVIZvHHAjp3/bqjYlPItprYSP
	cJwHZneZU0z0rAUApq2JXXeceNuCTyQF2hR0RPEWyw5k+lzJ9YMibbgUM7JrH+lomkUUdTzNX8G
	0h/N9cN9Wk77zr3B+X6N4jC1ibuAW/sACIL14JQ==
X-Google-Smtp-Source: AGHT+IF+e3IRvBmjVpfJ/vxYU8vFlrWmYswc5pBL+hm7q7VnV/9ycdn4zyZKiMu8ons8xjFulaoKdAI1FVJ/t9ECa/c=
X-Received: by 2002:a17:90b:3849:b0:2e0:ab57:51ec with SMTP id
 98e67ed59e1d1-2e8f11a82c9mr1465674a91.30.1729902205319; Fri, 25 Oct 2024
 17:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
 <2024101613-giggling-ceremony-aae7@gregkh> <433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
 <87bjzktncb.wl-tiwai@suse.de> <CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
 <87cyjzrutw.wl-tiwai@suse.de> <CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
 <87ttd8jyu3.wl-tiwai@suse.de> <CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
 <87h697jl6c.wl-tiwai@suse.de> <CAEkK70TWL_me58QZXeJSq+=Ry3jA+CgZJttsgAPz1wP7ywqj6A@mail.gmail.com>
 <87ed4akd2a.wl-tiwai@suse.de> <87bjzekcva.wl-tiwai@suse.de>
 <CAEkK70SgwaFNcxni2JUAfz7Ne9a_kdkdLRTOR53uhNzJkBQ3+A@mail.gmail.com>
 <877ca2j60l.wl-tiwai@suse.de> <43fe74e10d1d470e80dc2ae937bc1a43@realtek.com>
 <87ldyh6eyu.wl-tiwai@suse.de> <18d07dccef894f4cb87b78dd548c5bdd@realtek.com>
 <87h6956dgu.wl-tiwai@suse.de> <c47a3841cd554c678a0c5e517dd2ea77@realtek.com>
 <CAEkK70SojedmjbXB+a+g+Bys=VWCOpxzV5GkuMSkAgA-jR2FpA@mail.gmail.com> <87ldyctzwt.wl-tiwai@suse.de>
In-Reply-To: <87ldyctzwt.wl-tiwai@suse.de>
From: Dean Matthew Menezes <dean.menezes@utexas.edu>
Date: Fri, 25 Oct 2024 19:22:48 -0500
Message-ID: <CAEkK70RAek2Y-syVt3S+3Q-kiriO24e8qQGDTrqC-Xt4kHzbCA@mail.gmail.com>
Subject: Re: No sound on speakers X1 Carbon Gen 12
To: Takashi Iwai <tiwai@suse.de>
Cc: Kailang <kailang@realtek.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Linux Sound System <linux-sound@vger.kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

I get the same output: axiom /home/dean # hda-verb /dev/snd/hwC0D0
0x5a SET_COEF_INDEX 0x00
nid = 0x5a, verb = 0x500, param = 0x0
value = 0x0
axiom /home/dean # hda-verb /dev/snd/hwC0D0 0x5a GET_PROC_COEF 0x00
nid = 0x5a, verb = 0xc00, param = 0x0
value = 0x0

On Fri, 25 Oct 2024 at 02:16, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 25 Oct 2024 03:22:38 +0200,
> Dean Matthew Menezes wrote:
> >
> > I get the same values for both
> >
> > axiom /home/dean/linux-6.11.3/sound/pci/hda # hda-verb /dev/snd/hwC0D0
> > 0x5a SET_COEF_INDEX 0x00
> > nid = 0x5a, verb = 0x500, param = 0x0
> > value = 0x0
>
> Here OK, but...
>
> > axiom /home/dean/linux-6.11.3/sound/pci/hda # hda-verb /dev/snd/hwC0D0
> > 0x5a SET_PROC_COEF 0x00
>
> ... here run GET_PROC_COEF instead, i.e. to read the value.
>
>
> thanks,
>
> Takashi

