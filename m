Return-Path: <stable+bounces-200004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B433CA36C1
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8E030145BA
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C0D33C1A7;
	Thu,  4 Dec 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmVh/C0u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD23321B9
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847345; cv=none; b=BGiGplZQsyWpPmmNJQvb88mNLlh36JXbQJD41UcVHRxUcdRkt7co/387EsN5A7+W7GpErwxDQAumPbfoK2CDQYMwq/B7hpIhvrBC8H/WmGp0pmsyO7urkTWqINnVpQJV0FjKshpiLhPRZqBUMeu+7xM8poDNSLc6JT1YFdXXk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847345; c=relaxed/simple;
	bh=2IXCVg1v/j1YucPzSMIWBwmiut4HTbsSoCXz9IRXBtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUCorRTl//+lobyeUBjES2QVBcar9N74EKfJQ65g93uMee6xCFefaXOMV/0TPakv3zIB/GP3kMx2RLiVG5WhT3SXLXFUBDbUz0F4yr7UGzdsVT9vAl10H6A4Pznstu1MHIo2Cbq2FmXqMSCqHGFIgwsgHFXUeegCNg9nTCethbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmVh/C0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675F6C4AF09
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764847345;
	bh=2IXCVg1v/j1YucPzSMIWBwmiut4HTbsSoCXz9IRXBtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MmVh/C0ud8Is2c14hPn+Q8VfxhpaTVDn8HB5MF7s34kSA7jAgJXX3qli4TC1pEaTs
	 GEMVESPiuEwzmJ87dtOmCBk5cF9v8UrL/bPHqz+f54QeXBaHhxVWAtNinOlrknyvwR
	 lodMPVb+ry+vFBh3r11ONVZB6HWh2R1baDaq5t6Y1YaL5x4I0Nu7wuWtf9exoWxyQa
	 vfDHon1EoqBSSQqvSiUO9qZYZQwIQhdCbpcFB2gUxQtRfLfwckBdu4ZmnvYnlmm/yL
	 jWYpXTCmokthozLr/eWt2pznEV1BWAKyMmERbQ2+Wmn0DFB4+q/aUpJzEVSDCyhfBX
	 rY+3NHZDBwxgQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594285c6509so837560e87.0
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 03:22:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUup5pM58eJWFuTBKsBY8pbmpDgccOcw/Uf812nn9E2RWNQkvfnG3B/FTusp2YayOborldQQv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRh+R9b8bICmMz6iE4a/UqNhrUuAx9VZ8Q5ttzzVW/TqP9o9pr
	n8VlhoVy8tdORzA9zB0WrvrBPixMuVuff0EM11G0gbPB1itALCZ8HhUvzfSDSnki/WzwJdeImrE
	fDA9pmcd7jhKNTTM3bmkdajemFiPb6uFYdWA+FK1dmQ==
X-Google-Smtp-Source: AGHT+IEf5gfM8sjb1N0TBJ7d8IJLdzQ9cdr16tjDoUas1H9x+UpUR2QFR/4FzXLIIzqAnnafcIfYTqO9ApEZnZMIV0I=
X-Received: by 2002:a05:6512:3d2a:b0:592:f48e:c725 with SMTP id
 2adb3069b0e04-597d3fb96fdmr2290153e87.34.1764847344082; Thu, 04 Dec 2025
 03:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204094412.17116-1-bartosz.golaszewski@oss.qualcomm.com> <75004da5-1ff6-4391-9839-2d134709eea0@kernel.org>
In-Reply-To: <75004da5-1ff6-4391-9839-2d134709eea0@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 4 Dec 2025 12:22:12 +0100
X-Gmail-Original-Message-ID: <CAMRc=McEX6y_9JF=ji_TQ0aSMaQYe4kjq8Tj1S=vOcbawyXw3w@mail.gmail.com>
X-Gm-Features: AWmQ_bmiz31iFWg-Dr5WhAY1WG09Wx9MI-cKyH_LahqxsXvX6spLaYjJPBQRcXQ
Message-ID: <CAMRc=McEX6y_9JF=ji_TQ0aSMaQYe4kjq8Tj1S=vOcbawyXw3w@mail.gmail.com>
Subject: Re: [PATCH] reset: gpio: suppress bind attributes in sysfs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 12:14=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 04/12/2025 10:44, Bartosz Golaszewski wrote:
> > This is a special device that's created dynamically and is supposed to
> > stay in memory forever. We also currently don't have a devlink between
>
> Not forever. If every consumer is unloaded, this can be unloaded too, no?
>
> > it and the actual reset consumer. Suppress sysfs bind attributes so tha=
t
>
> With that reasoning every reset consumer should have suppress binds.
> Devlink should be created by reset controller framework so it is not
> this driver's fault.
>

Here's my reasoning: I will add a devlink but Phillipp requested some
changes so I still need to resend it. It will be a bigger change than
this one-liner. The reset-gpio device was also converted to auxiliary
bus for v6.19 and I will also convert reset core to using fwnodes for
v6.20 so we'll significantly diverge in stable branches, while this
issue is present ever since the reset-gpio driver exists. It's not the
driver's fault but it's easier to fix it here and it very much is a
special case - it's a software based device rammed in between two
firmware-described devices.

>
> > user-space can't unbind the device because - as of now - it will cause =
a
> > use-after-free splat from any user that puts the reset control handle.
> >
> > Fixes: cee544a40e44 ("reset: gpio: Add GPIO-based reset controller")
>
> Nothing to be fixed here, unless you claim that every reset provider is
> broken as well? What is exactly different in handling devlinks between
> this driver and every other reset provider?
>

I don't care if we keep the tag, it's just that this commit introduced
a way for user-space to crash the system by simply unbinding
reset-gpio and then its active consumers.

And the difference here is that there is no devlink between reset-gpio
and its consumers. We need to first agree how to add it.

Bartosz

