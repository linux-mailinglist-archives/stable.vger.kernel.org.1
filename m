Return-Path: <stable+bounces-119456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D8A4362C
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 08:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD977188C9BB
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCF25A2C8;
	Tue, 25 Feb 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pkp2YFwJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728A25A2BE
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468559; cv=none; b=GbV/OCq7jF3tn355ZRnJ/wqY5hg3yoChXOPP485q/+A5qbFPm2PRvdMEDQ2C6K9wSCoPa3R2I0ls7peEDMK2NSnihArjLs5xUYgaTxSXw/QljexC2rg/WSBp4GU3nAYnlLBNWAWeTLXYOjGMyHbhkKThI/uJh0x2vTZPwNHhr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468559; c=relaxed/simple;
	bh=zIvaaoQGm7KtfdZ12vZ6A5bV0odA8xANuXpTVcfAHfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+QjnFMKdpPBkyLW05Hh4EMJmsPnY6QmnF/MfRw1tEnsqKUR+Ca9DmQ/kyZIzOtktZpLCplb+SDmBZ1b6oyTP54uWmrEJGOehHquEGS/60oqHgbIJ2Lx7HDatQQno0t6H1yWA1VVraLY2q48OFeMbwfC0Fv03esIBNafd0CxXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pkp2YFwJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fcf90d09c6so13776187b3.0
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 23:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740468557; x=1741073357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YmLM7oHR00hoPy5F7b3VDNoInC9XlQISOKmVVqo7gNI=;
        b=pkp2YFwJ8UdySUpGyfT32apwslskcRIbjO6kPfuP/yOZjJ93xrqIe7WHQ/m4OmhJpE
         ZGfuwhBgoiMw+w+h74fGzUkWrtrSfbfBC5YwoHIo9g/Yt3yaMJoT4HreeBq3O6QHOk3M
         ODA5W/Fox1jpqsGrCK9U0iuBEHXGgA+fzXMRflaYAHJ9VIA7E4F5nhCh87y4hdsW1UbN
         QTbe0F90jC8RNXP08kkujpAHQ5M5nsBTrlmVFZ/0bwjSBNGxXsZABTXHIbnODFSkfj5C
         1xUnJ3fQsHSBDxa9QILsCqr3K4MMOZzLuvS/Uk81yo1WKu6K1MPtYwGdKQSaDNfZXDfo
         Assg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740468557; x=1741073357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmLM7oHR00hoPy5F7b3VDNoInC9XlQISOKmVVqo7gNI=;
        b=wM3vlPQmI6u33ZcBVZK7XfQXrVr4LFBesqcck38t8j5cFUsGEomQQvtFgnv/lvvZGo
         oA9ijZom8WWt1qG3p8unLPKQudnt5tXDB8aMbUYKR5Jzgkx1R/v0gffAjTOUZgfMo+5Y
         LxOahY8jevWMJCSFK7RFhLM/jI/WCj2qscChdfrz1v9hhw1rcIZDiW7Y/LVa8XQvgLSK
         S5HcZNtgn+hIr2ttM/eCRPiT7r7cHCwWLOPKxMR6/0Z5AydPhLSMtcRzoPx3EgtBinRf
         LGeYjTzJ/XfU5VkMEKA+VTx1DEo+bNvbIFMxg2oebBhbTuJgQI/0/tCSIWzfH655PmRw
         Itbg==
X-Forwarded-Encrypted: i=1; AJvYcCXG+42Q1ij4vU4rEb2zfnJX8RxHEbOsgnAFpXI/3lhZNLwrNz67B8ZO/ebcIZAd97pJDz+RaCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSMECoCD8Ph1u1NTGTgrdr7lwFY8uE8OwmvKMtw6qLiFtAIA5
	yVIqTZZ1b6p9VMnFA12iDrvY5rVGEgROxLReofdInkt2lhuio60prDg5oUwb8j287P3SozupHiZ
	Zcf+n4lpNpfG9Gp0Fsxoclb95Kn+FaHrMQ1zUsA==
X-Gm-Gg: ASbGncu4owgLaOYltwWEZ6/RFVWeUm2vUplLxkd2FPs1G+Giy6YWKF5uB1HFGntq5ny
	C8+JvM6I0Mt2uIf1j1DE8pCmu+YNfDGUKmzAqF7BKUPiZu4qnvorcEnipypXJDaRphJObbxhD/n
	yD90MihU4uYAWtEzJdyPy7Kd2mlnJ04wCrXfEYVYw=
X-Google-Smtp-Source: AGHT+IF9jdcF1gQYWcqJRP7dskBg5Xa5PlysLeHiljmo+uvVBKR+01JJ5+3ZW148YC22+F7vV3ocHacmYQVxaxc3wzI=
X-Received: by 2002:a05:690c:3687:b0:6f9:4c00:53ae with SMTP id
 00721157ae682-6fbcbc8c426mr119358127b3.8.1740468557236; Mon, 24 Feb 2025
 23:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224142604.442289573@linuxfoundation.org> <9a18b229-f8b7-4ce2-8fe0-4fabd7aa6bd2@sirena.org.uk>
 <CACMJSeuQkzvi5j975bbb6gF=+NMz0Aw-X5xLXR=8rMUjeQUoZg@mail.gmail.com> <2025022548-swiftness-supervise-ae80@gregkh>
In-Reply-To: <2025022548-swiftness-supervise-ae80@gregkh>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 25 Feb 2025 08:29:06 +0100
X-Gm-Features: AWEUYZnvrzYRtYLYeSfKngXkQZhA38Ce1zhEnS7-WwuvLBTGBLkn-dt-SFzkyZ4
Message-ID: <CACMJSesFVOp2t5C0mhB-=8m3reUtuBnMrcTShj-duEpPX1iocg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 07:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 24, 2025 at 08:57:10PM +0100, Bartosz Golaszewski wrote:
> > On Mon, 24 Feb 2025 at 20:52, Mark Brown <broonie@kernel.org> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 03:33:50PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.13.5 release.
> > > > There are 138 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > >
> > > This and 6.12 are broken on several platforms by "gpiolib: check the
> > > return value of gpio_chip::get_direction()", as reported upstream
> > > several drivers break the expectations that this commit has.
> > > 96fa9ec477ff60bed87e1441fd43e003179f3253 "gpiolib: don't bail out if
> > > get_direction() fails in gpiochip_add_data()" was merged upstream which
> > > makes this non-fatal, but it's probably as well to just not backport
> > > this to stable at all.
> >
> > Agreed, this can be dropped. It never worked before so it's not a
> > regression fix.
>
> Ok, thanks, I'll drop it from all stable queues and push out some new
> -rc2 releases.
>
> greg k-h

My bad, I should have just queued it for v6.15 without the stable tag.

Bartosz

