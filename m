Return-Path: <stable+bounces-15540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08B8391D5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 15:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9729E2862AC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A65DF3C;
	Tue, 23 Jan 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMN7XytF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738F50A6D
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021841; cv=none; b=RvPKeIHq0J03PL9JjLjuUQSMWdV4I9HkMcqMCNEduvhz+POHMUxfcsgdB3qz2MesWfGSSHuh6MnFD7A+DbrcWMZfPzfRH/KLvQO6Mvve0rYbMHG3jchGRQ3T+KCHEW23Kx7MWoIpI6eVoTQbhkMv9Nu/hSCKXTXwiAM6rRyjQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021841; c=relaxed/simple;
	bh=OEOMWTOeHMC8LbMpgkDs4kdAWbWi7Wm2wLN/YTNKjnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlxDhPRZnn2RpGvD+WpXfEpq+X9xjr/hxBoS+dzaz9yIDt195LS/7v9ypLnNDYM8Q661/splGLzK8cfndK7gq1U8CoNDiODdJiPzJcdWuum632IVpCTDRNw6tRnyFbw6EhscNFv4TPb4DagDMt3qdbOkNMgnuHfaThhhQj21440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rMN7XytF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6002a655d77so13640737b3.2
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706021839; x=1706626639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vrNkOuwNFtND2EG7v6Xrvesdx8TZWr4RyzW0Ux+jECA=;
        b=rMN7XytFOseBayyXnhtUAQXmHzgkoWTKH//alztgbsJmJHeByUMNHWxY2mMiyAIhoe
         1xxHO7XatUTMIcR+6uON6am1dmTkWZ4EFpaA6WPu4uKB0NvjbM54sJrADASZhA8uTUO4
         vk1kNPO+rmUy6ntc6maxC+iT3f16gzA5P6DYFuoq9atk0H8AxUCRJvwqVscSY3YIrW+Q
         AHaQedQxDaJrMw/qWolcHyiaoirkybJtUHPUBcuqIVDMtpgQo1mG/0/cEbeujusPGpq5
         Jt7hpIOkqiGhJUOhaQvD5JeMYlCK/z0LUxuA2jL+kcMKPs1pqPzAtXPr7+B1mpU1EK/U
         HlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706021839; x=1706626639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrNkOuwNFtND2EG7v6Xrvesdx8TZWr4RyzW0Ux+jECA=;
        b=Dyu/uqCNcCYkm8L948LLs03a49UVJ1lanZ696BdQjgyg4EVR+ouGj/LlA5Dv049rFe
         jsQCodk3KmGnXbqxRZeCDcIgRtJzTGOsE6sLMh0Qp/Moiv7MNbi5KO4w7hapQw6L+rYZ
         wfxE0I1nADZSxad7s3phBhrNcwO1XauXT+dLyXS+WnbPJyhRKQoo3db8qZ8vj+ZXMqD6
         0VEhqrfUnfcDhGTK1pKcH5CiQdtNbWe7tv0R0DbTga4QfFdIVrLKn9qOkrvFmDfJu5U2
         +hYFkfN6luiy2AKRFSLRV7s1GS37xzQNibY8+Jjwes2EjpKzuLuvwumsQ9rvl8FYSlrx
         2r3w==
X-Gm-Message-State: AOJu0YyXaV5JvIwyCNtUmDsXMX6XlNTB2nXzGcq7JqWju6AfcfRuu9nt
	+pSbn2uHnCYpueekWLfjmQ+TmFNR4Ye8Hjvq+LEE5Gr1Ssi51D6dixPjpIs1sTop96VGWXQFMz0
	V9vdrlS5XWBvATxSLPmB/wtKl9ET9T8TPyEie0vQ9oAg4O6q3
X-Google-Smtp-Source: AGHT+IEwGgdGS6j3b73t2bhroV+V2DhZ194hO3IyNOEKWxVRBICLfz6Jfxh3BFZyQ1qS138iqow8DinpWu4m+InBsR4=
X-Received: by 2002:a25:d0cd:0:b0:dc2:28e7:193f with SMTP id
 h196-20020a25d0cd000000b00dc228e7193fmr3583852ybg.35.1706021839284; Tue, 23
 Jan 2024 06:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235812.238724226@linuxfoundation.org> <20240122235822.085816226@linuxfoundation.org>
 <CACMJSevr71oSy-CjUKkyXa4ur=mQL3R+PBnJUWQB-Pw3yp+kgA@mail.gmail.com>
 <2024012314-distill-womanlike-77bb@gregkh> <CACMJSevTCk+HkeBC4YbmiRrzViwBNi9r30wdDKrB8J92YBcu4A@mail.gmail.com>
 <2024012300-print-deceased-ea31@gregkh>
In-Reply-To: <2024012300-print-deceased-ea31@gregkh>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 23 Jan 2024 15:57:08 +0100
Message-ID: <CACMJSet6xZ3CDpiz3JRr8Z2u1EKUacfrxLXzWyxUS1vvPuYLMg@mail.gmail.com>
Subject: Re: [PATCH 6.6 328/583] gpiolib: provide gpio_device_find()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Linus Walleij <linus.walleij@linaro.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 15:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 23, 2024 at 02:13:40PM +0100, Bartosz Golaszewski wrote:
> > On Tue, 23 Jan 2024 at 13:48, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jan 23, 2024 at 10:56:50AM +0100, Bartosz Golaszewski wrote:
> > > > On Tue, 23 Jan 2024 at 03:03, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > [ Upstream commit cfe102f63308c8c8e01199a682868a64b83f653e ]
> > > > >
> > > > > gpiochip_find() is wrong and its kernel doc is misleading as the
> > > > > function doesn't return a reference to the gpio_chip but just a raw
> > > > > pointer. The chip itself is not guaranteed to stay alive, in fact it can
> > > > > be deleted at any point. Also: other than GPIO drivers themselves,
> > > > > nobody else has any business accessing gpio_chip structs.
> > > > >
> > > > > Provide a new gpio_device_find() function that returns a real reference
> > > > > to the opaque gpio_device structure that is guaranteed to stay alive for
> > > > > as long as there are active users of it.
> > > > >
> > > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > Stable-dep-of: 48e1b4d369cf ("gpiolib: remove the GPIO device from the list when it's unregistered")
> > > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > > ---
> > > >
> > > > Greg,
> > > >
> > > > I think there's something not quite right with the system for picking
> > > > up patches into stable lately. This is the third email where I'm
> > > > stopping Sasha or you from picking up changes that are clearly new
> > > > features and not fixes suitable for backporting.
> > > >
> > > > Providing a new, improved function to replace an old interface should
> > > > not be considered for stable branches IMO. Please drop it.
> > >
> > > Even if it is required for a valid bugfix that affects users?  This is a
> > > dependency of the commit 48e1b4d369cf ("gpiolib: remove the GPIO device
> > > from the list when it's unregistered"), shouldn't that be backported to
> > > all affected kernels properly?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Eh... It is technically a fix but also this has been like it since
> > 2014 and nobody ever hit the bug (or bothered to report it). Ok do as
> > you wish with this one.
>
> You all marked the commit as a fix for an issue, so that's why we
> backported all of this.  If something is NOT a fix, don't tag it as
> such?  :)
>
> Or, if you want, we can ignore all patches in the gpio subsystem that
> are NOT explicitly tagged with a cc: stable@ tag, if you agree that you
> will properly tag everything.  Some other subsytems do this, but that
> increases the responsibility on the maintainers of the subsystem, which
> is not something I would ever ask anyone to do.
>
> Heck, for my subsystems, I miss tagging stable a lot, but the scripts
> pick up those that get Fixes: tags, so it's a good back-stop to solve
> problems.
>
> Again, if you want us to ignore any portion of the tree that you are the
> maintainer, just let me know the directory(ies) that you want and I can
> add it to the "ignore list" or you can send a patch for this file:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list
>
> thanks!
>
> gre gk-h

No, I don't want you to ignore the commits without Cc: stable. I may
have been too eager to react but earlier today I saw Sasha pick up
patches that were clearly adding new features and *did not* have any
Fixes tags on them.

Nevermind this message.

Thanks
Bartosz

