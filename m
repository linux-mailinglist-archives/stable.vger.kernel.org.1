Return-Path: <stable+bounces-111896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33524A24ADA
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07331626B5
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F4E1C5F35;
	Sat,  1 Feb 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="e0C0ZVk3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84021C5F0F
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428909; cv=none; b=jDaEEHEIkFYIIkmDTmJYe690Y8z0ZRkXY7tzIEl3SbOnzNNg1ZeCfnytrEzqdNXhIQz9LXkJQA0z0Tc7evd/RlavTRbmlAFbhnHMwkt3WGpphwwzUEBcqsir7LrPa9y1QVaxHm7u1z462yB09TeiqefJ2qgHjn//sH4LPqCGqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428909; c=relaxed/simple;
	bh=DQmCx1UzC+wZmb/DNTjP2+1lGenSItgsdE3BWkM4Ha4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQFpEHIroZfU4a3Ho+qEu4yW4V5PCK8lk+T25Hb9GJhUamFMhE1bxOLczFCKteh10Up/sLSyE/VTM5e+kslGy78p+xYu1v5g92CyVIAbkmdBKnmS8a0Kcn477E11EIbJpfCqnWtwPH/jNX7rCHbcixPP0cnP8Ce0MaEdQHAB8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=e0C0ZVk3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ddcff5a823so22048386d6.0
        for <stable@vger.kernel.org>; Sat, 01 Feb 2025 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1738428907; x=1739033707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4nxUHBFvGj81Oack1s7zBa0JySTAfnkZqGP49lK0Cew=;
        b=e0C0ZVk3WaxfugOokJjSxV81HRu0dc6wtSrSx48IlitK/9w8/XPJsdWWln2Yz/RaR0
         N67wsSv8uG3L1MI0r+wEyGZYJatNzOkA0PGJQmHiZq1XaPLwTYD6GGFkiF0hJWDkVAJc
         ew899cwT7w3/yrMh/N4zQqiiNIF9gcanlxqP3pkOg+X0mSeYWTTifA7hdzOJj44W4MHJ
         J7c+iCp/WzvUcy3RkGlmlLJlTFNqV8VhC/7myhz8UYxndVfoCki4jM14LHEwIg1rbJk5
         MQWSezZUFFtfpGiuEAvomARCSTCIrhTMYeJjoBAYBZ0d+IUw6ly3QyPSWs72tW1gb+EJ
         HfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738428907; x=1739033707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nxUHBFvGj81Oack1s7zBa0JySTAfnkZqGP49lK0Cew=;
        b=qCbu58JoCm7LOlWY3RqRfg92K339iqX2n9kAYTfpfYqOZyTrhPH4I4754tho91XIPb
         Ovd4ngbL9VY1Ac/AGpwJkXi647IhgJEKqMLtxsE8VE36MRhd15V2Jr04FrWIyyEyU2/j
         JgphD5MaFQS/NfglbWZuVQyOZ3tRA/Xc2BYzE2mtzImMti/ntssQoUclJCt6+AyOX+oc
         jYd4jyb/5CFrAreeG2PuVNYN+sxT0LX/kMvdijgjUuOeXyawGqe5OcUFVIAx5p/1gEzo
         Ju5P5n3+uKdNPwL3Q76XpjEc0BiUMws+Em3z9x0DWxc0dzQhuDJAAZiGja8mLkvcN5V4
         8Crw==
X-Forwarded-Encrypted: i=1; AJvYcCUK5phcg5881bY0hoXDAiamCY272sLoNFVIupDRgRh6q8qRDx/cd7p6wKaXi12HIYVRyWmRhqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30X8AivhoNcA5aN2ny9MP0pPFDJcF6G9WPwY3lHvatikN7cAV
	fCoKGJAvpl7i1gqSiHCHBYXajOxmXLPQY6/1SMgQ3LYXLqkps7gS030Gzc5Zd742gUNB7wK5tOw
	=
X-Gm-Gg: ASbGncuNAuC6RhmzaN3EwvMwn0D0/9tlIIqBaabyKMgdJyzaMOa6la4b5b6OwdoxfaA
	bNbGqkDVthGEKZd62cAlmsNctckf1jtcpKWcZLUI2fL4EUBtCc9xt3KG+TYQnX5z4u4aZ6DnqA7
	4dusE2DzsuiVTS5MuipBHV10WmqchIBfICsbuwlc/P3V+1tX9mgTV5QY/cHyHma6vZpOS8uq28f
	fVnNw3ID9y9hOHpAB0nD5U6hVf5i/daC1MtWs+ZVdlfPx/xUA3Gv1u9wZozzSs/AutG0y41VWy6
	NYlXxC/f0yOnCdIr
X-Google-Smtp-Source: AGHT+IEAmw5GFbOYKfZFPQolGMSY0m/awA0DFxPabq5SO2pH/P9s7vEQcjVulqZpIiIC0bo8IQJdDQ==
X-Received: by 2002:a05:620a:d86:b0:7b6:742d:c01e with SMTP id af79cd13be357-7bffcd06ab7mr2460374285a.25.1738428906791;
        Sat, 01 Feb 2025 08:55:06 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::2aef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a905597sm313250085a.88.2025.02.01.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 08:55:05 -0800 (PST)
Date: Sat, 1 Feb 2025 11:55:03 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
Message-ID: <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>

On Sat, Feb 01, 2025 at 02:42:43PM +0800, Huacai Chen wrote:
> Hi, Alan,
> 
> On Fri, Jan 31, 2025 at 11:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Jan 31, 2025 at 06:06:30PM +0800, Huacai Chen wrote:
> > > Now we only enable the remote wakeup function for the USB wakeup source
> > > itself at usb_port_suspend(). But on pre-XHCI controllers this is not
> > > enough to enable the S3 wakeup function for USB keyboards,
> >
> > Why do you say this?  It was enough on my system with an EHCI/UHCI
> > controller when I wrote that code.  What hardware do you have that isn't
> > working?
> >
> > >  so we also
> > > enable the root_hub's remote wakeup (and disable it on error). Frankly
> > > this is unnecessary for XHCI, but enable it unconditionally make code
> > > simple and seems harmless.
> >
> > This does not make sense.  For hubs (including root hubs), enabling
> > remote wakeup means that the hub will generate a wakeup request when
> > there is a connect, disconnect, or over-current change.  That's not what
> > you want to do, is it?  And it has nothing to do with how the hub
> > handles wakeup requests received from downstream devices.
> >
> > You need to explain what's going on here in much more detail.  What
> > exactly is going wrong, and why?  What is the hardware actually doing,
> > as compared to what we expect it to do?
> OK, let me tell a long story:
> 
> At first, someone reported that on Loongson platform we cannot wake up
> S3 with a USB keyboard, but no problem on x86. At that time we thought
> this was a platform-specific problem.
> 
> After that we have done many experiments, then we found that if the
> keyboard is connected to a XHCI controller, it can wake up, but cannot
> wake up if it is connected to a non-XHCI controller, no matter on x86
> or on Loongson. We are not familiar with USB protocol, this is just
> observed from experiments.
> 
> You are probably right that enabling remote wakeup on a hub means it
> can generate wakeup requests rather than forward downstream devices'
> requests. But from experiments we found that if we enable the "wakeup"
> knob of the root_hub via sysfs, then a keyboard becomes able to wake
> up S3 (for non-XHCI controllers). So we guess that the enablement also
> enables forwarding. So maybe this is an implementation-specific
> problem (but most implementations have problems)?
> 
> This patch itself just emulates the enablement of root_hub's remote
> wakeup automatically (then we needn't operate on sysfs).

I'll run some experiments on my system.  Maybe you're right about the 
problem, but your proposed solution looks wrong.

Alan Stern

